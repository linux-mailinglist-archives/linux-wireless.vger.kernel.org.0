Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D900BB73B6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbfISHJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 03:09:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35128 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387611AbfISHJG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 03:09:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iAqYi-00025V-AE; Thu, 19 Sep 2019 09:08:56 +0200
Message-ID: <fd8813c1c3c02734d60f494a3c8081d95550ec85.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: fix a potential NULL pointer dereference
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Allen Pais <allen.pais@oracle.com>, kvalo@codeaurora.org
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Sep 2019 09:08:55 +0200
In-Reply-To: <1568830262-5529-1-git-send-email-allen.pais@oracle.com> (sfid-20190918_201340_397923_45638148)
References: <1568830262-5529-1-git-send-email-allen.pais@oracle.com>
         (sfid-20190918_201340_397923_45638148)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-18 at 23:41 +0530, Allen Pais wrote:
> alloc_workqueue is not checked for errors and as a result,
> a potential NULL dereference could occur.

Wonder why this is coming out now ... but I don't think kmalloc() was
ever 'fixed' to fail for small allocations, so I guess this will never
fail?

Anyway, as 0-day bot pointed out, this isn't really right. The cleanup
paths here are also tricky, so I arrived at this patch a few days ago:


diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index eb544811759d..882fdf7e5e7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3530,6 +3530,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	spin_lock_init(&trans_pcie->reg_lock);
 	mutex_init(&trans_pcie->mutex);
 	init_waitqueue_head(&trans_pcie->ucode_write_waitq);
+
+	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
+						   WQ_HIGHPRI | WQ_UNBOUND, 1);
+	if (!trans_pcie->rba.alloc_wq) {
+		ret = -ENOMEM;
+		goto out_free_trans;
+	}
+	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
+
 	trans_pcie->tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
 	if (!trans_pcie->tso_hdr_page) {
 		ret = -ENOMEM;
@@ -3664,10 +3673,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		trans_pcie->inta_mask = CSR_INI_SET_MASK;
 	 }
 
-	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
-						   WQ_HIGHPRI | WQ_UNBOUND, 1);
-	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
-
 #ifdef CPTCFG_IWLWIFI_DEBUGFS
 	trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_CLOSED;
 	mutex_init(&trans_pcie->fw_mon_data.mutex);
@@ -3681,6 +3686,8 @@ out_free_ict:
 	iwl_pcie_free_ict(trans);
 out_no_pci:
 	free_percpu(trans_pcie->tso_hdr_page);
+	destroy_workqueue(trans_pcie->rba.alloc_wq);
+out_free_trans:
 	iwl_trans_free(trans);
 	return ERR_PTR(ret);
 }

johannes


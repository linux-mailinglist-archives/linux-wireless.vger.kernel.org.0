Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4132156C5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgGFLwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgGFLwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 07:52:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA4C061794
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 04:52:33 -0700 (PDT)
Received: from [134.101.131.141] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jsPfi-000600-Pw; Mon, 06 Jul 2020 13:52:31 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 08/10] ath11k: add the multiple bssid IE offset to the beacon template
Date:   Mon,  6 Jul 2020 13:52:17 +0200
Message-Id: <20200706115219.663650-8-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The FW needs to know the offset of the multi bssid IE. Add this value to
the WMI TLV.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b7a4913228bc..0c1743caaba7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1567,6 +1567,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	cmd->csa_switch_count_offset = offs->csa_counter_offs[0];
 	cmd->ext_csa_switch_count_offset = offs->csa_counter_offs[1];
 	cmd->buf_len = bcn->len;
+	cmd->mbssid_ie_offset = offs->multiple_bssid_offset;
 
 	ptr = skb->data + sizeof(*cmd);
 
-- 
2.25.1


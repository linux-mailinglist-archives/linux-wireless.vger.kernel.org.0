Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40493B6A50
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfIRSN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 14:13:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41532 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfIRSN3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 14:13:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHx8DJ064916;
        Wed, 18 Sep 2019 18:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=UjgOSjTYHKYQ3BViNdA+1Pbt5OtO2DhITkMO0ccXbsE=;
 b=YNxcge2fE7Jf9NrE4p+pVvJxPpd0rJjk0uwx7Tbp/f7hgyjAIO2KSBUG44QXgsaamU8D
 jHZVZgST4X7qOj+gi8GFM6t/WOiU/uybel2RdsYS46a2MCMEcFVF8Xe/6LDP1eiHPuQV
 DINp+SGZ/XIXIbb/lyzQ2bpbn3t1AoN3tppko0FU5rIUBzuAPQs5E4pdHFPcAU3+N9Hr
 6tlR7v9WpfPtGjdf8OzX0uuFmTPdA1cRY/0+25UsbUUYLa8I8B88JYOCVUabQiXdQCLZ
 YWN+7ntzC9CC5TK6D05ZlwOE0dKwUh8UHbPGufp1nwPoMROqx5bc1LxcXQ3WwWH9uIWe Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v385e5p0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:13:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8II4I1Y116899;
        Wed, 18 Sep 2019 18:11:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v37mb055b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:11:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IIBFZo005891;
        Wed, 18 Sep 2019 18:11:15 GMT
Received: from x250.idc.oracle.com (/10.191.241.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 11:11:14 -0700
From:   Allen Pais <allen.pais@oracle.com>
To:     kvalo@codeaurora.org
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: fix a potential NULL pointer dereference
Date:   Wed, 18 Sep 2019 23:41:02 +0530
Message-Id: <1568830262-5529-1-git-send-email-allen.pais@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180161
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

alloc_workqueue is not checked for errors and as a result,
a potential NULL dereference could occur.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index db62c83..276c26b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3655,6 +3655,11 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
 						   WQ_HIGHPRI | WQ_UNBOUND, 1);
+	if (unlikely(!trans_pcie->rba.alloc_wq)) {
+		return -ENOMEM;
+		goto out_free_ict;
+	}
+
 	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
 
 #ifdef CONFIG_IWLWIFI_PCIE_RTPM
-- 
1.9.1


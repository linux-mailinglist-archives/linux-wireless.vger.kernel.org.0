Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4F42A73
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408635AbfFLPMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 11:12:19 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39316 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728637AbfFLPMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 11:12:18 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CF48tr032706
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 08:12:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=ZuAXdh9Rb5eqGfEISEQHQE+aAdqvKXTmtarZe+mpmFw=;
 b=AQmoiUpvW/hGdCIbjcCUKwrTdXxv+W3dxoIEz5VwGTPF32wMvxxyz1S+iWUiHkxgku20
 0SfLu3H54FNyhnq8G22EWLiZL0OO5J2U/5xgVgcCqY9AQm4flgBLQkZXso8p7eYdsOuG
 CxqZPy3K+f9Yvj4xrpTaJnP+eJrHyNJhqlGJy705aix40t1a0PWVs28ZA6UWgejdZ5bI
 zNKHoouSYe4oBAkVB0cvc3v6YvqPwfeG3KQvaKGbn7vCrJfjadTUpvsVPNpcfAo1GIpC
 jvTDkWuqPp2GvKpnx6wpgL9JQn0ffDPwQ0oKvdcxWmbz+YwzP/BnrGyOGXz/E1JX6YUd mA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t2r82as94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 08:12:17 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 08:12:15 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 12 Jun 2019 08:12:15 -0700
Received: from gbhat-ThinkPad-T430.marvell.com (gbhat-thinkpad-t430.marvell.com [10.31.176.18])
        by maili.marvell.com (Postfix) with ESMTP id C05CC3F7040;
        Wed, 12 Jun 2019 08:12:13 -0700 (PDT)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH 09/11] mwifiex: update set_mac_address logic
Date:   Wed, 12 Jun 2019 20:42:11 +0530
Message-ID: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sharvari Harisangam <sharvari@marvell.com>

In set_mac_address, driver check for interfaces with same bss_type
For first STA entry, this would return 3 interfaces since all priv's have
bss_type as 0 due to kzalloc. Thus mac address gets changed for STA
unexpected. This patch adds check for first STA and avoids mac address
change. This patch also adds mac_address change for p2p based on bss_num
type.

Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 5ed2d9b..4eabd94 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -965,10 +965,10 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
 
 		mac_addr = old_mac_addr;
 
-		if (priv->bss_type == MWIFIEX_BSS_TYPE_P2P)
+		if (priv->bss_type == MWIFIEX_BSS_TYPE_P2P) {
 			mac_addr |= BIT_ULL(MWIFIEX_MAC_LOCAL_ADMIN_BIT);
-
-		if (mwifiex_get_intf_num(priv->adapter, priv->bss_type) > 1) {
+			mac_addr += priv->bss_num;
+		} else if (priv->adapter->priv[0] != priv) {
 			/* Set mac address based on bss_type/bss_num */
 			mac_addr ^= BIT_ULL(priv->bss_type + 8);
 			mac_addr += priv->bss_num;
-- 
1.9.1


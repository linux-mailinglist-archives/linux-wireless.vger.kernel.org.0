Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6756242A17
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439928AbfFLO6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 10:58:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37466 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436945AbfFLO6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 10:58:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CEqUSr023837
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 07:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=uE7MZuq+3WIUc6HVpm5xYAX5d0PSwwq0bThVMtvspxM=;
 b=rBtlwPhmEEHNqJUV6+r6bl6/AP/yob8HY+CPPkMp2yhktBYN4bQvI/VWf9WM4SUUMEUR
 PGEBzTxKUNgkHuLaY1Qr6rRIuqZv/pf7IAncntSkrGZhCcNnn45PAaJ9raSiQt/gOPpc
 X5iZROgLWEGlPlbGachC8T8A2uctxqSm/eBl5dlh5Qrkxx0iD7exZn/LOZcKrGU9XfCz
 3E5ZifeMLgaPKl8LoNrXKXdOWXK93wgX475DoSIWhkHtCDcSXH9ZXiv5KjWu1MW+jYIs
 boSFc/wOVg/+yzpoHXaFXnRfA26ZCYyvGosz+TSTWiNqo+7Uf/3odQpv9TOIwfY8+FUm tg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t2r82aqd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 07:58:49 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 07:58:48 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 12 Jun 2019 07:58:48 -0700
Received: from gbhat-ThinkPad-T430.marvell.com (gbhat-thinkpad-t430.marvell.com [10.31.176.18])
        by maili.marvell.com (Postfix) with ESMTP id 3D51E3F703F;
        Wed, 12 Jun 2019 07:58:47 -0700 (PDT)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH] mwifiex: update set_mac_address logic
Date:   Wed, 12 Jun 2019 20:28:44 +0530
Message-ID: <1560351524-16779-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In set_mac_address, driver check for interfaces with same bss_type
For first STA entry, this would return 3 interfaces since all priv's have
bss_type as 0 due to kzalloc. Thus mac address gets changed for STA
unexpected. This patch adds check for first STA and avoids mac address
change. This patch also adds mac_address change for p2p based on bss_num
type.

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index f6da8ed..4c14b48 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -960,10 +960,10 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
 
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


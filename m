Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291A13887E6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhESHAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 03:00:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbhESHAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 03:00:17 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlNty5L3jz1BP6k;
        Wed, 19 May 2021 14:56:10 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 14:58:56 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 14:58:55 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] net: ti: remove leading spaces before tabs
Date:   Wed, 19 May 2021 14:55:45 +0800
Message-ID: <1621407345-10625-4-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621407345-10625-1-git-send-email-tanghui20@huawei.com>
References: <1621407345-10625-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are a few leading spaces before tabs and remove it by running the
following commard:

	$ find . -name '*.c' | xargs sed -r -i 's/^[ ]+\t/\t/'
	$ find . -name '*.h' | xargs sed -r -i 's/^[ ]+\t/\t/'

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 8509b98..e500b84 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3242,8 +3242,8 @@ static void wl1271_op_configure_filter(struct ieee80211_hw *hw,
 		 * the firmware filters so that all multicast packets are passed
 		 * This is mandatory for MDNS based discovery protocols 
 		 */
- 		if (wlvif->bss_type == BSS_TYPE_AP_BSS) {
- 			if (*total & FIF_ALLMULTI) {
+		if (wlvif->bss_type == BSS_TYPE_AP_BSS) {
+			if (*total & FIF_ALLMULTI) {
 				ret = wl1271_acx_group_address_tbl(wl, wlvif,
 							false,
 							NULL, 0);
-- 
2.8.1


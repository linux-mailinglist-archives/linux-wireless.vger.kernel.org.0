Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12CB38E234
	for <lists+linux-wireless@lfdr.de>; Mon, 24 May 2021 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhEXIWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 May 2021 04:22:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5747 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhEXIWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 May 2021 04:22:23 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpVSH51B1zmkkT;
        Mon, 24 May 2021 16:17:19 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:20:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:20:50 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] brcmsmac: Remove the repeated declaration
Date:   Mon, 24 May 2021 16:20:43 +0800
Message-ID: <1621844443-38290-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Function 'brcms_c_stf_phy_txant_upd' are declared twice, remove
the repeated declaration.

Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h
index aa4ab53bf634..af86c7fc5112 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.h
@@ -29,7 +29,6 @@ void brcms_c_stf_ss_update(struct brcms_c_info *wlc, struct brcms_band *band);
 void brcms_c_stf_phy_txant_upd(struct brcms_c_info *wlc);
 int brcms_c_stf_txchain_set(struct brcms_c_info *wlc, s32 int_val, bool force);
 bool brcms_c_stf_stbc_rx_set(struct brcms_c_info *wlc, s32 int_val);
-void brcms_c_stf_phy_txant_upd(struct brcms_c_info *wlc);
 void brcms_c_stf_phy_chain_calc(struct brcms_c_info *wlc);
 u16 brcms_c_stf_phytxchain_sel(struct brcms_c_info *wlc, u32 rspec);
 u16 brcms_c_stf_d11hdrs_phyctl_txant(struct brcms_c_info *wlc, u32 rspec);
-- 
2.7.4


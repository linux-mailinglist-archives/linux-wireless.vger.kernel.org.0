Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749E382676
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhEQIQI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2944 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhEQIQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:04 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkBgP5RWqzCtY8;
        Mon, 17 May 2021 16:12:01 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Franky Lin <franky.lin@broadcom.com>,
        "Hante Meuleman" <hante.meuleman@broadcom.com>
Subject: [PATCH 04/11] net: broadcom: brcmfmac: Demote non-compliant kernel-doc headers
Date:   Mon, 17 May 2021 13:01:34 +0800
Message-ID: <20210517050141.61488-5-shenyang39@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517050141.61488-1-shenyang39@huawei.com>
References: <20210517050141.61488-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:2040: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1295: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c  | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 34cd8a7401fe..9ac0d8c73d5a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2037,7 +2037,7 @@ static void brcmf_p2p_get_current_chanspec(struct brcmf_p2p_info *p2p,
 }
 
 /**
- * Change a P2P Role.
+ * brcmf_p2p_ifchange - Change a P2P Role.
  * @cfg: driver private data for cfg80211 interface.
  * @if_type: interface type.
  * Returns 0 if success.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 16ed325795a8..d1dda851e176 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1291,7 +1291,7 @@ static void brcmf_sdio_free_glom(struct brcmf_sdio *bus)
 	}
 }
 
-/**
+/*
  * brcmfmac sdio bus specific header
  * This is the lowest layer header wrapped on the packets transmitted between
  * host and WiFi dongle which contains information needed for SDIO core and
-- 
2.17.1


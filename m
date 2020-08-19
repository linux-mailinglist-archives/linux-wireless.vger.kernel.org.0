Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581B249744
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHSH2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHSH0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:26:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5D9C0612F2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so20425049wrx.9
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dn1h7hnv+zK3JmNJ8owg74HJG3E/In8jlICFM66crSs=;
        b=AZWKgj9gDfQfz4GJLDtrB0WwHshxJJ7tcKzIGuAxvCXY9JzKaybqkdyFJo9GqxZ0EB
         cjb7K3Y0hkKjGydKVUNbOlWv2YrEYrWD7g5P/SMbHR+45oGCHSkNLx3MVrPUdpjQTGtK
         Cc9FeveNUUt+Y4PU4Yhf6vZX9l2NA9whyedEPeCib7kXNOVrtpOYtFngn+waNc8AKgTn
         2NK1gJ/+W7poRuE6u7ADjEKynsQNLU6VZPXee25+pyeIPFCnytPKZqA7ENPd/mAX5NmE
         4WVaZRSwfO+XjwDfcgIRx6ftAyW2axc4/qBRexeJlRo/He7ZhI6DmesCd5AhqnDy9Ls2
         TDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dn1h7hnv+zK3JmNJ8owg74HJG3E/In8jlICFM66crSs=;
        b=qZVGjeuwa7U9ziSJckfO8LTTPQ0mxV4MO4nlQiEKt+A7Adn5OCMB1u4mnzDmHeDimD
         5pchDqklQeYECPNJmPTkSqj9vXusLg5YoQU5DIWNur1ZjikDUkNUHe3CkF5ZAoy61YzZ
         IdtR5H7HxiN0q4w7hcoQG+laUDjZT6TUMxVfjgMBdXvWHh/y7hfyaapttSqsuRJ8LLbe
         Em5onHd6KaIz9BJM5c3fXIw9tGyFTFEtg80+Ih1p76OgeLwCy6CluBV58YHrc+gdIIPH
         p8Ijhy1S82XeIi9EO8dfA/caklhse8sr0+38oOtCx1MZhMhj/RWumwhOu3UKp46E0EkV
         M1vw==
X-Gm-Message-State: AOAM532hOvhvgklBwXIR6ih1m1T0cQgKIMCDQRiuNzaU59t2tUqSbxl7
        f7R/SPLDDwhQ2Mai/auoJW/3/w==
X-Google-Smtp-Source: ABdhPJzxe4bxgtGmVLxxJ5PC5vyocr5/mcvOh70h5bpuA/1A70YlK1XvF3T4ad0uG5qFDu/ARs9BfA==
X-Received: by 2002:adf:9ed1:: with SMTP id b17mr22842002wrf.140.1597821876705;
        Wed, 19 Aug 2020 00:24:36 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 25/28] wireless: broadcom: brcmfmac: p2p: Deal with set but unused variables
Date:   Wed, 19 Aug 2020 08:23:59 +0100
Message-Id: <20200819072402.3085022-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

'vif' is a function parameter which is oddly overwritten within the
function, but never read back.  'timeout' is set, but never checked.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c: In function ‘brcmf_p2p_scan_prep’:
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:894:31: warning: parameter ‘vif’ set but not used [-Wunused-but-set-parameter]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c: In function ‘brcmf_p2p_tx_action_frame’:
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1549:6: warning: variable ‘timeout’ set but not used [-Wunused-but-set-variable]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index debd887e159e1..7f681a25ab525 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -913,8 +913,6 @@ int brcmf_p2p_scan_prep(struct wiphy *wiphy,
 		if (err)
 			return err;
 
-		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
-
 		/* override .run_escan() callback. */
 		cfg->escan_info.run = brcmf_p2p_run_escan;
 	}
@@ -1546,7 +1544,6 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 	struct brcmf_cfg80211_vif *vif;
 	struct brcmf_p2p_action_frame *p2p_af;
 	s32 err = 0;
-	s32 timeout = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -1582,8 +1579,7 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 		  (p2p->wait_for_offchan_complete) ?
 		   "off-channel" : "on-channel");
 
-	timeout = wait_for_completion_timeout(&p2p->send_af_done,
-					      P2P_AF_MAX_WAIT_TIME);
+	wait_for_completion_timeout(&p2p->send_af_done, P2P_AF_MAX_WAIT_TIME);
 
 	if (test_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status)) {
 		brcmf_dbg(TRACE, "TX action frame operation is success\n");
-- 
2.25.1


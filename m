Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF0458AE7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 09:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhKVI4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 03:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVI4O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 03:56:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A6C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 00:53:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so31246110wrr.8
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 00:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BOwcu7/Nmet6CxNuJeudnGmrj2uw0wDmIhzt9tO75Mk=;
        b=KwiPruVbEXhtabqgzgQtnBvCe3eurtdUB5SNTS2B2Cvzf800VjrV9fjCnKwDRvVasB
         73c612+sb1uzZznJtcflNKynC6/bGbEOT7kikEdUpBV319BsQp+9NPKN9SdMSUsGrBdi
         eHxIbSf2M5g0xIVn+bPcNEymL12iINfZ5SSOocmTr4skNmYV+hQ6KpRGUZVl9s3adUwB
         eUAf0hRjtPDcH9lJPOeV56vbtoIArioY8RYykDhWzk4BroIrRRXZhRkrNfmZE058R9Qj
         Xpz95sRHogXmu1tmbjpdgqyAf9zAIgU5dpy9fu2lp8XBDO+2mOHl9iw2mBi1g9QUuLZR
         u1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BOwcu7/Nmet6CxNuJeudnGmrj2uw0wDmIhzt9tO75Mk=;
        b=q32LNKPQNWph0ePEGqJbj4DBfpm1JmHLCyOYwK2waCevnIhbjUtuXqb5NZhf2540Yd
         9nQFydZxvQhp8u3uK+4j1zbFafHywwK+8FOdkRUHN19V94WmX3KyuxUV3U4S2x8uDy6E
         4y9ITOov4rc0VH2KrFLu+djDeOZ9qEpm8xluVPOU7qH8UhLriEjhdEvR4mGLoO8rOLtC
         tjA6CmI/p/Md1h+o0Puo65kFQnxqWna9BWiHZfxHAuZJnmrsheKLuqdGLyWlO6xyNC87
         0WJlVq8LePWKWfMW7YaE7MY2ahZIwKmWRDyDQFe9xIwJQlE7ZkY0nH7bDG4sqUP312pz
         ZZHQ==
X-Gm-Message-State: AOAM530AiknvGLk51U2iTQWpJ6fqZCY6j7uNP44d8lSAe/VIgziidNsH
        yJ6LpV+rYG10wC/kHCjqp6bLdw==
X-Google-Smtp-Source: ABdhPJy3b7re3t7RhW9tRFqIqn+dJjS+9D90aEaG7c7JGbF/guZQepNjA+x3YiqmKUSuKvoUQ47EHQ==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr35003233wrs.136.1637571187262;
        Mon, 22 Nov 2021 00:53:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:d48:f7c8:670e:7ff4])
        by smtp.gmail.com with ESMTPSA id u15sm9915581wmq.13.2021.11.22.00.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 00:53:06 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, kvalo@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] brcmfmac: Configure keep-alive packet on suspend
Date:   Mon, 22 Nov 2021 10:04:16 +0100
Message-Id: <1637571856-1191-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When system enter suspend, there is no more wireless traffic, and
if there is no incoming data, most of the AP kick-out the client
station after few minutes because of inactivity.

The usual way to prevent this is to submit a Null function frame
periodically as a keep-alive. This is supported by brcm controllers
and can be configured via the mkeep_alive IOVAR.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 21 +++++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/fwil_types.h        | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fb72777..afa8ceda 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3901,6 +3901,24 @@ static void brcmf_configure_wowl(struct brcmf_cfg80211_info *cfg,
 	cfg->wowl.active = true;
 }
 
+int brcmf_keepalive_start(struct brcmf_if *ifp, unsigned int interval)
+{
+	struct brcmf_mkeep_alive_pkt_le kalive = {0};
+	int ret = 0;
+
+	/* Configure Null function/data keepalive */
+	kalive.version = cpu_to_le16(1);
+	kalive.period_msec = cpu_to_le16(interval * MSEC_PER_SEC);
+	kalive.len_bytes = cpu_to_le16(0);
+	kalive.keep_alive_id = cpu_to_le16(0);
+
+	ret = brcmf_fil_iovar_data_set(ifp, "mkeep_alive", &kalive, sizeof(kalive));
+	if (ret)
+		brcmf_err("keep-alive packet config failed, ret=%d\n", ret);
+
+	return ret;
+}
+
 static s32 brcmf_cfg80211_suspend(struct wiphy *wiphy,
 				  struct cfg80211_wowlan *wowl)
 {
@@ -3947,6 +3965,9 @@ static s32 brcmf_cfg80211_suspend(struct wiphy *wiphy,
 	} else {
 		/* Configure WOWL paramaters */
 		brcmf_configure_wowl(cfg, ifp, wowl);
+
+		/* Prevent disassociation due to inactivity with keep-alive */
+		brcmf_keepalive_start(ifp, 30);
 	}
 
 exit:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index ff2ef55..e69d1e5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -1052,4 +1052,23 @@ struct brcmf_gscan_config {
 	struct brcmf_gscan_bucket_config bucket[1];
 };
 
+/**
+ * struct brcmf_mkeep_alive_pkt_le - configuration data for keep-alive frame.
+ *
+ * @version: version for mkeep_alive
+ * @length: length of fixed parameters in the structure.
+ * @period_msec: keep-alive period in milliseconds.
+ * @len_bytes: size of the data.
+ * @keep_alive_id: ID  (0 - 3).
+ * @data: keep-alive frame data.
+ */
+struct brcmf_mkeep_alive_pkt_le {
+	__le16  version;
+	__le16  length;
+	__le32  period_msec;
+	__le16  len_bytes;
+	u8   keep_alive_id;
+	u8   data[0];
+} __packed;
+
 #endif /* FWIL_TYPES_H_ */
-- 
2.7.4


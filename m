Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D522C45917F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbhKVPj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhKVPjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 10:39:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038BEC061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 07:36:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i5so33534012wrb.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w2pf4AANKIrrDGXUkzCoOR4nVVm+8N5puOVZMmT6rPU=;
        b=E55mjZIX/Ws4rV5v1nyxd26UgKzpIgsZJWgdoibFx5YGSeDqIjErh7B+8xxbd7xHKd
         5pivP1ypET5KCtXwhhzQl2FXk2R5uQWCpVijnfOg9GWWwQtPsWkua6brebzmfQmzCySe
         dE+NqcuLetfnYWCcOHRKxpLcF90dE+KIX3oVxYnWx4siTcRfs5CXselTrVDt/PUtmd6x
         xZHdpWQbfWHeEn/swQuBraJXs2kvPnhyzQK7PcBPRoyHe6W7/mXhdN8caHeffuh5LOJm
         jHZ3WDbvjE/1W5ZUpzfqidVIiEc1GgfIKhfQILxk+PHzDYx7c5QqiJRU5bepZVhnkDpU
         EW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w2pf4AANKIrrDGXUkzCoOR4nVVm+8N5puOVZMmT6rPU=;
        b=JRDyeVonNPe9eAnlCDCJfGeUDIhE2UC6W7SEby9FQuAlm7VF+fn3I9ncDTGJHYTXOz
         1ARGxlxiM24/kx3mFXPtJ9sHPvSNswvjWwtrI/3gQCI3Jqj0bfnFoy5Qc6objeMyhhnG
         jF8oovwKDfo4a066hgb+M01+P4AheA/QKSFvKWkX/EwDh7sLd0ikDsioDfg+oa3YibnH
         nWGmNe0Lf+pruO7Cv0+mCXVruMM1ymgamBgojosD45w8cVbg36t3xNN1EgI/BG8Z0faS
         3FzCkkgXj9l33TA9jpTWMl6zDytCWRfv8Y1ajbhXMG2ZKeI5rcf5PNiVRmFMa/jblH28
         NZFA==
X-Gm-Message-State: AOAM53190vnMyzD1QB3+UQFiY4Y9+GdyymxWBEH/FPB54RVF0rEKWjDq
        MMf8P79LMQlroLuR60Agu3kUaw==
X-Google-Smtp-Source: ABdhPJx+q01japTOryyq5goofChcF1eidalkjkiSAT0rWD7Z/y1hLWfuJfE9GxzsYvXMZbmknaLgAA==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr38858686wro.187.1637595377495;
        Mon, 22 Nov 2021 07:36:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:d48:f7c8:670e:7ff4])
        by smtp.gmail.com with ESMTPSA id o63sm9319810wme.2.2021.11.22.07.36.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 07:36:16 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, kvalo@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2] brcmfmac: Configure keep-alive packet on suspend
Date:   Mon, 22 Nov 2021 16:47:26 +0100
Message-Id: <1637596046-21651-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When entering suspend as a client station with wowlan enabled,
the Wi-Fi link is supposed to be maintained. In that state, no
more data is generated from client side, and the link stays idle
as long the station is suspended and as long the AP as no data to
transmit.

However, most of the APs kick-off such 'inactive' stations after
few minutes, causing unexpected disconnect (reconnect, etc...).

The usual way to prevent this is to submit a Null function frame
periodically as a keep-alive. This is something that can be host
/software generated (e.g. wpa_supplicant), but that needs to be
offloaded to the Wi-Fi controller in case of suspended host.

This change enables firmware generated keep-alive frames when
entering wowlan suspend, using the 'mkeep_alive' IOVAR.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: - commit reword metioning wowlan
     - brcmf_keepalive_start as static function

 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 21 +++++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/fwil_types.h        | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fb72777..1679361 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3901,6 +3901,24 @@ static void brcmf_configure_wowl(struct brcmf_cfg80211_info *cfg,
 	cfg->wowl.active = true;
 }
 
+static int brcmf_keepalive_start(struct brcmf_if *ifp, unsigned int interval)
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


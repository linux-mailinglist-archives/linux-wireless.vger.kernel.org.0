Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3E2B74EB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKRDmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 22:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRDmU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 22:42:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94130C0613D4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r9so324605pjl.5
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STixirzAd4J7+QdE4FgirGi/qOtSsNZnU5WpIzam3eo=;
        b=O40FBp07HfOQpWiaxf/hohRTktBBYkM6cFZOYzXO5Mt1PmRhFOKjryswj+p43pEkbY
         1nyAf8OzAdZ1ADUqxrLBrCJ7myf+HmxVgoZi5BUU+ntsp8J2nvI+3ZyDXjdXHjSs4F8P
         1SHpxLMcIp/7y1E3ah0yhtSbZYemIG6yb/O+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STixirzAd4J7+QdE4FgirGi/qOtSsNZnU5WpIzam3eo=;
        b=tIu4tXuwCYh7FOXQ/5poHTWQnOgfBxwf5HJW7ys5VAx/ON3htrYyvhCkJk7qxnU9Q6
         Eo4dBpxI2pfFKW3JOCaO+8Twa8nohLtn4IebI6ugDwD/241QrwQuqlbGwV3ErHnbEY0e
         qqgPYfgFSSAeKmHFJ4oLuA3Uut7yflHXY/89iocL1ktVDoUFdMYhfmNidGY7z3nuWtgx
         ZNpodXOD1CT6igiISCa39BQSxHFz47ro4HbV4b7pvL4Y5rr2PRyxb3HkfJbmIudy60Uj
         4jNgm9r9521xcDPh1EzEVBkejOHE9dcMjeROMppU58j5wkyNRtsFSkuSYP9/aJSoAN6R
         heTQ==
X-Gm-Message-State: AOAM5337bdTxJTfSJiCEOm+iapuNrfnndc3XqN0ML8X/pmm8YLcQNJRK
        uFsUhGzZf6wuEqSJ2JCUTojj6g==
X-Google-Smtp-Source: ABdhPJynnhM4GywOaMiJnVQRAECkPahvCmG97HEfu/QqnNJxzoYooov1JVci8I8DCY5phJzlCmSXsA==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr2181872pjb.125.1605670940214;
        Tue, 17 Nov 2020 19:42:20 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id w2sm16097617pfb.104.2020.11.17.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:42:19 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        David Poole <dpoole@cradlepoint.com>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/4] iw: scan: parse HE capabilities
Date:   Tue, 17 Nov 2020 19:39:35 -0800
Message-Id: <20201118033936.3667788-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201118033936.3667788-1-briannorris@chromium.org>
References: <20201118033936.3667788-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 iw.h   |  1 +
 scan.c |  8 ++++++++
 util.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/iw.h b/iw.h
index 77ed097f229b..807adecd3b06 100644
--- a/iw.h
+++ b/iw.h
@@ -213,6 +213,7 @@ void print_ampdu_length(__u8 exponent);
 void print_ampdu_spacing(__u8 spacing);
 void print_ht_capability(__u16 cap);
 void print_vht_info(__u32 capa, const __u8 *mcs);
+void print_he_capability(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
 
 char *channel_width_name(enum nl80211_chan_width width);
diff --git a/scan.c b/scan.c
index 58a09983c5c7..dfc136a3943e 100644
--- a/scan.c
+++ b/scan.c
@@ -2272,7 +2272,15 @@ static void print_vendor(unsigned char len, unsigned char *data,
 	printf("\n");
 }
 
+static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
+			  const struct print_ies_data *ie_buffer)
+{
+	printf("\n");
+	print_he_capability(data, len);
+}
+
 static const struct ie_print ext_printers[] = {
+	[35] = { "HE capabilities", print_he_capa, 21, 54, BIT(PRINT_SCAN), },
 };
 
 static void print_extension(unsigned char len, unsigned char *ie,
diff --git a/util.c b/util.c
index 4591cbf77ec1..b09bcaf743fc 100644
--- a/util.c
+++ b/util.c
@@ -994,6 +994,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 			    const __u16 *mcs_set, size_t mcs_len,
 			    const __u8 *ppet, int ppet_len)
 {
+	size_t mcs_used;
 	int i;
 
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
@@ -1124,6 +1125,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_PHY_CAP(5, 4, "RX Full BW SU Using HE MU PPDU with Compression SIGB");
 	PRINT_HE_PHY_CAP(5, 5, "RX Full BW SU Using HE MU PPDU with Non-Compression SIGB");
 
+	mcs_used = 0;
 	for (i = 0; i < 3; i++) {
 		__u8 phy_cap_support[] = { BIT(1) | BIT(2), BIT(3), BIT(4) };
 		char *bw[] = { "<= 80", "160", "80+80" };
@@ -1151,6 +1153,16 @@ static void __print_he_capa(const __u16 *mac_cap,
 			}
 
 		}
+		mcs_used += 2 * sizeof(mcs_set[0]);
+	}
+
+	/* Caller didn't provide ppet; infer it, if there's trailing space. */
+	if (!ppet) {
+		ppet = (const void *)(mcs_set + mcs_used);
+		if (mcs_used < mcs_len)
+			ppet_len = mcs_len - mcs_used;
+		else
+			ppet_len = 0;
 	}
 
 	if (ppet_len && (phy_cap[3] & BIT(15))) {
@@ -1236,6 +1248,24 @@ void print_he_info(struct nlattr *nl_iftype)
 	__print_he_capa(mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len);
 }
 
+void print_he_capability(const uint8_t *ie, int len)
+{
+	const void *mac_cap, *phy_cap, *mcs_set;
+	int mcs_len;
+	int i = 0;
+
+	mac_cap = &ie[i];
+	i += 6;
+
+	phy_cap = &ie[i];
+	i += 11;
+
+	mcs_set = &ie[i];
+	mcs_len = len - i;
+
+	__print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0);
+}
+
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
 {
 	size_t i;
-- 
2.29.2.299.gdc1121823c-goog


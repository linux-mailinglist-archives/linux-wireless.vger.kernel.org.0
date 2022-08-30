Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1465A5946
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiH3CVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiH3CVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:21:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876168304B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y127so9985878pfy.5
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=e+UtcaVtfXdzb7tBYucETEd2/MznFEQfTq6+/Xfl8Wg=;
        b=ib9BaZlBpGfcnMZqXWb4OIPMCEfjfFmzM8Gs0W3uzKpyyeGCE8917RhVh+2f0LrxVG
         vxqfxMXVFDQl+EXYYVXHj4GaIL61hfLMgckrZKmwg/imBrL9fC6ItFmkzbh0FmU21Y/U
         ITVOlAj4+MUwTQjPG0qjVg3Ev38jyKO8fmqfXlAP2EBsEo+2Ic32gLVoLdqGWpFqd2Fh
         SyZP0oKq73vbmEYnbWbbQucX38cGi9wkYPInakDmOt+pG9wLR1varS7VTkxKm/0ac94D
         XlTj63x43d32/O1Cb9bVzoX45kReEhAwwzSZnYo5U8S9r8bPF9hyJX+hjnauTH3aUDLz
         QsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=e+UtcaVtfXdzb7tBYucETEd2/MznFEQfTq6+/Xfl8Wg=;
        b=BcW+sEGDxPJHvIORUpJZeZPoZIctpuiXv/QY70G2VDd2RNs2uVi7qFAbZBHqiLDwaG
         sxZWOvoaspTwqIhJpvEmyis7dfmdF5Ijd4TvGN/jzKeCUgacL54XYOiGHXrAelT89yDA
         /C4tiim09REon4krD5M5booc9q4F0C/pA3e/xwPuV/LgM4LO4BVSgGr9Wmv7lDciUu2v
         hMx29vnEIL9MlXpcNylw3aaRRXBJBb4eJGVVPjhphhX1G+N9V4XK1qFXu37IoWbEOipO
         jwOZfimI7uoManaAwLG9xE1Vf+AVJ8/3zy2HHMDvWjDv2yXT1iDUiC0dFAHoHyHl34Ej
         Dc5Q==
X-Gm-Message-State: ACgBeo2xbn8+ljFFOedg1Aq2CNUSTdiwuzWb+YwbaWGhACCudoXqMx+w
        BBnSPL0oacvrd1gtf0OCvQqk7g==
X-Google-Smtp-Source: AA6agR62vunWmp1nVKxHh0ClmEjTLYL+l6HH8EhlbMhFDT5uOsg6sUyU5cfYCj7n5xBCo496y+niVw==
X-Received: by 2002:a65:6d14:0:b0:41d:5f95:179d with SMTP id bf20-20020a656d14000000b0041d5f95179dmr15992207pgb.580.1661826058085;
        Mon, 29 Aug 2022 19:20:58 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:57 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 07/12] mac80211: S1G capabilities information element in probe request
Date:   Tue, 30 Aug 2022 02:20:12 +0000
Message-Id: <20220830022017.51017-8-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the missing S1G capabilities information element to probe requests.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/util.c        | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cd8879998739..e8ff4af9fc03 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2400,6 +2400,7 @@ void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb);
 void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
+u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 53826c663723..78e8c286011e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1857,6 +1857,12 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
 	shift = ieee80211_chandef_get_shift(chandef);
 
+	/* For direct mac80211 scan (probe request), add S1G IE and consider its override bits */
+	if (band == NL80211_BAND_S1GHZ) {
+		pos = ieee80211_ie_build_s1g_cap(pos, &sband->s1g_cap);
+		goto done;
+	}
+
 	num_rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if ((BIT(i) & rate_mask) == 0)
@@ -2919,6 +2925,21 @@ size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset)
 	return pos;
 }
 
+u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap)
+{
+	*pos++ = WLAN_EID_S1G_CAPABILITIES;
+	*pos++ = sizeof(struct ieee80211_s1g_cap);
+	memset(pos, 0, sizeof(struct ieee80211_s1g_cap));
+
+	memcpy(pos, &s1g_cap->cap, sizeof(s1g_cap->cap));
+	pos += sizeof(s1g_cap->cap);
+
+	memcpy(pos, &s1g_cap->nss_mcs, sizeof(s1g_cap->nss_mcs));
+	pos += sizeof(s1g_cap->nss_mcs);
+
+	return pos;
+}
+
 u8 *ieee80211_ie_build_ht_cap(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 			      u16 cap)
 {
-- 
2.25.1


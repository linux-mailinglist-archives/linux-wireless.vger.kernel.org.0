Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000236A0184
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 04:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjBWDZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 22:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjBWDZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 22:25:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C52DE53
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 19:25:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h31so5308755pgl.6
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 19:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBIegSs7cAcxBQr5oZ4JAv9xde4E92A9D/wWixl58gM=;
        b=wEzvYEWAAx6L9bJ78JZsuQJCaN5HCA7CTiEyKyPlonDnrekuP6smyImpaWQQ1uyPvR
         RtjywhrN+mgjrtnZY1bvswjpmlo51H7GKuZf2PHWKt1rU1H4D3P2suBT4CsWsOAW5kuJ
         VXHIaCMLSL45DwdaUNaVgjxx2IRR39eF8aDLpQTofCh1D548vh4rp7L/XCwoH/Z4R2z1
         yrUC8ycP3iEv8AxvMjD56bHlelMP6QTityPaxAS7QvWVv/Opm+W5+fghMC3/MbDydpov
         YjD3VO772+Uzp9KpU34/FA5udXMsoxBreW6O9bPxhj/YqAzc5VEPTBTOZXsumiFgUTBL
         XZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBIegSs7cAcxBQr5oZ4JAv9xde4E92A9D/wWixl58gM=;
        b=JXtDiiUz4jSqKnS1egUN+FuNy3jYDcY0Re6tH4d/vZX7rGE0jCCemoZKXSAADReVQL
         5hcPg/qTAGQ3HNrYlz/CQthr7MO++B6CTPprErtzAJysclR6V39qIxnZoNlSA2xUVMLV
         l/98UJvXqkMe6VKJs/KwE5d0cNaAEY+K/gqzwDSlt1G/yROrkV6skGi2cduZ8LHvqe80
         ltqbHRZZ9kbMCMykI+AMgndfPedh+QfMo5FLo5OmUFQcTzldfHlMZ/i2CpE2tVOO/wHJ
         0OMdccRDMrPUGjJ8evmky8cek2WFB4mACxsGsipFU+KA5p8lxKB4rrGB44AEnzPPjQD/
         +5aw==
X-Gm-Message-State: AO0yUKUE5dwDpVbo/89IhwZpBnzPxvudKU/BC7BM9VrSfBFiNzFlwK/f
        fpVAJgd28W+OEvVtcfe+qiVGlQ==
X-Google-Smtp-Source: AK7set9TGmF4Ocz1YtPAyaY/QHCxobE8bELtSttP4XaIgB+5Qianc4XVlOm2Y90bX7UMhywpx3YNxQ==
X-Received: by 2002:a62:7bce:0:b0:5a8:a570:4597 with SMTP id w197-20020a627bce000000b005a8a5704597mr8400847pfc.5.1677122719190;
        Wed, 22 Feb 2023 19:25:19 -0800 (PST)
Received: from virs-pc-014.morsemicro.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b005a8b882a239sm4747338pfo.109.2023.02.22.19.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:25:18 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] wifi: mac80211: S1G capabilities information element in probe request
Date:   Thu, 23 Feb 2023 16:25:12 +1300
Message-Id: <20230223032512.3848105-1-gilad.itzkovitch@virscient.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Add the missing S1G capabilities information element to probe requests.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/util.c        | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ecc232eb1ee8..963a0001be9f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2445,6 +2445,7 @@ void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb);
 void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
+u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1a28fe5cb614..10ac9819ed91 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1959,6 +1959,14 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
 	shift = ieee80211_chandef_get_shift(chandef);
 
+	/* For direct scan add S1G IE and consider its override bits */
+	if (band == NL80211_BAND_S1GHZ) {
+		if (end - pos < 2 + sizeof(struct ieee80211_s1g_cap))
+			goto out_err;
+		pos = ieee80211_ie_build_s1g_cap(pos, &sband->s1g_cap);
+		goto done;
+	}
+
 	num_rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if ((BIT(i) & rate_mask) == 0)
@@ -3020,6 +3028,21 @@ size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset)
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

base-commit: bf767e3600e0b7d389c6c6a861bd3313ac956c06
-- 
2.34.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0215FF2AC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJNQ4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 12:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJNQ4g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 12:56:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C01D52C8
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Bx+Qd1TUTY+HuHa0dasOK/gEVagLgQPjh6qMY8exnWo=; t=1665766594; x=1666976194; 
        b=H/tcZ77L4vub8LDdwybQnt0yWv+++YgY1sfqBt0jBP6/EwbSPfTjXX1zn6o/Q+iXuB6pm23QwMH
        puhAyYjuJuJVu0PAgPETlt4BqXTMRhaWf45Coda6l879YHUWwAAOYwBFGtkKGPmGHGwfRRBZiuJcx
        ELDlyTxdBwlnxNj/wuU/A1hpf3i+Xk6DFwQrBqdaj2+z78niTqsM7VYl/Eq4CNgAou1Csi1pmdXb+
        0GLztQHgBmUVL/mx46fWEkdld77/tQq1Mim2IbtA65mOD9TeEBwXW/Zd4OOtP6GROH0RGxORR91Sa
        6jcXy1FOKIKMhfM8JFC1N9mXlGcW1FBJz6RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ojNz3-006hAD-1h;
        Fri, 14 Oct 2022 18:56:32 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: don't parse multi-BSSID in assoc resp
Date:   Fri, 14 Oct 2022 18:56:11 +0200
Message-Id: <20221014185611.10ad19b70665.I23c1067ddbed7a9e6a98d79262a6972a3a6996a1@changeid>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It's not valid to have the multiple BSSID element in the
association response (per 802.11 REVme D1.0), so don't
try to parse it there, but only in the fallback beacon
elements if needed.

The other case that was parsing association requests was
already changed in a previous commit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a804e0220ed7..0aee2392dd29 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3932,7 +3932,6 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	struct ieee80211_elems_parse_params parse_params = {
 		.start = elem_start,
 		.len = elem_len,
-		.bss = cbss,
 		.link_id = link_id == assoc_data->assoc_link_id ? -1 : link_id,
 		.from_ap = true,
 	};
@@ -4017,6 +4016,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 
 		parse_params.start = bss_ies->data;
 		parse_params.len = bss_ies->len;
+		parse_params.bss = cbss;
 		bss_elems = ieee802_11_parse_elems_full(&parse_params);
 		if (!bss_elems) {
 			ret = false;
-- 
2.37.3


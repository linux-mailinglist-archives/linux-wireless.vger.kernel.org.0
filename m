Return-Path: <linux-wireless+bounces-25352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2DB03580
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6FB7A84BC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 05:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325E918D;
	Mon, 14 Jul 2025 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="1rTnmhKr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1221F19A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470083; cv=none; b=f4WC6fOKP4iYJsEZEyVBnb/68icEakgJrfz6guqSCiE7Y3LtxbJ97wGvjPK9XFxcoOs+4jAMjeQfTl0I7JSqBZUzRLAQ5WifouxxnWprWSa46vlV/T2Qjf665LCq2sw00ncGOukcyqj9fEkCmyEBsJdy9f5xYiwicb8M/XrH8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470083; c=relaxed/simple;
	bh=6QrMuVbggtbTUuatIZX6Lu5R7NKZOGU5hdkxZxdOKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8jBqdJO9Y9ZCGTgnos7yW3Bnz0MxGKZmGbIG1E36JN6HOtdn416YxmDibeYUc257Wp/wOUYIrBH9yoJxFWdrdFap61SU4LZhA5EzGMKqRDOeWJKGlwiA7vdyVdh0AxNonImLh+anAdP1X16zX6j7zsDQ3PsooaDTfYXn+3+Xrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=1rTnmhKr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313a188174fso3960155a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752470081; x=1753074881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVLc3fUMzxgW8xHGt3aOxgjkiRm4u/5qntRvjaaCo+s=;
        b=1rTnmhKraX/z1cGttwsns3U6ryIYqc9O/UzuJZfNe7AwzMdXCKc6PmxG+bZMtKuRg1
         8pLAc6wHbUH2gLCr6zWmxbkq6Tuh+j0FIKc0nIX5zbeP8RAx/obYfv78uPfzuSBYoD+W
         LFBFAMsgMq96XU2PW09Nn9Cme+Q8uMvMKvp6PVupeiryZDZIqeC+ieiA03xikhLpwW2g
         jMOHcMoT0Z5iPOzVeo8DGa4r1i99enDJrBUEebL3zSs80zqW9JyTn2+8LKSkkknh9foI
         lBo1wG5LblXf09m53yw/6GJhnDrSMFeKz/wAXddyUx2IP9I3P1y5p88a1mzF4eqdXnpt
         HT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752470081; x=1753074881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVLc3fUMzxgW8xHGt3aOxgjkiRm4u/5qntRvjaaCo+s=;
        b=bXEjUQUAVJ3Skc9JwufZEigLTaZhvX+Cik2Tbz8aQpAxCQjnGVMMXhqGmcDOZuUnlD
         iYqXh1mFDs9eGWCuYNc3A2pOY3OrzDzb2/ypNV+r96TxcULrTYGq+rRkzJDJV/CM9Kme
         Wa4qswXlMkBzYFFE+kWVUbs6GD/jb+e0g5ab+uYTeUrDEUHxXsdrJAklQevT4q0F3yjL
         9YDc5RntQl15C76IRSPYwMzCME4GhA4tnobKGdmYmo//pwKjmcm/Rx3DtoZd0UV1ifxD
         tOpMggMf8CpD81rf/wPdxIqIr4cD/f8z4TJD2L7GxYiLsfi6Axn6KosmGnz9OJduePtg
         CkRg==
X-Gm-Message-State: AOJu0YwDiTFWKsRXLyQ7easkHTtdlli1nnlsdL3oM89UqmzNjTx3grmb
	hCmAcKlwZUj4AFO1psrIkWZ0Z7MrNfPfkd6PvS31rwZvpj3mInrx6kKDDqNw7fdUDTQ=
X-Gm-Gg: ASbGncueC06w/MLKYgYRvFLNBDghBIkEdkAI/tIf8oMgIv7xLkF0EHaqCpyy/Zok6sd
	ArqiILbito+E710mmMEs9gxrRYeZALczzSF8GDjGkMPU54nJGYYGGLN3hHPTmzVptcufZe9OtwK
	J8ZtkoBpj15/EwHumwDry75YLTLEzpfU7ikfycKh1MYiYUAoxqeTCxfrgc0iZxH15e4uk3ZbU1K
	gPsW4MhK8Zlfdjignz313DKgXhzi/g2jsmjpY1fd/1vUziY/vYtIZBtSETJsrnStr+AWI3iMk78
	bZxc4fLFEJYDdPaCIe0kU2yRIzw5iS6O2AVSPGKglsB83dQKVA5dQPMgnl2IMdA8pUFYQrkI+it
	1bDEXLV32q8cw3K0lmoRr3FS2h4o3OlK08vFiSq8OGGPFUHg51vz4+pl5mvZD27fFL/uDi34=
X-Google-Smtp-Source: AGHT+IGGZRuEX8/A594KYjddEISULuhuuw77y2z+mi8dpAq/w6CqYIGqr0You3DoTTXOpd7kFG108w==
X-Received: by 2002:a17:90b:3512:b0:311:be43:f09a with SMTP id 98e67ed59e1d1-31c4d4d0733mr15585012a91.9.1752470080592;
        Sun, 13 Jul 2025 22:14:40 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb61291sm9881930a91.34.2025.07.13.22.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:14:40 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC 4/5] wifi: mac80211: support returning the S1G short beacon skb
Date: Mon, 14 Jul 2025 15:14:02 +1000
Message-ID: <20250714051403.597090-5-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When short beaconing is enabled, check the value of the sb_count
to determine whether we are to send a long beacon or short beacon.
sb_count represents the number of short beacons until the next
long beacon, where if its value is 0 we are to send a long beacon.
The value is then reset to the short beacon period, which is the
number of short beacons sent per long beacon. The decrement process
follows the same cadence as the decrement of the DTIM count value.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/tx.c | 104 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 4c457b715b22..c04f79875eda 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5297,14 +5297,14 @@ ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon,
 }
 
 static struct sk_buff *
-ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
-			struct ieee80211_vif *vif,
-			struct ieee80211_link_data *link,
-			struct ieee80211_mutable_offsets *offs,
-			bool is_template,
-			struct beacon_data *beacon,
-			struct ieee80211_chanctx_conf *chanctx_conf,
-			u8 ema_index)
+__ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_link_data *link,
+			  struct ieee80211_mutable_offsets *offs,
+			  bool is_template,
+			  struct beacon_data *beacon,
+			  struct ieee80211_chanctx_conf *chanctx_conf,
+			  u8 ema_index)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
@@ -5365,6 +5365,80 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	return skb;
 }
 
+static bool ieee80211_s1g_need_long_beacon(struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_link_data *link)
+{
+	struct ps_data *ps = &sdata->u.ap.ps;
+
+	if (ps->sb_count == 0)
+		ps->sb_count = link->conf->s1g_short_beacon_period - 1;
+	else
+		ps->sb_count--;
+
+	return ps->sb_count == 0;
+}
+
+static struct sk_buff *
+ieee80211_s1g_short_beacon_get(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_link_data *link,
+			       struct ieee80211_chanctx_conf *chanctx_conf,
+			       struct s1g_short_beacon_data *sb,
+			       bool is_template)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_if_ap *ap = &sdata->u.ap;
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(local->tx_headroom + sb->short_head_len +
+			    sb->short_tail_len + 256 +
+			    local->hw.extra_beacon_tailroom);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, local->tx_headroom);
+	skb_put_data(skb, sb->short_head, sb->short_head_len);
+
+	ieee80211_beacon_add_tim(sdata, link, &ap->ps, skb, is_template);
+
+	if (sb->short_tail)
+		skb_put_data(skb, sb->short_tail, sb->short_tail_len);
+
+	ieee80211_beacon_get_finish(hw, vif, link, NULL, NULL, skb,
+				    chanctx_conf, 0);
+	return skb;
+}
+
+static struct sk_buff *
+ieee80211_beacon_get_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_link_data *link,
+			struct ieee80211_mutable_offsets *offs,
+			bool is_template, struct beacon_data *beacon,
+			struct ieee80211_chanctx_conf *chanctx_conf,
+			u8 ema_index, struct s1g_short_beacon_data *s1g_sb)
+{
+	struct sk_buff *skb = NULL;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (!vif->cfg.s1g || !link->conf->s1g_short_beaconing || !s1g_sb)
+		return __ieee80211_beacon_get_ap(hw, vif, link, offs,
+						 is_template, beacon,
+						 chanctx_conf, ema_index);
+
+	if (ieee80211_s1g_need_long_beacon(sdata, link)) {
+		skb = __ieee80211_beacon_get_ap(hw, vif, link, offs,
+						is_template, beacon,
+						chanctx_conf, ema_index);
+	} else {
+		skb = ieee80211_s1g_short_beacon_get(hw, vif, link,
+						     chanctx_conf, s1g_sb,
+						     is_template);
+	}
+
+	return skb;
+}
+
 static struct ieee80211_ema_beacons *
 ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -5388,7 +5462,7 @@ ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 			ieee80211_beacon_get_ap(hw, vif, link,
 						&ema->bcn[ema->cnt].offs,
 						is_template, beacon,
-						chanctx_conf, ema->cnt);
+						chanctx_conf, ema->cnt, NULL);
 		if (!ema->bcn[ema->cnt].skb)
 			break;
 	}
@@ -5417,6 +5491,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_link_data *link;
+	struct s1g_short_beacon_data *s1g_short_bcn = NULL;
 
 	rcu_read_lock();
 
@@ -5438,6 +5513,13 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		if (!beacon)
 			goto out;
 
+		if (vif->cfg.s1g && link->conf->s1g_short_beaconing) {
+			s1g_short_bcn =
+				rcu_dereference(link->u.ap.s1g_short_beacon);
+			if (!s1g_short_bcn)
+				goto out;
+		}
+
 		if (ema_beacons) {
 			*ema_beacons =
 				ieee80211_beacon_get_ap_ema_list(hw, vif, link,
@@ -5458,8 +5540,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 			skb = ieee80211_beacon_get_ap(hw, vif, link, offs,
 						      is_template, beacon,
-						      chanctx_conf,
-						      ema_index);
+						      chanctx_conf, ema_index,
+						      s1g_short_bcn);
 		}
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
-- 
2.43.0



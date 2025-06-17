Return-Path: <linux-wireless+bounces-24181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96FADC436
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CB4188772B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A02951BD;
	Tue, 17 Jun 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="rjFaE+/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AAF2949F4
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147646; cv=none; b=nqU7GsumtwxoWn1jJQcWWy3ZwNAbMJNVLvIubmSFwUDe4vGHGqAIbc6A3pKViFunFWCswyZqyavFGuYH86Sp2uvdi5DcGJjI8yeWzeNs44xu/KeKe0OUaEfjPHhJ8yo7/Tp03vOTglfZi336ouSErGEvrMvWz9m0Ry2ITA3XHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147646; c=relaxed/simple;
	bh=tKRyA8yA9t41xc38ctw0kuKDSgOHujb2VNKXDYiQPvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jADfLYfEzEtLv8JOS1mVimC7Tvp7GiVJd26d4OU8C5H2IW7tDKeYsAGBExeZ/GSoRYD3aeqmV6hXnuv5YUyR3NWWXH18QNvisppqrUMUUDL/MG86jhAWKkzXp7gSdQuOKWz1UzVK2aFBVOdM9CYmktBnxtZbHBMu2Rsx2UHmDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=rjFaE+/G; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4087186a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750147644; x=1750752444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH9dkbwULtT45Jr2BipiuLPsD1wQyP6pP7YULQg1NWo=;
        b=rjFaE+/Gz1c4HLpEy1V9KyTCf1ulblqrdCcBVc+uuM8nRUZ6lEqjmiz4sSIAfLWv6a
         MCOA/KokfCvx+ftexxF3YhoZYWc3cl/fFI/vXZ+bLD48H4RTZlGVxcmS2F1GSsIOEfwX
         /VFARCAXsBl56mnOAqujKxJIDUeFwHfx2CHLSdcp3eZWK6DlVZ+u0AnJCWynJeUKoeYr
         E1UPEL6NkUhnG5fuBQOUuMFeMbhOkDt4zcrgcekITF9XE8N5yr3InupmLyCba3V6aXYP
         dvkrXQT78ay56bJa3povGEWoymgJt+h2ozywmx3eUCnAsNVd3QcnvSYuAbSEn6BxVLdM
         vM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147644; x=1750752444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH9dkbwULtT45Jr2BipiuLPsD1wQyP6pP7YULQg1NWo=;
        b=C3C2xY10UB823QzjZAGRR81517gprkEnPrUOO2kmn7SAfWZ25CIoSiuAQaqOvIWE+P
         pZnj+oW/R+NjxtJuwx8/7OnOLnuZKi94GJPDm3CJh1TvMh7YkOqOLgOItXaSuzJdCYjz
         yjsc4CXLKSmdy43TIZjif6P/v0PvvJRyMlXOjFACg7sW+JWfUyAPuLmmnLpTDAaiGksM
         k6j2vAW3sCGBNBi/R0hKaYYw1CntnzXuo3JfCQnu7sCgr5Sznh30cJH1lnEsP7lz2MM4
         T8BwKGei6q1luddZDhwz0SwF+Me9bIUHb1U3AKNV5CIzzErzJiro+aiX25L+WhAX3Ptd
         0YJQ==
X-Gm-Message-State: AOJu0YxJU3zcGanKzFIetnRMzLZso2gUP8e+TH7cs4alV1qLXh5fT9E6
	Y3v9vozbSgXTSa42FJIEzF2mKBo53J6RfLC5ev5ltOr400ncLWuBI/qeGw7xUBSxvuU0Eqrynwd
	mJsrlF8g=
X-Gm-Gg: ASbGncsJ0o3iL53tIVQFx01/ETLiiE+2QUQ8AmHUzeHjjnB/svoz//Hy11niCZ8W0RV
	yZ7e2FzKxbNRUF4EGNoky2BR88Q+EGXV1bgbzeTlrpZ3glcezlarxcDsMlA9v1KGkJwNMXXKIvA
	k81HnIRpAb6QnYcpS+rsl73bl8YHCexmBvpufgGUdKfzPV8ZFduqQikZFNXiFYGHKliYEL2MroF
	rGcskbseEZmBhwEDs4H65c1RlcKpuPMIYCQsC7WwiEo3h/Z8oQ3+g94NFgfCgAN70Wi3qRY/tTM
	sZDYlO1flfW/lse/ChfwPdbC2hOFCppMpQjZEazbZBdosYxS6hlIilY5CduGv7H1jQ16R1Zrp6q
	ZalSxgFXFNQhOC+AcjgSl4dFPg9/WT1omibWH1b1eg6X1XQ==
X-Google-Smtp-Source: AGHT+IG7tB7zTy5hA2getHiYSnIuMADnl84OvLUfKvMOPV/OL6SdC9Bu/obhPRkwRmdjRFGk5LuiBg==
X-Received: by 2002:a17:90b:540e:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-313f1c7d714mr16246995a91.3.1750147643891;
        Tue, 17 Jun 2025 01:07:23 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31413d2c8fbsm3579365a91.10.2025.06.17.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:07:23 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Sophronia Koilpillai <sophronia.koilpillai@morsemicro.com>
Subject: [PATCH wireless-next 4/4] wifi: mac80211: add support for S1G aggregation
Date: Tue, 17 Jun 2025 18:06:10 +1000
Message-ID: <20250617080610.756048-5-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
References: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow an S1G station to use aggregation.

Signed-off-by: Sophronia Koilpillai <sophronia.koilpillai@morsemicro.com>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/agg-rx.c | 6 ++++--
 net/mac80211/agg-tx.c | 3 ++-
 net/mac80211/tx.c     | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index ee534797c033..e38f46ffebfa 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -299,7 +299,8 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 
 	if (!sta->sta.valid_links &&
 	    !sta->sta.deflink.ht_cap.ht_supported &&
-	    !sta->sta.deflink.he_cap.has_he) {
+	    !sta->sta.deflink.he_cap.has_he &&
+	    !sta->sta.deflink.s1g_cap.s1g) {
 		ht_dbg(sta->sdata,
 		       "STA %pM erroneously requests BA session on tid %d w/o HT\n",
 		       sta->sta.addr, tid);
@@ -327,7 +328,8 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	/* XXX: check own ht delayed BA capability?? */
 	if (((ba_policy != 1) &&
 	     (sta->sta.valid_links ||
-	      !(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
+	      !(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA) ||
+	      !(sta->sta.deflink.s1g_cap.cap[3] & S1G_CAP3_HT_DELAYED_BA))) ||
 	    (buf_size > max_buf_size)) {
 		status = WLAN_STATUS_INVALID_QOS_PARAM;
 		ht_dbg_ratelimited(sta->sdata,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index dbd9ad5f3992..d981b0fc57bf 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -616,7 +616,8 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 	    !pubsta->deflink.ht_cap.ht_supported &&
 	    !pubsta->deflink.vht_cap.vht_supported &&
 	    !pubsta->deflink.he_cap.has_he &&
-	    !pubsta->deflink.eht_cap.has_eht)
+	    !pubsta->deflink.eht_cap.has_eht &&
+	    !pubsta->deflink.s1g_cap.s1g)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(!local->ops->ampdu_action))
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d8d4f3d7d7f2..691ea2d32e82 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1173,7 +1173,8 @@ void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (!sta ||
-	    (!sta->sta.valid_links && !sta->sta.deflink.ht_cap.ht_supported) ||
+	    (!sta->sta.valid_links && !sta->sta.deflink.ht_cap.ht_supported &&
+	     !sta->sta.deflink.s1g_cap.s1g) ||
 	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
 	    skb->protocol == sdata->control_port_protocol)
 		return;
-- 
2.43.0



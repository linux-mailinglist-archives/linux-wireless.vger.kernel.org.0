Return-Path: <linux-wireless+bounces-27868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC796BC31DE
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61B0734DC54
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7AE28D84F;
	Wed,  8 Oct 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="gMjzIcoc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79241286413
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759887624; cv=none; b=GnxkBeEedkYf8EUQfSp338PCsmVpTP9Z422W7xBX1Pv2M9yrrTYvMJEfre4jEYYq6TKj9olrXoA4VYVneP0Y90qcmuS1pu38m2BO7Xy3qsVj9JhNR5I1EkQG5fD5+cd+oUrKcebzegNpG+iv74xufO/1OAi5PMTmBOAU4q6qCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759887624; c=relaxed/simple;
	bh=CkTbyEC2YU+y8qtIXPNK5MWAqjP0nIpifyfONp32jJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzA5GGQ9e1e6zMn6vmvYslLgj4lwWnvwa+J0WQVY2Piqi9DSsZNJwrchwqQct8TTl8iA7FSevNQIj1DzGr2opwrLTiIohzqip2FzN9/pN9n58MtRFKtjjGNLdw0K/g+pIy0UOJuKKabqVpmvsLimD6fayLhcU7c5sTWd9i7X+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=gMjzIcoc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so409315b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 18:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1759887621; x=1760492421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtIpp9743/Mu1XZ0gD9Ou/X+3KiBhmq2ozuwA1sacp8=;
        b=gMjzIcocO2j51vMq2Ptb3GOIAzWYfieW3fnLhKR27o2dGzlK7OUQJSrZT2HoXexiKq
         +dqpWPvzzr5Q3ov6CkvgVasB2SQp96U9qV3VRWqcmXX+SKkaPqDOtfH3FkXPQsvhD66m
         +bv9VdLotWOPiYeeKEP5Es6/mkQb014OOMxIDO1ztI5PWIgSeCXhsXtEf9dn8EAc12Hl
         6pp/QzEe+JuTYIhLCT/U9L5cndxfqFk+oKCrSASREl4IV3hJ7XX0+xOlaml4Cf/bn4sy
         1BRKljWa55Hly5Tam7B+QSEFrAbk9NYMQSGuh0NQ8oBNfUjBfopboGKF4Y9HuRpGlOxj
         djGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759887621; x=1760492421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtIpp9743/Mu1XZ0gD9Ou/X+3KiBhmq2ozuwA1sacp8=;
        b=H0mWzk3STkWOhJQdY5rG4Zhh64B/AbUT4Sn/acjPQEXlvf8FAll0R4xro6a3Msf0wS
         ZlzKdf1oONGevvAUTXVZmvg6/xw7o4Fnrj4nzlMnkjqL2aAsNaROkjDMohY2SjgaQe7c
         JPe671lReADgIN5SdHULIYmmUgKKWChUJ1QxNnEMPiIFNqYJcDX4hz3kuFEGSBNwvuqb
         xVduG+L+FKXfqUchFQ9V2OhtYaNKMqS0LlKjbs+5lg81d4z29XurO2l2TNNKiBFQ5w1m
         zzSfgm4J0Cb/D0peydzv03610bnj/cQvpZEeb0I8tOKO0JdDQeExRWijECuZTIzqaSLM
         lKbQ==
X-Gm-Message-State: AOJu0YxfNtLcPIHf+ayXYOvc/c1WJoFEVtllbzAyh0labkYXbHnXQj9V
	DLSln1tV74jba3F1rt56a+D9LRLeDIC7dwmv3UPf8ADnBqB4sCKLBKqNYZh31ERE0Io=
X-Gm-Gg: ASbGnctjfgfI9jljElOH9x819AadSky+iDTKOtY/1RztvxcrNVXdXz71j1v3A5SVTtf
	tuiOhfLZ215D/SC7fc7b0479Q+R14+EcK5fKQCwp/XcjnGIRYa3iES6rS8Me3LowuloqBrJQ2af
	L8sLc9USsJPIovpW54OO/vNEjUH++A5yguh7kbwHDGwfA5P4qmsuNuTWDoM/bzC/oSHTvgIDEnV
	zzbZaeoZPhL/io/ilJFuk63ilzkxnkjFS3XaFqV3kC153+A2vB3Q26GiYea7QkWgOqF1uTgAaHR
	5Es2xvN8RMWplhv3wvDiCKOBzgAiSBA7AX0FAzjIrwfmFOHm9xdZn/jYJGL+RSNpdUqhHiu5JKH
	tGj4/z05G5PdsVvdtXkuMY76DpxKgx2Ef+YHQIBDJ8eOBwVxtHrZXKoocFjoMgqQRzDICZ1ZcRE
	HuBd5Kn33KeG2lHJtMMso=
X-Google-Smtp-Source: AGHT+IHbaJNtI1Hxg20n+uSFaukQ15RzWPd5yoXe/myvQwmk9GAn7wnZdt/aXbIu5niGvwn/Zw7sDQ==
X-Received: by 2002:a62:be0f:0:b0:77d:98ee:e1c5 with SMTP id d2e1a72fcca58-792323cfdbfmr4864790b3a.15.1759887621327;
        Tue, 07 Oct 2025 18:40:21 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205341esm16925993b3a.42.2025.10.07.18.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:40:21 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH RFC wireless-next] wifi: mac80211_hwsim: dont perform rate validation for S1G
Date: Wed,  8 Oct 2025 12:40:06 +1100
Message-ID: <20251008014006.219605-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mac80211 does not support TX/RX rate reporting for S1G bandwidths and
as a result WARNs occur during validation as the default value of 20MHz
(0) is always higher then the highest S1G bandwidth of 16MHz. This
prevents association from occuring in some instances.

Skip bandwidth validation for S1G interfaces to avoid spurious WARNs and
ensure a clean association process as there is no support for S1G TX/RX
bandwidths.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
This is kind of a bandaid fix (hence why RFC), but implementing proper
native rate control support for S1G within minstrel and mac80211 is not
pretty (lack of flag space, ordering of RX bandwidth enum, aliasing with
VHT flags and a myriad of other issues). If an S1G driver is submitted it
would be considered a "modern" driver and would probably contain its own
rate control. There has been some S1G hostap work recently submitted [1]
though it's only STA side though this will need to be fixed in order for
proper tests to be run.

hwsim tests were run, with the following errors occuring on the tip
31dc1462a Define QCA_NL80211_VENDOR_SUBCMD_GET_COEX_STATS. All dpp
errors are related to some OpenSSL python error and the bss config
file test fails to open some trace file.

dpp_config_connector_error_ext_sign
dpp_config_connector_error_too_short_timestamp
dpp_config_connector_error_invalid_timestamp_date
dpp_config_connector_error_invalid_timestamp
dpp_config_connector_error_invalid_time_zone
dpp_config_connector_error_invalid_time_zone_2
dpp_config_connector_error_expired_2
dpp_config_connector_error_expired_1
dpp_config_connector_error_expired_4
dpp_config_connector_error_expired_3
dpp_config_connector_error_expired_5
dpp_config_connector_error_expired_6
dpp_config_connector_error_missing_group_id
dpp_config_connector_error_no_groups
dpp_config_connector_error_empty_groups
dpp_config_connector_error_missing_net_role
dpp_config_connector_error_net_access_key_mismatch
dpp_config_connector_error_missing_net_access_key
ap_bss_config_file

[1] https://patchwork.ozlabs.org/project/hostap/cover/cover.1759334464.git.james@teledatics.com/
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index dde6a622ff72..e3688beb086b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2096,23 +2096,26 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 				       txi->control.rates,
 				       ARRAY_SIZE(txi->control.rates));
 
-	for (i = 0; i < ARRAY_SIZE(txi->control.rates); i++) {
-		u16 rflags = txi->control.rates[i].flags;
-		/* initialize to data->bw for 5/10 MHz handling */
-		enum nl80211_chan_width bw = data->bw;
+	if (channel->band != NL80211_BAND_S1GHZ) {
+		for (i = 0; i < ARRAY_SIZE(txi->control.rates); i++) {
+			u16 rflags = txi->control.rates[i].flags;
+			/* initialize to data->bw for 5/10 MHz handling */
+			enum nl80211_chan_width bw = data->bw;
 
-		if (txi->control.rates[i].idx == -1)
-			break;
+			if (txi->control.rates[i].idx == -1)
+				break;
 
-		if (rflags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-			bw = NL80211_CHAN_WIDTH_40;
-		else if (rflags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-			bw = NL80211_CHAN_WIDTH_80;
-		else if (rflags & IEEE80211_TX_RC_160_MHZ_WIDTH)
-			bw = NL80211_CHAN_WIDTH_160;
+			if (rflags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+				bw = NL80211_CHAN_WIDTH_40;
+			else if (rflags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+				bw = NL80211_CHAN_WIDTH_80;
+			else if (rflags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+				bw = NL80211_CHAN_WIDTH_160;
 
-		if (WARN_ON(hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(confbw)))
-			return;
+			if (WARN_ON(hwsim_get_chanwidth(bw) >
+				    hwsim_get_chanwidth(confbw)))
+				return;
+		}
 	}
 
 	if (skb->len >= 24 + 8 &&
@@ -2677,7 +2680,7 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 
 		link_sta = rcu_dereference(sta->link[link_id]);
 
-		if (!link_sta)
+		if (!link_sta || link_sta->s1g_cap.s1g)
 			continue;
 
 		switch (link_sta->bandwidth) {
-- 
2.43.0



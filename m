Return-Path: <linux-wireless+bounces-29305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF2C832A1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B03C3AE162
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656D41DE894;
	Tue, 25 Nov 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="i6NbK2PT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03CF1BBBE5
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039601; cv=none; b=OatvTceRN5oaoracrzZTsYwU1sDMINvO+eR8GBm0rpcMGnAF3n7L7kDVT//crwShz1QhSZpmpLizQGBZsvqYPo5wUQetP4n3fLd59xm2wvOG0fRafqqJ1EP/RMcGQlTE/K0QyqvNihsr7PxEM5d9nyUqpQ6MAmRB8k8znP7N4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039601; c=relaxed/simple;
	bh=OgC1jFhMecO8t9DeDVmalxOCA1ImE4au+fc8IcfFIlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUse8TbfSxu8wrkqb+3VlgsxOuAh4uN3DU3DuoR1d0vi8r/oR+/GkK7LbYdi0wzSBkTpdwU3zRel4BuUZy0vMA3xvmS+TzAGwv0y9qiWERuCW5UO77M0VES7Ciprh0jhbayTuiqxrRteAyY0T5g3BhP4WtWyUxIExh7K6dV0SM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=i6NbK2PT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-794e300e20dso3133531b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 18:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764039599; x=1764644399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbuJa7samYUY+Tq4OjPTIkmUTu9YkxNs5Fio/oZ7Szo=;
        b=i6NbK2PTlCk4HPGkmnJdXHeRCbnUCOIPWO8Z2Lb76EgiUMtvRtjyQbNbyUqWn8H7Kt
         BsL7x8nfPmHUMWKViNUYuLdsCgQ2IqlNfLN6/WGT6mrOqw2VliNPwlpjBAWeT9S395yb
         UBNtGWklTkG6/a5IwC2vQSi46YXU6kDvsRwLdCqPUXwdfT+0k1cpNvVDwdr9EV4oGhxo
         MnzKzHkiuVm5wqkScjPCfCKjnSQyhnTblTopm63Qtp1NDT8Gw9JG9qFbGLc/LORBkJWT
         Sq6KcbkAyvIFg0EjsFqe50g6yzF52U/qZOgCA3auNnxWvUQkErXHTMC+PaW//3sZ64sb
         lOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039599; x=1764644399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbuJa7samYUY+Tq4OjPTIkmUTu9YkxNs5Fio/oZ7Szo=;
        b=vtMYXdIGl/WkWn0cBil/L/mdEDKR6xUtUusWWdaGlKHnBY01piWqd41GY5yqloIF2V
         7TWnwvwBu7Guz30IvjRN8EnxIahrN3eUM7A0DiyOOFHMMx806Ye3m7qUrgDdYcWOOOy9
         Od8/kq+n58ykjk3Wq2/g2BsVCcVg1kfcfSOlgVBwmFZb9VJUIlhJbd1Z4bGeYZSh8q7D
         6fMocstjEeii0EHbh8kcLQBQd+tH1nNlHU1FgBhBnf1+Q+jPnGmHLNGAFzQnPIBtt4rL
         /bvXAhdaP8gbhmazHZc8NEoCceJZ0hm60cJn12ljlyFb2np2G6ixsQChe+gi2y2n7UKO
         fWZQ==
X-Gm-Message-State: AOJu0YwGLu+gTwUU8u/Vux0hpkWeTV5CfSgRa/Vmb3n/rCpU9ixARob2
	hNtAcBrDYE/egcEsePd4UYm9AyAk5U6TwtUmhqNSaUPrysUzKlJKF1Ru+oac1NYba9E=
X-Gm-Gg: ASbGncu9pjL3kTCJxFrbMPlFZcC6/riMepCcvtZO9rM8dWT6NU8KaiWTx3TmBAWb19u
	JRi1JHsiYnG1X9U5ntcuf5Bg3pNBoHUepQgQpM1Y0hwPn+0QkR7mL6+K7ukxlolTQE8qrygzjun
	ydWHomrphK/83UuQnLBv1yfHLutOYeNFnh2MYCQrwEBpEPzfQfLH4dXKV2D3tx+YRu+fGuk/Ula
	DQJfXSXXzp3zZc7HnZEnECBGAKzjQeDbCX/ASqmWj9yhnvjI0wohuDLyntEmGHu64EYJkklj9Kj
	QIbDCJVVLHe+/OjQ6R7MxIxfo4pl1PCf1dTLiqM66BOPCukSFACGFnu63GEiL54RrNLtMl1Bgg/
	Ru5KbGDPFoRmCRzj/oaCwfGl9a8UgKdu22vO2TED+zzxkkAqe9irVyvXrfI8llwL2A8SOWBkvy1
	/IlWh1CS5+Fx8BgbmK8mvo6EPH1Yxro9TL8OESYHWwprNdkJcV/V+T9TYb5KbBVYCYPaOyXo7P4
	Gg9/Nru2oL6Bgw3IQyvic8aQ2QthA==
X-Google-Smtp-Source: AGHT+IErP5lyUtGZ17CAjwaSIES6/nWAbs0AJwjMgPE74nmG8ry7BPgbgi9Xka99G4k2kfEEV6vK9Q==
X-Received: by 2002:a05:6a20:1590:b0:342:a261:e2c9 with SMTP id adf61e73a8af0-3614f2536e8mr15243293637.8.1764039598893;
        Mon, 24 Nov 2025 18:59:58 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e9b1239sm14549915a12.15.2025.11.24.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:58 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 3/3] wifi: mac80211: allow sharing identical chanctx for S1G interfaces
Date: Tue, 25 Nov 2025 13:59:27 +1100
Message-ID: <20251125025927.245280-4-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
References: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for sharing identical channel contexts for S1G
interfaces. Additionally, do not downgrade channel requests for
S1G interfaces.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

I've kept the WARN_ON(1) here, though it only *should* be hit if an
S1G driver advertises num_different_channels > 1 and starts a
non-identical interface, otherwise the connection will be rejected
earlier when verifying the iface combinations assuming
num_different_channels = 1 (should be every S1G driver at this point).

---
 net/mac80211/chan.c | 14 +++++++++++++-
 net/mac80211/mlme.c |  9 +++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57065714cf8c..f73973096097 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -530,8 +530,20 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	};
 	u32 changed = 0;
 
-	/* expected to handle only 20/40/80/160/320 channel widths */
+	/* 5/10 MHz not handled here */
 	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
+		/*
+		 * mac80211 currently only supports sharing identical
+		 * chanctx's for S1G interfaces.
+		 */
+		if (ieee80211_chanreq_identical(&ctx_req, chanreq))
+			return;
+		WARN_ON(1);
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
 	case NL80211_CHAN_WIDTH_40:
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 025210d50405..e4814cb1c181 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6122,9 +6122,14 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	ret = ieee80211_link_use_channel(link, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 
-	/* don't downgrade for 5 and 10 MHz channels, though. */
+	/* don't downgrade for 5/10/S1G MHz channels, though. */
 	if (chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_10 ||
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_1 ||
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_2 ||
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_4 ||
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_8 ||
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_16)
 		return ret;
 
 	while (ret && chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT) {
-- 
2.43.0



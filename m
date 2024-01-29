Return-Path: <linux-wireless+bounces-2679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA7884129E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68C1B21BDC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0913D4FC;
	Mon, 29 Jan 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i8OXWIsr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DC76C89
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553678; cv=none; b=MG8w8DPysH0yB42vS+sTHCdzh3kfkh+UR5P2er81f2fb+DZcUcrXcTInBRdBcvoWZ7usE+k69UE5X1TLYHSuSjG64YQZOcDdJVlYkTkzGSRQllMOIl9ngaWwmHgkUbrf72jUceRw/sR0YFp5UUXR5DXsx40UcuJboyEwccJPQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553678; c=relaxed/simple;
	bh=VQb7Z3c83IMjTtkgOKpGSGaAY2AcqYH7tFOLfHL+0J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZn4+WYdOV4TtOrJyi62TgCdhXMIug6e6hagXrWLoGN4QXX+HhXQ2IC54rsl0qcWo4gXfwqpO9KA6+IYzVge4Mzn8V1NjC4VHabpWdLdFkmCkhp1VQ/YEMzqGb9GrkZ3btYi9EEt16OB5TIHx/5O8bXAMbcxJqNbGZLl6qmwkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i8OXWIsr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h7oKX/Ve1ebjmlKJSTTAxtW4cpuVGDXs8Le8zrJS7xU=;
	t=1706553675; x=1707763275; b=i8OXWIsr9b+LGPUSrtYlj9uDw9rSdA1YY91gS82wthtIPP2
	rLmskf8OlO05zcFBwACh1H9x4v47Qc3kxOhQDLZwrpVQZSWO2YzDRdHI6FV8clyXxJoEGvWJkGy03
	bld+7S7Yd2E4DEwg6oecx7YyvQj5+FvABL/o2I3QSKahRWbI3IMcxqHzVai0ZLawL+kcJ2B5txccG
	GLcYbGJ5vcTldnPI7f8Vip7YWEjc7Z0WIby7tf8p33hDaXBnMe/zwrQD6hmKsHmOSOCYbs+8cU56S
	cB1iyivUfee95HQ8oKQhUDhys/yjnB564oevjpP41aNBpu+02T2zeoTV8I2XnkJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZE-00000004z9N-1VCa;
	Mon, 29 Jan 2024 19:41:12 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: mac80211: clean up band switch in duration
Date: Mon, 29 Jan 2024 19:34:35 +0100
Message-ID: <20240129194108.70a97bd69265.Icdd8b0ac60a382244466510090eb0f5868151f39@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Most devices now do duration calculations, so we don't hit
this code at all any more. Clearly the approach of warning
at compile time here when new bands are added didn't work,
the new bands were just added with "TODO". Clean it up, it
won't matter for new bands since they'll just not have any
need to calculate durations in software.

While at it, also clean up and unify the code a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 68a48abc7287..e424a3ee0652 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -133,6 +133,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 	mrate = sband->bitrates[0].bitrate;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		struct ieee80211_rate *r = &sband->bitrates[i];
+		u32 flag;
 
 		if (r->bitrate > txrate->bitrate)
 			break;
@@ -145,28 +146,24 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 
 		switch (sband->band) {
 		case NL80211_BAND_2GHZ:
-		case NL80211_BAND_LC: {
-			u32 flag;
+		case NL80211_BAND_LC:
 			if (tx->sdata->deflink.operating_11g_mode)
 				flag = IEEE80211_RATE_MANDATORY_G;
 			else
 				flag = IEEE80211_RATE_MANDATORY_B;
-			if (r->flags & flag)
-				mrate = r->bitrate;
 			break;
-		}
 		case NL80211_BAND_5GHZ:
 		case NL80211_BAND_6GHZ:
-			if (r->flags & IEEE80211_RATE_MANDATORY_A)
-				mrate = r->bitrate;
+			flag = IEEE80211_RATE_MANDATORY_A;
 			break;
-		case NL80211_BAND_S1GHZ:
-		case NL80211_BAND_60GHZ:
-			/* TODO, for now fall through */
-		case NUM_NL80211_BANDS:
+		default:
+			flag = 0;
 			WARN_ON(1);
 			break;
 		}
+
+		if (r->flags & flag)
+			mrate = r->bitrate;
 	}
 	if (rate == -1) {
 		/* No matching basic rate found; use highest suitable mandatory
-- 
2.43.0



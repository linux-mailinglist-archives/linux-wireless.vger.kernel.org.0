Return-Path: <linux-wireless+bounces-28125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29571BF4AF6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 08:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B533E34EA44
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 06:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060C2F872;
	Tue, 21 Oct 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="waq0TsDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588F433B3
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027116; cv=none; b=K54pBc5EtYGc8aCZdMSFhiGTr3NYbw1UHTMbFJhX3ySJv4p4MR/EzmH1qoaPNKka1fuBdFf1U20ULtdq86FXXSJY++TqrDGGjCE89yYZOisFjS/5olt9wZx7w7XWNFboTgf/bnqnxf7udGoRdeLu6Klta0iui1Pw9HoJMYsb4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027116; c=relaxed/simple;
	bh=LfHuehJpSQO7Z1ulPhCSzz1CNP/l/f9A1tQTBYuQbHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAl9gms3HlgdGUR2FT8+aZirb5t4tB/M8Hh9VGPreFQEAgtuh2WKxII7AErMR3vuaUdMLnDF9gtK8oLj16cc4AmBTptoqGh3IqdGq85jWKiMbYfNVYRXQK6IZzhSPyacvjQrw1mmJKHuykcIDIvjeE0GdCJ1Me22G921zr/TTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=waq0TsDz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7835321bc98so4542380b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761027113; x=1761631913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpDtB623tLfWD8W8ugSe6BeajTT1vCxvUWnhw36fZgU=;
        b=waq0TsDzGkHJjr7JNsTPLMwSq5KDhTNpxPxNLVZxvK57WIyehgSi3VaRLgzEiEkSNW
         JyBrgngSlLvCHOKvDooRfkKqpJXtFI2DSNwjU05Ty2u9OiOwSaaBJ6SYbQ0EJMg4BMNo
         ZWSBBCCS6fBn5R5u2dex/dSoaS+b9W50CIvkE655+bH3u0x/gyO6el6AcEVX76CGB5Ge
         GesOvSJmZhPOivGWJrIfPw9Run5JiVtxNA69nHHxl7fYCoH3P/EKR9OCAlXKvPGY+Sjm
         Xf1YhVrhgFtOltizLV2wk5x9qSobmKleVFsTKaff0wAWcA4NS+JIXiDW5gYebQ+8s+r/
         f3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761027113; x=1761631913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpDtB623tLfWD8W8ugSe6BeajTT1vCxvUWnhw36fZgU=;
        b=JxWejobx50CfXEgb9oXJopzJwIKf/txOjVc2SuU8lptbOUL6eC2bstpIclcxniA37j
         xrN//ZvF6scd+dSAg7Ykth+IUBPixJ4hQ1bacMCYt/uTR2+TqGZtCz4+s4LTJP/XRrZE
         gsuziuD0HYgCqCFznZk1cixoTuvez+5yPAwe5gxHKxoGrtaZjHHDBUklVwsoa38G4CS4
         myWI6m5YCorL2aD0EBXqS5tHPSBuMzWmKT9w6w7FgdQ3kckXRGvm0OBWSn2ZjZ+bH4rw
         VVCn7r0ICmITeClgjMOfmoNwZxOWMuvdGMfYSyn5z70F4L/EYc/phpypo0UNVqLnvjPQ
         A0nQ==
X-Gm-Message-State: AOJu0YyQtblL1AnmBunvjvkbUoz5hXp6HWRDe74jhlRhJoVLrCMcrAVB
	vhfvGodfMueoTejKQT7QdvLRZMH/EcQhaUsn7fHaqkKDQh3GDtKLx6Mwsbzhe0BTSfU=
X-Gm-Gg: ASbGncuaG7r+I29lPTUfNdGwx2mKszlQEvaKisSJe7+m68p1wNAB1j4crySV5Mnw6qm
	OMmEANgbXaeUwNcIUHAFIAl26qavjw4cifEQjqiOoGKe2HOAIQOaEPSCEK1/t7DaQMOo8NbCNdJ
	isB/VMAZOoWsS8I4Qam4MWevOjlwbpDH/FWE86qMoYNbzmynb2/QcphxeUEY69jnXAA3Gmf4J9l
	8VYRGkYl3CKGMKEgKIDtH91XAQk3OOKtSE4foKhNbH9piEzY6+L/xGiYPtKHz/CoxJcT2XTtiEH
	pkeTW1ehinT5OZzUwRWe9FeMWsDmSQWqIinmZDQNtfmHiUr0aDWmH3Ye+RYF6/rll5oYukfF1/T
	DpASDOMP/ehWWqtmI0aSq/aM0saLu0nC/uL4f4gdujog7BKIBl2BtOexDajrwoG4vtx5JAEHxwx
	qxj6tJw8T2ssotDQ5qHoviO0xhZzVbC1pLyWikQcmNlsP5kTjTDRB2HxMLQViD
X-Google-Smtp-Source: AGHT+IEJgn7gur/RWDvs7eX6HixHboe9ws3ufVkwLoTyvR5Cbd1S6aFI6/WaLD90sV6R75rquQXkKA==
X-Received: by 2002:a05:6a21:3391:b0:334:a2a2:90fb with SMTP id adf61e73a8af0-334a86070c2mr19505860637.30.1761027113478;
        Mon, 20 Oct 2025 23:11:53 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff14a2esm10575714b3a.9.2025.10.20.23.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 23:11:53 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: mac80211: get probe response chan via ieee80211_get_channel_khz
Date: Tue, 21 Oct 2025 17:10:51 +1100
Message-ID: <20251021061051.235258-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of ieee80211_get_channel_khz() rather then the MHz counterpart
to ensure probe responses received on an S1G channel pass the check.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3b5827ea438e..bf6f78d9b18e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6610,8 +6610,8 @@ static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_link_data *link,
 	 * Response frame shall be set to the broadcast address [..]"
 	 * So, on 6GHz band we should also accept broadcast responses.
 	 */
-	channel = ieee80211_get_channel(sdata->local->hw.wiphy,
-					rx_status->freq);
+	channel = ieee80211_get_channel_khz(
+		sdata->local->hw.wiphy, ieee80211_rx_status_to_khz(rx_status));
 	if (!channel)
 		return;
 
-- 
2.43.0



Return-Path: <linux-wireless+bounces-30722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0EBD16685
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 04:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C47B93006705
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 03:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867B26CE2C;
	Tue, 13 Jan 2026 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ESLplDWj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA161A9F97
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273795; cv=none; b=u256HibDBfCel1sXZEEgqQrpkK9tCjFQdWzuH6o1pVQjRnxch7BUq6bNIo10K3/XueXllLsShSMuXiTy24Um3/XxuZlzLH52bQE0G5JEyhHX02u20YD13RFT5BBpuLGfC11F9JnG27jSQetayZ42dsA523n8fT1qAOLxB3HCuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273795; c=relaxed/simple;
	bh=tXm8wWowa+y0Wpo+qvtQS2WTQPMeB1zxHPNcBvrRRlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSPafnqvLS/LkYI7qqwJkGmK8oXR0OrrBqaCpbeyWCHrP0O++KvFu+7faPv4i/dHhsHnayVAKrHGy0BaKirc1olGgJJzzSRiK6vTbf99Q1PE1AN0uMLd+5ulq/cUy1HtL6F8P30exr5Zr5AjnyztxoilzpFfmVXoulmmQxulKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ESLplDWj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f0f875bc5so56948425ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1768273793; x=1768878593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAxK5KKbscaQ3HanDCXU8kOKIzmGLyjclPEMWjiufpE=;
        b=ESLplDWjTzupCmQ+QZ7WP1MQY9cnAjYS8znGsNz93YSCwkHkSyfCIsa4/dkpR5Okt+
         ZSEqPVIrTOQUtoa5u/3/EADQDqMy25KJTnvD7hXqpAOIWq2MytsvrCvGwJV6rW2E/qKc
         kaOHt0517boTNfvS2WT4llPwBZgwtYbFIxLIDQtK7NuI8Xqwyf/RMUQKVX7ed92+IIgc
         EIg6Ad+PW9cwpmzWUi7OF6ijGfvcvvKPFWuJbogWuTdl9RwZjBxvZ0pwbf4txvdpSqTF
         gOrDiwrvOV7s3DPvZdPhq5eO0z+rQe0nxjQKGHDJAGTKCTFCuuaWamh1wY4eXaXS1l0O
         Hc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273793; x=1768878593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAxK5KKbscaQ3HanDCXU8kOKIzmGLyjclPEMWjiufpE=;
        b=gX49eShMAASuPctqHdTSx8KUOl9RZDN+HKaNwG6BYrphlJ3VrbGqOr/wQ8Sr6uQll6
         1d+tReO+PajdOIngMhdxpc9e8uwvFBD/6ginH1Cq2C+ZmreJ6wtoSsc21nMo+PqAmUnm
         ALHZNYa+RRD9+WcZ4EQ5iHqRfeTH+KXZKj7+rS4Vm9kp7gF2oYGioQ55V8ozGVZt6niH
         Kj56IFjblTLx8OIc1G/soZKYA0s5tgxjV6gaOb8yRx7jPjPuNZt0zNIFeVaOoO0D4B4d
         /GZwlKV++KPqAgRTbg/OPbOx1mS4Vm4uSoSvzZd5/aA1k8bCpmHBvOSeci4ndOawLjNM
         pEZw==
X-Gm-Message-State: AOJu0YzCbUu+cyQi5YFJFGWhGC2/35LO5LgyaMyuCZf2O9pzGh863W0A
	xhmlmNw7tCs8rWU5Ds4IJcLfwoNzLoCNdxxRSUtrZLbmIOWtBbSwBjUecffh2o9Cq+dp7WB/YC9
	X/CkJ
X-Gm-Gg: AY/fxX6vrFi0NJZrdsjBvucEm6aaqu6LSHs0jJ7CPCidtA/Ir7zC/VMoVJ+2JhW4skw
	Z+7cJ+aCJJZ/EySr20l5FXsEhV15RlO9PHl0HabS6mdr9wVhKyUGAQjFvd9A6VCzoDi2hjmnQI6
	uVg/43ng9ukFcKFXC7QoeJCo+wBBZ5NY+dxUsZXLoiLMoDVvNR8hPoloEcYm8V0Keg38b3tGG3v
	MrHVEEg7Vnr88iwLlUs1d3uMdtrHEykKdqX1LrML/s64Mjl1Cpv77zoJsxGwVjhuAAVbcf7VJ4Q
	XUtgq/cgQnOtD7IHeP9KYMnMWL11+8hvk7dCTGV5Ns24jDD2Qe2y6LkV6daV3Ticd49aCHKaNJG
	cHPCnKf6FnbvcYBtyd1lzEb88L6RI0KVZDFbZC7DRybvSHXpUCvO++hQ2X5OAvk0Rkavzpv+Kra
	XjZwgfWJHBesjMO6rNxU+7OxG85Y1n3+BaVOk63t5yX5Kddob1Mc60QfegBlUe
X-Google-Smtp-Source: AGHT+IGgK6qxyzV10CDm12v2duPosFBqaaUCOsqMoYt4Tv+w8bsrS8yMsZn0QTrRjcnb+MFPdgbHfw==
X-Received: by 2002:a17:902:f60d:b0:2a0:daa7:8a3d with SMTP id d9443c01a7336-2a3ee47f15amr184773095ad.23.1768273792580;
        Mon, 12 Jan 2026 19:09:52 -0800 (PST)
Received: from mma-H9MHD44.lan ([60.227.235.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2e01sm183392145ad.46.2026.01.12.19.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:09:52 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: cfg80211: don't apply HT flags to S1G channels
Date: Tue, 13 Jan 2026 14:09:34 +1100
Message-ID: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HT flags don't really make sense when applied to S1G channels
especially given the bandwidths both used for calculations and
conveyed (i.e 20MHz). Similarly with the 80/160/..MHz channels,
each bonded subchannel is validated individually within
cfg80211_s1g_usable(), so the regulatory validation is similarly
redundant. Additionally, usermode application output (such as iwinfo
below) doesn't particularly make sense when enumerating S1G channels:

before:

925.500 MHz (Band: 900 MHz, Channel 47) [NO_HT40+, NO_HT40-, NO_16MHZ]
926.500 MHz (Band: 900 MHz, Channel 49) [NO_HT40+, NO_HT40-, NO_16MHZ]
927.500 MHz (Band: 900 MHz, Channel 51) [NO_HT40+, NO_HT40-, NO_16MHZ, NO_PRIMARY]

after:

925.500 MHz (Band: 900 MHz, Channel 47) [NO_16MHZ]
926.500 MHz (Band: 900 MHz, Channel 49) [NO_16MHZ]
927.500 MHz (Band: 900 MHz, Channel 51) [NO_16MHZ, NO_PRIMARY]

Don't process the S1G band when applying HT flags as both the regulatory
component is redundant and the flags don't make sense for S1G channels.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/reg.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index a8ab0ab22d90..6cbfa3b78311 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2332,8 +2332,17 @@ static void reg_process_ht_flags(struct wiphy *wiphy)
 	if (!wiphy)
 		return;
 
-	for (band = 0; band < NUM_NL80211_BANDS; band++)
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		/*
+		 * Don't apply HT flags to channels within the S1G band.
+		 * Each bonded channel will instead be validated individually
+		 * within cfg80211_s1g_usable().
+		 */
+		if (band == NL80211_BAND_S1GHZ)
+			continue;
+
 		reg_process_ht_flags_band(wiphy, wiphy->bands[band]);
+	}
 }
 
 static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
-- 
2.43.0



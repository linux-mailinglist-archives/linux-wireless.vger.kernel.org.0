Return-Path: <linux-wireless+bounces-26605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33621B3521D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 05:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AAA1A83420
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6C29B8E0;
	Tue, 26 Aug 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK/gka2D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFA14EC46;
	Tue, 26 Aug 2025 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178047; cv=none; b=R+RVhnMOnL6mCTQe5MQ4jYIqNrDaqODFEiA9Ru+58FBALAACTe38FrGqnRWrC+s6jJlDevsRi5d/lQwW3k33UilB7Op/fp8Vzs2HaOMmg4C1x2KO15MlwaN2Da8//QMUVgF8AjfSxUOMBXdLrI8ypfI+wRo0jKEqs9xAtavg4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178047; c=relaxed/simple;
	bh=5YN6O6GC9zj2w2gyr2C02jpCaY11GyipQ674DFoTk6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kfoMUMg8bagp7pUL7hXghqrkWc75y7RYvEPOzbMJQTMDsfWCRiTITbu0lLIGQhZ5h/Oxq0fWW2i/618fG0Pm4BV1MXxMSu96Q7MiPXO5Sr1lFoFen/lEqfFe7SgmJ3YerOugyld1NUrb5LaEImCQOB4w2hynE7YrH+aE6SkkEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK/gka2D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce5243f6dso5457943e87.2;
        Mon, 25 Aug 2025 20:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756178043; x=1756782843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haEGMgQWYPiavHeip3qnO9dXl3bo4enC7b6lrk3mafQ=;
        b=QK/gka2D7BE34DCMSLDKcbuSHpgVwlYXR6UQwLTaOjf0ruYLV4XlU7SyrT3pBZPZrW
         lUPuBp1f7s80CnEfv1E5dnBMCyDbWkyvyzGQ8iR8viDzFc3tyIDoM1MLJXa8MQlsgQRU
         Yk2n6ncEKQ1mJqGt4r6u8Cghn/9xb/nvxBkxmkpMa73vx6pKe09DWeofTRH5eCoUiVxG
         BgUf8oy4o2HEmsyWfmV47BwuahNOyr3EkSN7/NQmTrBdxZUS7Po3oLduBESAS4ReSXR6
         P3j7lGWApv4LbW3Hjnb6XjdZleHmvPtQm3sdCu28CvqApmR8vdN980jahgXpAlTvtMyV
         o32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756178043; x=1756782843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haEGMgQWYPiavHeip3qnO9dXl3bo4enC7b6lrk3mafQ=;
        b=PssGWj6edxtDrCVtpwLXwwM9PfrT1+7doBEOvjaZPA34i2R8VJ6Vz6eq+B+CDza0yh
         Qjk3WysDhPcQ1uEFINnPXzaM0Pblcm9mXPkKPFZqJkygI1YjijDbH4gdjXgb5a3Kc0tA
         s/BU2cucB3n9sZ1KJgqoERa8ti+LV8TeHkBvtHq6uuRhGeP8Ul34y28Klv2AvLBGVWMf
         nax++fmHAjqbECQODZ29YkpRRFamlnjEw5+p4oh1OUUNeMEl1ZsG7knQYOKxBmOk+Pb/
         Hh20N04dX4dma2xJVC8Zh2J1cH/qLBMwic804kYsG68h6Ey6zYVXTuiuvc5PNhZX+AGn
         9z+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3xPfKS7l95402IdrXBvye3H9qXnl9WsAR2/QaBGALvgPmkFGDnGHTvK6Y4iO3bb4KO9Tr8B5DMwqNBhg=@vger.kernel.org, AJvYcCXs6mwJbwkU5xax3LpGjEqunnxcV2hEBRrKYjSNzm0yRNARBvr5P2xZXoU3Yz/61ue9dCFpW6mVaV7XuYq+iXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovBGl6em4172Karbr4CFTHzdZVx9vo21634nL0V+2dT5PG5cG
	4JCFwGtFfywUbRzGaaaL8RSgG+toee4aWIC8XVpZTz365+L1YtaMMOkLdAOC9F0VlpE=
X-Gm-Gg: ASbGncvusNeaxEL6BfEnvd8Lgxq21Zkh0en8bveWdGoGmcU8040Utp7fxLM7XFVwuqp
	hBu7bV+7l0EklWEbSUSqS/3gDNElXUN79z6bIkTZzzKxMTi2Ru+MwjrcndXyhZoGlcS2YtieuBO
	2iY0JGndDsJopj3vkbA/IRAbPI0ccdq4XBB5DvLtHR9asO2sRmpW3E5DHk8k80JOWwSQ8Xcqkob
	IZ+TF+7sUaP/CDLZWcXFJlH0MZEbEx6BENUt0n+jKf3KwbwG3KqGX7TZZGFpKFzvGRAyz/yEIbZ
	CuwK7zHvADEAUzZ+Kp4s1tWW1iqQjD2Z+6lR1xhc4NgHHfy2LHYE74XwDKEIW3R/HtSa0nSYgrn
	J9DKidm/5Na7fpSRRWd1Vn8NJzyrFuaEUS40IFbD2IDNJMCm5EGwIC6QWRGi+UaPQRfkhzQwOW8
	VFew7ytm+W/DZrcO3Fgw==
X-Google-Smtp-Source: AGHT+IG2uTbsT5FvN5W8j68SQ4oNq78+Q+UaUZ0b0Isc15lY0SLDiJWQZ60TgwVz89K1MIlLZzkIWw==
X-Received: by 2002:a05:6512:124a:b0:55f:4107:ac4d with SMTP id 2adb3069b0e04-55f4107b076mr2811906e87.32.1756178042760;
        Mon, 25 Aug 2025 20:14:02 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-af6-b340-a13b-482e.rev.dnainternet.fi. [2001:14ba:6e:3100:af6:b340:a13b:482e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3d4d1afasm1706832e87.58.2025.08.25.20.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 20:14:00 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	shaul.triebitz@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mikhail Lobanov <m.lobanov@rosa.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 5.15.y] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Tue, 26 Aug 2025 06:13:52 +0300
Message-ID: <20250826031352.510675-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mikhail Lobanov <m.lobanov@rosa.ru>

[ Upstream commit 16ee3ea8faef8ff042acc15867a6c458c573de61 ]

When userspace sets supported rates for a new station via
NL80211_CMD_NEW_STATION, it might send a list that's empty
or contains only invalid values. Currently, we process these
values in sta_link_apply_parameters() without checking the result of
ieee80211_parse_bitrates(), which can lead to an empty rates bitmap.

A similar issue was addressed for NL80211_CMD_SET_BSS in commit
ce04abc3fcc6 ("wifi: mac80211: check basic rates validity").
This patch applies the same approach in sta_link_apply_parameters()
for NL80211_CMD_NEW_STATION, ensuring there is at least one valid
rate by inspecting the result of ieee80211_parse_bitrates().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
Link: https://patch.msgid.link/20250317103139.17625-1-m.lobanov@rosa.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Summary of conflict resolutions:
  - Function ieee80211_parse_bitrates() takes channel width as its
    first parameter in mainline kernel version. In v5.15 the function
    takes the whole chandef struct as its first parameter.
  - The same function takes link station parameters as its last
    parameter, and in v5.15 they are in a struct called sta,
    instead of a struct called link_sta. ]
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/cfg.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2b77cb290788..706ff67f4254 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1658,12 +1658,13 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 			return ret;
 	}
 
-	if (params->supported_rates && params->supported_rates_len) {
-		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &sta->sta.supp_rates[sband->band]);
-	}
+	if (params->supported_rates &&
+	    params->supported_rates_len &&
+	    !ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
+				      sband, params->supported_rates,
+				      params->supported_rates_len,
+				      &sta->sta.supp_rates[sband->band]))
+		return -EINVAL;
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-- 
2.50.0



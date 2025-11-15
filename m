Return-Path: <linux-wireless+bounces-28998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12136C6099E
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55758359E62
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5523054C8;
	Sat, 15 Nov 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Dl88up"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD03043DA
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228575; cv=none; b=GyLJQNRoXnPv3dYY99vLMe1lghMKZEdm/zojNu6PXfFiB8pmXDd0QvUOkMmBf64H6qcMgtuHubLCMQQrR4/yTbwKXx0zgi6WtwxSqTE6ba4tHUaLiR00SrHWOPHeIdVB+W5NXDCwmEitynF8tvDaIWV1Yzo9ru7jl8rrf600RUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228575; c=relaxed/simple;
	bh=hv2O/DcV/LLemjPGzZJl8c530KZ23fPBBAqyLXlAIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmPaiNHXrvPe3kM/bAPXZ6RBc6o+uf/ll563fiKhDo2egl47tGN6M3G8mfH/ZeyHgBnabpBBgDNlFA4vpCTVcg3SPPqgWMw97RvaxRtVmgM8RhfG4HxyX6ZQo+KBswPOGpFvr9OnY7RZNbmhiquv3Ui/pf8MTWh8YrJaFFoxapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7Dl88up; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b472842981fso378251866b.1
        for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228572; x=1763833372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmOyheNjoX/Nvl+tjkFlCaDhDCSQnuW1tWSMjsqF8Fo=;
        b=K7Dl88upw9/XNRsS/11tUuxEgipZhSuxnS2N1qxplzPfCefWXG9W9NL/IXm2ILlpBu
         8qpFtisMvP28PNJIXEiVO8PrOL18CHz8u/iabvEfLmpqal561B70I9cv39EeJS1bigxQ
         LG5Xb0IPAyYNAlLOZI28PJBnyo6gB26/KnXoVQOclomMSG9iQaCGy+wywFfCGMmi/8I4
         aSkmEMtwAAN8l29AWdtvahueXkgwoSQLYrdNqYtzJ5I1FaV9eqdBBc9Xga+fHPnwM1n6
         WNbRYMFO5EOW1Ov8cjSQqSQFeg+uRMqSuUOo2MI8nufOvlcxrZJtqGn5zFsxeSeTu4On
         NeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228572; x=1763833372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DmOyheNjoX/Nvl+tjkFlCaDhDCSQnuW1tWSMjsqF8Fo=;
        b=csDvjaV22NHwwvkoctwewm9SvuK7TpKb8CJN6u15Z90kSaSjECLKqw8uz03S3RjKd8
         npK7BxUmO7T4nXPmhpXyn9XNiOx0KQ/WB0sQWkW86YDuQQ6kTBmVY4kmXI/5n5g63lRa
         krKwwNJi4qiEojbfvjfBSuivDfqFuKdrHGObKzBJsrs3AqVIItNgd3IiCEV3rfM8+Fg0
         6ZGBhpIGZy/RYO1PUzVSefuG6F4/fqiXwZCqg+piA4eOOhEuJS8m+DMEGQCGlsvmXHGx
         y9+GQI4OP5WvzyNXaa7Lkgrw/tHx0g6PMfmTAkCqvNJ+s1EbdeqfpMxOh9bPmiZGAoOJ
         vpDQ==
X-Gm-Message-State: AOJu0YwFXnnKzmjvlyiAl1mqiQnLWGNYFmRuBlyNrFTm6EWulwz8uVbc
	wriU1w5L7h0cunpz39jit3NkJGbAihgmmQO5UzUEjHWzBv7vS59657DEMdCO6Q==
X-Gm-Gg: ASbGncs8rtouhpx5cPGn52MT0O1VFdDi+WipxS3QnsnzzCfwD/bA5sDeam9w3YXmZWe
	eF4btyasCrsz0pZ5Sm/Brt2s9WF1lDm39cWDoedTA1HLbcooeX6FHEuOgC76uQRWgT1Jyuo7MQB
	qfSVdT7nO6RNrOKCxdP76ePiTEf6nP7zPzx6u6W+AFmEZ9pazf2W/QJ0Bwj4HFsixnLFoawwXYF
	UgMjeike9jsYfjcv2/Cu04V3tmuk+jILdJRVmi6tMHVLdcmiEdUSNmNQx+kXUhKAg+4OXgIxa1m
	H6Zk/f88fe8vgIm9+Yz7+anKBUZQwjFufLsaApwVQdO/tQHvzxm3RyAPIVvqeEhwDffMnAGdQ2E
	+VUz+zeMbPsT/00INI3F2oHhFUDbQOKbnDe2lBTpBPUyIsKXRvQWnJ0TcDyjY7MUL3ICZuQgOlM
	Jsnzdrg7WUruxJJTuE71/fCghi/b1cBDk6Q7t665CX
X-Google-Smtp-Source: AGHT+IGow8Cn2jAUwmB1hxmnslI0Gj82hfW6PQbhjzxNr3XV3cQ4TRJqje03pSBxlfZpuJRnCgXM0Q==
X-Received: by 2002:a17:907:98a:b0:b46:6718:3f20 with SMTP id a640c23a62f3a-b736793db07mr725267366b.48.1763228572451;
        Sat, 15 Nov 2025 09:42:52 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd8099asm664941666b.43.2025.11.15.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:42:52 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Sat, 15 Nov 2025 18:33:21 +0100
Message-ID: <20251115174230.20504-4-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
References: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case we report radar event add also information
this is connected with background one, so user mode
application like hostapd, could check it and behave
correctly.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/nl80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b3fadf9665a4..4d39476ed30f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21097,6 +21097,13 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (rdev->background_radar_wdev &&
+	    cfg80211_chandef_identical(&rdev->background_radar_chandef,
+				       chandef)) {
+		if (nla_put_flag(msg, NL80211_ATTR_RADAR_BACKGROUND))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_u32(msg, NL80211_ATTR_RADAR_EVENT, event))
 		goto nla_put_failure;
 
-- 
2.43.0



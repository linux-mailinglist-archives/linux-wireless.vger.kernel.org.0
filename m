Return-Path: <linux-wireless+bounces-27281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC855B56AEF
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Sep 2025 19:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4092C7AD7DE
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Sep 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3C2DE714;
	Sun, 14 Sep 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiF8c8HD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C71E0DEA
	for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872015; cv=none; b=n2SaYTH3wnZYCdyrL4qWPPwBd1sUETQ4p2gK5SJS4oYW+Px6x8fK7Amb9bof+isQXsT19QIIqzJ67MMONnljNMslmQgGtlKO389NNNlu5LrxCxQC3aPBmHLTJkVEuU96lcEisRnNXio+oPeRoBuSEuIEK0hOPA8uI1SDzbOVYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872015; c=relaxed/simple;
	bh=UbSxbkOxWbdVPlWl9aVrkGrFOKgp0e4bcAKuZQyyZLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFBjWWyqaAaxbGljpD5Ldr7hS04bN0B6pCDefSBXnMCfWRe6AS0adqu07K7pUUYYuW+jd+6g9+xP+borEXJKeymfBOHnpgqZN57VeHmIdfKy8fTldRodzUOmoYRkMpT1JYzClXp6poDQmeyXvpnoV5uQKcUMobMcUHiZleGpHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiF8c8HD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso2433362a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757872012; x=1758476812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sLJz0AbfYr3a6o7kZEV9kpjCiuHEVCSqG+lJ59ZBmM=;
        b=GiF8c8HDzE8TaGnYAIwL/Scz57fPrP3x1oMVhmw5kTAh8d7Q6orX5EC+QhQdKMaNf3
         pmvZZpVOmTsxllAfk0bddUc0n3NJRDEYOaMUxKcn8TTuESqBPRSkQq7xIuo3jmL0jjOh
         IbnL7Ee2ThGY2/H+k5TiGX3n3MDeiNcuQ10ux4f5XyYvJVprVUfzOxKB/we5S9DqL0o6
         /dCD/pOtjxvB+nU4yrHIRlPMAPtztw46GmTgje9kf/QS/NfdoK/VIcTD00yJKxmWECxW
         7FrU6NvnjEw/CkUddLBriUKS0Pjh1gTidz+dnhpDgNWKB5yF2+HsXWMc2wdE0hTybXms
         q4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757872012; x=1758476812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sLJz0AbfYr3a6o7kZEV9kpjCiuHEVCSqG+lJ59ZBmM=;
        b=JQQf3hGt4ER8GVQqjBg9c+9urrzL85mYMudWnLKBHWAJrpnLvblF0dqsZnyN53Km7e
         kRBfc8zzy7FYAKORxUiRegy6Mc0WaHJLSleHJ7UlKL266nbSQX6FiKsztb0RK2+AxKig
         h88X0ddn4wWFktM9BUe4cy+a0g8YxuOBvzj+GnG01U/W2KvVj66e2f7ZYWH5FXTLXuAi
         Qe8AP+pgLIPBkokLGV1CCu7mhWU/fC9hlO1j1SaVlNl0agGIP+M9HWxKNZ3udIMJdUqQ
         w1enCV5oFs6TOuo2ohxjb1zHOV3VvxRO+dDQJIOGbXjx4up+i3gdhXiPGJ6rEQ8kRIoV
         d8IQ==
X-Gm-Message-State: AOJu0YxR86zDyw8qc5xc5k4VyK0N3Ar8VeHm3qKMp+HYh1p1mxrA986N
	tudeYEkN1SZT6zwL0d2IYUUe50hPbDTrKs3uMROkWJ+DuWFS6GQr6tJsrP7t7A==
X-Gm-Gg: ASbGncsOylSZ58m4gB+8bfOW/TUPU5oaOWbg+qvqwAzB4JhujJ7r7KOApcb5VF6UjXi
	Y3hFpCA596VBYeiyeOn80i5TejwjAi/zodHnmkszu8cd82+ETYWgSiC0tbrJoHpchI+q4gLSbpc
	0ykIzWxoKYtnL4vko51Y/Jito/f6fRtnnY2pQu+2BNZK9tyWWHLvhi3HrrVhQPDjV7ydK2+pebU
	GRKOfJaaCCJhN+icjacUlNf+5DoJFJ8C2r5Q88bABRSMdjlCKGwSXAkAO1dT9CzKZX7t//EFHNv
	GBqbj25lnDDXin6ZX9gYES3eM2aicW6MXPGFwOoxcAnt7KjFb2++b+hHNEPcOXarQfvxh0NF3nn
	CVFRWX66YavQIxQnt7Zadag077eGk9KAyEYuli4pfWxW1eE6TdSTzFk4H2C58
X-Google-Smtp-Source: AGHT+IGru4r3B2yGoL0zVGXb5GyVCuuSifebAmvzbg6miD3RL8yMx7HDLIO78I0JewNYKu45W6ULTw==
X-Received: by 2002:a05:6402:3582:b0:62e:ed2f:a667 with SMTP id 4fb4d7f45d1cf-62eed2fa945mr7479081a12.5.1757872012129;
        Sun, 14 Sep 2025 10:46:52 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ee7b531d7sm5063438a12.51.2025.09.14.10.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:46:51 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC wireless-next 3/3] wifi: cfg80211: events, report background radar
Date: Sun, 14 Sep 2025 19:46:22 +0200
Message-ID: <20250914174622.479249-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
References: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
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
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8235415e72cf..7ea876903061 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20825,6 +20825,12 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (rdev->background_radar_wdev &&
+	    cfg80211_chandef_identical(&rdev->background_radar_chandef, chandef)) {
+		if (nla_put_flag(msg, NL80211_ATTR_RADAR_BACKGROUND))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_u32(msg, NL80211_ATTR_RADAR_EVENT, event))
 		goto nla_put_failure;
 
-- 
2.43.0



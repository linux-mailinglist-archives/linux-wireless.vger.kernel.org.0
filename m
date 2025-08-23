Return-Path: <linux-wireless+bounces-26566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E95B32BF1
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 22:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E871BA82A6
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Aug 2025 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3522F177;
	Sat, 23 Aug 2025 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD1+HR54"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF761F463F;
	Sat, 23 Aug 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755980553; cv=none; b=hlBSKxpQiEQgKm5Ca5ixJ0LtWewB17dRcLmjmFshP5R5a9hVzi8b6Dei572t/f4aSvThV+osba7mO51NtTCvhLoXEUNzIMa9Ek2ImrxCMEW8xLQPzgCYktYJ+XmQr5PGkaqbiACcLbVJuAeAO4U2fMxSJBImkXbdPt+uMrUFX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755980553; c=relaxed/simple;
	bh=FQccn/mnCuKMjzy32KODULbWn9j7n+6MgtLwkBtBSUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkXa8nCJXv+/fqPxZJLzFUjXAv7V5bIPgZMa3pH3G0CrfLsLla0/SAbwHBHEIycGevXdnqkwLL2iKZ2jR8RpIIZ/ieIaFMQymobIuzp1pln7u9TaJgAHtLTkVg0CjJSERlYv+ifJRNzADGDaBiNn5P5RF0etIs1zh/YgDwRjA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD1+HR54; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce4d3b746so3575379e87.1;
        Sat, 23 Aug 2025 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755980548; x=1756585348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkaVXvGmGwTwhyRFOa6DDpH5NmVfdKNvcReIU8TQCxM=;
        b=nD1+HR54UAAvhlDAOo0XoUZeHlv+fDgeA4kMk1rSnMIm7WI2RUEt/pSC4oVWRr54Ba
         GxbWVJ0lBJCUd5TBOAztMWpQVxj/W6YAwoxsYi+4jxB36/kLhvnpcNUR22A8Tny36ddd
         k3NKld0A7nj4hg8ZFwH2Xi96+KkNVPMWyMbSQM6mZf61jvqg5vP3KapNNyeXV5XCXYH7
         tXLjDnOguXclOvxkmv7sTCjn+wmIbXy29fgs8sfsbE3lsCmmzNzKjESyjyZ3LqsUfBg3
         8CGEszujihqinYawZDY6s8dB06iZ2f0ZBj52mGpbhftWh1jqm/ouIl9pZwqq2Izr1SrV
         id2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755980548; x=1756585348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkaVXvGmGwTwhyRFOa6DDpH5NmVfdKNvcReIU8TQCxM=;
        b=ed8f6+HKB87m4gxy+gZ/FCQgHe5fD27+4OEybut6L4uTKC79BUUOoY1kcYAw+/H8pa
         jMW7gHBHVmUI6cIXUkbRSlrTl7wPBpWMaAS6wum9QdYZAEbTffse9ugYOaGPoGLWtOay
         e83yftIheMz5v8hO3svBfdwpEXgxFa94VkgCpnK6Gk6dY+whRIOB7VesQIZTQeYsV5Yk
         jZP5AewBzGulBqZrLqV+ZqfasCVHuU3AzLopG7cCTdO816P0NGwOZJWQbVEp38nKohSA
         EToEoA6ecCQ0OLtJZpD8eXxiGK6bJOQgLxVgLK/RtcFube/lYb9RcROaAjxs9iqmYa/T
         npKw==
X-Forwarded-Encrypted: i=1; AJvYcCUCDf3qr7lxu3NxjpVrYrJnkxNzf73nWn6/epmF7fcThyu7QxKYPz55JUH39sLFYncDuxOg1+0NxbbBm08=@vger.kernel.org, AJvYcCWffwZMYCLaEP6bOo4ny35ErIzwTKv2BEiyBJ1vq+1ULhnifYUUo849dPcllHgUT5se+NsJg7iDSaiOl3yjO7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MR6wuW+bIJq2mLhC2++P9Trs9N2SFV8rgXRQMlGRhIZO11/I
	v6HguECNKX4vfTURlW6GJzJKf/ZAOgS1UtfDiVDcbIvbzumqNmaD2SjyB1ZHcdmDcTo=
X-Gm-Gg: ASbGnctJpwGq+G9If6S94ZAW1qjVyJqB60jOFbnjDIIMEPrz8Fp2kTaQOPtXLevUhni
	92y50nIuTS6SGTwcxHYX3atheHj4u7ndvalpC5MigPJKtDpLeJF0ukx8Q6b7FhGZYQv+m6kgBUH
	qMIqJvEmx+A3p4/J3tpsHYvhxv/7qC8nnDcjfME4Zr59iqE6JJ48H4NriP/EGJNar4Rp9jyKmDZ
	9fvrvA6OS1rzoGYzLD/CzWV9BuEt2xZkl8+93/jRC9m7F4mAUi2eV5ge6+6+RJeC7wlOzsHg8Tw
	SiCep6ulSHyVbgrQRHgJLgkuOYASyvxmlY9tmSTvFEbfGFFv0wVc1rbFPC5iK9sJWcUm9GevBxM
	f2ClPxg+2z7ir/XCZIn8vw5Y+UdpLHAiC1yX/jSSapg62EvTh3fn57oHy0PE3GEklVI48xAk5UC
	zqXk4eQvLOC7DK0zxeBHUm
X-Google-Smtp-Source: AGHT+IHT5OiJrgOGVSNUQDNc7iv/jwpAb+TzHRjYVDlMIt2lEi03MK6Ye96jnRvqifCPUN5ywys4Og==
X-Received: by 2002:a05:6512:3ca6:b0:55f:3f00:a833 with SMTP id 2adb3069b0e04-55f3f00ac62mr364421e87.8.1755980548333;
        Sat, 23 Aug 2025 13:22:28 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-e1f1-3f10-2a0d-f34f.rev.dnainternet.fi. [2001:14ba:6e:3100:e1f1:3f10:2a0d:f34f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c99e65sm677901e87.109.2025.08.23.13.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 13:22:26 -0700 (PDT)
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
Subject: [PATCH 6.1.y 2/2] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Sat, 23 Aug 2025 23:22:08 +0300
Message-ID: <20250823202208.43086-2-hannelotta@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823202208.43086-1-hannelotta@gmail.com>
References: <20250823202208.43086-1-hannelotta@gmail.com>
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

[ Summary of conflict resolutions:
  - The function ieee80211_parse_bitrates() takes channel width as
    its first parameter, and the chandef struct has been refactored
    in kernel version 6.9, in commit
    6092077ad09ce880c61735c314060f0bd79ae4aa so that the width is
    contained in chanreq.oper.width. In kernel version 6.1 the
    width parameter is defined directly in the chandef struct. ]

Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
Link: https://patch.msgid.link/20250317103139.17625-1-m.lobanov@rosa.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index be48d3f7ffcd..b42eb781d7f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1735,12 +1735,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->supported_rates &&
-	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chandef.width,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
-	}
+	    params->supported_rates_len &&
+	    !ieee80211_parse_bitrates(link->conf->chandef.width,
+				      sband, params->supported_rates,
+				      params->supported_rates_len,
+				      &link_sta->pub->supp_rates[sband->band]))
+		return -EINVAL;
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-- 
2.50.0



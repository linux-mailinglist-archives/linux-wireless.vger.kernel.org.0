Return-Path: <linux-wireless+bounces-29304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3CC8329E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CBBD34B5F1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188E1E2614;
	Tue, 25 Nov 2025 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="XFsCiXx8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B691BBBE5
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039596; cv=none; b=E1vRwlLzO4DtOqXwoTdcnHAa3jtvd8Hska7HxTO35/XdPR2JXQiLQy3SPgYwAAaXvIhFdIxejpbyw8Ad+QfQDOdkB4zM8LwT3TRobKLbl7pZ1JWT1XAbpfPqpfhZvLKMPcyO+Kag6A5nniFq7CErAuaq/K8KAao1r38j2BwgilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039596; c=relaxed/simple;
	bh=oq9L/G1Ek1MGQ+uEoyV4ozoQvE3zuY2kgFdYJuxAMmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vim4SPzPzDEvzRKAjhZr5ujqMYF+lLo9bZoTRF6ORHw5TpzIlDlWxuGrY4SRIlvQeNy1wyjfKU3HtCzT9bqCSL8KlF52rzUdrKgLjySlfN41ZwRS0jVqM2vz74k9bTIVwI8H2J/zIO/865PbhV52ZnvTLjjOsHix18UphEUqBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=XFsCiXx8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso7600932b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 18:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764039594; x=1764644394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCrEsVXYPUZFfTFfizE6pFADMcHBfSUlNzC6tJeHeiU=;
        b=XFsCiXx8MIAS+TEOmpHDpvM+CuscAvtq+MMqCAVDqNEQiFyl/fMg5Id8gL3VeKiv1V
         ho2/b629vKcqHITjmMUV5K/Cj3iPc5Nu4xMc479ASbtEEoC1ebl4BmY2yEzSTHx44WvE
         cz2krYpOz6E8R7g2IY0F8xEbJCkz4sMsHW61clI3/EXrl6Qm22mnuaIIwpONSMb2jurM
         WDZyWP72YwmrXho9TYOAlurPyDdNtcYqiuIM/JH5RAjXHV855r5foi6jxv+qSTieGp56
         lkfeotfWtLchr8Ry/yi2yDyxdlTL5aRrafRxVhlgB3bua/vMKG+ffdMXrpqLpN4u0D+0
         5Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039594; x=1764644394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aCrEsVXYPUZFfTFfizE6pFADMcHBfSUlNzC6tJeHeiU=;
        b=eA8N3h7toGodjNPSU2PpV+Mu8GZWpZSHwdZzZdRvoFHAXm4QhNOEYOWcj0Z9Yie6V0
         gIy2MX5FduU5gzrp1J783gwOhoLmwIgd0z1TjWYLhthkgDjb7NvV3nTBh9awlEB6PArf
         31oU5040dnFcVTxvNboo33nVC2+QUXkEDOnJrx2rCUfjC9S2Wyhl9JHFNTzLOHQd0/Ca
         vr0FZvaLypJRHyuu/n894bxDvdAImKz4HXbM91DxD/1B59X/fCLydQSF/Y97DbBQwja4
         crxqEvx64oRqKXFRecicKHL+Le4VRqDrTm/22CHhGjYsYzJe7LxWakVpgQhF1Lw7HzSW
         HbEg==
X-Gm-Message-State: AOJu0YwTToLBYjCIXhb5Sn8DtzQy3apCRWcJZi3VrJM7D1b3p7bqWTeo
	EyKvE+6SYutq/1NblO33J4FOSEs+J1mGIoVtOS12KA5eJEFW5o2Z9Udu5VflzfrPm8M=
X-Gm-Gg: ASbGncv/W0yzxZoDTs+jfEXDIhwNrdFNrdTcuVlaV6DptvOKKF0bIJR6R2MfRxzfB0K
	0PYEkAzpEi9gpMS2HGIEZoT7tgJuW6TD+48MsyBAKBSN8tH8AbP8eX1jHG9RgsOZNuNbuItYQZu
	X3IaGuchzwXSZlG+d7uGMkviSZ8JtGRIH7wjJGQsETfd3f0uUG6LNkyYHmfXfCjM5YWQhlnKAs/
	bYG5aXvIK0zt6BMfL2vmjyf8MBj8bRMr47jtiUjZGJ2iz92JCBd8gGoR6mOVEm9aH7xj60Ar25i
	oxM/3Wa6+roKSSofAtZzlcGw+v7cq5l3MD88yhOvZizzv9iZVXcd/rll2d8oOwBm3+zoR/EKzx6
	AMUTtAmOPbO569iNbIb05GhJObLpKe2xvI3VY3kIhg1AyqwMD0jT2lUG7iw4qGej13RyLzAkdH8
	hgXYi/Yj++aSPWnxHoH9nm+Kx7Oisqs7pexP1Q+3MYjuqyiJB777iUsPWlrHcPL5D9W7TAFNm4Z
	/XtJuABCu6uHfhXVrY=
X-Google-Smtp-Source: AGHT+IGtwUKKLBuKsANs8h2ZfW3G/29sLkhfj2S7EhYyXMXsl/4R53xw9nFfgH2YPh8gz/EQVXmnSw==
X-Received: by 2002:a05:6a20:748b:b0:35d:53dc:cb56 with SMTP id adf61e73a8af0-3637deafb4amr1072038637.36.1764039593898;
        Mon, 24 Nov 2025 18:59:53 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e9b1239sm14549915a12.15.2025.11.24.18.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:53 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 2/3] wifi: cfg80211: include s1g_primary_2mhz when comparing chandefs
Date: Tue, 25 Nov 2025 13:59:26 +1100
Message-ID: <20251125025927.245280-3-lachlan.hodges@morsemicro.com>
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

When comparing chandefs, ensure we include s1g_primary_2mhz.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/cfg80211.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 53490eb04e87..d513a70fad07 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -975,7 +975,8 @@ cfg80211_chandef_identical(const struct cfg80211_chan_def *chandef1,
 		chandef1->center_freq1 == chandef2->center_freq1 &&
 		chandef1->freq1_offset == chandef2->freq1_offset &&
 		chandef1->center_freq2 == chandef2->center_freq2 &&
-		chandef1->punctured == chandef2->punctured);
+		chandef1->punctured == chandef2->punctured &&
+		chandef1->s1g_primary_2mhz == chandef2->s1g_primary_2mhz);
 }
 
 /**
-- 
2.43.0



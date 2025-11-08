Return-Path: <linux-wireless+bounces-28695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B407C433B1
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 20:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3190E4E066F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCEE28031D;
	Sat,  8 Nov 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLBTT4YP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2061A3164
	for <linux-wireless@vger.kernel.org>; Sat,  8 Nov 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629810; cv=none; b=MSTVt+z2gzRVQ0ZGzcpHFCnj6JrDGqUX3oQtaGNeU3zAFoWE5PEpBwQdAdy27RcFUqo6plEbwXp2UqAT8cs5yrB3sleN9yBtqiVT8seC4VFF7SeofmohyRR55LPlTNLCckh7JMn90DyfeDmmBM4HCnZVsZHBIU1uU5ZTEowPZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629810; c=relaxed/simple;
	bh=mTbcRD3VkfpuAtDSR/kk8aJDNJYCsJb+Ci9UiOxhwq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3tAIjzW7nYeBzE6srb7oZw7d/ECgxE8qqUbaHj2atzdLnqhg2Y/aQ127O40QE74F+tbYKV6dn1NON8qlmVr5tBF2flCjp2GA1blrXvgeuFyosVI3vSiWzMnr+prH0tuvEfOl4zsGEF9xA7K68LbN03ePnSi6/lMtu184/+ZpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLBTT4YP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so2931435a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 08 Nov 2025 11:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762629807; x=1763234607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqyLWjBuDAdqD8OgBcZLZzDDoVCLesLlq4L5A2Y9FWY=;
        b=OLBTT4YPodCOp++F7b55//+M8ScNkWPhY3SgLeQjChkdbwGJdzXcloNZzU6C6qNCVv
         4Jf6UAwc37cYaiWxJmNaLpkHCUYp0OuhhDh0hGdxCPV64FW5Ufx3sdXOejTgxDElpJTl
         ULyhxYWzWKrmEhOLI2rrsl6LB7oaEdNVWUBzSquByH9OpouixkQDFqGZh/eV2qc1acNe
         o5A1JLynUKP/R8E9EbuEjjHYvL15YtCCgdgdiqVfu7f4dfRmnzzJW0Ql5RCxGiVB5QyH
         4F0mdyhRqtuXqXfUkL7VH3CzNLULuqpMgvjNy3mCk/sH/vL5wqQGlaIufSybcY5N4OP+
         2N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762629807; x=1763234607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqyLWjBuDAdqD8OgBcZLZzDDoVCLesLlq4L5A2Y9FWY=;
        b=ve4R/D8s8nTgZffjVc1HcYLH5R0HNbnPoJh76uA3yd0gfJZGgvpTouuIcRXqRjHxLU
         UcXvBOZhYD7P/elEN4OaOc0JgkFkjz9UzgtnObjtGcsFcPF/yyzCDx3Oxye1XZBZ9zIn
         UZuicjdwYB/eUEQRrz/DNwmGkJAk4yyhPWLEtNwZoeDMbq5ksF3KKzqoS18x8lkCvd4l
         P7Jtzxi6CzZsh1gq49mFM8hghNSav9a3E0SXBu0x6Y7o/GxpEbIwRgWXqODTEV4RnqST
         +5JGonfkwLgKeK7IdterVkflkhPMcSJ9elxgYSGIuHrnTXfBVKwsLch5/pGee02gRw6N
         VRGw==
X-Gm-Message-State: AOJu0YwAXmBeZCa9jFLGEzWy/nXidf04tLbeIcF9BaU3xIDJNd/2TEMC
	pXGswDq8wncr1/1lPaue2h8ZI8V7HzdLvTA3DzI/4m+Bxsuzx4g63z/Zf8Ikzw==
X-Gm-Gg: ASbGncu1iqy5E8WRjcCJcABZwQ6RqqXzXPYnqZJ4oiaAztYZhLvRgJjLvTHgxtprJhM
	1EwsIBAt8pVI4Y2DbE5LX4z5CRfN8ghdHXRPWY5W0+TxbzKbv+MNy73vb+OtAtkFva3j3SXS/Ei
	tKs+LtrWZxThBBis3Q1UxYrO5ZDl5hO+bMYjBc1/32JMvilDDGirksqa47vfsj1ZPaE5m1tFRJr
	KCOef3JpVQjgB7FYCpIMvqkH6q/yM/ajS3NXj1OGFRPJY1PhhipaaXa5DoRdX5OdxZiWh/n+X42
	j0h7RAk0mWGdS+HCTpWH2TfVT5oQbqwBYdf5fgJezyLf4phJnJEDDtjQZcK/vVi9rLKrc+V76jH
	7JasTfaN1HG2mmPG9lDDy2CM1LcbKXR3dgy8KssShOX4UOlGrOAB4IgMKVBJPBUshHrSaffCezp
	9sPaFk6QbMcVKnGvfuwnGdurffD6e+reA6MvEpAw==
X-Google-Smtp-Source: AGHT+IFb+rLGOKc9AJPznDNBEME2JfIwoCq7lo6jG3LFNlpAnZ5Y1krDXabkM2f5QLblCAO3x6pfgQ==
X-Received: by 2002:a05:6402:34cb:b0:640:9c99:bfac with SMTP id 4fb4d7f45d1cf-6415dc12161mr2711389a12.13.1762629807040;
        Sat, 08 Nov 2025 11:23:27 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm7284377a12.33.2025.11.08.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:23:26 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v2 wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Sat,  8 Nov 2025 20:22:38 +0100
Message-ID: <20251108192239.2830459-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
References: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
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
index 50bccb6b33b0..357580faa368 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21096,6 +21096,12 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
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



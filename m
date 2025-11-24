Return-Path: <linux-wireless+bounces-29271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC145C7F045
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 07:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5968F34258E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58997221F39;
	Mon, 24 Nov 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="hUXpOGbA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E83217736
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763964698; cv=none; b=L1mZjBcR9/LOf2yWOrX2h3b0q3vDBF3nIyE85kZqXHg3CheI4r17o2mabkpDi7clWzWMUnByJe8jXNqaUNLMcrVnEGy2+bCp2gxaGTNR5ZrPe3humNZfWtlrNTHAjUbJqkU3MZQDRPDL1Kl2TB0NYucB0tLvr9sfMWT8MRsn0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763964698; c=relaxed/simple;
	bh=+fyIxpYhIo9F/nR5oMTv04MHmHnFSw5Alutm0aDkbag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2yyxTACzU2XlOwGw8LlB30K/BCZs3rYSFeVT9LEifKatYqqhalHdbTLBPKiOF6398KI3+32QgyQyojLtHj3812xThn1jgmnKCV0I+kD69+QS+nZ7oref+/kDwnwlTIZ047A/HbyM5cfqTZeJ6HwUJZ3kbXlhLtRZm6lTO0tDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=hUXpOGbA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29812589890so46197555ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 22:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1763964696; x=1764569496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKejhinRAX5Jri7ceK++2hZuNvpE8bhMRpF+xH5VYJk=;
        b=hUXpOGbANxcx2uNLZJ+Vh4JFGLqChBgcuS/uraFe0p97zss7zXNzjKKzdBpV2Vnkpg
         amtQcu0ZjosLcnouxTr7T1vo0VKbMKPYutoHhZfr2nj0Uchz/UQxaY9ANErIl8UjajpH
         VDXWSljviHzt366qFE5wR0yRqDTRHxTw3bHdY8Q7AjZnx23kn4deOTaFVhBP6tDBFzbd
         Zdp7zcOTXofHWxWkzYa5XUwrLVrvWD7CV7lWPhAxRjmfzDO3hMMGWJ7baT6EnqsxlK+N
         eEkm5P8hAw1ViPLKdQVm0lxv9S3oj7rNm4myupgfjV98en7IxzAW4yaNrJMS1VfW2efI
         gnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763964696; x=1764569496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKejhinRAX5Jri7ceK++2hZuNvpE8bhMRpF+xH5VYJk=;
        b=f/NBVLxj0qvAu1kbIGLbzGHFNIXvz4QzDe9POAaAUHtZwGcD3qZoqRqxYhnyJX0/ra
         6ofYLmYYyeSLbByUV/PViblBwEz9Y+SRwCUc9GgkwU6SVisqZL/ihXaqQQea5xSX85vM
         kZAgtA7mTUgVr80wvNjmGIfRLfPF64pX1UaPB8k1htpieJiaJbD421y5p9B8CCKJMMWz
         C/SIpAQaXHxb4BxKuKubdynHG2YLdex3oyKccUh3Q/jGIIYx9JR8i2Q2/zFI38Bz0kW/
         8CX4AVuuqYozBXpIOBfidKkvB1GEaWCMxD8Jey7Br7esWTCC29NNnGkVS2s71t2eK+ml
         l5Yg==
X-Gm-Message-State: AOJu0Yzl2Wsm71lUwbdUYpfDsz6t5ijfQYEzXerxcCzh5F1C9RbOOd71
	TgBwU6HFw4o1NLmyhAlZC8iuJXojBv+cFrsb6uAbue9jeMN/rj6XNWv5D8q0uLyB+g==
X-Gm-Gg: ASbGncs/XE2mZPNTzSJ4mdBTCvhd3Emxpe0NY759y56Vp8xUtTcKg8lAaW5VT88djrQ
	aB6sCnvdlyyPGGhK+ZHsvX8U8t1vz+tdgnBG7VNgx78dT1anm3B4E51k8WiPO9XDLvY4wkUsngY
	NV3YJqH3BVttpCpyJhVPLSGqy/YgyJALS7O6NiA2WzZeRh/ms6clW3Z/qEeKFe1tTG63yURO4Fm
	kNcM1P8ARPuQpp9rUYSOARISVgTTo7S/vvzp/4rtbBrJ0pTKn6oQaqoBCJRlZvSgJrJrZDgPsNX
	vOAVEAUn8xOWTvZB5MNWqHCviYoJhQMlMdl5lMUQVyN+8QJ1wOTg2aI/wME9pp2Kx/jjceVDYaK
	BafNH0RDAOvU02myhqsIdk+SHVz5OeyGHc7Ys/vKznf33fM6A94J0+l8UJkYPxU7F0o4crddo7Q
	BxHwZaRMggcxkJvk8k4GCea+TJ
X-Google-Smtp-Source: AGHT+IFOIG95gbQiKXEQigC0yCrYt3Cz3wYI6i+ZcqDXSH3/SA8TzgwIdbqnOHCPYL/UYq6JLqzlQg==
X-Received: by 2002:a17:90a:d00c:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-34733e6cac7mr9713229a91.8.1763964695670;
        Sun, 23 Nov 2025 22:11:35 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4c73a2sm11801881a12.8.2025.11.23.22.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 22:11:35 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless] wifi: mac80211: correct FILS status codes
Date: Mon, 24 Nov 2025 11:41:11 +0530
Message-Id: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FILS status codes are set to 108/109, but the IEEE 802.11-2020
spec defines them as 112/113. Update the enum so it matches the
specification and keeps mac80211 consistent with standard values.

Fixes: a3caf7440ded ("wifi: mac80211: add corrected FILS status codes")
Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ddff9102f633..1f4679092e69 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3594,8 +3594,8 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_DENIED_WITH_SUGGESTED_BAND_AND_CHANNEL = 99,
 	WLAN_STATUS_DENIED_DUE_TO_SPECTRUM_MANAGEMENT = 103,
 	/* 802.11ai */
-	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 108,
-	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 109,
+	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 112,
+	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 113,
 	WLAN_STATUS_SAE_HASH_TO_ELEMENT = 126,
 	WLAN_STATUS_SAE_PK = 127,
 	WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING = 133,
-- 
2.25.1



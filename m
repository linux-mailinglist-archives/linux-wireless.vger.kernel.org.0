Return-Path: <linux-wireless+bounces-10922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD99475E0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A17B209E8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3C5145A0B;
	Mon,  5 Aug 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOj0OSHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8A6A01E;
	Mon,  5 Aug 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842301; cv=none; b=oaCB8kL7SY7VtKP+5Yw7tsZTESC1wAkQrrfSgVmLTWGe1qhRC994HHezSX9PNhNIBxsbBKiWSAzwZWmbNZzpQy5OnYmv4wqkE8AIkGIeA/ZeR2BlRAWr8gS0XQyVeLqAf1OkPm38S58+GpUqs8bip3c1hwqiTZxOsW5XRyLuKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842301; c=relaxed/simple;
	bh=fniE8tuhdokX16cHRGF9TxpDQlWgeT3TOL9mIKL38bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WY35B54c4KFfC2qTZx2nC8zTGjqAkb7vShdOB0i9Bw4dv/q1URzUvjKvmQaffNd5BbeunlnXwW0UDXXa7nQ3mWd1r1aZZ5cQV3hl6Pxi2upnxdRl6b6J3oRDEFXm3H9HczUHzEMkrIofIOyEtsgDyYvYdekfVN0tp3hJELk2Esc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOj0OSHk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so6594063a91.1;
        Mon, 05 Aug 2024 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722842299; x=1723447099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/el0xGNFTdbbDtr5pZPM8/5Ct8VQl2stpFBoM0IeY1A=;
        b=UOj0OSHk41vRFZGAve/q8+z2JmyneNPBw3Z/HW9RgG5K97+ts226S02fmD7cXO2eLO
         wSem259a4jhElF+xo+F2s+lpf5Xn8rn8jaZciSxxb1s2qDXpfjj1OY3bVk/VXCsYawOu
         0Mjro2ol/XAkqznh3/yhSvsXZsHRgLG5rKPLyrtVVAgPnERvv/fEVgfgbpY/AYBIqK14
         bZ/8ggrNkmT1Ijx497KWkjtPL3Pjw1xV7XTy4z0dl2gnraaklLQmdVoGbKBiHzpZ/EjG
         6YcivxtfgX41yphLMFek5EsQcFmMeQx2lsbxm5brktO+fUVdYq53Yf2z5Xx1SZEt6tGY
         gGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842299; x=1723447099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/el0xGNFTdbbDtr5pZPM8/5Ct8VQl2stpFBoM0IeY1A=;
        b=k+zno/p+Q0fJmH5I243cCU2bT0hV+r55Wl038HrCEtNnv4PvZ73d+PiLqaYQOObhad
         T6kJIvcrTKIE3elFW33kTQZBhuq3VpG7Mls8J4ABJY1m3nLMOiO2RQlLegYgRqvP+C1/
         xbK3ay9EIOxU9ecEmBbXyx1zymUgBfGyixRZxOItrPLeqKA5TXiC/C4i/uJxrsxN/hmb
         d+r2fSxncTG5pdzuuMcBxrPZE+RR3+j1QtYhr18WiX3gUmFtLJsXF0Cr1S1wZuit4Hpk
         4AmCKU9KgOxXOiO8ldEJy2FNcmgWmr95pp2BFycbV8qqmkrjOrPw5LXrIfAhsUfh4YMF
         0y3w==
X-Forwarded-Encrypted: i=1; AJvYcCViFzvMniDV4XPZ3U92fN5ZZ6WrFkutntwnyWkoFhBMhWZ4Rr3C0KkqczdE5zHPa/s6qRzkKCANiHoDH3PXYPAbVeSC1n5a6EML23wW6A4UPno36skqBY8pdzXikb1BxtpMiKBI
X-Gm-Message-State: AOJu0Yz4Rza7tCWDdw9dPoWmWY3ZYM72rpqFXZ+AgXxI8zLwRBQiFBcx
	CH3epJglEPXPFS5nEyv5HlOOJXj1IqbN8SROgCJIsFrFqThChxSF
X-Google-Smtp-Source: AGHT+IHOjps80DUneOXvRsMhTqimZWaMVNi12LGFI9HVEfB5rRDEhUQya6OsdFDNELE3faQYIfKU/g==
X-Received: by 2002:a17:90b:17cb:b0:2c9:321:1bf1 with SMTP id 98e67ed59e1d1-2cff955e51fmr13968237a91.39.1722842299500;
        Mon, 05 Aug 2024 00:18:19 -0700 (PDT)
Received: from 904-569.realtek.com.tw (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69d54sm6316927a91.12.2024.08.05.00.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:18:19 -0700 (PDT)
From: hhorace <hhoracehsu@gmail.com>
To: johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	hhorace <hhoracehsu@gmail.com>
Subject: [PATCH] wifi: cfg80211: fix bug of mapping AF3x to incorrect User Priority
Date: Mon,  5 Aug 2024 15:17:42 +0800
Message-ID: <20240805071743.2112-1-hhoracehsu@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26), 
AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4 
and AC_VI (Video).

However, the original code remain the default three Most Significant
Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
and AC_BE (Best Effort).

Signed-off-by: hhorace <hhoracehsu@gmail.com>
---
 net/wireless/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 082c6f9..4e04618 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -998,7 +998,6 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 	 * Diffserv Service Classes no update is needed:
 	 * - Standard: DF
 	 * - Low Priority Data: CS1
-	 * - Multimedia Streaming: AF31, AF32, AF33
 	 * - Multimedia Conferencing: AF41, AF42, AF43
 	 * - Network Control Traffic: CS7
 	 * - Real-Time Interactive: CS4
@@ -1026,6 +1025,12 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 		/* Broadcasting video: CS3 */
 		ret = 4;
 		break;
+	case 26:
+	case 28:
+	case 30:
+		/* Multimedia Streaming: AF31, AF32, AF33 */
+		ret = 4;
+		break;
 	case 40:
 		/* Signaling: CS5 */
 		ret = 5;
-- 
2.42.0.windows.2



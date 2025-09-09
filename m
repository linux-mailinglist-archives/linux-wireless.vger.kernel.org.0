Return-Path: <linux-wireless+bounces-27185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DD9B4FE6E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCF3164039
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031033CEBB;
	Tue,  9 Sep 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7vFJlNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642383191C6
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426200; cv=none; b=XTiY9ttCFLI0Pp7SF7nxas5S6DUTyIC/ZaHA4DSVf3PZ+bTFTUubmt9mgqhnIgYKwdCQ3fXbokHItOQcIAI54LRlSiEa7iFfmLCC2xZGJWSE2YhM3U3/6r7Y+3M8Icg4WIMJ+9ODAkCKVLlY7CzrJSiqk8HwN7ik6nvM34fUfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426200; c=relaxed/simple;
	bh=t6g1aUXyWrgNrZhwjW+n9bwxW4j+ZYvLiGDs5nt8QPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJFQpJIabfBM74tPumJDEWSI52yWAyDfHtRZLHIlOCMU5nDbbJmezDkJ83LAYoZldTjjWiZTnsMlve4AMxamA2JEGwlP/ABD4WVJvJVFWeMNZESqdqydeTEkoGYI1AHQZn4e/dhaxtNkpSeUF78jzWF+cQCpiXEvmXR+DKiGBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7vFJlNR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-811ab6189cfso369532385a.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757426198; x=1758030998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdc3VostB4OtgOjh3NMT2fLgs9hapZCHnoB7Ua5wgNc=;
        b=l7vFJlNRfCZdmeaNMGOOiEaI8EyxgDabVIb+KUfQRp+4w+dOcwu9L/iWjKtSUWxkuF
         yLY4lLV9YZT5mxvQjuh7P55FT6i8qBgCSrkrlvioRuKec4uQsn4Tn7Z+2/2m+hvUAJVM
         4+Q6LGA7qwhfqCeIRWFuK3ZXIQTwQ94zdvR5BgO1qd412NxyzFcfvGFrONTiROBfcp6v
         7GeWGQbNT8G3z3AE9sPPpX7PDcGgOTTxtwkdJ5XG9ySiJwFaJclPdQ3hraVOIXb//+2B
         6AtyLrlxc07xjp+9b4e7lYf1nPQU2aTnjS6vunjSPhvJ5GU8Dk7Z8zjfaqjlOjflruQA
         oPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426198; x=1758030998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdc3VostB4OtgOjh3NMT2fLgs9hapZCHnoB7Ua5wgNc=;
        b=ggrhAL1tZf9EK+Jc+UmcSBu8jTNSthcB6ys8uZusGvWJtshNTRdIYIZOf22rLVW/VP
         nV4hz8Lqc9zbaOeazClfGrgTQExTLPDOGyi/HPYannn9PFHkJKUktoJ71jnuhLHYQD9L
         Al0rkGITjiRTxaRb62jV+QtFQsd5moG7c1VVgIWjoBEUogZxNwgExy2aImcGQ6TC+ChJ
         vWleEcCIh0ZqBbu27zWHicXgrxC3WRMpnytcKDQ35axY4k2hzP7Wa03d9hxLpgeaQrvE
         VtdDwKCzUjQQxLghB2R3rsNDP0xYq7OIITTV2Px3rmV4ymbW1zWLa6v9gqdLPCA66vU4
         PyjQ==
X-Gm-Message-State: AOJu0Yx2uYnr51s3p46tRdOLQhDKR7o+chZBJcLv0BYU4NGGhm26lpAQ
	otcDGuAgLNs9U7PNtpKU15UoJHXhkZ7+dtUnKS+KdhrNrVQMlivnKEwBYCEPzn6r13Y=
X-Gm-Gg: ASbGncs2LVQ3L7kQYe6hC88UtMcuh6MX3TgSd8g8qacG+2pYrjLYRMMAhqilCKy2lGa
	XzOF5nAuEQZ4pVCsiRNCTUzdITevmQ6GJh2R3BlL8jEG8mYlgru4I3QF7o7C8XROTg5+/crI0eS
	zxJEyyxHcWJFdhzRynKIHPrYaTXxr9xv9PArGcmU03Ps+aYfHN3BlSwrMzWzrOYS4+KqRSRCo5k
	ouBovEIwGt5rVof5iuFxsT/R7YHBS+EUeMPKSRLkS0LaSAPOeeuVRIys/n3+EsXGzCF3yeVwcwL
	Tw78IdgOSm7Ks5Nwcj+FPt8M6sZheavUf9xKCjoDf2jQTF2gnJno8U7Z1G5nPlET1RihXGHNYr4
	Z+ofr2YDr+Xd0SI6ljRzKpN33mU3/d/DybHVmh5p98MTz1x2ajyVfNavjMg==
X-Google-Smtp-Source: AGHT+IFcildUHmaba9sU5KJxXSQ3fhTY/0fp2bl8KwtnhWhjhZavG2KPFzNkPzqEaGZopzYc+4WClw==
X-Received: by 2002:a05:620a:17ac:b0:816:d061:7d2d with SMTP id af79cd13be357-816d06182c2mr806479685a.70.1757426197621;
        Tue, 09 Sep 2025 06:56:37 -0700 (PDT)
Received: from work ([209.173.25.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5e4cb960sm119522285a.33.2025.09.09.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:56:37 -0700 (PDT)
From: Jeff Isaacs <scaasiffej@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jeff Isaacs <scaasiffej@gmail.com>
Subject: [PATCH] wifi: mac80211: always mark 6 GHz BSS as QoS/EDCA capable
Date: Tue,  9 Sep 2025 09:55:10 -0400
Message-ID: <20250909135510.757750-1-scaasiffej@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6 GHz, QoS/EDCA operation is mandatory as per IEEE 802.11ax/802.11be.
APs are not required to include a WMM Information or WMM Parameter
element in Beacon or Probe Response frames, unlike in 2.4/5 GHz.
Instead, stations must assume that QoS is always enabled and use EDCA
(default EDCA parameters apply if no explicit EDCA Parameter Set is
present).

Currently, mac80211 only sets bss->wmm_used when a WMM IE is present.
When it is missing in 6 GHz, mac80211 wrongly downgrades the connection
to legacy rates, resulting in unsuccessful authentication and association.

Users see log messages like

    "WMM/QoS not supported, limiting to legacy"
    "Rejecting non-HE 6/7 GHz connection"

Fix this by unconditionally setting bss->wmm_used = true for 6 GHz BSSs
during scan result processing. This ensures that mac80211 maintains HE/EHT
capabilities even when the WMM IE is absent.

Signed-off-by: Jeff Isaacs <scaasiffej@gmail.com>
---
 net/mac80211/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index dbf98aa4cd67..ecf0690d8c08 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -142,6 +142,10 @@ void ieee80211_inform_bss(struct wiphy *wiphy,
 			bss->valid_data |= IEEE80211_BSS_VALID_WMM;
 	}
 
+	if (cbss->channel->band == NL80211_BAND_6GHZ) {
+		bss->wmm_used = true;
+	}
+
 	if (update_data->beacon) {
 		struct ieee80211_supported_band *sband =
 			local->hw.wiphy->bands[rx_status->band];
-- 
2.51.0



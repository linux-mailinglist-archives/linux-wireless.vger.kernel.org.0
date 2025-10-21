Return-Path: <linux-wireless+bounces-28126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA51BF4AF9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 08:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AE304E3FF1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391A433B3;
	Tue, 21 Oct 2025 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="HXld9pq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4042F872
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027151; cv=none; b=ge6R+tr7oE0jU2CKg686F2pq6GRBpOJ5gLm7gBXQsgN2Zr3i7BqkEiG5VGQ3Jd+fBls65yDHR/VkH9eugEHQ2nZbV/jfZWx2udpUOZedXeDnNGdHZNPwmgjQ3xkcwin3Nyryf8kq6lqWLH4gNmZebG8A3a55oiWxLqmFkmlpB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027151; c=relaxed/simple;
	bh=txsBiMadMRiSyp3/KP/hpXeCXHVOQNtLZWrV8/nQKBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuXTbBa3SpWZJbbhiFGvzyepq/gKcumcX9Ke7mWQEI83vv3ydbgEwXQwyrqYD8gN5t3A+vxlQO4p/5R7ym4EUJOE2zoRjFOK6N4ZunG5Gb/7c4fWeSWQ2z9m9ndvE2cYA6Qv6irg/BBam+Qf8vuJ7ZHcb+D8O5knbjwbGCkotI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=HXld9pq9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ee41e074dso61307775ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 23:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761027149; x=1761631949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfxXnyVrmwSt1ASfhzGp3zyRj5WuPDeuyodAeuVKqew=;
        b=HXld9pq9UJ7f+DIlG03Mgd9Dv3x/EtSqkMBigOaYYL59lPTIHTLM1qkz2EOOLHbvTp
         KoMvYRXYMPAbMdUrle8He/Cllv1ONgiIO+AqYlf6CvfdPQ7qmT4BScnXH4NA6zfi5uD7
         1Z0Uhxo6Da6QYdY2NaUZz1/2nyr7w5zAb9muq+cLNuEly9FR0Vc8srdvQ2AxfBzu0IGM
         5zTjWSMaql5rN6lyrxbbe6hvH7mVM+Qgq7wPHFtnkDLchiBYef+gInIY21h7ILPY5Pca
         lvtX65CQmi4dHTJloUdQVwhzrGUBE2eg/e7aSRKUECXTxkp8Y2gG1qqSAFReKCXWPbn/
         4soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761027149; x=1761631949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfxXnyVrmwSt1ASfhzGp3zyRj5WuPDeuyodAeuVKqew=;
        b=NekISPi0/+uJfTb4adzb81ZIS1dcxVX0n0dB9tQRrVuUCqdqaC2PHBupiPecTzb/ZX
         O5ybt1xTDZDDYgnEXV5kbpYPhRcjDNWrP8Idkle+X5NH0k9/yQ1HFSzM8t8CKlPijbvH
         aDCsa6PjWrTAWyyExt0Gxzp5IWritcbOJeRulx2SDVg4TRTrAB9QMnsiF8/i5lO81HX0
         1Ksj8etiJMoJGqBHWhzoHaz6fM7GiVMTYzHJ30fBO7gmhZn0m9fAk2ldJEE+FNn7y11s
         HIollBWec6aAl6VCSkM97cyi/F7YMH6BMCkmJih7FJhwYB83/mtyPgHGNjNtnXzqI/ph
         3DMA==
X-Gm-Message-State: AOJu0Yys7WiGqJL0exqBLwlIU/+Y+w5U00EU+mn2js0N1YPtPqLbfZBf
	yaDSI8/4ZfJ/t3WREbq2Kns8GlxuCcRefm0n6L6N3Rua3IeVj14XWrtYTmqcNhUT7qH64X4AMCB
	dw5WJS5I=
X-Gm-Gg: ASbGnctE8mH8WU/p16AoZEjjN5VYHHZUbcivn8RsooUnWAzy+tQ5+DY2h7DxGSR96yJ
	TV80nRVp2sRPpdHraKH3gBQwco28mlXrAJ65q72/AKqM/0z0za4PAhcj7ng6DcW9C/FQhVsbqPb
	gYTHnSyZBH2qpqEHj4pta/W3X+S2oPX2ig++6khrbEWIq38leqrKGu3nFgMuKU7C5fuWa1Mivsg
	WQdNJcxrWoPx7UbIRm2Qk0Xvuut18GXOdSia54+Jr5G8Lh+Qeh6vicYFoenIqSgqQ7L8TSvssSV
	0IA+XxoC1E6XTRAVNw+z6FZAJ5nBfc/YzJTUS7fhb47yBZCJjLUrN5ehesK6kY+3bgf5m/tMHCu
	T1WVpfdaRKnld5PP29zsEHfGKEhBWEnVCJGBqU8eNooT6AjTcrFLmA51E32npgAuA8viVbSa0Wt
	0EXTeYZo+CiGYptgU6zJ0LJnhRNLYzjUOdbDgpUeSA/QqzLGiiCw==
X-Google-Smtp-Source: AGHT+IEZ+PztHyWaCoCtD20tCUKSeI/iXpK2suBVNebQ0hqmYsuo0WggXq7sMFPsGAC2N+vH3vdZ/A==
X-Received: by 2002:a17:902:f548:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290ca1214e1mr224059345ad.31.1761027149124;
        Mon, 20 Oct 2025 23:12:29 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fdc9cfsm99073665ad.45.2025.10.20.23.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 23:12:28 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: cfg80211: default S1G chandef width to 1MHz
Date: Tue, 21 Oct 2025 17:12:01 +1100
Message-ID: <20251021061201.235754-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When management frames are passed down to be transmitted by usermode, often
times the NL80211_ATTR_CHANNEL_WIDTH is not used as its implied to be
transmitted on the control width. This can lead to errors during chandef
validation as the offsets from the channel center are wrong. Ensure we
initialise S1G chandefs to a width of 1MHz rather then 20MHz.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 346dfd2bd987..ceca47cd9e25 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3544,6 +3544,9 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (cfg80211_chandef_is_s1g(chandef))
+		chandef->width = NL80211_CHAN_WIDTH_1;
+
 	if (attrs[NL80211_ATTR_WIPHY_CHANNEL_TYPE]) {
 		enum nl80211_channel_type chantype;
 
-- 
2.43.0



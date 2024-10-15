Return-Path: <linux-wireless+bounces-14018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEA99F72E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EA6283A96
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557B1F80A2;
	Tue, 15 Oct 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRO4MTbk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498651F80C4;
	Tue, 15 Oct 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020145; cv=none; b=Xzn67ttx6RQPaktsYl9BU+mE8fJJ0cgKczMd1hnnPnOP1c3wAlRBPMqA1LwXLSdpOiKTTzbfHJNgPBukVxxYgeX5yt3GfSqPfaKtIaAPWWQKgBx6elIp3qdRrwIdm8Zd0+Q0CODWZCwrDguasbUsvkRXp8q+kJv27iUDDqvTg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020145; c=relaxed/simple;
	bh=uAKGkJ4M3SRrf1ZRHELx/lQpeiO6UYKPiTFzxksy5ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Om/b8+KEWbK5qxmPLHTJyD6UshNxPCCl0Ijpw2YPizN9iyUoDuioA70XNlJKYoyh3NNkC6uV8fRAyvMFDMUGaTyXGuobVXi8Plle7YydYjb7a+fxvLcj6sel7cK4EXqYAwJ9Cqua/0fnK6u/ICUAdvsZjAuRjtA2Yw2mZDCpVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRO4MTbk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e63c8678so3579766e87.0;
        Tue, 15 Oct 2024 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729020141; x=1729624941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN1bH/cSXd06vWBgv09b0nbi6rv9Bqx5gJyYzJHnxSE=;
        b=MRO4MTbkSWTv/ULCUYUDro5XTkE42kzUSZ7Wdghj6qsVvIZ5e5TWWHYacYJvyanVvo
         SILHvQqah9LjhTFs9TgcRpJujvIwNSdJCjZcrrkI4wSrWQzKhDinhU207618bypZI4DC
         t3zly3EDeilRYoGbayJCdFIoBg+5IpKgAIr0iR/pu9hnYzjam3ULrLBaayIIh+iKLGcE
         JemmqMIccA7Tag7irJSzajuFsxZk2RUNVtcMhmRQfFw71h9jEGapOVjrOPeB5It4tm0h
         LxPA3L53yX2oKXRgwM0ixD0X3l4y/DqdeiFd8GAmwEbsJvppJUabEmkhH9JRduh0YX6I
         Znpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020141; x=1729624941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN1bH/cSXd06vWBgv09b0nbi6rv9Bqx5gJyYzJHnxSE=;
        b=oO6JG501NUmLHzkQ1b4GMM442xphAyDVxfYCV8/uUKo4mkDmh0DfdiwA/HSgB2dZsn
         NgRjsnbwXGRjLWG0kctLbXO2DvSUKvxyyRnt7nmbRKS95wXgz3vM8v1WbmQldFcjE9WO
         Z8Dc8AFRRWG4wNbAyvh0rTjh6spELFKFst03UQVIJCT0ujtr2zrlEClIsg97IOSCD16y
         m45V5A1RR6C57Nesuj2qYgSR4Wo9gUr2shIgdHVCeQnYTS8LQUFpG/R4wVAJ+vQaOpka
         XoyFOzc4nTtuZK2NMZ7l0cCxHvngrCzDvXDfALaFFBT32PUg8eKlNChCMGdrZ9QfXxpN
         3wIw==
X-Forwarded-Encrypted: i=1; AJvYcCW3heloElSDADgHj8Y6ShcQVXXvGUKBzrCtgh1u/BWWMaf9Fnk4iVIQjru3vJb/7aXaYlRJpxEoHVWJSU0=@vger.kernel.org, AJvYcCWa2NdJNH8u2/2th7hxT3DaqlWSe/G+3VfgrkJhbDxjWhZrZlJ1d9KSGKRuvJvnJGcXWUL3HnQJ21m31SHqZ/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYNORnIninFPkuZZUavzM9a4R0L0k3YjWTc8Rtz8Tr0PX0fo7
	urzTNWSl8v+9mn0k9QBxzu/J/bRJDxN5WDw0g6qygVeLV+cthMvc
X-Google-Smtp-Source: AGHT+IFq/iItMESBszKIBLEXDdkFl2SMGGkViVgXD51kYJiMz3z6FTkaSXkqQp9KqMhRnsQCsahyNg==
X-Received: by 2002:a05:6512:280c:b0:52e:7448:e137 with SMTP id 2adb3069b0e04-539e54d77a1mr6547243e87.6.1729020140985;
        Tue, 15 Oct 2024 12:22:20 -0700 (PDT)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f7f19sm982334a12.23.2024.10.15.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:22:19 -0700 (PDT)
From: Karol Przybylski <karprzy7@gmail.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: Karol Przybylski <karprzy7@gmail.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: Fix for out-of bound access error
Date: Tue, 15 Oct 2024 21:21:55 +0200
Message-Id: <20241015192155.3643363-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Size of array passed to print_array_to_buf_index is decremented by 1

Discovered in coverity scan, CID 1600742

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index b2be7dade79f..74767ba9ec2b 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1550,7 +1550,7 @@ ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
 			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
 	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
 					htt_stats_buf->ax_mu_mimo_brpoll,
-					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
+					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS-1, "\n");
 	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
 			 le32_to_cpu(htt_stats_buf->ax_basic_trigger));
 	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger = %u\n",
-- 
2.34.1



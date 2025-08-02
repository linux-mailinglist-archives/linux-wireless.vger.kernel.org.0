Return-Path: <linux-wireless+bounces-26106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBFCB189BB
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Aug 2025 02:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BB81778D3
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Aug 2025 00:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB317F9;
	Sat,  2 Aug 2025 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHikuFWg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE8367;
	Sat,  2 Aug 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754093076; cv=none; b=NLFA+agPqU6s+0Qtyb1dONwROmPWmcL5KQBuv4eIoQkuRtNUc/vnvbT+DHQuC9TWlr1Gujaj5NiXFqsX3ZHvczSIhQmGCQa5Xd5fTqFwVT7E1B2HL3opgWRweA6lcoWauyb6Z/OmVgYVp1zvKWFv7OoAiMbBzVKIelf3/QWwhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754093076; c=relaxed/simple;
	bh=93la5Nh5E/ARqUQFVgenbhdCEF0XnrujFCDwUJPPhwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brTimvYxZ2WhXzXS9iaJRj3f6ryNwf4w8BAjdq3kJ5LS80X5oEAxVpheeOmU2wlEe0+KFnCEFoGwLHhr3+f0vn6Bb6a1YrkaGgCNEy9kwxnkEmdkFNgTEm3IoW4976wK877fIwBaPGDNyzcCRKJgA2GGiC900A7hNG3MdzADBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHikuFWg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so1364362a91.2;
        Fri, 01 Aug 2025 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754093074; x=1754697874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IteazX0LOkoWRhxiLZppCFmfzXAsX9QvqoKdjEi90Q=;
        b=RHikuFWgYXRqaJA9+FCiSH2Q3TDs1kKXckfNYupQCLd1gsG+MQptQ0PWIseIjqI1Mz
         05yf5E9vy+06N2DDyXZK9bXUZO8P7Gm0dR2c8DFNAJ5jk37Pn9LFkDeQHqMjPz5xXmhG
         OZJTPW4lCa9Vd3/+7qBgXzCb9MaoIqKA4S3zxHe/ojxZ0xUiu6Yw1YDrshi9/rFc6C7t
         ViycvW+abuNNV295zPKtcY2mLPWbTS2m63ltj2SWFa/CRAgJNQqxa7z2FQ2te0IwMgK3
         CKYE8LfaKvYQS3rOrCDmlNIJQWJqEFsfm4LA5voNsxo0HirIwMN47QXljzQqqPYc6Nx8
         a8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754093074; x=1754697874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IteazX0LOkoWRhxiLZppCFmfzXAsX9QvqoKdjEi90Q=;
        b=oEv7xnQ/5KWg7R9Rw/krHdvpf0j9CBULgw2XTyyl76Mt4W4bs2SAjgttrKLI+BhRUI
         4ZCeMF2EgQprlo6R1wi49kxbLbSBg28I7XVXjjf9iDBUmUudFyAb9h058TCG9xNzbyjO
         4XNmC9Lqr6d+twCxgGwU/XQQ9AN3MzLRi/Jj1DthZ6xZ2F1qfeHHfJS1aSSBve+r4xM9
         HWJmH4MqCm389oPJ4HAZ7YcfhCgg2XdTBXF6ax5NTbt/7woB6o09gJule4qECw/ALnmM
         VteVv8kIvjGo0fBwScsW95ns3imEyAVwVRMt2hHpDOkLdjcDtWD4svK2Zm9cmk7CgLhW
         m49w==
X-Forwarded-Encrypted: i=1; AJvYcCUMaMjJQi8LT8qeD1dsTDSQk9AGtIfnyJ2r6sRo/qBtt7uS8h4o12zvAh9JM1fWp3CYGxl6/qHa1lyqpwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWmXtx4T/RTeElFStXiQNMC7o2swUcZPIVTt/irtt0MOmX4AX
	lAAmS78W1hKdEQDEngYfCkMqCmdthKEZ+qRwTqEUo6xgnPZJp+BN27IKim/tfQSo
X-Gm-Gg: ASbGncskYrRH2cj8tZkP035l6k7J7ZI9L5N+iRFsCue5/BKwsXukF6jQzdHzATZzOtk
	7Z0hU1vuNUyb5bOtejgYVSZB7Ts7nq+ubdCzWrXg+DVYhJDjtDRrUKqfMlDCLBPNZi8gLlHwb/q
	LhXanvTQGEL5x/dRK1C3ix13BgtV+zWLmx5Q/MY7DHymRW9jEU2wb0DiyZ5YVNdf5Y37e92cILR
	xClolou2V/cNvngrfY6dMfATrkhPS74+Bl6PVxANxlh1zDiIe0P3tGwb9rRRZFhiJ9kJCEAsHnv
	jYHsdSo/KONfKrdO4Hagvndhmlb5Z+R0g3fUX7tPmXYt+T2plWzkttXXA5Av3tCEUrQ+C0Ch5yy
	lYOv57nAhuFsBfw==
X-Google-Smtp-Source: AGHT+IGOAcBAh+rcT/zuSwxS1odjYxc7VWPPco+s48wMK52y6mb+tBIgKE1ReE6ez7zGMvmA5tWcOA==
X-Received: by 2002:a17:90b:4acf:b0:31e:6f0a:6a1a with SMTP id 98e67ed59e1d1-321161e9d36mr1939627a91.3.1754093074058;
        Fri, 01 Aug 2025 17:04:34 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da602asm8474893a91.2.2025.08.01.17.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 17:04:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Rosen Penev <rosenp@gmail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 wireless-next] wifi: ath9k: add OF dependency to AHB
Date: Fri,  1 Aug 2025 17:04:32 -0700
Message-ID: <20250802000432.3079550-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to OF missed adding a Kconfig dependency.

Fixes: 2fa490c0d759 ("wifi: ath9k: ahb: replace id_table with of")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Resend to satisfy bot as the commit is now present
 v3: Add 2 characters to commit id
 drivers/net/wireless/ath/ath9k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index 0c47be06c153..47d570a5ca6a 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -47,7 +47,7 @@ config ATH9K_PCI
 
 config ATH9K_AHB
 	bool "Atheros ath9k AHB bus support"
-	depends on ATH9K
+	depends on ATH9K && OF
 	default n
 	help
 	  This option enables the AHB bus support in ath9k.
-- 
2.50.1



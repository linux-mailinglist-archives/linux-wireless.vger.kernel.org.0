Return-Path: <linux-wireless+bounces-26028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78CCB1289B
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jul 2025 04:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5953546996
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jul 2025 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E721DEFE9;
	Sat, 26 Jul 2025 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8GHc0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5572B652;
	Sat, 26 Jul 2025 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753498545; cv=none; b=aUZOtD5+bkvjiaSdKlyOssg4CHchmn2YuEtfX2NFIXzLGyeOk53rUzr09hVH7z1lWvVPYE7NH/trd3ED9XtQ7Fb7lMc3DbaSZMalAV3ZWJh6HMCc7WA2goySezw/GmKH4Jhv1glCAAGc1FDhGE35pX43WsBtebAB4/XB74/U+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753498545; c=relaxed/simple;
	bh=bsNCJX470Sx87fx9XCE/3CTpgvu6NexEYGw7Q+mQjtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHNLVsVIWJ7H5IaoX74Y1O38WCsZcz6+iB6/2BcrogV8i9Y21Z6TlfrErzhijqQMie1jMbp872jjTFB+xXruVNCNbxTTUX6YiFz6Fb4bQwFjQO+xGaGsIewuloU8DiQtxwi1NkvGS9X61zb9qClntV60f1/3vfz2Mu0L0e+UXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8GHc0U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23c8a505177so22888085ad.2;
        Fri, 25 Jul 2025 19:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753498543; x=1754103343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5E1zxfvhUAFhyszfToZS/bfvLCkUqeh4wlzHON3KcB0=;
        b=Cn8GHc0UnvCgBN32chfxANQnseUkFpqUFofNmejv5RbsITEGg6LkwajoE6U365Kdcs
         nqb58P7EwmGrDPaevr+fZQ8tT6enGJfTSUIm2/uybxPO+TA0W6cHuikIrFdKNx8pMXU6
         mDt0DqeMxqpZDO6+QAYQQx+uZ/aEAbMwDPimIwvjgRt2tbuHryU75CiytHnxy0V8TcHt
         0ewszjzPhV6N6fWd3+UJ7ZWeM9qzwK9Kt5q5wj4Y/TMst4T9s2YSFn+rWTnaidc2YiwW
         AA5BGIbdVJVUBrmTsp8aalRgZBI/RvEcnNMzbUZkr63x9uQIbSVdYWOUQgZdkqS/sm8d
         25Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753498543; x=1754103343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5E1zxfvhUAFhyszfToZS/bfvLCkUqeh4wlzHON3KcB0=;
        b=LEFQrDmd0KCZ2NJ/lBVVsRVcV/POi+PhqHhFwFGTXTcTbNnHeKCq7aUkQX/L0DFg9r
         DwdPtZgX47RVOdfn9lssTg6YdW1sRYmbtVJrnOqBz9wcbJe76K4KOaq42HuPWdv29UYS
         RKX/G5aksfu3IJdqQ0n/E2ENGRS3C9kSQhFNXaZRNZOwwt4TSmdlBRbD22nbhMzsLBp8
         Dr9MlDTkVynUiJSyaKM7m9u46K0tudMB6lFJgjH4QHh4Yd5JWzqgkKNHcvV0ekiFNa5R
         PJ9d2tB5nzvlrRiDCZW5jntC7IjUULS1j2bBSW2QxhYGHtFHqxvyTgqHbYx7YB23XMcf
         KMZA==
X-Forwarded-Encrypted: i=1; AJvYcCX/i49fjJHFZuqolki60lIck3DTS7vr/2XgszmfFygv3oNp4WPvi5GdRm7nbsE+9/XhMAXMfWyjVAfAksY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXMKz2qR97hh0IBoN97DE7CR6OZvCwl+plhHCTh92ECGjQH5w
	0QztoydS1TcmuKQg6CUMctcT0BkHkYthX/xz7efcFAJZqXQ+1Zv3VP1IQV+KC5aM
X-Gm-Gg: ASbGnctyyhRLprbRH/a3IA4rq60PzjajsJUje1jyQ7WhhdVH69EYOC+2anzIdN81ky9
	nhRFmH/SUdz8KC1TwpiaOfdP9/oyjXYA2CLCvSMekJFzN7cALvWZxWU7awMC3E22ZhDScJZFU+P
	n6P8pfvHhxwF9AOigCmpNadEAVGtzbdouM6HERLp78HRhSv5lAbAyAQ3xq+kigbl3D0ufSDHGfw
	uE78fHLqkHXB4/Wz59m9i56+mgw7ec8YIdzvRhSJ52nzt4QFu6/s+vvxxJoul9WyIvFaqGGTGRe
	CMLnKlQWfdYcisjB5YSoZTpLok7tvvdkLu0yZQo4x609DJjveyZ9DIVUsrSXQb+caXgTM4jkiPD
	zvIU=
X-Google-Smtp-Source: AGHT+IG9Sfib3vDQt5V1ALhPK3875cvFCO/BuOtbLNJQCmPg31qCmp3QSuyeRD/ZtAR1XVE8+ceL3Q==
X-Received: by 2002:a17:902:e541:b0:237:d734:5642 with SMTP id d9443c01a7336-23fb30e8680mr62462645ad.41.1753498542952;
        Fri, 25 Jul 2025 19:55:42 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fcd8fb34asm1985125ad.33.2025.07.25.19.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 19:55:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: ath9k: add OF dependency to AHB
Date: Fri, 25 Jul 2025 19:55:41 -0700
Message-ID: <20250726025541.11331-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to OF missed adding a Kconfig dependency.

Fixes: 2fa490c0d7 ("wifi: ath9k: ahb: replace id_table with of")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Resend to satisfy bot as the commit is now present

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



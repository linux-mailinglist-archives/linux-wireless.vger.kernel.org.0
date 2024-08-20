Return-Path: <linux-wireless+bounces-11657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D69583C8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7899C1C24623
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B418DF6B;
	Tue, 20 Aug 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OrWgyEQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E418D651
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148748; cv=none; b=s6LdCGnbPN0rKOnxsEY0Jmn3DHghkHWTnbsGkgtSrlancWXGy+apUx5hlhTTGj0U2sAplr78Y/ar6/nbqypqGLlDiqGewBolOZ7btxXKIUQ+Fr1eyFVWw7YnuF93vas/EpQwaEWcKwPGU4/NoHYRBpRwQm+ap1TRjWBaNnAptj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148748; c=relaxed/simple;
	bh=rAQMs2nUAujqv3seBbUaUiGHZmRef0b6WBseJYrS+iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=efX/bc7uGwWHzbu44obI6oK4MoXBxE1SjVluW7ot/IOyUDf/ZBS7NIoda65gJJXDK7tbGIKeFK2c4j2SRfFSrWZHSWlUZZ1dOkOa0OUWpcc/t+sMyF5LvTFDBhmsgQdy73+UVvE5/nDCYqZ/aA/dSi24sWHrWk7V8Nc2YBikUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OrWgyEQi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714187df604so74991b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724148746; x=1724753546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8mNuHffrbuK1rugdn6v3Dt73nbw6yd9qMrSFwaRLs8=;
        b=OrWgyEQiY3FpDGs0HFMY8Mvid4pf/uiWKLbbueUrm7qctiWkOVaX55fnScqSdkDAzg
         pQGxn69HvFzZZH6Nyc3SD7K1+jUGIgCZ/XlYxB4rrzUARBdmC6IVzdXMXMok5T+jIYMm
         NCdBcuX0xgQm6Vo2WqgovxddfjqyHJ+ZLGWuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148746; x=1724753546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8mNuHffrbuK1rugdn6v3Dt73nbw6yd9qMrSFwaRLs8=;
        b=E20wfe2/iaQqQvoYxoZkM2dK4WH+jCuZFfNM60cfPHXy4ugJAgnKKbzSjmcpLvS7Ri
         3l10y/FGkNJTHzFzxdD0bcwc43h3+nrXAX+8m1MJGPZioZF6PGOZVSnLeN+lQ1Y01CXB
         4OP4DWGxOn+Mg1ACZ3UmYzq29MgY9Asn7PBFf99lPpBT+XzbKK3eY0JO1lOcH7piaWgp
         b22zKFfGBE7js1eEZVgCr9Y6xeNadZe0ZggMTa2ygDlmETVPQDN1VXBRcwMuA/AsNUeM
         WI7L4ZD/lp1OVc7pRRPFjp02XJvl9mCasAenFuL+0AJDTIsuLLznpFI4d7Bl9BQaE2W7
         myhg==
X-Forwarded-Encrypted: i=1; AJvYcCWPMVNo7J8GtLSULBqLG7r3Aoe/YpFdCghsyte/bxM3I4Vs5cJCsHtSHMeNrgCkrxxgAxSDZFx6ZbfJpHzzQr0up9pWJrXp5rCK/19snlo=
X-Gm-Message-State: AOJu0YyJsnG5qrM3huJ2sPz2w09H/AEcnYLzB3LgH9Vu3Pvot/0u+tBT
	fATzEJ9w0Tv4tPGorOrxPVsLTscakHbvSGc1TXoGr4qb4fRZbNhuoZPgMPBZiy8toU7js5bqLQy
	sVA==
X-Google-Smtp-Source: AGHT+IGVNRr4ycH9yeIC9iSR/lf8TJNHBQHMKw/kpMSfpHTduTtii93oIx25NUBCshqrvVaygPL04g==
X-Received: by 2002:a05:6a20:9150:b0:1c6:8c89:88c9 with SMTP id adf61e73a8af0-1cac714ed81mr3404416637.18.1724148746291;
        Tue, 20 Aug 2024 03:12:26 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-713f3c35cf0sm3111052b3a.173.2024.08.20.03.12.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:12:25 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	asahi@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 0/2] dt-bindings fixup for brcm,bcm4329-fmac.yaml
Date: Tue, 20 Aug 2024 12:12:14 +0200
Message-Id: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix to restore the constraint in the json-schema that was lost when
support for the Apple PCIe devices was added in e2e37224e8b3
("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips").
Not sure if the rule of separate patches is the easiest to get
this fixed. If one patch is preferred I can respin.

The patches are based on main branch of the wireless-next repository.

Regards,
Arend

Arend van Spriel (2):
  dt-bindings: wireless: restore constraint for brcm,bcm4329-fmac
    compatible property
  arm64: boot: apple: fixup wifi device specification

 .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     |  2 +-
 arch/arm64/boot/dts/apple/t8112-j413.dts      |  2 +-
 arch/arm64/boot/dts/apple/t8112-j493.dts      |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)


base-commit: daaf0dd0398d5e93b7304f35184ca182ed583681
--
2.32.0



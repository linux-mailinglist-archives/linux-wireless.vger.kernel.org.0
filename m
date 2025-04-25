Return-Path: <linux-wireless+bounces-22053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D9A9C282
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123FC7B69A9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C3223A564;
	Fri, 25 Apr 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VtKrIxAz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21622367A1
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571331; cv=none; b=DHDq7PfK2cu3IFiV3UfA1+10kNOHrk3K30ELP7njVgU68J6h8pRwXadp38ru0GMEaOqP6CRGPVQnfZ80rZO0N/WHn1othT0mQeygcLw06gJaWlE4ja1YtRkabe/suo5l7nyfwv02wk7V33JNco581caXiCJU1A0plLSEm801a3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571331; c=relaxed/simple;
	bh=CZqj5BJ+F9nGfuUzehgz/29o8eO2JwnSjCkRPFzqBFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IbVgbUQMRYA2c2D5ruDDuNJv76bvW78oWFM1E5db6iDmtv6WAEIAsd3oDFATWjLe+uY2J4SQ52ZiviD2YyW4L08hiZFxLAlKTAc8in1y/DSQLb4YFlUl3pKxSBc4S312x/SP8kUmfhicZGbd15pMMKIuqb/CB8/CbE0Tf9EAmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VtKrIxAz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33ac23edso18942375ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745571327; x=1746176127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLk1imrVTtrpJbWqDoaFAq9AHbfHxqAvYTRp4hVRDXA=;
        b=VtKrIxAzYj6bCf/BhhIqiVHcW2WVoR43kTUVS7clrC8H/y7a9V6ddHbKi0ECLwBK9v
         8hvgU1h43hm+Adai5xbVUTcsCdjC5ehbIiVhrZZZDGQJh5W4dJqcu7nzKjUmKXMcKH4Z
         bVTxxX17TyzH+HElK3V+58rSa88b7El2xShVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571327; x=1746176127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLk1imrVTtrpJbWqDoaFAq9AHbfHxqAvYTRp4hVRDXA=;
        b=K5Fnyj94wQAowWlnCuZgsHzl3P/OzVtmBpqqyHehdGy4vnUIzmCqnqbIFVrJtdU3V4
         PvZtmgSbo1zQC425uxiQl28yE9Ew2EIGpavY83m5mvJGavzCiyNBA5KkA4stCDKlt23k
         7oSn2rmcBzHOLJpiylqdiedGGTJcOS+lsMVfNUsf2AYoFUC+c06DtdNiHa/ay3OhMOEt
         dCJtL3vS5wGatutI3Wgn9kd44XIO6FffeyceDExsWui2abbdFCUkm0D8ykt7di+cyMZj
         LL1h5Edq06MZH3Vnek3t6mvbEVaZZeQCl4q/W84Bb+l3JgrPNlFw95YW7k2giR/Dp0Bn
         QSqw==
X-Gm-Message-State: AOJu0YzMrev3LDkQcMKj2tBXuxJetUt62tzZ5SxP7PiCC+rD2QklnM9Y
	OeNlyhiNga8U6b/j4SzI7W79CYHXjZyz075qp63HWx2cer6ajlBFLf0waldpgA==
X-Gm-Gg: ASbGncvydv+ghneZzuqjycsgNvVbBBiAuU+AD2J9z/9Q2IIMMEPpjGTwifIrcr8rMNG
	2MYi7Kglc2wsnhb8/C3ZJMhenxI9mIam790Xl8ivd0bbEvtA+HhGFPB77oD/4tZ4s2CGTiDgn2m
	P47RMZZ53SMygqsgJNrr9aWNy7hg8LxzrexYnJ0vUJXLkuIT2/HkEe5ixlE6E2acWxSQVUHlEhO
	uihLL/wwXeLx8wdf2RQp/KI5IYa+kprVcYmU+gxKXfifoRREDUQgFuwdLi9wjA/R2xpdSTcrOg1
	B49gWv/VVtbBu3jmg2XS+OvXpLbJWyU487XGZfOV9eCXvAipng9eUCixgMk9jkppTj3zAUgnqtc
	p3Sk3bLQ8ybdkzIAWnvkJ
X-Google-Smtp-Source: AGHT+IHvNj+T2miyitTkiebT3bjTMSSX+lRizAHiFK/yIBbZAuVf2umZ3kbZIa/T/tDWcP8+Au49xg==
X-Received: by 2002:a17:902:ce12:b0:227:e74a:a066 with SMTP id d9443c01a7336-22dbf5f4cf0mr26479535ad.28.1745571327036;
        Fri, 25 Apr 2025 01:55:27 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221943sm26988875ad.249.2025.04.25.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:55:26 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth support for Infineon devices
Date: Fri, 25 Apr 2025 10:55:15 +0200
Message-ID: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Infineon chips support external authentication in station mode when
firmware advertises it. The feature that must be present in firmware is
sae_ext. This has been ported from Infineon repository and makes use of
the per-vendor framework. It showcases how things can be organized per
vendor to provide the functionality.

Unfortunately, I have no Infineon device and firmware that makes use of
external auth. This series was submitted earlier as RFT and it was tested
successfully by James Prestwood with iwd after adding a fourth patch to
the series. I would not mind if more testing is done with this series
like using wpa_supplicant instead of iwd.

Arend van Spriel (3):
  wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware
    events
  wifi: brcmfmac: make per-vendor event map const
  wifi: brcmfmac: cyw: support external SAE authentication in station
    mode

Ting-Ying Li (1):
  wifi: brcmfmac: Fix structure size for WPA3 external SAE

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  44 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
 .../broadcom/brcm80211/brcmfmac/common.c      |   1 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
 .../brcm80211/brcmfmac/cyw/fwil_types.h       |  87 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |   7 +-
 .../broadcom/brcm80211/brcmfmac/fweh.h        |   8 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  29 ++
 11 files changed, 495 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h


base-commit: f600832794c91d7021d7337104734246b02a2b86
-- 
2.43.5



Return-Path: <linux-wireless+bounces-15733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7129DA049
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 02:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA92845AF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F328E8;
	Wed, 27 Nov 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOSuL26f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A79A23
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671135; cv=none; b=IeGwb/K+xV8j6jC6NkTxctfz0XzERDSju5hyrt7vXmBSjsVV53x3BBDKPzwhxltC9FPqHfuUDh62VKceLuzDWSZKZ7qpz/nEL3gt6oMLv2Vu9mfeBaqe03NlG1I9T3BBLPVNOhwxRCXv014w9dot6c1ommXjVumCQGnKNOftm9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671135; c=relaxed/simple;
	bh=Xs8py6+DQDcAhivKKHrp24KumOs1jpd1Y6aTw86UFfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XOfAbANV78PIdF7XkbGvcwtLNBncNB7gZRUTVc3OuA7apsGPZt8hw+fc96Ne30cJhrsBbd7oUjF1z/huEmG06RnEylHSYQVp7zy4umaYR20+6sxChR/nrHpK6zP9WdqRQsJ5VvCZAkRxXo7M6oSg6X6HrL2oh+NfFXSZkPVafqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOSuL26f; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc88476a02so387217a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732671133; x=1733275933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVKiElbX1G/Llu1UB7E/2V7jIT5D9hjhB8BONhE5Lhc=;
        b=KOSuL26fxsJA3mPkK9hZMH1q59Aa413LKAaLjGy0M8wDiocmwUlisQQv64TLaKAMYp
         V1cls9XfNBEUGtgP1Ceh+K3kVPG84vBh1EApzqcjJT4Ro/YI/tIaAY11Ck5fc9X4oN4j
         9Y5bIL/ECzXehmJ4hir6rL3gwOrsp84LGOIFW6eno6zwy4zQri1PISAackykBkqyhq5J
         PvUHY/5hLKVoR8VwNjnt0FLq4aDygVxLxKPDauNgDTftuf9CadjfZsJVOxMYQMe9LQxY
         HfbMyoUXo/DoesvKHQ5Vf6GxH3xo1vJC4pogga2zXlUhVi0iLSwMm+mdHUL9SeXTIdR7
         4nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732671133; x=1733275933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVKiElbX1G/Llu1UB7E/2V7jIT5D9hjhB8BONhE5Lhc=;
        b=OlRWll9SHJUDz6n7nDjakXMslDqnnGunOMCzt/DJ0sdGwBVnHlaokfudqw5Kg+IkUL
         GdcWR7bn0vrXbMx0GKsNiODeWAR/LBd1Hsxzy9uVCOLoAvxhO/q6GtpbDPRH2NiLZ0a9
         eL6PHxVcTmuMVFu0x32Q6EFWxoHCZ6kbaR6rmiG9eTtp8wulH8TNcH8aWaPrwPluu4nb
         kLaf9KuoQ1ZdV/fTIS0bikP/nBMv42WEmxXc9aT2/vdECWJ3eJDcTjXhos0xjVQiLSFN
         5wVQWIcvgCG09KXxa7/wuqKRbR2OWCYxIbARP/tLy3mQtGRUSxTjErppI/tZIAp8k1s+
         jGeA==
X-Gm-Message-State: AOJu0YxvozYw190+dyP0SALiGEf2I1dT/+/0FMscdRMUPX75kWLVh1C0
	s/OLtl0XsBnY/zeFtyIxoNqEVcHaqSsbpwEgK+s50qdFyHRjESuj
X-Gm-Gg: ASbGncucexREY3peNoKSILAcYwrWdZ9/3uCgNXr8esGqAnwsjjOJLESDDHRY314aip5
	X5o1+7R19oMs20YccEg65tyDXhV3yDqGXkGLPfm0GB/z2J+jzc9MFjsm5nCFNcX7nTkFk0bRBFm
	nmaxcNYn4EvHsBPYsY3bd0Emiu4AmCUcxSVrSv2MCFu/THtPm/iNnGEVwMd0SpEPZ4EanXdHoQj
	DXec5QMTfM1e9A8jTr2CqAfszbp8cvcNd2+/Po79+XAymQ67Xpke0+OacwJDozhHdCMWxrEacdB
	4wYfRN/DG8oV37TQ
X-Google-Smtp-Source: AGHT+IGF0AWXVhwQgKp852jMAYbzZeHUusfk5AVedXEbtlYU3QAlauARD3i8MDGg8I1fO4/aUsRJDg==
X-Received: by 2002:a05:6a20:2444:b0:1db:a919:27ea with SMTP id adf61e73a8af0-1e0e0b71e9emr2343943637.41.1732671133234;
        Tue, 26 Nov 2024 17:32:13 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-724e3e636f7sm8964534b3a.183.2024.11.26.17.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:32:12 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Azerbaijan (AZ) on 6GHz for 2024
Date: Wed, 27 Nov 2024 17:32:08 +0800
Message-Id: <20241127093208.4693-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The ICTA established under the Ministry of Digital Development and
Transport of the Republic of Azerbaijan announced in June-September,
the State Commission for Radio Frequencies responded positively to 17
applications.

At the meeting of the State Commission, taking into account the
Decision No. (20) 01 of the Electronic Communications Committee of the
Pan-European Conference of Postal and Telecommunications Administrations
(ECC Decision (20) 01) and international experience, the "Conditions for
the use of the 5945-6425 MHz radio frequency band for Wireless Access
Systems (WAS), including Radio Local Area Networks (RLAN)" were approved.

ECC/DEC(20)01 defines:

* 5945-6425 MHz
  - LPI, 23 dBm, indoor use only (adopted)
  - VLP, 14 dBm, indoor/outdoor

[1] https://icta.az/show-media-news/iyun-sentyabr-aylarinda-radiotezlikler-uzre-dovlet-komissiyasi-17-muracieti-musbet-cavablandirib?

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/db.txt b/db.txt
index 5710545da0b6..24195fcac004 100644
--- a/db.txt
+++ b/db.txt
@@ -180,6 +180,7 @@ country AZ: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (18), AUTO-BW
 	(5250 - 5330 @ 80), (18), DFS, AUTO-BW
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # BA as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1



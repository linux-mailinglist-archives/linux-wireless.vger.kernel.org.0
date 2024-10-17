Return-Path: <linux-wireless+bounces-14152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B579A266C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2292879D0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB11D517F;
	Thu, 17 Oct 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHhYBKm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E2111AD
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178450; cv=none; b=e7E6unVU/BgK/baBPchn243HocNun5F2cn2PyZF3rtvbpS6cwZsRocg5bzmN40CyuSx1/cRvyskpQtRHC6WP7sNZxyiOSHuVqY9ObbFvqMA01j2t1L/IkK7ymXumO4o5hDRi6CKhv4pAjF2kan9IzR5rndeMmI3XsdhvclVATgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178450; c=relaxed/simple;
	bh=3JdO1yJxjVJLV23PohCLA39s3NFjx2Ao39MwWBssavc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sgo5KcgbMNvjOd4JzG6nw0CCpJj05ifMtwREjIz3CLpF6cEX9txrvFK+7F2HF0/fjElbcNL6DMXO8G1iBKaKyxaGW4RDLBZyptRpyIea0rjZWrM4+znu8Q8+aQ8p3swdUkmLJi3+J7cYsC3E8C+IcwulraFAIhIzs6ZMqvce5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHhYBKm8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce65c8e13so10222045ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729178448; x=1729783248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cIB9OSf3uU/Zoyv5JOLucA0RZXRQSDDvqQX1qLlh9w=;
        b=bHhYBKm83xBhL1OED8gW3VWgf2+jccKRLQ5ZfnFdekUUBuostngdq9QRa91S3kF5ug
         ENV/pFL4il0fS7LRKoFst0W1ApEh1f7eRJLyHKIxcLyyeAc6vF36Sxs+Sn++H1r5vCob
         Uwe2GYz/sJGtOMiNZQ/+n5pC9hYqb9Ks/EDJ2AKe/dST7Y7xzc6j46Tz1k7p4pwSVdqF
         gWjhwOEUfdiVFz6F9ZFLWNQ6DcoIYUPkcKGJ9kEbdchWGSA8XzJ0YVpiL2q5A7IjO+li
         mWElFDhAbIfOB0388pt3kgKSYhmC3tHwf0GkCdWZom1Jw6O/tosunwnu3x9bObomNa5o
         dCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178448; x=1729783248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cIB9OSf3uU/Zoyv5JOLucA0RZXRQSDDvqQX1qLlh9w=;
        b=t/6XpZNJHnaL4ZlSTnQXorajlbZ2Lhgjf3rlG+iW9MLSfV5QNELZV5Xx/TzcKRfg6f
         EQNStDc1zDnjEKYqMMbdtz+QlEG56bL2Bq3+f1MSfHugDEz5/Db2MpfWlwq1LFrbc0XO
         k5kpDKudQ0PUeFJ6e+ncAfG34xsMI6lPhbbGEZYGanWWHRyDq1VcyM+Wa/M8zo2gz6V4
         DRJvIWc56eR9xJV0hSCukL+Q7gpK3dE2ItsHQuQvaLEMyUvT07zpOKitEvfaf3u8ChWd
         Bi+7bFwmmZ12S81H97SG0N4UjUK6uMZKkfFJfEaxPLNvg2/jjFJ4aSWVx17HboBpPZ9C
         vONQ==
X-Gm-Message-State: AOJu0Yy/bUnnj3p/KPFGu80DGNJhMTEPTlUFfWikH08c0nEhhn9A/oLZ
	SXrKW7zK+sYnfwm6PFZd+7XIG6x1myqOWft8A6ZJZzWdPOaM5FB6
X-Google-Smtp-Source: AGHT+IEPPgHjuuQZWKgZDii8aAlvqol8xvBwCwNFnr9dhtOFvAeoX8eU2Irn39wDFoFO0zSViiVG8Q==
X-Received: by 2002:a17:902:ccd1:b0:20b:70b4:69d8 with SMTP id d9443c01a7336-20ca16bd6cdmr262757365ad.37.1729178448028;
        Thu, 17 Oct 2024 08:20:48 -0700 (PDT)
Received: from BM5220.hitronhub.home ([2407:4d00:9c00:839f::7acc])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d180367d9sm45469665ad.149.2024.10.17.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:20:47 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	pkshih@realtek.com,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH 0/2] Remove unused firmware images
Date: Thu, 17 Oct 2024 23:20:41 +0800
Message-ID: <20241017152043.10205-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused firmware images in rtl_bt/ and rtlwifi/

Zenm Chen (2):
  rtl_bt: Remove unused firmware images
  rtlwifi: Remove unused firmware images

 WHENCE                          |  30 ------------------------------
 rtl_bt/rtl8192ee_fw.bin         | Bin 38764 -> 0 bytes
 rtl_bt/rtl8192eu_fw.bin         | Bin 37904 -> 0 bytes
 rtl_bt/rtl8812ae_fw.bin         | Bin 40520 -> 0 bytes
 rtlwifi/rtl8192eu_ap_wowlan.bin | Bin 25264 -> 0 bytes
 rtlwifi/rtl8192eu_wowlan.bin    | Bin 29008 -> 0 bytes
 rtlwifi/rtl8723bs_bt.bin        | Bin 9120 -> 0 bytes
 rtlwifi/rtl8723bu_ap_wowlan.bin | Bin 20886 -> 0 bytes
 rtlwifi/rtl8723bu_wowlan.bin    | Bin 26398 -> 0 bytes
 rtlwifi/rtl8723defw.bin         | Bin 27726 -> 0 bytes
 rtlwifi/rtl8822befw.bin         | Bin 127496 -> 0 bytes
 11 files changed, 30 deletions(-)
 delete mode 100644 rtl_bt/rtl8192ee_fw.bin
 delete mode 100644 rtl_bt/rtl8192eu_fw.bin
 delete mode 100644 rtl_bt/rtl8812ae_fw.bin
 delete mode 100644 rtlwifi/rtl8192eu_ap_wowlan.bin
 delete mode 100644 rtlwifi/rtl8192eu_wowlan.bin
 delete mode 100644 rtlwifi/rtl8723bs_bt.bin
 delete mode 100644 rtlwifi/rtl8723bu_ap_wowlan.bin
 delete mode 100644 rtlwifi/rtl8723bu_wowlan.bin
 delete mode 100644 rtlwifi/rtl8723defw.bin
 delete mode 100644 rtlwifi/rtl8822befw.bin

-- 
2.46.2



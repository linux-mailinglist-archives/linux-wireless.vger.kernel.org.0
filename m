Return-Path: <linux-wireless+bounces-12545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEF96E198
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BF31C23CC0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C115B562;
	Thu,  5 Sep 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nar21GLB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824817ADE7
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559774; cv=none; b=UG/jhFW1qi456IaBeNZIsOox5PAplfKgHSqcZxZUbsGrS5lIQkldlD/JM4p9qE0s4DsNGWpviOMB1aO6qdKBF2pGlkvvxIf+9TdDN2Nb5qR9yje3C31+ky9DtQdLbGxQb46onnLGvqLBsvk4mpDh9N5yv9Ooscm6+9zn/ClhMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559774; c=relaxed/simple;
	bh=Mf/KRL8f8J0USP53Ooo13Yd4DU6ikFUJaiQnuno6sDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQeQBf/yOYBNUruDiI1l4V63JU7QGkTSe6jQZexRzDy8n8sQpLR0GmY+knL/gyDVEzSSgTIslaafUxJCy6/UtzwOkQLwuReJFEZlvlCDL929mKx8AjE7dgHlK3e++ZbnZ6KXdUQmU9jfBTzXP7Oa4j3XizUvZy9Ld5rwqLkP328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nar21GLB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7184a7c8a45so221817b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559771; x=1726164571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYRZSZGnk2rFODEJdwSyDPgiMlEj96Nr3+wdwx30Hjo=;
        b=nar21GLBPL+05FLqvJed8FsHenWArL27c87dlO0jcVipHq72XRb20B1v8F+sKHfOx6
         7Kk8PaoMwDz8fidoOVEEPZfBgjjMesan9nDt64LNGz09jeGALOJs0BG28BL/VNoRw88m
         FuTUQxJhICcuhimM++mEf/PhZiZ7f1JaQ1aM3/fWgobVaefMXnOnLL18XE06DoJ9bY1m
         B20YnblBSVcv8nUxr7ExMA8rHKlByFGBMO8h4PdyAOtw3AL/v1AhBCmUNfLwrFdKOruy
         b9xQQa35W1SOROjryBTez+t8kxRe2Ld3gm+pKubGWvS7Q3qHsFq6if1YeBqln3oev0ZI
         DLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559771; x=1726164571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYRZSZGnk2rFODEJdwSyDPgiMlEj96Nr3+wdwx30Hjo=;
        b=st/G8ODvZQrwy//eg99N55J847y4m343PI9tE6xcf1Kf+AWdSNndYR0LPHYvsXjjYm
         j8HaNuiUsfdu4g/8oJDzJalgYFTwRHOKxSMdfY6R5tc8fSVBhikvfBwQL/bfBTBe39xc
         gSzAz8njMZUhDp9PjUlo8eS0KFm995GyWK2ZUTjBvJTL0R+vpPRgczrKESAGwP6ed6fs
         ulnOfor6l608f6j3lr2JKz40Gq6Mp4dY/BBkMlJ/rX9E2KN4FSkfAADESPt00V+cyU8A
         YHULrTXu5T3hemHrbngONQJiRG4ZuAfLoQM9VfnwlzDInuDWNJvc2dA3rlEpsTOHDYql
         WwHg==
X-Gm-Message-State: AOJu0Yzcm+NA8tQ2AbzL9E3qUNtc9Cl2k5Y7br8d42exq40kU6Z1j4Wu
	68cUQv3munNdM/37ltkWv2Gb1umO9Q14C4F206ey3lh1pY7FRo7lUGkcbLfZ
X-Google-Smtp-Source: AGHT+IFiu2NUtFbm1NBqr+cNNbBGccL0mAyZHZRtiU6RnTBeP7zAa/Zz9Qe3RZ1xlWCfsP+OnYxDAg==
X-Received: by 2002:a05:6a21:e8b:b0:1c8:9749:a4c1 with SMTP id adf61e73a8af0-1cece5e2f92mr17721581637.49.1725559771518;
        Thu, 05 Sep 2024 11:09:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3485199b3a.133.2024.09.05.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:09:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com
Subject: [PATCH 0/5] wifi: ath9k: remove platform_data support
Date: Thu,  5 Sep 2024 11:09:23 -0700
Message-ID: <20240905180928.382090-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes platform_data support as it's deprecated, unused,
and replaced by OF. Some OF bindings were added to match (improve?) OF
support in ath9k compared to platform_data.

Rosen Penev (5):
  wifi: ath9k: eeprom: remove platform data
  wifi: ath9k: btcoex: remove platform_data
  wifi: ath9k: add extra options to of_init
  dt-bindings: net: wireless: ath9k: add new options
  wifi: ath9k: remove ath9k_platform_data

 .../bindings/net/wireless/qca,ath9k.yaml      | 12 ++++
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c |  1 -
 drivers/net/wireless/ath/ath9k/btcoex.c       | 16 +----
 drivers/net/wireless/ath/ath9k/eeprom.c       | 12 ----
 drivers/net/wireless/ath/ath9k/hw.c           |  2 +-
 drivers/net/wireless/ath/ath9k/init.c         | 59 +++----------------
 include/linux/ath9k_platform.h                | 51 ----------------
 7 files changed, 25 insertions(+), 128 deletions(-)
 delete mode 100644 include/linux/ath9k_platform.h

-- 
2.46.0



Return-Path: <linux-wireless+bounces-14733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635039B63CC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941801C20E00
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5D1EABA5;
	Wed, 30 Oct 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZQAIhVr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CD1D1E7A;
	Wed, 30 Oct 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294061; cv=none; b=hY9OTiyVwJNMFQUkaIWvoYliih6nqgfw2d8nMiLCG1Doc6tzaTsSDdMmvF90thGb2ObV0ioV6c8uLRAO5DQz11egO6Mgbw2UcrQ5pm+TXp0TR0xbGSl9kN/ZzyYVhf84OUTzFpLxxwEnd8ujFXUO4pURzVjNiF3x7HUniS4Ryz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294061; c=relaxed/simple;
	bh=BdmExtkMA0VZuzrJ5PrYQTQ5P7R2up+kNAlU+s9OMZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qqdqgBgEZ0DbEH4zjrz9tWPRY3Ttgw0HiIv39Dxt2kUfTsDc2NN0f1KS06gpt+1bqbMyc8aivImiabHxqknmn9Zl9iK+pzf/xqwaHmWEdfGY3n3Ddca59l2FDS6unmC+bOt/B6tsHxhKRTcfjzhgtVqfgg6WY4G3rERUzD8Bm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZQAIhVr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so61052145e9.3;
        Wed, 30 Oct 2024 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294058; x=1730898858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFu9X9ZfhRR/+8JSdiYichwPIWFG9gfOkKOe7mEGzqE=;
        b=JZQAIhVrRIpN9M5mPF5J8hf13bCts6aHYo6SOr7lMxjWV0bWyh70ogMIVW0QUZFi3l
         sGqfcVdkLT9IptNA3CouuTRkKPpFB7jHaIV3qWSt8jxn5gOUDL0c5YTDsMaSUemZn5Bk
         34CEVc8jIoWLYu+uHwV9iZiRRkIgnA5YhUW97cm6/EftdWKFIbrLAxBVrSoW5JlyBmga
         ePZsdbvhXBCpC8Q1vpd10BjvDTTtscuQ3B4DFpIlPOACF6DlTVzo9uZikAKLhv63tAqh
         HvhKa3XzDtrTMwH6rBQIis83hyqomZtSUDVePEm1jF+nFLNCUgY0PP8f+2OQ4/qgH/F4
         jW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294058; x=1730898858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFu9X9ZfhRR/+8JSdiYichwPIWFG9gfOkKOe7mEGzqE=;
        b=WLWp40yRbF8l7jsGI3hUqQG1FkvNDSrzHfSIcmvLIqVeNVk7jPp03NfpMuww0/z2xF
         VzjNjtnyLZWutbCrRZygCVAil5Z/HAkrhH9/dlws08g/jViHlpciXGbVxsSFcTHofI3E
         jj3llDdcHG9cj6yCsL8LACLLs9v3NwENA2ncrDNAKSMxQ9c6YA0hNHOOcWgB5timWtIZ
         jPfduWNrxQANKlXz3u0B2A106HO7YGG/cULOuScp/D7aEDyGwkrOjxEwtwga8/63ZDcK
         FisANrVJ98998cdUOC9cRU31LYMJdG4pJjDQjp45NRUnmitSagaCF0uuI95H+PO9TOLX
         pnLA==
X-Forwarded-Encrypted: i=1; AJvYcCUMb919B4C+G0rEFzkQdaJg1QHzbOCMUIxgHphtso3uQq6gW3uzlhwkhwqTG5hiemJM3FXAtVsFCGG3ugXR/qs=@vger.kernel.org, AJvYcCWKxHjFj0XrMtUIfxmNTfqUJ2a5ehE6du2kCCtJDGuK28AmiEF27vYxBZpXkqqKVVKcb3TV6Kx4cFUDv7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdcDYOkWqz8upMRucryW7jNoLDiLFissQp2Q4au5T5KpCx7kn
	UkN4ShpWcKC7euyRT2ukeN5ncXAOZEjdNLHdXAGnFaTxiYNcIXp1
X-Google-Smtp-Source: AGHT+IF8uQpUwo28perjaG2xI3g/LHuSBns2dWrPqR/sBur/Bi+UnRnwW1Ksp3eUVXqn7ebfyU3rkA==
X-Received: by 2002:a05:600c:4e04:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-4319acb42cemr157648745e9.17.1730294057359;
        Wed, 30 Oct 2024 06:14:17 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e848csm21382295e9.3.2024.10.30.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:14:16 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: 8852a: remove redundant else statement
Date: Wed, 30 Oct 2024 13:14:16 +0000
Message-Id: <20241030131416.3091954-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The cascaded if statements covers all 16 bit values in the comparisons
of dgain and the last else statement is not reachable and hence
dead code. Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 9db8713ac99b..f3568c4d0af6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2248,8 +2248,6 @@ static s8 _dpk_dgain_mapping(struct rtw89_dev *rtwdev, u16 dgain)
 		offset = -9;
 	else if (dgain <= 0x155)
 		offset = -12;
-	else
-		offset = 0x0;
 
 	return offset;
 }
-- 
2.39.5



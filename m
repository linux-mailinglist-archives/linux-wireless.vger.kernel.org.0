Return-Path: <linux-wireless+bounces-20854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9DA71B21
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744DC3A41F1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1B1F4190;
	Wed, 26 Mar 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJUHSdQ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634771F192E;
	Wed, 26 Mar 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004326; cv=none; b=uEpkA7BcIOULQwoXypHZAC6S2Kst+u37qmO4qC/kbCOJBXggdRKLsPzeTtkcPxQwenBUKOJNfqFOdgbB8xCHMIkm0rfBoJlsGfWzHXT9yZ+H2fGZoRlyfpva82lu57c/nIdsmOKiZWMIQ48OUIPR72XoBjsroxkzq75HzLivFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004326; c=relaxed/simple;
	bh=3usZOAbnVHLeoNs5mBoiAoWAvIhvqu9KzdrKYHwy5ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/banMpsd8sMGko4oz0KXyt5TJlW7XxOxSWt6dVek33erBE8KKDO/RrwDJesppv51wjVRb1Fg6ad4DoaETlxqvj0MVuEmolsjsJ27lmcw675W7am4c1ZA+hVP7MvFoXxJeabs7evQatF8HQkX2qmpLYgY+D4y/+fCCBjCcgP0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJUHSdQ5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fb0f619dso852705ad.1;
        Wed, 26 Mar 2025 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743004324; x=1743609124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdI3T8Ok7IQ4l7knnga+WV3FdTZHD60Sol3JxkMqBnA=;
        b=QJUHSdQ50tjVRgn44xbsQgwFFPJegfAaXKFstfGcc9F96Oc9eFpQotNXS0MsI4kSSK
         aip3JNOOFKoZMH405bmgTSh/Ky5KauTy9n8nBEECNom5UJW59O2Wf+8sNQcxO+gj4Izi
         AiDWe6VVe2XtZSdZ+OdaDSiBYra+bVrak/C25o62glGYvNwyFXnPIe2yU5DGSwLPALDz
         pqccykbBk+LXTWqwfxsczLzikjwg2FjGpTFMou1uukb7zPywwfw6snonLgBcD5p5ZiPz
         u9LSF4S0ekD6naTuqB13ns8KLQ03b5MU/EuwKq2N2TAoZ+dtToMLmDtJ+zSd/nbw0HD7
         O+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004324; x=1743609124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdI3T8Ok7IQ4l7knnga+WV3FdTZHD60Sol3JxkMqBnA=;
        b=hbAscsFyL6rmWwsk13/8n4gkjBIh2JptcbgChwHNUJcNGAfClwchUe3tgHo+6Bhtwj
         //GTgMFIR7XpUOG/aRaHiEJX9+ILZVndiCvnFHfPd72VfSZJL1e5nF2GkURGSMhMzXml
         KrBgR+tcfD9NGO1oXMJNm8TLICm9PrD5rCkGpFS1J4SDSiZSVyS9jnHa86YsgIBVk6RA
         EHcLAJe1Ej0Ng/bns2VaNHYeA2x51V646DywSzF2RIueQtyDpKL0+4xUN/mbKu8PI92I
         mc9Z0PEtGcLdx7M+IUReqIeTL20AFC9MCXD/HTwXwGdAGnPE1yohK5leYxKg391i0hPi
         J3hw==
X-Forwarded-Encrypted: i=1; AJvYcCUtCdwgwZoKxFqsILqNcHR+UlRWfDE1xiGDf8FcOkf3zUheVVs7A3x8Dz9HRTt7MvPxqzSrsUAElv2j2uwCV/Y=@vger.kernel.org, AJvYcCWPR2kfGBdHWZW6aAwSrVnUITTE8Rh17n2ZZsfURpJpM+sETYA7e1PgOVrW0qGuZ6t+tmJ9FAWtwU3rWDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7IBKCNlqh0FFA8NcBd2+HDGQkgA3NOpBNh0jC+ac+TgQyHOR
	ZIk0oUnQSXFoyRFS6mmYnu2lLiDAqIt8tGydRePWekJNmi6CXCr2
X-Gm-Gg: ASbGncs3RqHgVwaW0j7VtXJbF5v7Hdb8RcF6VYL1aUESG5XR6H0ajVdhcVFmUJaHF0s
	04SllJJnAyS6WA4gud4veGcCUfmL6cUO8IsA3isrBnVxkWTcE5CfxezsKC82lT2ehe3lirJ/J02
	b6UQi1pwwaWMsDWC3uFR1fZVhwiWIQzr41Kh7/6EyXNJ8pNGd8mkqZumE1LKD5vSBuu4K+eawxs
	Qy2oBX94kzQ7ypzNfKwPMxBVEXbZqcHqtfsXPImoo/emx0yIx7JoBegizXNtqDNRyVf68I9sHdc
	fBfeg08hMBG9PR89/HYz8/swuHOHLjyJ7gG1m9sF1mek
X-Google-Smtp-Source: AGHT+IGBjdhWXohagh8cql7g4AaCRhBTm9LnLpJP7tH9k0cnHUBz47MG/2XEVNfI2+iyHgtpuQfa9w==
X-Received: by 2002:a05:6a20:3d20:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-1fea2e9f6a0mr445863637.25.1743004324397;
        Wed, 26 Mar 2025 08:52:04 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739061543aasm12314579b3a.126.2025.03.26.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:52:03 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] wifi: carl9170: micro-optimize carl9170_tx_shift_bm()
Date: Wed, 26 Mar 2025 11:51:58 -0400
Message-ID: <20250326155200.39895-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function calls bitmap_empty() just before find_first_bit(). Both
functions are O(N). Because find_first_bit() returns >= nbits in case of
empty bitmap, the bitmap_empty() test may be avoided.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/ath/carl9170/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 0226c31a6cae..b7717f9e1e9b 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -366,8 +366,7 @@ static void carl9170_tx_shift_bm(struct ar9170 *ar,
 	if (WARN_ON_ONCE(off >= CARL9170_BAW_BITS))
 		return;
 
-	if (!bitmap_empty(tid_info->bitmap, off))
-		off = find_first_bit(tid_info->bitmap, off);
+	off = min(off, find_first_bit(tid_info->bitmap, off));
 
 	tid_info->bsn += off;
 	tid_info->bsn &= 0x0fff;
-- 
2.43.0



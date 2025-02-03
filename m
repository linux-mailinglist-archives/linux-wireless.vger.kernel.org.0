Return-Path: <linux-wireless+bounces-18310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4223A261F7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 19:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B627A24C0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F920E00D;
	Mon,  3 Feb 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhBI+fEM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12A1D5176;
	Mon,  3 Feb 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738606163; cv=none; b=EV0pHh/JINWNLE77OnE3JSXExeKaRpMk9OeFgPT0tFkqTzqVf4v2ezjRLYmmTxUr8Zlfwb4jaa4ymYyRfWkNLylqqmhxcm3a9txK/kZbagQ0z9D+KwTPyUCezIX5uZNdy//wt9aau6FBpGgBJ3Fe0iInrq7wYj3XkMHrmtY4ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738606163; c=relaxed/simple;
	bh=OYykUork3X+hICHRr3hJuZdlIa+GgROF2W8koUUx7Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8QTUolYHfggnOVwC46CTDiNtWBlizC/WZle+SpF9OvrA7cdgbDeMLxkcNHmVW5dDT+mFDi0mzx8sjceWX9D+zu8m1/xbcF/MSQZSmJFNJHXU9uyiw/qXLdLflWdDFnuJj7rCwJi7nnOlr6MfC5Qr+ZXhJ7cuJRgTZFyUx0e2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhBI+fEM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso48738775e9.2;
        Mon, 03 Feb 2025 10:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738606160; x=1739210960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sgtlo0xo5sqrWLZRiaVyPa8HevdAgKTIjU5uL9579lo=;
        b=NhBI+fEMXfEfJdDmq4KyljxNcXEVvJuELJMVjxpl0I7i2lRe7dUmlJNoEKo9z9RR4a
         nVhnLlF0lpP0skCtnlC1DRL6dNjTIEWw+qWSuovt8aFsv7gHI0oGLU9mr+joobABZ1Ur
         l7+4JGoWXBLO7WQt6vrIpWxyPcg/xf+rAfRrl/D7ZounzL2by36xgqZbKnB0HlWMnCmM
         pyzDyGmMV1H0Q0SdpZtLd1hCutDd5Cu/FvUuyhQx4ju+7nSx7gWyHxD+Yvo20osAXhYy
         rcgQCuNopHpOayjUHJlwhViYJ34xnwiEFBdkpB8cwVhWmDJddPkw/qJJUWCbAEUDVkvp
         yktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738606160; x=1739210960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sgtlo0xo5sqrWLZRiaVyPa8HevdAgKTIjU5uL9579lo=;
        b=uMbN209fQq5aVJbMYLHILUTQtDGOfv2864cXwxdrM3m3VsRKsdw8TcOuEeCqgS/f63
         Fs2a35QJTEE68iyrSacb0jsBDfv7VXjroDPFoHmj1aMwnM5UeQWutNK19Pj0yYtrMDzj
         GoD4UOfmrWRV9Y6kYd0S+T/VW8HRBQZYEnGdRbWCt50odRNwFDpvCsu4YWiyao/BJIyS
         WnVoJphruXkehN4r6AOukUxTY4ORH3ibWsxxKgIsk0D/rxPW20ibbTbU6Fcq8sO1gZAy
         YCMC+ItoKWMrQDJieijJVU6Gn0pedOI4e24UW5YsPgzcd5Xi94b7qokUOQ/s2bF83g/2
         G9sw==
X-Forwarded-Encrypted: i=1; AJvYcCUMO1ddhESH6GPqqK32Ra0BYWzSIL5BF/iCQVwn1l4kn0adQPWbPxX7x6wolGRcJJZ7RutYyrHDv35M3bak2fE=@vger.kernel.org, AJvYcCV3zOReEO827/pWC52JP8jy+lsckyJUHxa7Ej8lMthXhsdAjmQ6j/DCL8FysgmPjtIHD/tVJ+jTXpulJYfZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpOCq5rTIEyOoMdA/3HgAHDz+w2pJp+IUMvOoszz9Kd14H+OR
	NBH3r5S+AckS9iLs0g7xhkYIqXvd1KKii7NobZDYkIPttt6rOinB
X-Gm-Gg: ASbGnctNyV3v3skyYjxyJvAHtWjy+aF4DLIKyXwUF/n81L4wfXtPyBzLq8WS3mpWrwA
	Dkg34Ge0uXYv42MazTrrqYDvN2j+C0181UNPmhL91HcsMCp5EXgfB/2J8z/bS2H6iVwOuh3gnE+
	RZbRiS0Ad53496LqOQpRQypwdAaKKQ4w/olq/pq6uaqYzhZ6C4gKeFEYjFxr01u5bqxfndS1fVc
	UBWgtpY+nsErT6AkCejpHmRUCkztUWKftO2TFvYJVeD4hV+Yt0h8NxhHgUMeo9PR5HInUMLukwX
	PuUmlLczRQ5ISx9G
X-Google-Smtp-Source: AGHT+IHW9DR5vFDwPqNm5XHYpy6u6vBd+UMSCORSDM1BSpZI9d7BkFPGP542xUfbD7mk9cbTF2UZ5A==
X-Received: by 2002:a05:600c:1e02:b0:434:ffd7:6fd2 with SMTP id 5b1f17b1804b1-438dc3c22d4mr210504855e9.7.1738606159655;
        Mon, 03 Feb 2025 10:09:19 -0800 (PST)
Received: from void.cudy.net ([46.210.194.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ecd6sm167073535e9.28.2025.02.03.10.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:09:19 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next] wifi: rtw88: Fix a typo
Date: Mon,  3 Feb 2025 20:08:27 +0200
Message-ID: <20250203180913.5435-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.91.g5f8f7081f7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in debug messages:
 - afer -> after

Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index eeca31bf71f1..87715bd54860 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -444,7 +444,7 @@ static u8 rtw8723d_iqk_check_tx_failed(struct rtw_dev *rtwdev,
 		rtw_read32(rtwdev, REG_IQK_RES_TX),
 		rtw_read32(rtwdev, REG_IQK_RES_TY));
 	rtw_dbg(rtwdev, RTW_DBG_RFK,
-		"[IQK] 0xe90(before IQK)= 0x%x, 0xe98(afer IQK) = 0x%x\n",
+		"[IQK] 0xe90(before IQK)= 0x%x, 0xe98(after IQK) = 0x%x\n",
 		rtw_read32(rtwdev, 0xe90),
 		rtw_read32(rtwdev, 0xe98));
 
@@ -472,7 +472,7 @@ static u8 rtw8723d_iqk_check_rx_failed(struct rtw_dev *rtwdev,
 		rtw_read32(rtwdev, REG_IQK_RES_RY));
 
 	rtw_dbg(rtwdev, RTW_DBG_RFK,
-		"[IQK] 0xea0(before IQK)= 0x%x, 0xea8(afer IQK) = 0x%x\n",
+		"[IQK] 0xea0(before IQK)= 0x%x, 0xea8(after IQK) = 0x%x\n",
 		rtw_read32(rtwdev, 0xea0),
 		rtw_read32(rtwdev, 0xea8));
 
-- 
2.48.1.91.g5f8f7081f7



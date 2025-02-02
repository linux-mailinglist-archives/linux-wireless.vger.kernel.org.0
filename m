Return-Path: <linux-wireless+bounces-18261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567BA2503F
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2025 23:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33531884A43
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2025 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EFB2147E7;
	Sun,  2 Feb 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbTdU9Zk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2D20C003;
	Sun,  2 Feb 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738534048; cv=none; b=uDqdYP8Gn/gDJNsGNVlEEkObh7FTWR42G5zHL7mGu8gSRp2RtRbUCKVCxTJa5pmhtr9HTQsMjahwyCpBDfF1d6w2hcrGQrgm2wMjAYcuYX22PQkL/GcxWLP6u2dzr8/45H5nWNs76ZRfqt0vTNv3VoOAFDfYV8+SsbQG/gV1Lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738534048; c=relaxed/simple;
	bh=Tww6j7IITtP1JpiFaLexj9OLS/m0wJmj2DIOLw7haZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L83nqVQGPX6ZETXaj09iIaLyrMSwGLAQmhjl4ppiNaCIaU1qQ89t4rhNyY48pPnUDE/0JhF9oaOyAgAjUDh5C/wR+omWXT46btOxbZdKfS+ezRowOIVFOzEuRWrHxKHNEHQ1mL9U9rFUOu+8lNJPBkvCqodhiEPDdDR80T28bzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbTdU9Zk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso25279635e9.3;
        Sun, 02 Feb 2025 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738534045; x=1739138845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNwdZ9Rby6QrQ/t2sXkUgdNUisz3NDMDNDDC7nr5Ytw=;
        b=nbTdU9ZkaK7tsKva8OYK3dgnld3VEBkDlVRCjQMJXGYb8fnRTbBuMnvi8WsnkAuOM4
         LWqoblbxy8/uSdKXfO3/X30A6bvPnkZC8QmrJuDAPQUkB16RcTXLV+gaulumaB8nG7xS
         GStnpa3+qz5M1aFb4rIjdaRAxkoQwjEhPnNE/f+PAOmUGxo5eMEFTOEGiYQU2JPt9acX
         WdhJJadfBMpKb7CEW1+4xXPe/wtU4s30n1OdHKwRqH/zrxFLq3/52yjbGT9S0bnnLC0s
         LVZ/Ohe3Z/q6cV2S9Yc8S2QOPvc5+p1uCIqx/JMERUacpsMXP1vCcFYBmdZCakAn7b4+
         vtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738534045; x=1739138845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNwdZ9Rby6QrQ/t2sXkUgdNUisz3NDMDNDDC7nr5Ytw=;
        b=dXgDNZJpZIamwH9TWZ9elo38AFH66MYa7lcXwTUdhP/5vAN6j6UBCRhUFoT1WbXTGZ
         LkiULn7Y0fN1xyi6MUsyUGGvtJsr4wsiSUdAL8jpBBxC9IJbdQTk/yhozLunmLRYt0ek
         4ZiiIw+8MO45lU6Eb0ZtP/B48/CzBgx/Rj7A92enDlIryhN6axzdscqfXeITsAFMbAiR
         5IvIhF0Ckpdsg7sHGS1yLStNZqIZ8nzwgvzvjNtK+KsxV93ugrGxGwwseDZidC0ovdV1
         7PewrqvZoszFZZKtx88k1MrUtFaQTDRc7X6XmlSuI1JTZwIBjf4rrs+92BaZee/IK22o
         SZZg==
X-Forwarded-Encrypted: i=1; AJvYcCXoww+1TeBLQoPADtRTddwCn5Lw9jw/bDu5vZLyitzySrrs7VIjCCA/Dpg312Rl9J8hWw90tEqmVeoqoYWoKlk=@vger.kernel.org, AJvYcCXsMgyojlFfLphKPU9v2tTZxDL7196r/PMIM3IQ7sju9xs4cNLO7TK9wRYQ29nye4Yofv1DRs8hNWZmfag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DH7tmzonHDMlnbrTKj40Ptl4AjxWVBqLOn66gpTMBxta5kVO
	lgRsvlKmiMXt19bP8TnNpX1umLqu7LTg5f14F0WH8hc/l+MMhUd2Ns6Q9lJ+aaw=
X-Gm-Gg: ASbGncsMTpsio0qxIWrBQzmhwWa3WREHdiwhyWfkcXzQzd5SMxBbTJbaOCQEbITeSiu
	YqYr6trYh7QDWUo1R97GVMdHxP6uDMePPKXeMjxOiiKycf13OJkO8G8HC3JD21uHmd/sczJPQWb
	mKe5o9nmu31P5lsGKAQq5TNxKDtS8r6YPmsd2i9EdhEiNyTCAnZGzC32dvpeHE52fXJXRsV8x7f
	/qQyoMRTXMIWZP7Sq12z9LAkQLH+LiUiSUDeqZAKX0pMgcjBkyyF0iljyqEnIgTIDtBEq6lVu9i
	bxC0NLKqKnu8BaSI
X-Google-Smtp-Source: AGHT+IGqToJckq9WXaHfFTvgbHEi1aCj7NGnpjNkDKNYHEBTw3PFmy6Sr/Ktlpr9n14KVY4K4FlLqA==
X-Received: by 2002:a05:600c:3c89:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-438dc40ffaamr151077395e9.20.1738534044751;
        Sun, 02 Feb 2025 14:07:24 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-438e244ed3fsm135150805e9.31.2025.02.02.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 14:07:24 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: ipw2x00: Fix spelling mistake "stablization" -> "stabilization"
Date: Sun,  2 Feb 2025 22:06:59 +0000
Message-ID: <20250202220659.199341-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a IPW_DEBUG_INFO message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index be1d971b3d32..24a5624ef207 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -3295,7 +3295,7 @@ static int ipw_init_nic(struct ipw_priv *priv)
 	rc = ipw_poll_bit(priv, IPW_GP_CNTRL_RW,
 			  IPW_GP_CNTRL_BIT_CLOCK_READY, 250);
 	if (rc < 0)
-		IPW_DEBUG_INFO("FAILED wait for clock stablization\n");
+		IPW_DEBUG_INFO("FAILED wait for clock stabilization\n");
 
 	/* assert SW reset */
 	ipw_set_bit(priv, IPW_RESET_REG, IPW_RESET_REG_SW_RESET);
-- 
2.47.2



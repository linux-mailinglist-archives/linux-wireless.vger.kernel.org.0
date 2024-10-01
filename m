Return-Path: <linux-wireless+bounces-13364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A491C98B812
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A35D1F2316B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6C19D090;
	Tue,  1 Oct 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqNMcchn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C64594C;
	Tue,  1 Oct 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774033; cv=none; b=DxMRIguCDvOXCRZGeKiWfunPpmBZm1lINALd13rr5SyMYeMp4mv4ZO6Pqji+iDTgsHGgJUCjWMREuqthGA6c9LumHwCEedtsk7/vazjneVR4pzUqEyDjmMgEeyENN2XP0xOcJoyTMsChGgOQYU4e+y25n0d0StcRODTawIfEsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774033; c=relaxed/simple;
	bh=SiC4rx0Uaxb3sCsy8e0UVnitmu9e8ZlW8c9ynEs8+yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUe2uv3hDRqNMJuAQvOXDHe7gWukw1HKs3qfcfxflbwVhuzvZMlqvPYoje7MpOlMALXNDMsA8kOomNXA2qhJGbcGG1yauAJ4Baxr947oJdbB+7jvxdglKjsur0Kd2YwbdI5UGBJt9gMsx6WBnJLfJHwe4SWrbSZj++vpXh6M+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqNMcchn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so48742025e9.1;
        Tue, 01 Oct 2024 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727774030; x=1728378830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ8VMiXu6gGmVrp93Vd0jleOW/f3dpveonWUZYL14c0=;
        b=WqNMcchn6exF8JmTB87Wy6gEHIfueVh1VPRdGy6oK4bAE0yGsH7RA5bVD9Ix5YGZ0I
         NLg4ESljUPitp8uHwYyxMZzyIvjFhU8c4XwdaQnl10Yels8SyneopV6cW+UdU/optm8z
         9Nf5MT8ZTudVXC8+Z0aztYxUcyQr1Z71/Elp8b61NhKxbvOEKmoCEvZ7gFH0vWAjICfZ
         U16RKI1nk9iqjU6cFMX41rlVMwZ094fCd9hpUMUuQRu81t00fgGwBf8AcEodMb04/DSH
         /PSgr+dX2BQoArYXctSDODYjriT+SVUb+J82xRjKadEo7ZLt5ra0c/qwJW3gxWDmcjlR
         uNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774030; x=1728378830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ8VMiXu6gGmVrp93Vd0jleOW/f3dpveonWUZYL14c0=;
        b=sJlr7quBFIcGwIxJFOxjPbgfChFBdAcYc3gyHI2nw9dANirMuDXiIWi7JyK9Z1c1pF
         O1I1iK775bl548m/O/+c7nm/TBFCgIdGgkm4/QmD7zCuYq8K/BtBdts0gMnDWruyXySw
         xY6jlPHQSwoH0UyL+ENNGYHWcBMXdfxTGAeKYP86OK7C8HlXH60AwcDOvSiNUaTsKZLQ
         j5wwk91zv6KvOzJdIUd/FTChd/syoooUsRE37+C3zBVyfC1PZdoqohVMxFDzlQRPxkTh
         ZwteyQoDarMU6G7mXM6dSt0A2iuNe3W7XZ4Rf0HwHgzNWMLVK/TABuRDXmA1iIAvqrNz
         zcBw==
X-Forwarded-Encrypted: i=1; AJvYcCUncSQC3ZEZWIGlcZr230UAf/B4xCsFEfk3XCApdH2fVOVZ+DfKG9LMrs1OOUknQX2gNlmw6sWwsNvR2nk=@vger.kernel.org, AJvYcCX/2Pfj336l4upojDhem3uYXeQbgd+75YW0HKsOtSfy5/7gqyUYEBCccI3QZo8uaUGqHDITuwUezv/nix1P5P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb79FQ51k7rKdNPmZlYxmLNktWa4G/V0pJO+5eSgmu0lE5P/R6
	plSvBY5bJLwZm/IgRZGrY73TQhdsVJla6HabZB8LL4dvC+LKxpai
X-Google-Smtp-Source: AGHT+IEHo6FjFSSwdArKH11zWRailghYO5HUV6hEY46lvJVjNHGNbQl9JqV/M4Mr5RhWT9PkAJ9XYg==
X-Received: by 2002:a05:600c:1f91:b0:42c:e0da:f155 with SMTP id 5b1f17b1804b1-42f584349a4mr101548295e9.11.1727774029290;
        Tue, 01 Oct 2024 02:13:49 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-101-4.cust.vodafonedsl.it. [2.44.101.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ffc56sm174792905e9.22.2024.10.01.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:13:48 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] wifi: rtw89: wow: Add unlock mutex before to return
Date: Tue,  1 Oct 2024 11:13:16 +0200
Message-ID: <20241001091320.38687-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In error handling code for "ieee80211_gtk_rekey_add failed", release
the mutex before to return.

Found with Coccinelle static analisys tool,
script: https://coccinelle.gitlabpages.inria.fr/website/rules/mut.cocci

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 86e24e07780d..8045acb27cf9 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -624,6 +624,7 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 	kfree(rekey_conf);
 	if (IS_ERR(key)) {
 		rtw89_err(rtwdev, "ieee80211_gtk_rekey_add failed\n");
+		mutex_unlock(&rtwdev->mutex);
 		return NULL;
 	}
 
-- 
2.43.0



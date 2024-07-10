Return-Path: <linux-wireless+bounces-10158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36F92D8C1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 21:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA885B2411E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D954E19754D;
	Wed, 10 Jul 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Dh3qmnDU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA4195FE6
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638302; cv=none; b=T4cIrHvXMbbOgJ6OuC7Ghwbd1D1EkEBj+3Ol+G/Vh+SyNaK2DQDt0K859aWm/RwjJqBQiwSGDEKx1jEQ4vzNu4cGjumD2Y5DxJHprrTf0T5tgxZeJNJJOBJfjsDK1tKW6JdHJrBt4pocp1aL5LUaVRjM95NxTm9omN/hG62a6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638302; c=relaxed/simple;
	bh=8kTWAtWWo90peO317+xcJpa5Np1wjx9fVrvZFV29URM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0k75ZjytD2nU8gKeVucq5+8Eh1RazkEvPjtzUjDcCl2xBt+zZ66ip4TeqiRaEYQyZbuKpNtbid5cTlHVTa+KZMjJNPGUTXKTyPc5Vauo+zuSJ1xkFdglNjSzQyQ10KRXvEF7kAIjaVJU/f0A6ZLkMUdEN8QFjj4YuPd/bl76ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Dh3qmnDU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so888211fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720638299; x=1721243099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BjJg5+cc4DFwzqRgRcrx6C9qV5+bdiGH/qRs49GKZ8=;
        b=Dh3qmnDUL4E02J7K9xfaI7xo1y40xab/Ug9xlMtpGoBDZepSeLvDWB1ij9GYlNcw4b
         s72NF/OtVxvc6SQ8WDcs+2/wDFV/1gI3mGddR4rxgO2tcNqPDfEYB2Xy1xg95VLk62nC
         b/imYDMGh7oLxlFw3u9nMM8Fvu9fdvfETaH8xO/owwSb8jfVjpc+qFQLkKSfLFv+kE+G
         hZMT4amwWPuN5Fz5yL6SW9m1GOhv5qtDDRgmSMWlDmlj6iHb5NGFeGR4wt0pF1H6OFgt
         ASU/iVUWKRxyaYg1Bp5eRmSqrTwjLAjBIlPqUefv84uFhlG8CejMNkqW8t9WAoCqs6Lm
         V7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638299; x=1721243099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BjJg5+cc4DFwzqRgRcrx6C9qV5+bdiGH/qRs49GKZ8=;
        b=U/tfqI5oBN/HnRa8pEZNgulfxTjOaClk07ZzW/S1DbO6X69gku5Jp41xTrgpssrkQz
         ntauk4S9eyRtgNtavu/mX3MjD9QE8sivjpgB4ZMwkU5J6v2mygUtUEbSvA/KpMbzTk5A
         NUwnGGcNMEes6d79ik5F0+1nyccyQSfRGXos87F2grbkbonRc5F8b8KI6d4Ifv4x8mi1
         g+y/WyZO9gm+qUeAU2vYLWeciB81ciy4GjAdaHR39hM4HKqy3Na3/QDdPYZ7sR60A+Uq
         S8e3WNvyQwrpk/kU/Dx5jXdal83RI4dXTAejJV9IHTqCZM8JMXxvnqv93mazC3swgrIW
         slAA==
X-Gm-Message-State: AOJu0YyQgsSgW/thc3qRmRrZzYBAlY+Ujv3D7lj5t87Qy7S7TD6z42n9
	b9apHUvQCdkqkSeIpKhxnct1aT5Jr/cJ3mlTphylwVsCQfzB8myuj7d0esgJEeY=
X-Google-Smtp-Source: AGHT+IGTNlHpnJiEbA9o6dIYl7B3FCtglM+iFl5wCaNY31v22EEtg3XOCp/c9ybtdLc7xRpdSMv8+w==
X-Received: by 2002:a2e:b059:0:b0:2ec:403e:6314 with SMTP id 38308e7fff4ca-2eeb30b9a43mr48063061fa.3.1720638299015;
        Wed, 10 Jul 2024 12:04:59 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426602e4461sm176088645e9.36.2024.07.10.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:04:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] wifi: rtw89: chan: Use swap() to improve rtw89_swap_sub_entity()
Date: Wed, 10 Jul 2024 21:04:27 +0200
Message-ID: <20240710190426.709964-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the rtw89_swap_sub_entity() function
and improve its readability. Remove the local variable tmp.

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 051a3cad6101..3b1997223cc5 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2322,7 +2322,6 @@ static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
 				  enum rtw89_sub_entity_idx idx2)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_sub_entity tmp;
 	struct rtw89_vif *rtwvif;
 	u8 cur;
 
@@ -2332,9 +2331,7 @@ static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
 	hal->sub[idx1].cfg->idx = idx2;
 	hal->sub[idx2].cfg->idx = idx1;
 
-	tmp = hal->sub[idx1];
-	hal->sub[idx1] = hal->sub[idx2];
-	hal->sub[idx2] = tmp;
+	swap(hal->sub[idx1], hal->sub[idx2]);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		if (!rtwvif->chanctx_assigned)
-- 
2.45.2



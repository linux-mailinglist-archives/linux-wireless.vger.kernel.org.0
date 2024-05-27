Return-Path: <linux-wireless+bounces-8141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8CB8D096E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8481F21E26
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B9426AE7;
	Mon, 27 May 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpGDTjTQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD915ECD3
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831324; cv=none; b=sFbL2SzG30kiFvwOdrRaeoY+271G9bcIgF/5OhlybfK38gFlNfxxn6+fmQdBsMUFq3G38p+QcRU7XPPW19hDKt2iq/fw8QzLM3Z4HDeC+0VpGVGzbt7t1wdj4zwkjDC7svNniN02wSe/EVR5yrN3zehgwzJjkO6hpTz1dcmWOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831324; c=relaxed/simple;
	bh=vmkBx41QPRyI/Cv9jjYcdOjxzmIMb4pAj4PBcs0mQ+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSWEMP9K4r5JL1AEkN/z82tRF7uS7pMIZVBNUSALbIMkIxdU/v3ia2bR/kj8XvDJIBlSVoiBgOnuRj84FLQqBMrNqdRIJB5SiAB3VgRK5LQh4BJ4uO3DGH1158IW/4xYrbdmmtDf1wtgmEgYWSs0itYJjUyiRqfxRSh83d2PRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpGDTjTQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a62769075adso2299566b.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716831321; x=1717436121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=251TBfsIxkSVquIpcr4ttLdo5hooDJoQtJnRIIO3trE=;
        b=VpGDTjTQUVl8Bxm3DDDdqWUs2sU7b0MK7guOy30ClkOIqq2BboZWQzocFrG3QlPKd+
         SNX8HsEOT1V74gfmuCei4Ptv3WQzM56OJhzx0Ie/NAI9RAf9zxhCjhEJnHsZSjmVKZ7+
         /g6a+B3MZaR+8d/++2+/Yxb1Mf4g2wVzEuDX4OMAoT8HvNgelaGu9zq15FUU90lNurSx
         e1hNQAMvoJIwcfWP9hDHajAKLUUomijTfBr6sWTKwD9hkdO1teXysPNVq16WYPOVPVGQ
         nZhr+hACDJe7k0SvC4q9my1vFaalzb9Hmp33xn45VwF7GKabJvQfsoP0EKt4CmXHfnAR
         3eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831321; x=1717436121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=251TBfsIxkSVquIpcr4ttLdo5hooDJoQtJnRIIO3trE=;
        b=NxGsAdwMZN8lH7TjfnFgGcwSrptCyhCHLVcX6hx91gtlp0aT0MK5OOHh4uMTJewnsv
         TrZCg/pwHBiyjQQ4VY0AmiDc4QtYE1Avq1VqeYP+39qDyhnc47TQ/kJ8drIoJtk+mT2O
         pp2hD+7FVG76JXb61LN2x4HeGyXkYtfJXb5L1q82Cx1xS3+PImdBT36Tjpwkj3YPMSt7
         FyE4l5NtpKJvBy52yP61RVitaz5HKshfeIrJqt7OhHOzcZgLnGu3QytRSv9uh5eqRDDI
         vASBo9DVhP+u4tLGMt8G0W8Kqzdt3/JpBKRbZjZ0m1p/TKzYkTzGnqlXeTiBiZbaFvJz
         H08w==
X-Gm-Message-State: AOJu0YwDMml2CwUUdMms0jo/obuMV+nb7abDYD7SRh9k89bIm2AL7os5
	HIQOCrB3qFtdH5D9ALP/hNKmR8p98hCnJvRX6AOQaiUPuEwEe+JzZlZ+WGLb
X-Google-Smtp-Source: AGHT+IHa/gWs7IG7jWDDpeGmExw92YC/mYxKIW9YifPdkbuEzvfTDZvIfiLC/NeOxznFiwinqSYt3Q==
X-Received: by 2002:a17:906:640a:b0:a59:bae0:b12f with SMTP id a640c23a62f3a-a6264f162b5mr645830566b.57.1716831320787;
        Mon, 27 May 2024 10:35:20 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (1779df417e104.rev.snt.net.pl. [213.192.104.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm512070466b.125.2024.05.27.10.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:35:20 -0700 (PDT)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 1/2] wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/leave IPS
Date: Mon, 27 May 2024 19:34:53 +0200
Message-Id: <20240527173454.459264-2-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527173454.459264-1-marcin.slusarz@gmail.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

Needed by the next patch that disables power off operation for one chip.

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index add5a20b8432..f9fbc9b3174b 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -26,7 +26,7 @@ static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
 
 int rtw_enter_ips(struct rtw_dev *rtwdev)
 {
-	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+	if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
 		return 0;
 
 	rtw_coex_ips_notify(rtwdev, COEX_IPS_ENTER);
@@ -50,7 +50,7 @@ int rtw_leave_ips(struct rtw_dev *rtwdev)
 {
 	int ret;
 
-	if (test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+	if (test_bit(RTW_FLAG_RUNNING, rtwdev->flags))
 		return 0;
 
 	rtw_hci_link_ps(rtwdev, false);
-- 
2.25.1



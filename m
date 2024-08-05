Return-Path: <linux-wireless+bounces-10979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B394856B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EE91C21CF8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65714264C;
	Mon,  5 Aug 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrQX4tzN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DB13CF86
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896356; cv=none; b=XM3U+J9poxatT6JKugvOmV5iLIrnftCok7bfGigWwGGMjAvY11XGqHNG8rqMa4ZQEb88+3jRYFeIdTnlWoxKUONOpUOcmrOEsQ0At78Y1FmDYrlwXONwmfgtpOAMD90NaYtD0TMpW2zxev58xX3mx7lRhcYCgO+Ti0/dxEZ87Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896356; c=relaxed/simple;
	bh=EPgmkfR7T4qNM57dALiZFPtlaHApY++H98nu3OtXijI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwOuaZ+uMo0PgOVIKFDZNB8OobGi8h8jHQfm11dKZH79I4OaWy5pnMfpMgP/RK36aNX6CAn569yiKpNDTVIUUZ//V+enDIMBqPYR8R86+oK/ee422clJngeYQG2TrSBg/Zf9HOTIPccxnUKVBJT8+rxd0fjgm82+weqzm4Fzp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrQX4tzN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so1165765e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722896353; x=1723501153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeYfXRHF0W1ngZfjOHag+sWPLfOW2J9IedXZ71EFF60=;
        b=LrQX4tzNH/TU/ncalk1QP0gw+w0FN3eax6fXmynFVTjbmHDjim4RdSImryXGS/4vOq
         fe/jzzxYDT7wfPVVhlrtwjfl+9Zl8vXPvwIbc87hBWqd8wDMMZyn3twNtQtadRmq/R1R
         uw3kf6B79mfnY7O/PDqv8S+Bc80E8TgvJ7QnA/SiUsjcSg6vWrIc1CDKfrywNRybtNHl
         vMNZgtG9ypBzFVGsd8ggNtHbsXocj97ssQgCrd3TMJAQWj3I7fdME96gwTgN9mM3iOg3
         2LE9uaxpfDBqFPJOcjltQlih6xdunuM2eBSPfg86yLMvmvJfo1VRdDsww1cahEkQEdYg
         i7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722896353; x=1723501153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeYfXRHF0W1ngZfjOHag+sWPLfOW2J9IedXZ71EFF60=;
        b=KBTFM52SZ7U83PYLW3jMyAbWCmmzFlSFDbaDePC67aJPksCNQwRTvwBpnUe1VC0EES
         ftf1pEVhZr5+5cdFPibbwAXStDYsgXNSa4nUfiBGSROE3vrjLZACDiHqpB1cj4HpWh6H
         yjtfwmRiF9PcTI/ESfCxhV5iEjsUMrnAIZ1Ao2xnTkm+L825u8/yH6FK39XgYEI1gGEI
         MY/AA2DgNj20+jZqn267hWQ9/9sYgGwGGZKXAACzjGneLnJ76kwmLEZ4YifwOMsbpUCZ
         5ERvleYEWmR6X+vToPDypMrxX5v6gRKAR+N20LsJwPrf4LGptT6myRzScn5O1XnoNKSk
         +S9g==
X-Forwarded-Encrypted: i=1; AJvYcCX6lZLyrpOnTYJI+lA3IlEwt/VFcUvcb9iT80ojmVOlsf7DDUFUMc5W3SXoDcklXwJvm6JeQqg+40FpIQmAQmeXnGez3EfKl1UnYaZfs7w=
X-Gm-Message-State: AOJu0YwVF4V1VBU4WI23R4CfVCM1UAxAltO+bdH5BycWFLtbxDVnCnbg
	CPL+ns8kkAi2eHJLXHuKAV4HZkvSWjUqr5CDp1bEddjHEmyeIsyb
X-Google-Smtp-Source: AGHT+IGDJAfQa7IxTOAW6BYra6xr+zT6hj4wwkSYMYG1HWYwdg6JXL4TDz0bXHJNDYZnBYYE4R9/Qw==
X-Received: by 2002:a05:600c:3baa:b0:426:67fa:f7 with SMTP id 5b1f17b1804b1-428e4728b50mr110411605e9.9.1722896352429;
        Mon, 05 Aug 2024 15:19:12 -0700 (PDT)
Received: from morpheus.home.roving-it.com (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::1c8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e9cd14sm152822525e9.45.2024.08.05.15.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:19:11 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: drop reference to staging drivers
Date: Mon,  5 Aug 2024 23:19:04 +0100
Message-ID: <20240805221910.3765214-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig notes mention staging drivers that have
since been removed so update the driver's description
so it no longer references the staging rtl8723au and
rtl8192u drivers which have now been deleted.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
index 44ad94757a03..14d0343368ac 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
@@ -20,9 +20,8 @@ config RTL8XXXU
 	  memory footprint than the vendor drivers and benefits
 	  from the in kernel mac80211 stack.
 
-	  It can coexist with drivers from drivers/staging/rtl8723au,
-	  drivers/staging/rtl8192u, and drivers/net/wireless/rtlwifi,
-	  but you will need to control which module you wish to load.
+	  It can coexist with the rtlwifi driver but you will need
+	  to control which module you wish to load.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called rtl8xxxu.  If unsure, say N.
-- 
2.45.2



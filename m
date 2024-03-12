Return-Path: <linux-wireless+bounces-4609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00C879404
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37C71F22EBC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9779DD3;
	Tue, 12 Mar 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAQkdPV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4E7A155
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245838; cv=none; b=icK2DpPtKd/NoIwQzUPlwcC4JbETQDFX86zxD4ODmERgvbYEScrnRjFyLlnFt2RLMdhx1Q0Rym+tjahJcx2Hsreyxy6rf57pJa7J5qDgg0wFhQGEzOEBSwDMj/hAR70oImfhJ1MqlAlrNAFVKkeOLlOMA7Z9UAKKkrja9ek7aY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245838; c=relaxed/simple;
	bh=ox1OshzYtjXnwJZvax1HViW1meQ/xYn7K8HelkpWugc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=moVXuULHbqdNVOiWupBcm3T3A8yHw6sfNZ8BEsv/R0fJtkYjSOdNxbkIZh4bu6qX0wpbUNH2RewoKWw92FMyCaCg4QwC2ukAvOTY5yOq5Dh6MeFVeo2CmMvz/8mO7pqZfiX9iDbJMsO1uF9STX4VPGO7/MVzvWkNblHvV0bKqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAQkdPV1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4132a348546so12691915e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710245835; x=1710850635; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Onh50EFB6Qa9xqDX1VQb3TDEpFv+Y0XCstJlAF2c8s=;
        b=WAQkdPV1HggJ8fI3Lhs2nth5pM/x0DtdRastgQvdbHBC1qfm4xBOzotR/nG9G59dZP
         f7DQAqqHcxDkHv7TFwh4ksuWm5pIcbmSwwvbAQS7kywpvj5ATjPsFP0DF8qa61/sTQh9
         ANFhVbFdw/khCe725hRFEu4qbpdXiDqPbUhFjIuxpTBH2oObZO4rCj2/sVXIXF2DGOZM
         g3CAyzmPTlObMHGLQ8XyyLC3sr5w6A+de2kafUNQfh77CharwAJghVr8FAzV5y6hTVSF
         zA/2R3lZ5TcctcgVi0lKLvLofPBxhsyE9cjfMA0CWtjvxxtwsv7p8T07Z8cshpsItVtu
         1JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245835; x=1710850635;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Onh50EFB6Qa9xqDX1VQb3TDEpFv+Y0XCstJlAF2c8s=;
        b=LNf9wACiWL4dl9T1SPDxClfC1Zee5+ri6Y78mrnihVibZYgBzUgpmZwjroNTD8hILo
         WYxitggNI21BCi/hEphcjiBV3YdplmM0RaO3UVDh/7ucZ6qorwWUxpwbfPyhHMPl3Plc
         bJcGWuhrHGwL/41QZxYTRBkyJAptj8ZYsezQhuyVILFNBa+MdYlxKZqqd+isXfiwsRLU
         wlxlBqjIpdDo6Jx2/AKyU5zLP3CpmHhoFKFOCfpMa0RBv2oarVIhwZ6csc2u8nbYAH8J
         8Z82KbxiTWWZVZjH1HTn0xBNGfecxhtZu2Y+hloyHtGgTP4Cwu6KOD3xYcGuO+PKqX7L
         6+lg==
X-Gm-Message-State: AOJu0Yw2re7J7jPYkPk6wQ2JgWluIb0bcyhBcyESGsZJ10ZbnOCXl0cq
	kVckZFV/xdjN3a4X0X8OGeHZpYA2MiYCCGAS4qNni90AsPWXwReuP1p2nRIg
X-Google-Smtp-Source: AGHT+IGrn1UvroDZBeg6W3Cxfog4OF7xU6x+PfAhZZTTLKmqb7GlKOaDQ8poCxkmXKjJcUp7iE7ymw==
X-Received: by 2002:a05:600c:19ca:b0:413:1258:82f with SMTP id u10-20020a05600c19ca00b004131258082fmr7844435wmq.1.1710245834883;
        Tue, 12 Mar 2024 05:17:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05600c3d8600b004133802cf8csm1889427wmb.38.2024.03.12.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 05:17:14 -0700 (PDT)
Message-ID: <9995b805-ef8b-47c9-b176-ff540066039a@gmail.com>
Date: Tue, 12 Mar 2024 14:17:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Different channels have different TX power settings. rtl8192de is using
the TX power setting from the wrong channel in the 5 GHz band because
_rtl92c_phy_get_rightchnlplace expects an array which includes 2.4 GHz
and 5 GHz channel numbers, but it's using an array which includes only
the 5 GHz channel numbers.

Use the array channel_all (defined in rtl8192de/phy.c) instead of
the incorrect channel5g (defined in core.c).

Tested only with rtl8192du, which will use the same TX power code.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d835a27429f0..56b5cd032a9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
-- 
2.43.2


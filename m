Return-Path: <linux-wireless+bounces-21958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46693A9A7A6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D295443939
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFA1A316A;
	Thu, 24 Apr 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="HJ91rwWS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4433DF
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486794; cv=none; b=ZVcZHefqXZmp6Rl0jvP/2GechEvqEMDzsGuskG1G/dmJOztD2VY2pTL2z7/pugTbdpqEQD0bPb0HcNSbqFvDvY3aQiN+yApnQNmwVey5TlQPyGRMcL6Ww8w9IMTmaygj4z/CnGyBnkAjQ7RN1DV/Fq0l/4HbfXiMdh8yxGuUff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486794; c=relaxed/simple;
	bh=Z5MyafENlEpco95TpBaUFshFsw1OM1QNr9nB8iGntOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrYwDdhkPmopsCkADzypIwfB/0440nSG9MZMTrqbI9KQ75UL76b9mbUWP54CnyRoYVIUpvty+w2BtmNox8Lm3yH3zAupYGycsNPa2IsULG3AlFxiHQQRZtz/oQrkX9ZRiyLzOr+qPzmz5qhpw4tPEwzrsnuJLcur8W+FLsmxGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=HJ91rwWS; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5240a432462so817740e0c.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1745486790; x=1746091590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5MyafENlEpco95TpBaUFshFsw1OM1QNr9nB8iGntOQ=;
        b=HJ91rwWSFYYzPsqKdWkdS89mciVI+/hDJsmX4QM1rffabuiLAGegdBs6t7f+7FVYV9
         cf+O8Q92fosQjUya07LLvGItGcEP4Uxur/eTtyUEU+zBr61eKGmFX1peg5aeezRiY6AN
         kSiB029+TrmY0Lvb9yQuVAtsaRnVd4IWj4dd5tGsBIxRLO/nJolqkSVpVJHLfoGHwa3J
         Vinpq4tziH+MXGvVPG7mVG/MMDajzn2zXPOiBX6gMmxGNe17ImheeKVU1P5yUGQH4ZDc
         YB93cE+hX/ner8hQ0fs/3rzAVKja/1vxjUFQlCCdSykLPJURszgXL/MX/xHTICBegzw+
         S4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745486790; x=1746091590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5MyafENlEpco95TpBaUFshFsw1OM1QNr9nB8iGntOQ=;
        b=L7TUo4gjQF8z+v3h+KVgMvH8YO0ISH5vw57nhnLROA3gYSYkKnSsSBNZ8V90d5DPrp
         D9MRk6oNgmwg7ezR/1tloCGLzKqgs4B1a1luKfvPjxOcLcOl+34GLtLk2Tx0PNmE2Mom
         80RIN6gCrxxmo02koTly9LCx2pxHy7roO/iwJJYi4JXPHOXgpIXwX/WlLIpifYi0fnMh
         WEOLJJ79JsInP5ZNf8cOcUvrBgisUylib3f7IrgUbMe4sOD4qqBhJbtNiW17NKZWwi08
         /RSnlfEHWNFHHfQP5FfHKLFskzXVmzJsPI7gxTYVKHjhP/Zyz1S8S198bSE9fyvnBQ1f
         M/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXvcv+QAhTMfbFRBCn59qWHcCAFg3xwzwYMZNXAjeVd5NLfURi14FgT/sz8QXF1NLoDlWZ/zz0LBAEgSuOQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYF48U5mSLMuBGGIuN1/r5irWV3+ibMxeHheaf2wKHkWkAWdk
	erXF2F2T9R1Lz9KZpIfHxD7+ob2hBzQ9oeZxRxASF0aBzcnZ1ocB4djLf/bJq50VcyTcammWEI+
	JCd7zzewwc0mAHbMG91y1zltv89HJPT0Y3qw1hg==
X-Gm-Gg: ASbGncsvuvEe8DHU3DVNO09UITWqLw1wEeClsXqbLXmovadyoKqXvdBzz0HsMHykY8u
	TL6vwBNsK8ljIo54dbFnr7Pl1Yfspn5SBIp4ot4aEHYYVgNfdGYD9OdUby9hGh1LqLurw12RsLS
	B/nmmuX/ob++bHy7NwCGVkxhP5
X-Google-Smtp-Source: AGHT+IHyRB1i0g5fWywav0cOEieN+e4nUaQszBAhGxbwm/VUdLeZHQSkjvE5yHBUJoZv0utbFB+4Woyyfi+XwG64SUU=
X-Received: by 2002:a05:6122:238d:b0:527:b804:ff78 with SMTP id
 71dfb90a1353d-52a79cecf47mr761229e0c.1.1745486790456; Thu, 24 Apr 2025
 02:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com> <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
In-Reply-To: <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Thu, 24 Apr 2025 11:25:54 +0200
X-Gm-Features: ATxdqUG_WrsQh_EY6ExiehuPKJDvXkH23pwheICaehGHv3febMevGIvKvu1CnIY
Message-ID: <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

@Baochen Qiang,
Thank you for your feedback.
I tested unloading and reloading the driver and it is enumerated,
detected and operating correctly.
And I understand your concern about other chips, and certainly it is
not the best way to implement such a fix.
I will continue debugging to determine the root cause of the
synchronous external abort.
So this patch is now just a workaround to fix the kernel crash when
rmmod the driver and reboot the system,
that i wanted to share with you to attract your attention to the
problem, and seek for help.

@Vasanthakumar Thiagarajan,
Thank you too for your feedback.
Yes, I understand.
I will enable the debug_mask and check the logs, like you said.

I'm wondering if anyone else has the same problem with ath11k_pci.

I will keep you updated.

Balsam.


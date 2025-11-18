Return-Path: <linux-wireless+bounces-29093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E34C68DB0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37193387310
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133E2989B4;
	Tue, 18 Nov 2025 10:25:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB415346797
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461502; cv=none; b=hK/mN8Jxx7M5aHLxK1hBx4+Y4WTAeCpYgwietBR5EC+7kRqco4BZjDgi3KuE74ICb4UkRAoGLKaXt4WYNM2JLF9K3UPC9Jqh/GsV8wF4ieq/ujC0P9ybvJLCKhTQXwEI0k3TRW4R9NivVODwb6H5oBqmJ5uSxhIPiZ+1JsUMevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461502; c=relaxed/simple;
	bh=qeivDoo7gQYhbm6hxAcQjY4XXajHEI78jheZkZZDruo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrjEhelPcXXjRnv4Rf+j/+iPQCBPBTU7NpRJ/2fNHUqTSdMsxvsEnyGGNLDfqwsO9c8sNkAlbB7Th5ErYplbEY4gslKeLfAeCzO7DQHg0h4zjXdKzuTwqohpqkdTVRoScDXbyUIGU240K5P20RWwA7eiydPtpiqg3dZujGM8UwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b24eedd37so2393927e0c.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461498; x=1764066298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svD5rzGWP7p3UDbS3wHWrpaUXSCJS/QIfogfnlGuLfc=;
        b=ahDU0BwsvlSLp59C9MYnzEgnQ/6yDuJ6litoR2dnbn+gFMgoID6mQhuK33dzzQQGRq
         5qG/UxUW/6kSEpOLfzWEe3GXylWZ1EGbWgIu1dLZSzCuVByhVu15a8ViP2AaSTq5m2Q9
         X+X5U/2yp/8kDhxrGnfW2EtbfKqKWVsuMKyZ7SfgryfH64DWGHIAOukhygnwUgthEtDt
         jPghfa3+zDLyRHy3S/WWsGQOn2FRpwgzUAh/ZGyAR4Yiaeq32pNEMkaJADSGX1t2SPBy
         SnU+tarkMJ/OEXE9gABZVK6wM62Ipm1/UzWWV5+xc/0TYGzAmqQqQelf+R/ec/F79Wox
         i2HQ==
X-Gm-Message-State: AOJu0YwO6ybz03W/lIyy9I+w5RxfHY+nyz4i5x8xOp8ChlG/CR14Tf/P
	h/xkZZgfPVDLGZLLfhlbLILKp8r7mMn8Co47U8rXd2xfa+vaAUPnh3soaSArQ2yjXCA=
X-Gm-Gg: ASbGncvj1e/8r/3N+tIra6/LAw8ZT+l0bkCwwnOG5cSKgvAMSXKAmQJTElycmD+JCmR
	cVq2t0Cq8ObIlxacCuYgxYyaF8gVPu8VJc1vddRweA2Hhy/bNmbnZcl2i8YY06NMYQs5GX9CfzP
	T/s5rO+V9Oaa2X0HpCwt5Blaxv0voB8VI7aQfYhg9n40hRCOjTT7CHBFhjFBbUi1NtzGH475WPP
	i29HWMVMUBdZJ5dnIH6mJOezIZI++8pgfyeygYa30nZWgc2CQA2fQSxBKIlME5SGi+X9bZYUBTb
	AldNbeAxCx6pYtIOGUYyhszqUoPCyTy2s2j0lwHpRHAxbWpp9ClXalny4Cw9wCDPFItNiF+wkGY
	vBdHUvr3D9FdAfAli05wT7cmjEksP6tIIjOM6TIRd06UONFtOCLcTIhqpzBYZJCBJEaDzmor3GR
	Bvfbk9snp3nEVTTOOAWVe/b5DF918bcdxTYjUAruC7+hUHTCzi
X-Google-Smtp-Source: AGHT+IGzIaIJNeMREsssuYLtPCO6a2mNLdRXZlFG8KeBgBkNSS8BTm1SMAt3raZCdXTdr4qMweggyg==
X-Received: by 2002:a05:6122:82aa:b0:55b:305b:4e33 with SMTP id 71dfb90a1353d-55b305b6fa4mr3606923e0c.19.1763461498368;
        Tue, 18 Nov 2025 02:24:58 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f1e104csm5614683e0c.0.2025.11.18.02.24.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:24:58 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-935134ef989so3217192241.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:24:58 -0800 (PST)
X-Received: by 2002:a05:6102:548b:b0:5d5:f6ae:38f0 with SMTP id
 ada2fe7eead31-5dfc5c042bamr5844811137.39.1763461497934; Tue, 18 Nov 2025
 02:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117032910.11224-1-pkshih@realtek.com> <20251117032910.11224-2-pkshih@realtek.com>
In-Reply-To: <20251117032910.11224-2-pkshih@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Nov 2025 11:24:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVuThcAyVuAU=N0FM+vd1xNyk9p4bcDWJUEpsYcmh2J7A@mail.gmail.com>
X-Gm-Features: AWmQ_bmd9zOQUfY9RN4j8kcH5Xyy-GaAqW6ffV90n1TRpzM0BfefVaulPaOLn0M
Message-ID: <CAMuHMdVuThcAyVuAU=N0FM+vd1xNyk9p4bcDWJUEpsYcmh2J7A@mail.gmail.com>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of
 reset DAC/ADC FIFO
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 04:29, Ping-Ke Shih <pkshih@realtek.com> wrote:
> The field mask should be bits 16-31, but suddenly use wrong bits 24-31,
> rarely causing a little performance degraded if DAC/DAC FIFO stays on
> an unexpected state.
>
> Found this by Geert who works on bit field functions.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


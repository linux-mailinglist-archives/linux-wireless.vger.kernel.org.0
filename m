Return-Path: <linux-wireless+bounces-23521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F312BAC9CE6
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 23:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D96E189B537
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D701A5B92;
	Sat, 31 May 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9cCjkY6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74D139D
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726709; cv=none; b=k2JJAj1ekFb0vmYdqepol9nGFw6s5odroCSGWJlsHJyK6wqxh28o15C2T6P/OlM8zlP8LzT9yYrMTKTY+faO15q7jEeuLn+Z8XiwYEX5OfFLhvg5MmSXuMcrJCf4Wn5sY1k9Mm7sBZUshhTJHebbwmAqVPI8VNL5QeWf5ubf8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726709; c=relaxed/simple;
	bh=VY9Ha0+7+JTRQMdymnY6ha9JZSlyzf1a6oMqIm5U/sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwFrds+prL7KM979y/R549finMui4CyOLzV07cNNI0p2d/NvaUIxMtiufjBWbHK9/jlUciFbHk1S1PpMA0Yyf7us9dB+/hsRP/JrVxBGiiYBK1eMybrYAP9jmkqSHGGSZ1Bcc56oq0ahGnnPfdhMrG7EHfIpKSQp0nrvIVR2pJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9cCjkY6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7dd151f79eso2947183276.2
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726706; x=1749331506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VY9Ha0+7+JTRQMdymnY6ha9JZSlyzf1a6oMqIm5U/sI=;
        b=d9cCjkY6qSLhlKWHsZVIzgq2zf9SV3AL7TuDBKSrW1xPwgzIvMj5Yf2KAsiJFm803S
         7SWf4055X27hszOnJrCboSDH5ZV3IsA/HZL6iVSB1/GwgFCFZI0b8JyAf2pA6BAwXRhQ
         vM1f52jZWAiCzmakYcyg7uweVP9xUaGPlyg+BzPKg2XBYFJCpO3iPf6pfAX4BR5BRiZb
         16lpAvAIbx5M9voceA/PqbNT0rLEf0MPAMpa9mwlL7hvv4OV0xmZriuK2OUV7/AI5gAH
         zcovCzbNAZhvHlb2ZgXerrUa+B5QhePAnKhm3THCf0nkiHJZ4fk4/oZfVD00L5UdFQNx
         icqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726706; x=1749331506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY9Ha0+7+JTRQMdymnY6ha9JZSlyzf1a6oMqIm5U/sI=;
        b=LnLSnibaeeZxGb2PlaQLvEwe4KLajcDIyctrSN5E2nDA1fsfOGe+2JSWrBnCVulflx
         mfdYO9jrC33tWwTb3lsvQwbZUnwc/mneKhEndovRoyYpyEj0eBOA18JwoFxwXBM8YMOk
         4mMAaZ+9q+rrLP86sRLymNlbkh+2WrUjCMEm28dPcA2Bu+mxUOcNxUlIUjlvzQmBpC7w
         jNQns4YYE+kk1C2yKgn3TMbeQlk+j4b8ncv3C5fQFM6tygDiQkELQxA4cPxWZ4paIjWE
         V+2X/s/jj2DochnzE+XSKDQ2elROeSuTGbnBEehkxUufC6GxvSc0LJYohLv8kSGn4egr
         /NWw==
X-Gm-Message-State: AOJu0Yx+QajivPizvvJJ1LiIfo4l2FBnNZk9tnJtI0WC1VzWguduWwXK
	es3p/FVeekutTLkGtCzUqv0vt14wHmCRRRDFBpsu8T7Rn5kBAUTb+h56QbifVbbWUlvsW7ja0QI
	HXhW18kasrG14K7dLxS6pwWPTsO65ga/vSV8YJbl5fA==
X-Gm-Gg: ASbGncsflY0xOsf8iFw3dtGKTbS+QseQHIQ+YwL+wdQstSMhWjmjLQFTjcWyqzbLTJv
	w5DORW+goY9jlypZlLIEfGkyhzWvt99wcI3kLTqiS/HPRXywa4QPzvTg4d2hz9fxhMlG7bDjhq0
	ilwl2EHthyHfn5EJuKRtV3/AqBgsvpri1I5RJkpHL13RuUYID+UXIRt+/DYxbZICZ8Qg==
X-Google-Smtp-Source: AGHT+IFQkd2vXiTlcffydL7iovYgUbxoSpUzUlzihPy5Nly/Dtgdjhm9TQhTBH6LaDjwNpif4wVN3VPFnqH0TVMrmmk=
X-Received: by 2002:a05:690c:4b06:b0:70e:2d30:43eb with SMTP id
 00721157ae682-70f97e78453mr124814537b3.12.1748726706702; Sat, 31 May 2025
 14:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
 <Z-SdYIm_lDvmCcO-@debian.local> <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
 <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
 <CAP-bSRb+qO-FhtjrGThCy2OoXU-jb3rkzzyUUkk4vP_P-u53Cg@mail.gmail.com> <d3f5b6aea39528ab7647e69f66fa90b26623a543.camel@intel.com>
In-Reply-To: <d3f5b6aea39528ab7647e69f66fa90b26623a543.camel@intel.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Sat, 31 May 2025 22:24:55 +0100
X-Gm-Features: AX0GCFtFRUpgONotrTQETqJcMgIBg9SSQMBQI3FUMyXWkPMQ0C1mzO5RYpOLIuQ
Message-ID: <CAP-bSRb_PeuFMqOjJu=akYsYANQ2ek8N1oR=8RiPXBeefM5_NA@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 04:24, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>
> In any case, the patch will be reviewed internally and follow its way
> upstream following the regular process.

Hi, did this patch ever get merged? I was just testing another issue and
noticed that iwlwifi still dumps this error on resume in the latest 6.15
mainline git on this particular laptop.


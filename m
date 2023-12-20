Return-Path: <linux-wireless+bounces-1055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C3E819679
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 02:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1720281D0C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6C168C6;
	Wed, 20 Dec 2023 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwDKgOzy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EC16412
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3367a304091so190066f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703036676; x=1703641476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKiRzNtGGIY1uHjH837oLbfNwwCc/Uk8HlilWVS2/0M=;
        b=ZwDKgOzyuzg6J3eBJ/xnrAk5schcCdMtldiXlfrUF91qrcGxX2f93pS65Mxs7En3YR
         RrmVwOQ6vGU55zEJfO+TQMMYtRNyZVs7Qg3XrxkHfMhyKmGNzGw9W61xQvaJo7uleHhS
         D5zGzMxWaGcpZlkdxg16qWWtSo10J2EfJ0xKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036676; x=1703641476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKiRzNtGGIY1uHjH837oLbfNwwCc/Uk8HlilWVS2/0M=;
        b=urNyVDseebq6XLh6xljeNZV5m4A9NYhuikxyAT3DeEbCgIJE2LkNM6zVZ5T/XEjjt1
         8ASsDPLAVgWYUhyVuXFV73wkfRNZg/4szDqkUTkj4dR2yihfk/POzdNj6y4p+HRVtzUc
         LPX0wnhfP4fjoxNAjTUzt1SGI/4n8OAEKn9RqECShFCrEVq7ilSJi/7JIjRMHWlkbGYN
         mrYKSX24oT59UlF3ftJIHxRefMZZTUrAlRRjGkPs4Kc+d+S0S7BCn3xxpubx+/vwlSEz
         ci07YpWqNSgdTyOsneCTAcoICKZTMGySId73MzbSbX728Z3KB0sPNJcZYLBVyN5b3UKS
         1htA==
X-Gm-Message-State: AOJu0YyM0s+wWj3c8vJCBSlqWrkVdZOS2HFdAEAvveC7hvWfyfz29YRs
	M9X9ZInJZcVPDK6h+2Y/1WL5RTYV0PLD4hDDgvU5nDaSBY8=
X-Google-Smtp-Source: AGHT+IHHASBMjJ24Dg8wAlERePpM7l6nd+Jttcs0MRRFR4qezYSBYbW6zpudAbIrARvwvR61+GEwBQ==
X-Received: by 2002:a5d:4084:0:b0:336:597c:ce5c with SMTP id o4-20020a5d4084000000b00336597cce5cmr2975549wrp.178.1703036676074;
        Tue, 19 Dec 2023 17:44:36 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id q3-20020a5085c3000000b0054ccac03945sm11974779edh.12.2023.12.19.17.44.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 17:44:35 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d2e5e8d1dso9069035e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:44:35 -0800 (PST)
X-Received: by 2002:a05:600c:524b:b0:40c:4857:e012 with SMTP id
 fc11-20020a05600c524b00b0040c4857e012mr5485525wmb.85.1703036675282; Tue, 19
 Dec 2023 17:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st> <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
In-Reply-To: <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Dec 2023 17:44:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
Message-ID: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Hector Martin <marcan@marcan.st>
Cc: Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Arend van Spriel <aspriel@gmail.com>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	SHA-cyfmac-dev-list@infineon.com, asahi@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 16:06, Hector Martin <marcan@marcan.st> wrote:
>
> On 2023/12/19 23:42, Kalle Valo wrote:
> >
> > Why is it that every patch Hector submits seems to end up with flame
> > wars?

Well, I do think some of it is Hector's personality and forceful
approaches, but I do think part of it is also the area in question.

Because I do agree with Hector that..

> Just recently a patch was posted to remove the Infineon list from
> MAINTAINERS because that company cares so little they have literally
> stopped accepting emails from us. Meanwhile they are telling their
> customers that they do not recommend upstream brcmfmac and they should
> use their downstream driver [1].

Unquestionably broadcom is not helping maintain things, and I think it
should matter.

As Hector says, they point to their random driver dumps on their site
that you can't even download unless you are a "Broadcom community
member" or whatever, and hey - any company that works that way should
be seen as pretty much hostile to any actual maintenance and proper
development.

If Daniel and Hector are responsive to actual problem reports for the
changes they cause, I do think that should count a lot.

I don't think Cypress support should necessarily be removed (or marked
broken), but if the sae_password code already doesn't work, _that_
part certainly shouldn't hold things up?

Put another way: if we effectively don't have a driver maintainer that
can test things, and somebody is willing to step up, shouldn't we take
that person up on it?

                  Linus


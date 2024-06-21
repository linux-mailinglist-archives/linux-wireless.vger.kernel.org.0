Return-Path: <linux-wireless+bounces-9442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA6B912CAD
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 19:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151A21F263BA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16195169AD0;
	Fri, 21 Jun 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKNecg6p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E915FD1B
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992445; cv=none; b=HMw4ZbVjd855vw5jcgF+eaBJ3dKLSEByIFmmwcfzuruf9TBUGrruyLQOll2efy2+tR1L22Gat6q4/7ta2W0k0xUADQIF3vcx/qMoXcJE5Kqe1A2K4dqoiRdiFnt/yzVmD2sYJRxuM5creNGNbC8lbphugSXPAdbY/A8ySMzJrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992445; c=relaxed/simple;
	bh=5Ul1dcj7VExsFyXCnzd+GQq0jgR2txEAK2Ur4F8DNN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRAeHVazr2+buCbrU4Y9ZEim4dlMhMwyUL0nI71jRGf5scQCHCgf8wbkVKwSwzwn/SVsux5052MLpaEtj7nlsn0ekfUZIzQSjqkNe1FlU2150BL1GwfSn5kGlvF2htsjS0wj07eka9QqgufXQQl1WSnh80aB3ue5RopggNftANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dKNecg6p; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso243476666b.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718992441; x=1719597241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ul1dcj7VExsFyXCnzd+GQq0jgR2txEAK2Ur4F8DNN0=;
        b=dKNecg6pwMqM+StHoS6wM2n0CVcYHvEOxeI1X/aRuymyzAmwH9hHY2KXE/EcIwLY6P
         /bvlOa4z4sqIpvsEQF77ujwPGxcr8bysbmOoRT2l+Y1zbZUSUlfACt7g7eCCxDjUwYKP
         bWz5Lgj8nJIM/BdMIM7SRl1XSjzp1HHZlmDjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718992441; x=1719597241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ul1dcj7VExsFyXCnzd+GQq0jgR2txEAK2Ur4F8DNN0=;
        b=KjUqDSyr4L2ib6fufzA8eUYH8kPBCr2LMES3aM5eon69OEGQLTUJ9KUk1k6g3t2kDK
         KTvcE3+C9YzOR2xyjyKUBsM/LRZKuUCiyIS6J3TtwzytqR+lnhMAFRztmcJprVkYva0c
         o19YGZW0q60zBCBIxMvwyhVeqJzs8Q4sfsvzEhy9aQE/VOMn69aAbKsHBFskdYjT0jvA
         Ih7mny3F8RzOV68C93Zu4z8noHYGs3bHnOgn5FzuocYTXoJxJ7SfB6CU+WEeWheuHM/i
         Wdqm3S64tnKIjY3NmN7cFHzZ6X7R5Elv12RJFVY5JcqhIVqg+rM8LrirjvpYNjTVRn+y
         4xjw==
X-Gm-Message-State: AOJu0YwkwmGjTvnXxUyg86NBGsz4SHUZQr6JkDa8Q9mRH1Nux0cFcEtQ
	WFMM8kyY9aWOXmGfJbs+x56fZ6fveAWEiD2ZfVrn0UOQHVQrYO1jaWFKnOohqU+4zVfGDOS533A
	=
X-Google-Smtp-Source: AGHT+IF2G761Ofx9zCrAPWsilHI9PJy3x58NclSOg9SYTT1odKYGagpxaJQ0YXDUF3DCOEGjOb97ZA==
X-Received: by 2002:a17:906:fe43:b0:a6e:f594:a292 with SMTP id a640c23a62f3a-a6fab7cd218mr653779666b.63.1718992441383;
        Fri, 21 Jun 2024 10:54:01 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560ad2sm107743566b.173.2024.06.21.10.54.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 10:54:00 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso318739366b.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 10:54:00 -0700 (PDT)
X-Received: by 2002:a17:907:c283:b0:a6f:57f1:cebb with SMTP id
 a640c23a62f3a-a6fab772482mr519008266b.50.1718992440147; Fri, 21 Jun 2024
 10:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 21 Jun 2024 10:53:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP1W5dwuiD0wRzwdvkH-0OwXMJN+3h4d5qNxz6XvftzbQ@mail.gmail.com>
Message-ID: <CA+ASDXP1W5dwuiD0wRzwdvkH-0OwXMJN+3h4d5qNxz6XvftzbQ@mail.gmail.com>
Subject: Re: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:52=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wro=
te:
> This driver is a derivative of existing Mwifiex [1] and based on similar
> full-MAC architecture [2].

For the record, mwifiex is a fairly awful driver. For one, its locking
schemes are generally unhelpful or nonexistent, and sometimes
placebo-like (as in, they look like they are protecting certain data,
but they do a very poor job of it). So I'm not sure this is a
promising start. It was just yesterday, in fact, that I was telling a
colleague that if mwifiex was proposed for inclusion in mainline
today, I would reject it.

Also, I'm far from interested in reviewing a new driver here. My only
interest in mwifiex is in making sure existing hardware (especially
those used on Chromebooks) doesn't get significantly worse. That
interest doesn't extend to "nxpwifi".

I just want to be up-front about it, and that you might as well drop
me from the CC list. (Of course, that's not a requirement. I can
ignore email too.)

Brian


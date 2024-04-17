Return-Path: <linux-wireless+bounces-6422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F58A7D3F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3FC2815AA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA36A8A4;
	Wed, 17 Apr 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH23kjid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA39184D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339644; cv=none; b=f9D4ZLYF81OPHcdmTs+ec+nWmQOwQrPu2kU+vEU7waVHNxKxZOKAiEnZzuNEKSvGhURqNY7xhv3Fet4OSWVT+1+3tr1+ZKQTbIqVR17sAPk7PXFchCFaSOzyC6mL6P02IToyOcEHOMuderHEzylbhwhTJA9vE/vTxNxU5jqeDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339644; c=relaxed/simple;
	bh=G9b21iNoZ/CW4iPVg/VxnVtBKTRskOJAiambZbUPYrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRvyUr9cY17yGn2SjFZnK5axbNbrXa1dX0XlnFrmRz1PaLnynX+wPLWSrFEpWPOWqPUlAfuYVLysCNPMCbXM7uV7ESUTrXhv6GFWx3gvUmyPjqQrFFDa3Csjzs2kKzDhBVRyNXYhC8qVHQpvhmucFzov3WiAi284B1T/rXP/ZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH23kjid; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22e6b61d652so2045404fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713339641; x=1713944441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9b21iNoZ/CW4iPVg/VxnVtBKTRskOJAiambZbUPYrs=;
        b=OH23kjidQXjNjYffHDHjS4yE/UUJ3WKn90sivVTFkyJFjloUY9PCOfCvZZcqU8kI+J
         EA2zEySG8ukzRhOuaXjl0/vZOfYWOi2Eeg4APT9blgIFSr701czBxPRnB1rzXudB2sNU
         IlLWEPusc1RQhVmpjrpAK/hReaInz1ZQsLAmhELMnReToRTmjqOoSzK+UEQAX3wy47bw
         cJiqSiN34FeAI318tfsSpTiP5ZTpx67tu6dZvk3WJGGHxJN7xDASLB7osqO6nZtNE5Bp
         zcw3tNavVzUyf5b1oFeNMkuH6cvupVM3iUGT1xWpN01+eIPofDDulFuazLRgw+ufqTzi
         QPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339641; x=1713944441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9b21iNoZ/CW4iPVg/VxnVtBKTRskOJAiambZbUPYrs=;
        b=CmxQnwiU+5pHSEG9z8hvb2WROh50cQradQKwVq04bzIY1pT/y61NN7mMgf2tHRvn0X
         r670qbbacjhxhB5nGJ5UaWTxB6z2pDGJobd6y7joUVLl5n72N5Rof5pWvKaiPmIMeDzI
         1loiOyBijns7NRTzyqW/l873gYi6BEvQkw74eBm/T4viImBw4BYzDybarLXM7GyO/LWH
         woO4DNDXWs+RCNm1XUkUUhJOCjj4MikGZ/1POQZABBuqHfUnT7QSUmhhGapbMzUK1Ymn
         GNrAo39JxvtEXRrGRaCnbhk3wZ/KHt4nFUrr/Dz+K5ZVCPpQqNCqBwo5NdbTtUQD/Iyk
         N4rg==
X-Gm-Message-State: AOJu0YzsfnApf6Ka3vi16e5Tki3eClUrb2XzmVqlJslgEv3fw+SdiUzr
	OjEjhSV7R7+7ozE7GvihMCiXU5qnsah2HZ+ScRcQ/EDbWpVZS9K9U8FeRGLjFXbaofg+shwXtbo
	ZOAwiA7SEdtM/toWz/3fPRh82FfA=
X-Google-Smtp-Source: AGHT+IEeJidm9m5NgckaQlRUGFTH/1ZQICnfg6Er8TbpqSJb/ieX1M7YkHMuCaCGkWWlu65uqEWu30BQgUNNKBGDy+c=
X-Received: by 2002:a05:6870:b294:b0:233:5a50:ba3c with SMTP id
 c20-20020a056870b29400b002335a50ba3cmr15702266oao.19.1713339641555; Wed, 17
 Apr 2024 00:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414173847.222809-1-change@change.com> <77db8dd55656cc18c2b0662224231e7a4746dc98.camel@sipsolutions.net>
In-Reply-To: <77db8dd55656cc18c2b0662224231e7a4746dc98.camel@sipsolutions.net>
From: Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date: Wed, 17 Apr 2024 13:10:30 +0530
Message-ID: <CABPxzYKO62zHE2Q72VPNyaUnDyjsz-i9NC18KLXAc23mh0cRsA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211_hwsim: Use wider regulatory for custom for
 6GHz tests
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, 
	Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Sun, 2024-04-14 at 23:08 +0530, changename wrote:
> > From: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
> [...]
> > Signed-off-by: Chaitanya Tata <Chaitanya.Tk17@gmail.com>
> >
>
> I think we need Author S-o-b. Or are you saying you developed it at
> work, but released it personally? :)
 :), forgot to change the gitconfig and it picked "from", will send a v2
to fix author name and from.


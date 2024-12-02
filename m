Return-Path: <linux-wireless+bounces-15831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC499E04BB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 15:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EA4283B9C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389EC203714;
	Mon,  2 Dec 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVNV3im+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1D1FECB5
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149419; cv=none; b=Jv+JrTsal8/clP94IqAdmFbUUnOxXB84bMqJ56/k7Jnb7e6q8yshGhha2Sa+QFfyQco76OQkg7I8Z4xPrbqbZ0tv7uD6pxarAXq6BJwqejm8E3AL0QFCF64bnqq5AZmVJ9mZ9pwMlWSN2eHRXXO5WCMMpcripCOgeNkq/V0HKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149419; c=relaxed/simple;
	bh=ddXyzgpGt4YfD/0sGUPWPz0YagqWpiS9hsBrxijCS28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMGfyDg5bq+jA3pHSLRfj7B7cVelbUGKAkAp3/u3vlR99rjXbm3B3Iwdv+H2GHEar4VrcR6mfzVwRJt0gwbM+b6r6YJzsYf/ES65UirOBYONEqB1cXPRRx5PxraIl28iKPlXLa/nPMHFqPrtOZSRZ5ZanRxXVrA9huf2IzEWuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVNV3im+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2127d4140bbso39460775ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2024 06:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733149417; x=1733754217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddXyzgpGt4YfD/0sGUPWPz0YagqWpiS9hsBrxijCS28=;
        b=OVNV3im+UI8NsFk+23i4y4iM/W6vj7B20IdUgntTJ0lepKmKw6ai0coDBtOaM87l7G
         1CVuguydDk3OSduFINIIlRNcQ1gEiYgZ8rtf3WHE8r/NgybPvEr80C0hhnHT4Ay7mwWg
         WVrRPyRe+WGWk2BmalOew1p+NKPeIF+GTpOcsmcOSMk9zblEF7yvo3KzNJT7MqV3/DLN
         RyC9CQ4p5vV0lfzq73Pdt1rUe/id+McuQ8C2RMq5/2VtqMFqnXi4o3bRtL+O0k76pq77
         NkbbrtDZNecNxjnfUQ+gcDrOqBTvAdA4ZeImLTmUnIiSEoaXQsQ7ARulvHwe0RybPuv+
         gHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149417; x=1733754217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddXyzgpGt4YfD/0sGUPWPz0YagqWpiS9hsBrxijCS28=;
        b=B4Iv2/4Dz9k4R/PmSmnR8hFLLp1+zEhxVwAwFpY3+ZSUXC/nhg+Jl7jD0fb6RM/AuK
         7FeUoZrnfxluQmL7oNZtod1S4P1cZMeW7f9MK2qMh03ev4g3cdv4rkzL1aeQRvH+D5Lq
         Nj0DKQCimHXkE53OdNFyjV+5GT96VnjeJsmS/VzIQmSMjKk9rKjhHXqScH4NaTT9Xr4o
         eN5varNcxUvyOaT4IEorH+tOp3gFx6GMk/4p6xrA1AI6D/8yrMpBh56MgEDhNeK6R870
         PYcxJaSyRwYSeA8DdmtZ4mkIEa2shBaKArcOiXMUl0Q0NmmOu9VBZyfTXOG6F8wlnUeM
         +zMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpR1H2nqdHuRVbTQwkr4P8M5O7qHXQTDJDWO7UxetIn3PCYg7/h+/zzHscfoLjDGd5RPqzQusgD/F52rI3cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlcJIDgxXkYcNFhl9HXWggoALHrL0qD8U7QBKl3Tf91DPQDrM
	dLiP9KIikJOUTXHrA8GAOdjAdC2vpI1GVLVniaN1d41PKjOJmki5Bu4ZeVXtZbmbP17TLxYIZAp
	sG9DN+PEkBlQVYOuH+dI6URVp8jI=
X-Gm-Gg: ASbGncvYtymkmoLE4W86cC0D0ozzt+SkQ3RuT9M5D4Jy5RjongNWvwnQqEjlAB0AmkM
	M35VDIeab2rJ9ZvqTLsRpwa/k3CkilaXPPQ==
X-Google-Smtp-Source: AGHT+IFCPg3KH7kpAUHkaK/AmiADjjAqfIg07HCx93mKaGC+w/Sgl/IIaxp011A1W6qGEXZU3GLH11/lgUjFaVwY9Zk=
X-Received: by 2002:a17:903:1cb:b0:212:68e2:6c81 with SMTP id
 d9443c01a7336-21501289b60mr358035355ad.24.1733149416838; Mon, 02 Dec 2024
 06:23:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
 <20241202042100.6384-1-renjaya.zenta@formulatrix.com>
In-Reply-To: <20241202042100.6384-1-renjaya.zenta@formulatrix.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 2 Dec 2024 08:23:26 -0600
Message-ID: <CAG17S_O03v6YAK2aUa9kN7ZGgCk2=Lb5B6KeX9qihfFTJPZikA@mail.gmail.com>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Renjaya,

Thanks! I am assuming this is done by setting a flag in the driver?
Can you detail what that is, exactly?

Keith

On Sun, Dec 1, 2024 at 10:21=E2=80=AFPM Renjaya Raga Zenta
<renjaya.zenta@formulatrix.com> wrote:
>
> I believe those errors are not fatal but I still hope this can be fixed
> in the kernel (or firmware? (or wpa_supplicant?)).
>
> Fortunately, you can disable DUMP_OBSS feature to disable dump_survey
> which triggers those error messages.
>
> See: https://github.com/raspberrypi/linux/issues/6049#issuecomment-248543=
1104
>
> Regards,
> Renjaya


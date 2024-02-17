Return-Path: <linux-wireless+bounces-3718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20678858C9D
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 02:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9132837E1
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3642E2376D;
	Sat, 17 Feb 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="f8zF86cp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1362376C
	for <linux-wireless@vger.kernel.org>; Sat, 17 Feb 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131977; cv=none; b=c3dDILZ4OIB4fxfvP6uLWeGkbCP8ZJy6cxveffhzEamzM/O23K8xmG7nkoLROE+sd0OsBUasLiILC2sjtialEbFoHnRt2twTCTHSyK5SGogO0Y+gh3jhi7j5O2bV+BhhETDJG5guwmzwn5GnkYghseOlKkMEWw32eSSl8OHdsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131977; c=relaxed/simple;
	bh=I7f+uaArkA2lejzKTuC73e6iQLhpPbXSgqoVfp/xUIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPvdzkMmDhdXXZeGj8Wbat6VOCK9SC+NDNhw5trSwp3Ou4dffv+gXhyymawVWNKVoxlc86TfgHSLCKLEeDGbj6xic7HwONX5XQyORI6TDogdG4DxndGR/C9aM1kA+oeZhEfcj6EVms2+Nwc38V39ClumsZWMf2aVjCTyXNKI6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=f8zF86cp; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so1310539241.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 17:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1708131974; x=1708736774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfkSvBHz/Z/KjshkJ6+Vt1cr+ClUcSDaN9mCuw1bF1U=;
        b=f8zF86cpbfzTMbV8JNTZPKCDrv4LZ9L/wFR5S4Uo6J3sKfgBVw7v1QkghKdGh0tC4u
         hemU7MY0tM0RAeq1+QRsMssFGC1cp8fAZBgCJoMTt1bVXRbU2zfhJeCM7qDemBe+CSH6
         F2+MY6JIhiA/KGNizoZyutOkjqN92C38qQUOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131974; x=1708736774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfkSvBHz/Z/KjshkJ6+Vt1cr+ClUcSDaN9mCuw1bF1U=;
        b=PhrAwYlPNF+7YUIinsOCt6FKGp342LOlhk6XtzGVlMeZTtkQ7smcdRTju9gqTK845b
         XFBBQIwknT4uq6fim44KXdg/lw+ohOM0Tts2txSvKiUhWpu4ywkTBSAsSs4KVio1HSmM
         MWHZZfAd518AI8bl/5gs9t4NV0DwUIW01ivGpGRAknWVEzWov3dSXa05IRvx/9XeUWG9
         eGmEyJTRiK/uklCtvQWwr57irinlQfP+oPf37h2VwoHUcfow7qjoJFJvb30jP6xZRezx
         rYt28wLjEilt6T+zPB/LTpaCsqaM4vzdPppcQOKiqvRWyaqjsqEYZVLi87rrnvuLZDTI
         p4Iw==
X-Gm-Message-State: AOJu0YyZMF7uxEXeeZwLpBu+gVUrWt+7jncw1M08dnekb1TDK7ur2jdE
	FB55eLy4zKgUOnjLcxkvLm+p3xtBmkOBGkGj+YDOmQskfxpJYUi2kxKFlx+viiYuXIx11RRtfJC
	InQq4/qWl/8T9mJrA/mXR/xT4aymW9pSAXA6aWVvITiZsOo4tyw==
X-Google-Smtp-Source: AGHT+IFdCcYvP8lOwtSY3GcXSP0Gmh5njRyJl5vQwbfw5JqWP4LzL+NMUTerRS3Z9tgWF9EheTY48pQLW2aKXq6W4b0=
X-Received: by 2002:a67:f74b:0:b0:46d:4811:422b with SMTP id
 w11-20020a67f74b000000b0046d4811422bmr8875177vso.8.1708131973914; Fri, 16 Feb
 2024 17:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112040217.24356-1-me@ndoo.sg> <170528847205.770636.8573617454652565233.b4-ty@kernel.org>
In-Reply-To: <170528847205.770636.8573617454652565233.b4-ty@kernel.org>
From: Andrew Yong <me@ndoo.sg>
Date: Sat, 17 Feb 2024 09:05:57 +0800
Message-ID: <CA+yTfBAR9jtapt0NfRM7iBasg7eEg2ez6=+oBvcgZpTrCnVC7g@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update and disable 5470-5730MHz band
 according to TPC requirement for Singapore (SG)
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good day, Chen-Yu,

I've received confirmation from the authority (IMDA Singapore) that
the original interpretation, 3 dBm EIRP reduction may be used in lieu
of TPC support, is allowed.

I'm not sure the right process to cite these communications to the
mailing list; I'll do the following, hopefully it makes sense:

1. I'll send on this thread, but without CC, the relevant emails from
the authority for your review
2. I'll send a separate PR reverting the change with just the relevant
text from the emails from the authority quoted, citing this email on
the mailing list

Cheers,
Andrew

On Mon, Jan 15, 2024 at 11:14=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wro=
te:
>
>
> On Fri, 12 Jan 2024 12:02:17 +0800, Andrew Yong wrote:
> >   - Use original regulation Tx power of 1000mW with TPC for 5470-5730MH=
z band instead of -3dBm offset without TPC
> >   - Comment out 5470 - 5730 band to disable it since TPC is not impleme=
nted
> >
> >
>
> Applied, thanks!
>
> [1/1] wireless-regdb: Update and disable 5470-5730MHz band according to T=
PC requirement for Singapore (SG)
>       commit: d695bf21d1cdf02e64924f452c242f7588469609
>
> Best regards,
> --
> Chen-Yu Tsai <wens@kernel.org>
>


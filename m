Return-Path: <linux-wireless+bounces-18548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A354A29BC3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 22:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338AF188396A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640A20B817;
	Wed,  5 Feb 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8+SksTY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7E204C1A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790271; cv=none; b=lGBgEGF8oy5FaPhA20G1A9c/wPLpM5PNe/pRFkos+YWeUbR9bW6iN/XqgLSuWmPba7kcFGvn3+HIP5j5h4ddhrtFIj50on5+P6DaikTNcyuDGFf0BpedRFdyaT95IMtypQkLb1+bVQO2WeiFD9sWdbrmRUncA600jbEufuGLvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790271; c=relaxed/simple;
	bh=gLdB88JwLzJ6KYngLg38ymBBPoY7Rf7rIXqmJWKTHQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+Hk7ODNEXV34GmjYh6KEknUvoRaZ9Djy9nYSIhK6X/rdJ0/fLAZTXPosnMkCa8TkSmw3HBzYQ3ZdEWBHoY1yzbtnI5g3vwFsl2jIffCJ8VFSGM66/ydWr6B7oDWgtmyxkhPq7J3LxKDK6pPkJnCmYhT2kW2m1TI2vnZXowPIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8+SksTY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e4242b0b96so3750756d6.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 13:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790268; x=1739395068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqJ97tCh8SkMUaEeWFymeris3fl6NFZdP7xfRwnTDX0=;
        b=k8+SksTY3fDeIxbIaIFpQ2EJBkKjaDYEuYHzD2nOsJUJ7bxLbaIxonBNKiAQ0nsZqv
         IyWV5WNc0VsgqhlLQFWbEjKVu3z9jPM+clI5vjB5CSLFDPUZ5QAKbAzQVpxGfnBFtKOn
         D294qgfI8e/REhOkyAvvTfiwiBXzevf8RSQKkCVq3xXG2eaRHbF+y6QF4g2qYjY00tC9
         EpRCVyIdcXcJJx1j+BgbbhNtbaS5fQw3nZGHHbPflTJtsa/SCY8vuQqjt/b8hChEeEp7
         fj266OM+uosiLaXwCFZTA5mFanOit1e5natdR7bowRsNeHwAScrROwoFdbgWNsRdC/VM
         EPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790268; x=1739395068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqJ97tCh8SkMUaEeWFymeris3fl6NFZdP7xfRwnTDX0=;
        b=Ky1/u/UIg3qF7dCGOP5tmfYH9UcDfvS7H77TL89kDJe6ca4mird9CLTJG7eqxfzrbz
         bi2jaJPDiZ08mIhrX7cz6xLxbKQGk/5TPv7UhXBfcCyualpeGtkz6tIKIgYYPgN2KMod
         mnTsRZSjUxnTWhF5tn0gk2/Ya7pUkxDPxX82w6SdE7EXn4D7+SDNcL1cHFur2xg3UnTw
         wK+/Ci5rmHseo6/v2y4ZIWuiFebu3Cu4Eg5D9+GeD26OYe4iXCZvi7AwGB/lfXDjiLzT
         m32qwmPvnVz97itjCuArn6PoKz9GAAO9CVZdnQEM00JQhfDDzZ4PcmTX8XYCPD4oGuQp
         FbpA==
X-Forwarded-Encrypted: i=1; AJvYcCU8GY34VZ6U09LWeUAkfi/5PrxVXchtQwIfdAvBs3KjAPmNLwiRyGxhW4qffot1X9+Q1AXFuu2RdRN1V0Akhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnCVZoWnIqGN2ZXNAOhC6FqfRlaXpyqD1K1Mrn2Ze5rhQ3zP6
	alQCqN8hw1sHy2/IxPD9GPrIYKlNs14rC/VLY9WJ+tvI9ghJkPndT7qmQWedt4dSofY8G6xqege
	B9+tazp02Wr3hjQt2wvCL1XkYyV4=
X-Gm-Gg: ASbGncuyr57EwZsbJd+q13qr3/GfisfkdnvsCf47RDTJwjbXpUSdnTfUpTr2noNvad5
	DudbvmGm4CtX4d5NfbKRgwy0SKMlIwBkkefpy8zJ9EXKFFOUgyNd2gmIDmI90opFv3i/NMoJaHw
	==
X-Google-Smtp-Source: AGHT+IHPMdTpxbgoJn2dvlcek3qq4T7xaYlKAQD5jqHvLRjdNGNIA9a9Cm5/gdLFuKAAWeP87KN+s0ChnQ3IFct89lE=
X-Received: by 2002:a05:6214:5091:b0:6e1:700e:488a with SMTP id
 6a1803df08f44-6e42fbc8c22mr60943516d6.22.1738790268496; Wed, 05 Feb 2025
 13:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205205452.384911-1-jacklivingood@comcast.net>
In-Reply-To: <20250205205452.384911-1-jacklivingood@comcast.net>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 6 Feb 2025 08:17:36 +1100
X-Gm-Features: AWEUYZmkQlOoWwSoNyJLdOvWAdkBKwtIe7x46NzHkTA6Hr3voNqI6H9_1Ltu-s8
Message-ID: <CAGRGNgWzUjEdwZVz2+0Uk+WXuQZSJ6LGHtjJvmt0Jy5kk25UxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Undoing Macros with flow control statements.
To: jack Livingood <jacklivingood@comcast.net>
Cc: miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jack,

On Thu, Feb 6, 2025 at 7:58=E2=80=AFAM jack Livingood <jacklivingood@comcas=
t.net> wrote:
>
> Signed off by Jack Livingood <jacklivingood@comcast.net>

Why?

> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-io.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wi=
reless/intel/iwlwifi/iwl-io.c
> index cd7eebe6a7b1..957000d5df68 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
> @@ -230,15 +230,19 @@ IWL_EXPORT_SYMBOL(iwl_force_nmi);
>  static const char *get_rfh_string(int cmd)
>  {
>  #define IWL_CMD(x) case x: return #x
> -#define IWL_CMD_MQ(arg, reg, q) { if (arg =3D=3D reg(q)) return #reg; }
> +

This doesn't pass checkpatch.

>
>         int i;
>
>         for (i =3D 0; i < IWL_MAX_RX_HW_QUEUES; i++) {
> -               IWL_CMD_MQ(cmd, RFH_Q_FRBDCB_BA_LSB, i);
> -               IWL_CMD_MQ(cmd, RFH_Q_FRBDCB_WIDX, i);
> -               IWL_CMD_MQ(cmd, RFH_Q_FRBDCB_RIDX, i);
> -               IWL_CMD_MQ(cmd, RFH_Q_URBD_STTS_WPTR_LSB, i);
> +               if (cmd =3D=3D RFH_Q_FRBDCB_BA_LSB(i))
> +                       return #cmd;

And this is not the correct expansion of this macro and won't compile.

Please read the documentation on submitting patches:
https://wireless.docs.kernel.org/en/latest/en/developers/documentation/subm=
ittingpatches.html

And please explain what you're trying to achieve here.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/


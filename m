Return-Path: <linux-wireless+bounces-1474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE433823E49
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24EF1C2393A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5412033B;
	Thu,  4 Jan 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtOj2daW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9120303
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7f2c72846so10520339f.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jan 2024 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704359282; x=1704964082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPkikR0+Cp9CaLqdSLUmre0cKqV7mereubM4P+BkCyc=;
        b=CtOj2daWqqlhZNNa8rOcA9R0E1HHV053grHMnMRxF2y4gHvbT3m9j4OwVS+wWY0ED6
         CAraVVDXrdFDfVPEvsA4BF56oXHVLjZPRT5ebzK6kXF2ZsQKB6gMuiA/07TZMRO+OoEH
         IfuCj4E1yQWccF1q41oCbyK2pZSx3OU1bqACtQucRuoNNHxoVKd684CR242R0YZ/BxXx
         +kmlBDEbUCK6YSHFT1Dtxc2IylzgizCgDY8qSGmfeVnrJSQ3Usta38kZSC5IdDzZ2OBg
         uzLuPh37ov3DGZdI53k14fX8kulhjTY8jNFoqnCNNseoy9Bh+tkM8ptRAlhLjPiJXklG
         S57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359282; x=1704964082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPkikR0+Cp9CaLqdSLUmre0cKqV7mereubM4P+BkCyc=;
        b=mcgPpO++RlGr0zAoGHgEqmT/5nZK5G7mogOTb8pCDTd6Xabn9jaMtpH8RSXzqktoXO
         hbHvhuUKE2vJn58vyJwuKsIi1zaiTHOAdTCQMTIkHUAITGTPa1WHoKbhGqMWxWnlcv3O
         hF2VhSl5ws+SIZzBm/hwAgY33bDyljIZQx6ood8qqSNscPlLAg6JN5DbCzBiaL7P8WTy
         Tsq5gKr0czLpBDcDZOIE8VfrG/XAkqflBO9mRYvvZAfYltLzCjtrpg58S8xL+KAOdwtC
         wMsrmowXjBTg37N5VMQ+YWzbovSDwZK2SOlru0p0ZaePCCogDwP93WxHDGK75o/Rb+HK
         AHYw==
X-Gm-Message-State: AOJu0YyCoCiFO1X+cABdSi0iJHd0cRTx7HMHRQdnEFPitqn553RQ/q5D
	UDsBrXy7Q+n7dM5PU/Wvvwj8ATJwA9w8HG2qop4=
X-Google-Smtp-Source: AGHT+IGuhm70ejPN/hiQgCDZR4YWOHYKn7MwRnNDZQgvpU4BVs/DsfrRaYduse0xQEVgMXCzh3W8g3dGP7/Lmwv8ngU=
X-Received: by 2002:a5d:824e:0:b0:7b7:fe2f:dddd with SMTP id
 n14-20020a5d824e000000b007b7fe2fddddmr347340ioo.22.1704359282587; Thu, 04 Jan
 2024 01:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
In-Reply-To: <CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
From: b.K.il.h.u+tigbuh@gmail.com
Date: Thu, 4 Jan 2024 10:07:51 +0100
Message-ID: <CAPuHQ=GSuKW5=T0GXXCq7Pf9jw=zcEnms-fEJey68QUWH1ishQ@mail.gmail.com>
Subject: Re: WiF Transmit Power Control (TPC) Regulatory Requirements?
To: wens@kernel.org
Cc: Seth Forshee <sforshee@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	wireless-regdb <wireless-regdb@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can find a wording in most such regulations that if TPC is not
supported, the maximal TX power must be reduced by 3 dBmW. Hence in
all such cases, the entries in db.txt contain 3 less than the maximum.

If, on the other hand, you know of a country that specifies that
devices lacking TPC may not use the band at all, all such band entries
must be omitted (commented out along with a URL).

On Thu, Jan 4, 2024 at 6:59=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wrote=
:
>
> Hi folks,
>
> I wanted to clarify the current state of things.
>
> As far as I know the kernel doesn't have facilities to support TPC or
> transmit power control, nor does the wireless-regdb database. And so
> in the database we would either omit rules that require TPC, or include
> alternative rules (as specified by local regulations) not requiring TPC.
> Am I right?
>
> This came up recently with regulatory changes for Singapore and Armenia.
>
> For Singapore [1], the 5.250 =E2=80=93 5.350 GHz range has provisions tha=
t allow
> usage without TPC at a lower power, but the 5.470 =E2=80=93 5.725 GHz doe=
s not.
>
> For Armenia [2], the updated text (translated by Google Translate) as I
> read it requires TPC for all 5 GHz channels.
>
>
> Thanks
> ChenYu
>
> [1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-c=
onsultations/ict-standards/telecommunication-standards/radio-comms/imdatssr=
d.pdf
> [2] https://www.arlis.am/DocumentView.aspx?DocID=3D181829
>


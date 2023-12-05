Return-Path: <linux-wireless+bounces-411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B214C8049D5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 07:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636FE1F2146E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E50D53C;
	Tue,  5 Dec 2023 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1fnPH+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068D9C3
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 22:12:48 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7c461a8cb0dso1155256241.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Dec 2023 22:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701756767; x=1702361567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ryYyV8/M6pyTb5RJURq7C3uofpRRqUWY8rbZOcLmLI=;
        b=G1fnPH+THTT1bsHXByst88Xy/p3I47OlBlY8iLVj2wH4bDELUvpaEihl08WO2T/PjX
         qWqHNfBGUfC1UaHqfm5zb8/avUmU5LAu2Wwhh0FFeDKi/PBoI2nr+jwofce2I4q0hCet
         UrOq/nwSWBDiF0EiWjTGaHThdESySOdF+vjXxSgnXGDAZaRwfTD69FGlwDAm3VXiPBc2
         N55N3Xk3eFm8x6yAa+avutoG2ypDI6iCf4ecnbpR868wXQTMaI0Z0tFPljN8ixxqMteW
         D65oek7saWrTIerqn0xbSvSZfWZ9h/6dc5ESZlEbF9V1ylyPl1jSULYf20nEffkCc50S
         Knqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701756767; x=1702361567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ryYyV8/M6pyTb5RJURq7C3uofpRRqUWY8rbZOcLmLI=;
        b=twlWuPDJCAVcmydCHMVSWiJMljubZOy5oqNmQmkEgC16vhpZ0WMCH0xFONCFV4y39I
         H+15MvJcd9Sf7UFf2fStYbBl5ABhkV/IWaAwXnDrVvfXNszbjLtrDw4WMeYNWMq73Eq2
         3+IWP6rEmVxB16ESGsQd8iPI3UFDQbBHf57Uq8ecdsEjsKifaAqKzlA7uw7js6g0JFVT
         y6uHHgdmmP85Ds38NvfKf3jJ93nLL/jTCkFDfViJKKkmhNWyV1Zja1lrWkltCCr46Bt7
         eZYeqMLgNwtP89c0JEEnm1HMsZMWHHmTdcjQnjcX7MAUsNZe29fPzy7LTWiu8depEhIA
         Ur6A==
X-Gm-Message-State: AOJu0YxFognLdkozXNVqSQnnHoH5/QYcXsy+QmWeezhtwqlAWAQe1b17
	h9wuRbW9GxpKKFu7BJmzf9KzYWDzmiKDv/Bof1GI+2c7kfTODQ==
X-Google-Smtp-Source: AGHT+IFECnQFLNQUCoPSYzME9aRiyINEiDD9v6oQXGG8wrsJJLX3gdI+3H9bkdgonZ6FEhG112z0KoHBwbjkWyZU3DE=
X-Received: by 2002:a05:6102:2f2:b0:464:901f:cfdd with SMTP id
 j18-20020a05610202f200b00464901fcfddmr1540656vsj.23.1701756767097; Mon, 04
 Dec 2023 22:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com> <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
 <b4cfd676c0b24d98b82302aefac7f379@realtek.com> <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
 <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com>
In-Reply-To: <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Tue, 5 Dec 2023 08:12:33 +0200
Message-ID: <CAOE0c97cFjF=LGD8-nb95ihQhE0YRRqM=4PKud4nccQa06MVxw@mail.gmail.com>
Subject: Re: Lenovo LOQ rtw_8852be
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > > > $ lspci -tv
> > > > > -[0000:00]-+-00.0  Intel Corporation Device a715
> > >> Can I know the type of your platoform Lenovo LOQ? Is it a regular no=
tebook computer?
> >
> > LOQ 15IRH8 - Type 82XV
> > I am using a dual boot with Windows and Ubuntu 22.04
>
> I still can't find information about the device a715 that I also can't fi=
nd
> this ID in kernel source code. I will dig kernel further when I have free=
 time.


According to the specs:
1x 13th Generation Intel Core i7-13620H Processor(Core i7-13620H)



>
> >
> > >> The PCI EXT capabilities locate from 100h. Not sure if host controll=
er driver limits to display them?
> > I did not get your question. Can you say it again please?
>
> I meant offset 100h of PCI configuration space is a standard area [1].
>
> "PCI Express extends the Configuration Space to 4096 bytes per Function a=
s compared to 256 bytes
> allowed by PCI Local Bus Specification. PCI Express Configuration Space i=
s divided into a PCI 3.0
> compatible region, which consists of the first 256 bytes of a Function=E2=
=80=99s Configuration Space, and a
> PCI Express Extended Configuration Space which consists of the remaining =
Configuration Space
> 5 (see Figure 7-3)."
>
> I don't know why the PCI controller in your platform doesn't recognize th=
e region,
> and then _possibly_ cause driver failed to access 719h.
>
>
> [1] https://blog.csdn.net/huangkangying/article/details/50570612

According to the specs:
2 x M.2 (PCI Express 4.0 x4) (1 free)
512 GB SSD M.2 2242 PCIe 4.0 x4 - NVM Express (NVMe)
and I have actually inserted a second SSD myself

Is the driver compatible with PCI 4.0?


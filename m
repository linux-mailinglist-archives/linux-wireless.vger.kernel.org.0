Return-Path: <linux-wireless+bounces-7214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD38BCAEC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 11:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991051F23308
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0744143886;
	Mon,  6 May 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtYeSODk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BD143887
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988350; cv=none; b=noSvf9mxGrqSUrUCxIU1d+NsepzKT4DV/5B32w6TfEeHIqoBN6F2JmZiv0aZyceeaGsejiFJP+Zei/sQDg/mXNfjhWUrPrmKG3/2T9Ni99oPEjkHYbcTkvSXAUXId9875X0z4PN4LcqsCEdIWPVAgCtnskxXPeoPlk3uePhfRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988350; c=relaxed/simple;
	bh=D5fxi7K/I+wiOZxYCl01o5FiAL0+LnZIViBxp0ScRY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odIe6lvf0nsGEG5oXD6WmWoqTvwUIHvJOFeX/A43j1tyDahHy+BZPE4jVLTA02GzVXX+Wmvc2FQ6Serv5kTP+etmwaE20cZRMgdcKiWtLdEdPGcynB8BUvW7ZlqJQ0QhZA5NL4T2+cS48GJ9FpfgeKCkkOasw3fxBgE1FJpreDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtYeSODk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso2320371f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2024 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988346; x=1715593146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xM7FTnJKRl03pnMfNQj+bOzBzsNvwdLFuhfPFQDwow=;
        b=BtYeSODkFff4sGWwgPQ9tfUaegr+ko0prZo7Xa0KSMjJh4lvzjB+XDMl2ePx9C/arx
         HQEwEeGfZHZiWjiNWsow7B+smvw/5z0B26EUbGwkIMoMWr2KNQM5EiWRJmhHW8AI3yNq
         T01hoWn3d+s4fuZKQ+rq+R8oQn+gNAenD/b7Vow3QNGY1321/QTz9GWMet+NhODNlZJr
         nOuQjX/ukbI5yOK1rFXveVaqw1T7f+W+vEngHLygGpbHLLHHZJAtWTr/17EWi/enzOJs
         ZdZSLjH1wSJsS2XKMm4s0O8TDJb2ktadNO/SrW6XWRyrplo2NfRUdQ7D16DCE3ixjwIX
         UcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988346; x=1715593146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xM7FTnJKRl03pnMfNQj+bOzBzsNvwdLFuhfPFQDwow=;
        b=PZvCmLXBxpgJjgQhxh/gLMlTasVZJMWDDXachwjYpZhSEHBQTHBHVLum3dLbSaJSnF
         cEARqqUWDLCYPAF8KFuLfB89OvgS21eM/bsXSyYbF1tuHAo3mdTHfEJC10WXhuCl+htc
         XbckItlbGJFGA/yov8oFvVuV6gmvbsuAAuHTZlPYjU+Qh4lBEXL8rQ9XdL9Oz24bxaLI
         gCtjj5LrkGPDw5lB2uyJaoov37uzL+sVJnA8A4FvTGRoNKQLkfeFqdfcpKOOLOrMOAi9
         dIba4qJDfdM1g80VbaRA0DGoyOXF/V8m/OjL7ldq3Sks9cv0bj0bjEwSg5hre7GhcL5Y
         2WSg==
X-Gm-Message-State: AOJu0YzAhjzmbSodWZEfHhtm93enK+sLvlpCJCVefigK3H5psHpx91Sy
	2iZqbnQjKVzUh22dpbn/afGNa+YSocp0+9sMyjXG+KecJIebjuCyO8ZtRr3cto9CKdBseEDmKQh
	Ew9HoeWF7upI7BgWsIKYZPgf+0Ef6JZMpiFo=
X-Google-Smtp-Source: AGHT+IFUZ69rdQfUVQGBgnO4dyU1pDXNoel5rAclsJlmfTTMFe1GAt0Kj9kUzk+Q+CJaAenvI1seaH2j854WaJS7Mpo=
X-Received: by 2002:a5d:5045:0:b0:348:7e75:4d75 with SMTP id
 h5-20020a5d5045000000b003487e754d75mr7856185wrt.22.1714988345866; Mon, 06 May
 2024 02:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com> <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com> <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com> <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com> <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
 <e4ccf840-a38c-455e-af75-5f4db8a97702@lexina.in> <CAD9ZU8C1mf92UH1_k4bB5yTr8yXLX_0CDZHFz+Yh6Z0MQZLs=w@mail.gmail.com>
 <131edbb8-be69-4766-b7af-49ec9232eb3c@lexina.in>
In-Reply-To: <131edbb8-be69-4766-b7af-49ec9232eb3c@lexina.in>
From: Gabriel Tisan <gabriel.tisan@gmail.com>
Date: Mon, 6 May 2024 11:38:54 +0200
Message-ID: <CAD9ZU8DBn_pmkAX2JkBh2_HPe08pGRx6n+8i0TgKq3xXa2+2eQ@mail.gmail.com>
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Viacheslav <adeep@lexina.in>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested again and I could confirm that rtw88 does not send any beacon
in AP mode.
Once again, maybe you could tell me which repo of the driver rtl8821cu
you tested successfully in AP mode.

On Thu, Apr 18, 2024 at 12:55=E2=80=AFPM Viacheslav <adeep@lexina.in> wrote=
:
>
>
>
> 18/04/2024 09.58, Gabriel Tisan wrote:
> > @ Viacheslav:
> > Can you please tell me which repo did you use when your run USB 8821cu
> > successfully in AP mode ?
> >  From your log bellow it seems that is not the mainline driver rtw88_88=
21cu.
> >
> > On Wed, Jan 17, 2024 at 10:49=E2=80=AFAM Viacheslav <adeep@lexina.in> w=
rote:
> >> I have USB RTL8821CU. It works in AP mode:
> >>
> >> [511809.841083] usb 1-1.4: New USB device found, idVendor=3D0bda,
> >> idProduct=3Dc820, bcdDevice=3D 2.00
> >> [511809.841111] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D=
2,
> >> SerialNumber=3D3
> >> [511809.841118] usb 1-1.4: Product: 802.11ac NIC
> >> [511809.841124] usb 1-1.4: Manufacturer: Realtek
> >> [511809.841130] usb 1-1.4: SerialNumber: 123456
> >> [511809.973789] usbcore: registered new interface driver btusb
> >> [511810.432057] usbcore: registered new interface driver rtl8821cu
>
> Damn, I thought the rtw88 driver had been picked up, but now I see that
> it hasn't. I will test again and report back with the results.


Return-Path: <linux-wireless+bounces-28095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B1BEFF64
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CA394F0057
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218532EB873;
	Mon, 20 Oct 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD4MBqFD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377222E339B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949108; cv=none; b=hPtDCEfGRTHQI66SNcM1xJw+Tm0Tw+bIL24Qidf9mE2pGXbal2f3XHVawKkfAUZmvi7512Zffxbk3YYD2P+z/LlT53d5mcWbvP0O5INtfjEa9KN/Jsw8w3vGvxdFY+b2PzwLFHW1k72IzzaY6WkTwSeHzbF+8oMyP9vkIuWjdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949108; c=relaxed/simple;
	bh=ZvD3ZMZdL1w/6XegkMJCVYKZa/CKWyTVrD/45o3+BFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYAWBpzaY0FfYHNW9CGjLBtQokJbkIARRpPS/Ff9XITId8jYI65MmM+isPcjexkce03nrcfLD1BTj7iRVJgEbbFCr+fXL8XykiKNnPLk7DmQ8XC0eR04WFcMfg2CP/U2NaOErEqxfFilwaQSnKMB9vwDEKjSFngT3dTSLlbNxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD4MBqFD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso4774584e87.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760949104; x=1761553904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/A4cHmYOWCf0dL97JI4s6z4lNHCMjZua/3EXqu47DJI=;
        b=QD4MBqFDDuDgrw0U0tROD7zCGLj2WIeaJ0brDIicrBaJUw+3cON0zuxJ01IZg3W36L
         frHopsNheyEbbDwFkVDlDDMXgO8HmvTdU1MSiYc7tuxphcIBUN8maWl+FJLmW+w47AvK
         oPmrSY1IEGTUIMFARlROxBxq8IMeg7O2+jH9+F/wSskw/yNDxbN5RnT2iMprWDhbA/bn
         kJeFQKgBl5h2Dm5ixbMaT05fBh1XR2bh/jhouQuD2qInZ6ynwxa1lc1x0Pn263GW56Zk
         Sd6jFLaMayUbPmANNdkyMvUSJMHQB2AVRmfuDUhtjDG9qPQGozDnZj+KqUd7Gh0ItFBZ
         u/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949104; x=1761553904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/A4cHmYOWCf0dL97JI4s6z4lNHCMjZua/3EXqu47DJI=;
        b=OTbllX+s7NsKRYKCPAa/MkkfH5wZWcApb1akjMNIwSPP74/G7DflZpuhOpHmQZrZ15
         oz1f+P/WwXIDvVYqNvO0C6W2arFHfsylNu3vYOJxj56wvptkj0My5fNBjFwMtrcejRfh
         eIYAEI1pl+FEArI5i0JV0KHhFvW3oaGtUEf+LM+7pYvSGlalF477LqG/t6PdH2QvHkp/
         KHhAtiex6XCEus4NK/QFpjgqqzVii6Ks/X1xq6R5kbwYhVsbWJgXgt9oQpUubnQK7YVX
         wVNYXJDp2iV5T/VyLmxQnhui3+90VW4Fbk9NjmXoEE8ddLrXkpRk0002D7V/28/wzJhS
         mlXw==
X-Gm-Message-State: AOJu0YxaKxPeFrpF0MG9rXn77WCtvv+CQRxEuVtmstdPklseAgPMldsR
	P8aHYvb/BA7Ejrr/9Jcv8RLseCLyzSiTQJYTJp2RrTzUSWf3xnZYfu/CvAwZtuxRP0/wddXbgeg
	5PDkQjliNyrDvAfFp711eim8quml9bTQ=
X-Gm-Gg: ASbGncuqv8TBHu4W/XNit7XnNuoJNdvZEtq7aJIc9X2QT76gCvJBaWRIVMvviz1zOwD
	LZD64FamtHIEHL0KRXUznLbBZ0OX5GmhsWR6QJfi0wk5Ny//7GpXz0c/EhLHMl/TvclntbVPmWw
	7rzw2iKsCU7JOlpgr2tBCAZHxnpV7esgv9dLGy3mDd1W3sHGTD76b4j9MtkPGsusoo3mA3MAdro
	Xoi8zkTuErFVKUEgkeMgu2xSuCV48aaw6ma0cPMksiBVm5lgP506I//eAo=
X-Google-Smtp-Source: AGHT+IE42qiWQSmH4fNgySSy5iZ9HHBA/72mgHfF3UNVKwQsT9p5fpIQne4VWppsxcaB/3va0c6KvWnBKugslZMY2dc=
X-Received: by 2002:a2e:8593:0:b0:375:ffc2:1b2e with SMTP id
 38308e7fff4ca-37797a8d834mr38883871fa.45.1760949103930; Mon, 20 Oct 2025
 01:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC3nzgJ9uX3rREGQGbLA+oJMzDh0Bc-Fs5sP1sM_4DGScgq=3w@mail.gmail.com>
 <977b67ef-ef6f-4ae4-99db-eeb921a17e3f@broadcom.com> <CAC3nzgJM6azT8T4StreR874h5sUarLH62mgHvRZndV_XEOBEgQ@mail.gmail.com>
 <199fc3250e0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAC3nzgJxowTjrJJppahVMg1iLVXad38D5ZR38-rzsDQm8daUTA@mail.gmail.com> <98a614cf-0016-4cb2-9109-84dec84b535f@broadcom.com>
In-Reply-To: <98a614cf-0016-4cb2-9109-84dec84b535f@broadcom.com>
From: Berkem Dincman <berkem.dincman@gmail.com>
Date: Mon, 20 Oct 2025 11:31:30 +0300
X-Gm-Features: AS18NWDQUl5MF1GWw5yZD57LFRBu3h3PcroP7Q0u6GLCcED9z7v2VHC9_U5xVOo
Message-ID: <CAC3nzgJ94L_20hhCbsNu9Unzjg-gDvs-a1x2_vMiarj=wdR6TQ@mail.gmail.com>
Subject: Re: New test release reload driver
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, brcm80211@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000cec12a064192e907"

--000000000000cec12a064192e907
Content-Type: multipart/alternative; boundary="000000000000cec129064192e905"

--000000000000cec129064192e905
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

20 Eki 2025 Pzt 11:16 tarihinde Arend van Spriel <
arend.vanspriel@broadcom.com> =C5=9Funu yazd=C4=B1:

> On 10/19/2025 1:50 PM, Berkem Dincman wrote:
> >     [ 17.288032] Bluetooth: BNEP socket layer initialized
> >     [ 17.319081] Bluetooth: MGMT ver 1.23
> >     [ 20.068465] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> >
> >     As Bluetooth resides on the same chip as wifi I find that
> suspicious. I
> >     would like to know what happens when you disable Bluetooth. Can you
> >     test that?
> >
> > No I turned Bluetooth off and restarted the same error messages would b=
e
> > printed onto the screen
>
> Ok. Thanks for testing. What do you mean by "turned Bluetooth off"? I
> want to assure the bluetooth part of the chip is not powered on. This is
> probably not the same as "turned Bluetooth off". Please provide logs for
> each test and/or verification done. It may save going back and forth
> over email.
>
rfkill list all
I observed another thing, the battery was drained overnight this happened
before in the 6.17 series the screen remained black shutting it of with
Ctrl-Alt-Del also would let somethings open in the 6.17-rc7 release there
was a power management patch from Rockchip and the screen started working

>
> Regards,
> Arend
>
>

--000000000000cec129064192e905
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">20 Eki 2025 Pzt 11:16 tarihinde =
Arend van Spriel &lt;<a href=3D"mailto:arend.vanspriel@broadcom.com">arend.=
vanspriel@broadcom.com</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On 10/19/2025 1:50 PM, Berkem Dincman wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 17.288032] Bluetooth: BNEP socket layer initializ=
ed<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 17.319081] Bluetooth: MGMT ver 1.23<br>
&gt;=C2=A0 =C2=A0 =C2=A0[ 20.068465] brcmfmac: brcmf_sdio_bus_rxctl: resume=
d on timeout<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0As Bluetooth resides on the same chip as wifi I fin=
d that suspicious. I<br>
&gt;=C2=A0 =C2=A0 =C2=A0would like to know what happens when you disable Bl=
uetooth. Can you<br>
&gt;=C2=A0 =C2=A0 =C2=A0test that?<br>
&gt; <br>
&gt; No I turned Bluetooth off and restarted the same error messages would =
be <br>
&gt; printed onto the screen<br>
<br>
Ok. Thanks for testing. What do you mean by &quot;turned Bluetooth off&quot=
;? I <br>
want to assure the bluetooth part of the chip is not powered on. This is <b=
r>
probably not the same as &quot;turned Bluetooth off&quot;. Please provide l=
ogs for <br>
each test and/or verification done. It may save going back and forth <br>
over email.<br></blockquote></div></div><div dir=3D"auto">rfkill list all</=
div><div dir=3D"auto">I observed another thing, the battery was drained ove=
rnight this happened before in the 6.17 series the screen remained black sh=
utting it of with Ctrl-Alt-Del also would let somethings open in the 6.17-r=
c7 release there was a power management patch from Rockchip and the screen =
started working</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
Arend<br>
<br>
</blockquote></div></div></div>

--000000000000cec129064192e905--
--000000000000cec12a064192e907
Content-Type: text/plain; charset="US-ASCII"; name="devices_112749.txt"
Content-Disposition: attachment; filename="devices_112749.txt"
Content-Transfer-Encoding: base64
Content-ID: <19a00bbbcd9beed38ce1>
X-Attachment-Id: 19a00bbbcd9beed38ce1

MDogaGNpMDogQmx1ZXRvb3RoCglTb2Z0IGJsb2NrZWQ6IHllcwoJSGFyZCBibG9ja2VkOiBubwox
OiBwaHkwOiBXaXJlbGVzcyBMQU4KCVNvZnQgYmxvY2tlZDogbm8KCUhhcmQgYmxvY2tlZDogbm8K
--000000000000cec12a064192e907--


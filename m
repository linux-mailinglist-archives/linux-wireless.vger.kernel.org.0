Return-Path: <linux-wireless+bounces-9790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71491E93C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03A9B2206F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BFF16FF41;
	Mon,  1 Jul 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC3shke8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEE171641
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864507; cv=none; b=acxYFzn45vLq+6Kik99GCwgUTCOCmfdIjZfO1mn1dDl6W7UmTxNfEyR7filsbGEbMWZmL6zrCBxJIhCr15gzGkIhHoeGfur2l/JUyqM4//D6IIicT+SVgRKqiMwJYTlBVpyDrDVmRlwYQZK7/Cwb8M56Mu2h61KSRgPn6naXAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864507; c=relaxed/simple;
	bh=XUp4pXUHw116I+N9/JjRLUO4zS58e2B6E67Braz7BuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kINTYRNjWmE7kr4dr2RHQNBOkWrALfbG9VB3LjDjzfmUs/gdqDRIZM4bhTw5l2PzuGCTunu2M7geVUAojxbusTOaYnEDM912br8CU66UTMgbYI87EQnaeWpvJrIbaatHJo/vWbldJfGg8JorTE93tp7OEOakOzTAb11CiN6Ojkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC3shke8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7276c331f78so2971486a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719864504; x=1720469304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljer9lEV7DEsm/a+oQxsexs52qwEhseZgCNbRJr3ryM=;
        b=iC3shke8zPHFAFVn+G6xEdPIeto7hP5kscXUvyKQYssL4AFy9iyozI18sP6w5zTs+t
         SU+kSL1V/6FUOxYN0s8MpPZ/Hx3LN0s3ZigLko1Zd+ix1cSUl1/8UA1PdnaSgxLbQWj6
         e2CE+wNvuGsJAu8CT4vTsrAoAw2eseb7F4nhv7aSNJB9IGS9iAcj61h4LUkIj67A/QCk
         TbqSpUqGMzic3BlrUDjFpqzplTGgmfizAVNwmAQNTVOie8Tn8mSwkVjt+7kW9NvpjyYA
         6Z3kkhkXAT5SCvo+OX9nJO78jvTm679sYF6SumScyYrT72WKdwZGsgqvXWBTuuRfTnth
         34lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864504; x=1720469304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljer9lEV7DEsm/a+oQxsexs52qwEhseZgCNbRJr3ryM=;
        b=d/nkysdaci5YLmE04qBF5xiBlPcXR4Fs51LbdeXMlB9t7Yd6lXPgPp92Md9quuGKdd
         auIHqXFb/hGZHR/Vsu/7oll8FXzuvthTiLWKKw6FvLEqTRwaDtBMm8mj85DKaGh8QnGG
         NmbDmE1FBwFvq4N0a7ViF0aQ5DYhb0AAaC+dHcNEyxMHAbm8bEAsmiEl62Vd5pnFUyWC
         0haD3Zj5OMzxmvEMA6Kh8F602UyV5TeNjSVx19zxEr8MxWokTGv1tTvwADQVBvRTc0PF
         7VxWzk0j01fvrfa4J9llrjmHTZCRrOueU2p6dFWJto1gBNDpHZ0roxoprxFQw4j9lHcp
         GY4w==
X-Forwarded-Encrypted: i=1; AJvYcCVMwgpozzGYkInkBlWP+Jdi0vq4MN3KvvqajPkmMlQ31EwREnqAsDPgjrayPSIkZdPjNHAlUDJMGcI9yL9JK8nUmSz9CfrPaRfSO0H/Qb0=
X-Gm-Message-State: AOJu0Yyw+3g7SYw4RLQwwCEbcGNze69Id0jbc2aT6weHJIjSrol52yAj
	ORljPsSS6l12jB/7/8Z1Ol1uBpC858yXF6ToN736uDztJOKhb1A+79d8UPbQ+ofhq7WaLw5Suhq
	CXKxT0ldHCxBTBN7zN+jys1PaoMBOs/jKnPk=
X-Google-Smtp-Source: AGHT+IGfJGQx+UDr7NGB43tG2ANyhYxYVIBQfTt4KgZwvxTah8wp0aDP9p8r3lTr7qU830DMYdpFLaF1/RL/JTZoHgU=
X-Received: by 2002:a17:90b:3e8c:b0:2c2:d6ca:3960 with SMTP id
 98e67ed59e1d1-2c93d2ab720mr10342554a91.17.1719864504052; Mon, 01 Jul 2024
 13:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
 <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
 <CALeDE9M78so=roEFion9GGo4tV7c+M885=ZNZgi9zKyBur+iMQ@mail.gmail.com>
 <190355aedf0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NBO=tTBp9GX=S9C4REbT-Gx634n66+7JERcWbe-KXt-g@mail.gmail.com>
 <190369b8c10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NHC7EqUMtc58eSY9Yoq4K0mvp=C1rcP8PTRzajXW3Csg@mail.gmail.com>
 <c065ae75-f89e-4b14-9fc3-6ef19e6d144b@broadcom.com> <CAG17S_OMV5TpCO+XwP-6dQNB_zVs+OCoawpngZUshuDOgFOF0w@mail.gmail.com>
 <1905383f7e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MPwwgzup17zwHmNH87RS9mrwn7A8v0FkntQx2du6fLig@mail.gmail.com>
 <19054769d10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NojmnuQqLyOAT6+Tq4OLaBVc1FY6J8cqwWvo_VxcNLiA@mail.gmail.com>
 <19058122ea8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_Paw=634Q5zNm8jM2c_66OMscN1ngxR53kF=DJHKU2N1A@mail.gmail.com>
 <CAG17S_OMU2QbeMnue+RWqFErhbPKVCmFR90VMOYkVy+aMcdoBQ@mail.gmail.com> <1905a29df60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1905a29df60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 1 Jul 2024 15:08:12 -0500
Message-ID: <CAG17S_OL+zskWOQty2rzZG8+Ddb+qeR4bQYCZ53qJ00-9QVeiQ@mail.gmail.com>
Subject: Re: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi: brcmsmac:
 advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, Jouni Malinen <j@w1.fi>, hostap@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:46=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 27, 2024 3:46:35 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Thu, Jun 27, 2024 at 6:34=E2=80=AFAM KeithG <ys3al35l@gmail.com> wro=
te:
> >>
> >> On Thu, Jun 27, 2024 at 12:01=E2=80=AFAM Arend Van Spriel
> >> <arend.vanspriel@broadcom.com> wrote:
> >>>
> >>> On June 27, 2024 12:47:02 AM KeithG <ys3al35l@gmail.com> wrote:
> >>>
> >>>> On Wed, Jun 26, 2024 at 7:30=E2=80=AFAM Arend Van Spriel
> >>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>
> >>>>> On June 26, 2024 2:05:07 PM KeithG <ys3al35l@gmail.com> wrote:
> >>>>>
> >>>>>> On Wed, Jun 26, 2024 at 2:48=E2=80=AFAM Arend Van Spriel
> >>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>
> >>>>>>> On June 21, 2024 2:24:19 PM KeithG <ys3al35l@gmail.com> wrote:
> >>>>>>>
> >>>>>>>> On Fri, Jun 21, 2024 at 4:09=E2=80=AFAM Arend van Spriel
> >>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>>
> >>>>>>>>> + Jouni
> >>>>>>>>>
> >>>>>>>>> On 6/20/2024 8:25 PM, KeithG wrote:
> >>>>>>>>>> 1718907734.308740: wlan0: WPA: AP group 0x10 network profile g=
roup
> >>>>>>>>>> 0x18; available group 0x10
> >>>>>>>>>> 1718907734.308748: wlan0: WPA: using GTK CCMP
> >>>>>>>>>> 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network profil=
e
> >>>>>>>>>> pairwise 0x10; available pairwise 0x10
> >>>>>>>>>> 1718907734.308767: wlan0: WPA: using PTK CCMP
> >>>>>>>>>> 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network profi=
le
> >>>>>>>>>> key_mgmt 0x400; available key_mgmt 0x0
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I suspect the message above indicates the problem as there is n=
o
> >>>>>>>>> available key_mgmt to select so looked it up in the code and he=
re it is:
> >>>>>>>>>
> >>>>>>>>> sel =3D ie.key_mgmt & ssid->key_mgmt;
> >>>>>>>>> #ifdef CONFIG_SAE
> >>>>>>>>> if ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
> >>>>>>>>> !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) ||
> >>>>>>>>> wpas_is_sae_avoided(wpa_s, ssid, &ie))
> >>>>>>>>> sel &=3D ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
> >>>>>>>>> WPA_KEY_MGMT_FT_SAE |
> >>>>>>>>> WPA_KEY_MGMT_FT_SAE_EXT_KEY);
> >>>>>>>>> #endif /* CONFIG_SAE */
> >>>>>>>>> #ifdef CONFIG_IEEE80211R
> >>>>>>>>> if (!(wpa_s->drv_flags & (WPA_DRIVER_FLAGS_SME |
> >>>>>>>>>         WPA_DRIVER_FLAGS_UPDATE_FT_IES)))
> >>>>>>>>> sel &=3D ~WPA_KEY_MGMT_FT;
> >>>>>>>>> #endif /* CONFIG_IEEE80211R */
> >>>>>>>>> wpa_dbg(wpa_s, MSG_DEBUG,
> >>>>>>>>> "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
> >>>>>>>>> available key_mgmt 0x%x",
> >>>>>>>>> ie.key_mgmt, ssid->key_mgmt, sel);
> >>>>>>>>>
> >>>>>>>>> So 0x400 matches the expectation:
> >>>>>>>>>
> >>>>>>>>> #define WPA_KEY_MGMT_SAE BIT(10)
> >>>>>>>>>
> >>>>>>>>> You already confirmed that the driver reports SAE and SAE offlo=
ad
> >>>>>>>>> support. So it seems wpas_is_sae_avoided() must return true. Th=
at will
> >>>>>>>>> check whether the AP and network profile are setup to MFP. This=
 seems to
> >>>>>>>>> be the fact as your hostapd.conf and wpa_supplicant.conf both h=
ave
> >>>>>>>>> ieee80211w=3D2 defined. This function can only return true when
> >>>>>>>>> is enabled in configuration file:
> >>>>>>>>>
> >>>>>>>>> # sae_check_mfp: Require PMF support to select SAE key_mgmt
> >>>>>>>>> # 0 =3D Do not check PMF for SAE (default)
> >>>>>>>>> # 1 =3D Limit SAE when PMF is not enabled
> >>>>>>>>> #
> >>>>>>>>> # When enabled SAE will not be selected if PMF will not be used
> >>>>>>>>> # for the connection.
> >>>>>>>>> # Scenarios where this check will limit SAE:
> >>>>>>>>> #  1) ieee80211w=3D0 is set for the network
> >>>>>>>>> #  2) The AP does not have PMF enabled.
> >>>>>>>>> #  3) ieee80211w is unset, pmf=3D1 is enabled globally, and
> >>>>>>>>> #     the device does not support the BIP cipher.
> >>>>>>>>> # Consider the configuration of global parameterss sae_check_mf=
p=3D1,
> >>>>>>>>> pmf=3D1 and a
> >>>>>>>>> # network configured with ieee80211w unset and key_mgmt=3DSAE W=
PA-PSK.
> >>>>>>>>> # In the example WPA-PSK will be used if the device does not su=
pport
> >>>>>>>>> # the BIP cipher or the AP has PMF disabled.
> >>>>>>>>> # Limiting SAE with this check can avoid failing to associate t=
o an AP
> >>>>>>>>> # that is configured with sae_requires_mfp=3D1 if the device do=
es
> >>>>>>>>> # not support PMF due to lack of the BIP cipher.
> >>>>>>>>>
> >>>>>>>>> The default is not to check it and you wpa_supplicant.conf does=
 not
> >>>>>>>>> specify it.
> >>>>>>>>>
> >>>>>>>>> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >>>>>>>>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >>>>>>>>> update_config=3D1
> >>>>>>>>> network=3D{
> >>>>>>>>> ssid=3D"deskSAE"
> >>>>>>>>> sae_password=3D"secret123"
> >>>>>>>>> proto=3DRSN
> >>>>>>>>> key_mgmt=3DSAE
> >>>>>>>>> pairwise=3DCCMP
> >>>>>>>>> ieee80211w=3D2
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> $ cat /etc/hostapd/hostapd.conf
> >>>>>>>>> # interface and driver
> >>>>>>>>> interface=3Dap0
> >>>>>>>>> driver=3Dnl80211
> >>>>>>>>>
> >>>>>>>>> # WIFI-Config
> >>>>>>>>> ssid=3DdeskSAE
> >>>>>>>>> channel=3D1
> >>>>>>>>> hw_mode=3Dg
> >>>>>>>>>
> >>>>>>>>> wpa=3D2
> >>>>>>>>> wpa_key_mgmt=3DSAE
> >>>>>>>>> wpa_pairwise=3DCCMP
> >>>>>>>>> sae_password=3Dsecret123
> >>>>>>>>> sae_groups=3D19
> >>>>>>>>> ieee80211w=3D2
> >>>>>>>>> sae_pwe=3D0
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Arend
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> 1718907734.308779: wlan0: WPA: Failed to select authenticated =
key
> >>>>>>>>>> management type
> >>>>>>>>>> 1718907734.308787: wlan0: WPA: Failed to set WPA key managemen=
t and
> >>>>>>>>>> encryption suites
> >>>>>>>>
> >>>>>>>> Arend,
> >>>>>>>>
> >>>>>>>> I find the wpa_supplicant docs really hard to understand. I have=
 read
> >>>>>>>> through your response a few times and am still a bit confused. D=
oes
> >>>>>>>> this have to do with a pure wpa3 versus a wpa2/3 AP?
> >>>>>>>
> >>>>>>> Correct. If I am not mistaken MFP aka PMF aka 802.11w is mandator=
y for WPA3.
> >>>>>>>
> >>>>>>>> I have tried editing my hostapd.conf and my wpa_supplicant.conf =
and
> >>>>>>>> still cannot get a connection, so I must be doing something wron=
g.
> >>>>>>>> I commented the ieee80211w line on both and it would not connect=
.
> >>>>>>>> I tried changing the wpa_key_mgmt on both ends to be 'SAE WPA_PS=
K' and
> >>>>>>>> it still would not connect.
> >>>>>>>>
> >>>>>>>> What *should* the configurations be in the hostapd.conf and
> >>>>>>>> wpa_supplicant.conf to negotiate this as a pure wpa3 setup? What
> >>>>>>>> should it be to be a wpa2/3 setup? My phone worked fine to conne=
ct
> >>>>>>>> with the original hostapd setup, but I have no idea what it is d=
oing
> >>>>>>>
> >>>>>>> As I mentioned in my previous email both config files listed abov=
e look
> >>>>>>> okay to me (might be wrong though). The problem seems to be with
> >>>>>>> wpas_is_sae_avoided(). For it to return true the config should ha=
ve:
> >>>>>>>
> >>>>>>> sae_check_mfp=3D1
> >>>>>>>
> >>>>>>> But you don't have that and default is 0 so it should check for M=
FP. This
> >>>>>>> is where my trail ends. To learn more I would add additional debu=
g prints.
> >>>>>>> Are you comfortable rebuilding wpa_supplicant from source?
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Arend
> >>>>>>
> >>>>>> Arend,
> >>>>>>
> >>>>>> Thanks for the reply. I could try to rebuild wpa_supplicant from
> >>>>>> source. This is on RPi, so debian *.debs which are a pain, but I t=
hink
> >>>>>> I can do it.
> >>>>>>
> >>>>>> Do I understand correctly that 'sae_check_mfp=3D1' is supposed to =
be in
> >>>>>> the hostapd.conf and wpa_supplicant.conf? I can try that and see i=
f
> >>>>>> anything changes.
> >>>>>
> >>>>> Ok. We can try first to put following in wpa_supplicant.conf:
> >>>>>
> >>>>> sae_check_mfp=3D0
> >>>>>
> >>>>> Let me know if that makes any difference.
> >>>>>
> >>>>>> Why would I have to re-build wpa_supplicant?
> >>>>>
> >>>>> I would provide a patch with additional debug prints so I get bette=
r
> >>>>> understanding what is going wrong. Would be great if you can apply =
that and
> >>>>> rebuild.
> >>>>>
> >>>>> Regards,
> >>>>> Arend
> >>>> Arend,
> >>>>
> >>>> I was able to try it this afternoon.
> >>>> My hostapd is still:
> >>>> # interface and driver
> >>>> interface=3Dap0
> >>>> driver=3Dnl80211
> >>>>
> >>>> # WIFI-Config
> >>>> ssid=3DdeskSAE
> >>>> channel=3D1
> >>>> hw_mode=3Dg
> >>>>
> >>>> wpa=3D2
> >>>> wpa_key_mgmt=3DSAE
> >>>> wpa_pairwise=3DCCMP
> >>>> sae_password=3Dsecret123
> >>>> sae_groups=3D19
> >>>> ieee80211w=3D2
> >>>> sae_pwe=3D0
> >>>>
> >>>> and I can still connect from my phone to this AP.
> >>>>
> >>>> I tried this as my /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >>>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >>>> update_config=3D1
> >>>> network=3D{
> >>>> ssid=3D"deskSAE"
> >>>> sae_password=3D"secret123"
> >>>> proto=3DRSN
> >>>> key_mgmt=3DSAE
> >>>> pairwise=3DCCMP
> >>>> ieee80211w=3D2
> >>>> sae_check_mfp=3D1
> >>>> }
> >>>>
> >>>> and when I try to connect, I get:
> >>>> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan=
0.conf
> >>>> Successfully initialized wpa_supplicant
> >>>> Line 10: unknown network field 'sae_check_mfp'.
> >>>> Line 11: failed to parse network block.
> >>>
> >>> Right. The setting sae_check_mfp is a global setting like update_conf=
ig. So
> >>> it should be moved outside the network block.
> >>>
> >>> Regards,
> >>> Arend
> >> Arend,
> >>
> >> Thanks for the hand holding, I am out of my depth here!
> >>
> >> I tried this config and get a similar result.
> >> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >> update_config=3D1
> >> sae_check_mfp=3D1
> >> network=3D{
> >> ssid=3D"deskSAE"
> >> sae_password=3D"secret123"
> >> proto=3DRSN
> >> key_mgmt=3DSAE
> >> pairwise=3DCCMP
> >> ieee80211w=3D2
> >> }
> >> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.=
conf
> >> Successfully initialized wpa_supplicant
> >> Line 3: unknown global field 'sae_check_mfp=3D1'.
> >> Line 3: Invalid configuration line 'sae_check_mfp=3D1'.
> >> Failed to read or parse configuration
> >> '/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'.
> >> : CTRL-EVENT-DSCP-POLICY clear_all
> >>
> >> seems it doesn't recognize this parameter.
> >>
> >> Keith
> >
> > Replying to my own post.
> > I re-built wpa_supplicant from the current git:
> > # wpa_supplicant -v
> > wpa_supplicant v2.11-devel-hostap_2_10-2215-gc9db4925f
> > Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
> >
> > It now seems to recognize the 'sae_check_mfp' parameter, but still
> > does not connect:
> > # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.c=
onf
> > Successfully initialized wpa_supplicant
> > wlan0: Trying to associate with SSID 'deskSAE'
> > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=3D=
16
> > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 =
seconds
> > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > wlan0: Trying to associate with SSID 'deskSAE'
> > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=3D=
16
> > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 =
seconds
> > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > wlan0: Trying to associate with SSID 'deskSAE'
> > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=3D=
16
> > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 =
seconds
> > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > wlan0: Trying to associate with SSID 'deskSAE'
> > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=3D=
16
> > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 =
seconds
> > wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"deskSAE"
> > auth_failures=3D1 duration=3D10 reason=3DCONN_FAILED
> > wlan0: CTRL-EVENT-SSID-REENABLED id=3D0 ssid=3D"deskSAE"
> > wlan0: BSSID d8:3a:dd:60:a3:0c ignore list count incremented to 2,
> > ignoring for 10 seconds
> > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > wlan0: Trying to associate with SSID 'deskSAE'
> > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=3D=
16
> > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 =
seconds
> > wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"deskSAE"
> > auth_failures=3D2 duration=3D20 reason=3DCONN_FAILED
> > ^Cp2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > p2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > nl80211: deinit ifname=3Dp2p-dev-wlan0 disabled_11b_rates=3D0
> > p2p-dev-wlan0: CTRL-EVENT-TERMINATING
> > wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > nl80211: deinit ifname=3Dwlan0 disabled_11b_rates=3D0
> > wlan0: CTRL-EVENT-TERMINATING
> >
> > I tried setting the 'sae_check_mfp' to both 1 and 0 and still cannot
> > connect with this 'current' version of wpa_supplicant.
>
> Right. So I should have asked about the wpa_supplicant from the start. Le=
t
> me work on patch for debugging this based on git version (SHA1: c9db4925f=
).
>
> Regards,
> Arend
>
Arend,

I ran across this note today and investigated it with the
wpa_supplicant I am now using:
https://github.com/raspberrypi/linux/pull/5945

It still will not connect with this firmware
# dmesg | grep brcmfm
[    1.995113] brcmfmac: F1 signature read @0x18000000=3D0x15264345
[    2.002317] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    2.002497] usbcore: registered new interface driver brcmfmac
[    2.223405] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    2.224010] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
01-b677b91b
[  109.454302] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save enabled
[  109.508572] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save disabled
[  113.543122] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail, reaso=
n -52

this config:
# cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
update_config=3D1
 network=3D{
  ssid=3D"deskSAE"
  sae_password=3D"secret123"
  proto=3DRSN
  key_mgmt=3DSAE
  ieee80211w=3D2
}

# wpa_supplicant -v
wpa_supplicant v2.11-devel-hostap_2_10-2215-gc9db4925f
Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors

# wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
...
nl80211: kernel reports: Match already configured
wlan0: Authentication with d8:3a:dd:60:a3:0c timed out.
wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 seco=
nds
nl80211: send_event_marker failed: Source based routing not supported
wlan0: CTRL-EVENT-DISCONNECTED bssid=3Dd8:3a:dd:60:a3:0c reason=3D3
locally_generated=3D1
wlan0: BSSID d8:3a:dd:60:a3:0c ignore list count incremented to 2,
ignoring for 10 seconds
wlan0: CTRL-EVENT-DSCP-POLICY clear_all
wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DCORE type=3DWORLD
wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DUSER type=3DCOUNTRY alpha2=3DUS
wlan0: Trying to associate with SSID 'deskSAE'
...


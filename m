Return-Path: <linux-wireless+bounces-9792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243391E9DB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FE2B21A71
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A716F0DD;
	Mon,  1 Jul 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzrvyvI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBF1366
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867271; cv=none; b=B10dhMX2iStWKq7WDXz3xNbC9Cv1LLvWSEGWbi2fQPwBJTd1NY7vbRz2FbdPyKH8TkGlJmBDL3LNmu0ghVIBQquBXRrzaO1FvOsvNY+yaynPfBuT99R5QnS2ANowmyiALKmVSh8jtcuw+pR6lZWrcYrEUgvSFGEb5QWpNhGiwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867271; c=relaxed/simple;
	bh=NFJfNoPeYjmh6dJpUN6LZGtZDBooYMCFHfeYkyXaWY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvAQOefdFkNWWH2X+eZovsLlpjO9QLn2tQr/hLejL/Yn9Ziwf4cBszSym+27Bc/TGBHQivXtmCtl0H+uCpVb2Jxdr+JhuKvm8q1TSWg3XIXayl1tftlfsfDcnVGUnUenvln7TLdt8PNP6sjjzq5jN2XxjCh0uFe7UwjGqrbZBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzrvyvI7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso18730345ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719867269; x=1720472069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HFTYzmm13ie+IEkwt6GXk/sECDX32j+EYnHbWOognE=;
        b=EzrvyvI77lp23ysNau/s1gDPxjmotG0IHb1C0pwkGgafoUDXUzof3ixmRrNr7snX1Q
         5MLC45nGqsNAEZ0bIZXS+YS3Rtu1ukKlWlxtkeTBeBWEJGbHz5fzRfIUnXQ/sfaLEQ/y
         O61A4iDbhibityyq7OBOdMhQTCOkohk6AEAs6OzLLsUf6EjKLbqpzau2LeIg63XWRq/T
         vSV0Sq1mwsxvZY5nRv4UYd7qeR8KDilpOwz5nSFioSfekVQfngAAXBg5p3KBk4zPQwxw
         VEjJOe5W5nhakMHZ5kLlcxaja5vHDBhJWUGplSNA5dJ4T1ykuMCwYkTy7KNFxWCs1ccT
         urjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719867269; x=1720472069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HFTYzmm13ie+IEkwt6GXk/sECDX32j+EYnHbWOognE=;
        b=ARW5ECzSDUE0kyofaUmn7Lki2kOwJ/eZE6nfKAVFWLqrcrhgSFhzujtXX8jAk/6f+t
         CsefTvydm2g7AZ37Ffa1LA/G0VhYl+uxL7FvhLcZHPAqoWvk4xzmhEGbaQOYHcIrIhoU
         1fcZieHB+43rqDOKhVMprl5lVPVJYcO/ncW6i/JqCbKuFNtsgnLrydfxFJmgzJzUX6li
         i2XliBWZin8BbTasqd6CAynX0ucQQjfmqfjbQgSNQqrGnS+LEn1FUja09Jwbbvxq1qGT
         T4xutk6W5cqQSI1VBWDsxFrGAkRlpk3+8OlNt8gSKAVt2v8mjunrDFmYoc1oVnopMH+M
         15qA==
X-Forwarded-Encrypted: i=1; AJvYcCXaMdSsbTTo+hLTCTdZSL2JVngQb4epdU8Y5G8P/bLu0PklkQg5lG+x/qXl1TecnR1XbH90PgLaQvS2ae1t1JVvWchJPl6PVz8hMxOOEuY=
X-Gm-Message-State: AOJu0Ywd2G3EWgg+yAoTRnmbQj/l90ZERQuVVzRlNdni8Cw82X0k0QuD
	Jhj35pOVkeO97JbiQR40acK8LMq5c7+Cztyi4w5Q4GIUn0ocgs5kEZLBxZGQYxHxxf48NlI2oIk
	LqnGyFZzGwtoLsEqkcqL9jXD8qYjaoqLKYmw=
X-Google-Smtp-Source: AGHT+IEtfEiURuRocKhXIW9m9YS6aNk4QZ/4jsFbl7iydvnNeIzjXxVtrrV/wwkHizencSQgZufDISmBmmlC2Wrffhk=
X-Received: by 2002:a17:90b:1bc1:b0:2c8:e68f:d3b8 with SMTP id
 98e67ed59e1d1-2c93d70976amr3365617a91.16.1719867268946; Mon, 01 Jul 2024
 13:54:28 -0700 (PDT)
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
 <CAG17S_OMU2QbeMnue+RWqFErhbPKVCmFR90VMOYkVy+aMcdoBQ@mail.gmail.com>
 <1905a29df60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_OL+zskWOQty2rzZG8+Ddb+qeR4bQYCZ53qJ00-9QVeiQ@mail.gmail.com>
In-Reply-To: <CAG17S_OL+zskWOQty2rzZG8+Ddb+qeR4bQYCZ53qJ00-9QVeiQ@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 1 Jul 2024 15:54:17 -0500
Message-ID: <CAG17S_Ngcgvg9i5S-DixKDXn0-nZuS=0_=gT0bL2HxyYS_zK3Q@mail.gmail.com>
Subject: Re: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi: brcmsmac:
 advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, Jouni Malinen <j@w1.fi>, hostap@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:08=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Thu, Jun 27, 2024 at 9:46=E2=80=AFAM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On June 27, 2024 3:46:35 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > > On Thu, Jun 27, 2024 at 6:34=E2=80=AFAM KeithG <ys3al35l@gmail.com> w=
rote:
> > >>
> > >> On Thu, Jun 27, 2024 at 12:01=E2=80=AFAM Arend Van Spriel
> > >> <arend.vanspriel@broadcom.com> wrote:
> > >>>
> > >>> On June 27, 2024 12:47:02 AM KeithG <ys3al35l@gmail.com> wrote:
> > >>>
> > >>>> On Wed, Jun 26, 2024 at 7:30=E2=80=AFAM Arend Van Spriel
> > >>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>
> > >>>>> On June 26, 2024 2:05:07 PM KeithG <ys3al35l@gmail.com> wrote:
> > >>>>>
> > >>>>>> On Wed, Jun 26, 2024 at 2:48=E2=80=AFAM Arend Van Spriel
> > >>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>
> > >>>>>>> On June 21, 2024 2:24:19 PM KeithG <ys3al35l@gmail.com> wrote:
> > >>>>>>>
> > >>>>>>>> On Fri, Jun 21, 2024 at 4:09=E2=80=AFAM Arend van Spriel
> > >>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> > >>>>>>>>>
> > >>>>>>>>> + Jouni
> > >>>>>>>>>
> > >>>>>>>>> On 6/20/2024 8:25 PM, KeithG wrote:
> > >>>>>>>>>> 1718907734.308740: wlan0: WPA: AP group 0x10 network profile=
 group
> > >>>>>>>>>> 0x18; available group 0x10
> > >>>>>>>>>> 1718907734.308748: wlan0: WPA: using GTK CCMP
> > >>>>>>>>>> 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network prof=
ile
> > >>>>>>>>>> pairwise 0x10; available pairwise 0x10
> > >>>>>>>>>> 1718907734.308767: wlan0: WPA: using PTK CCMP
> > >>>>>>>>>> 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network pro=
file
> > >>>>>>>>>> key_mgmt 0x400; available key_mgmt 0x0
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> I suspect the message above indicates the problem as there is=
 no
> > >>>>>>>>> available key_mgmt to select so looked it up in the code and =
here it is:
> > >>>>>>>>>
> > >>>>>>>>> sel =3D ie.key_mgmt & ssid->key_mgmt;
> > >>>>>>>>> #ifdef CONFIG_SAE
> > >>>>>>>>> if ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
> > >>>>>>>>> !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) ||
> > >>>>>>>>> wpas_is_sae_avoided(wpa_s, ssid, &ie))
> > >>>>>>>>> sel &=3D ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
> > >>>>>>>>> WPA_KEY_MGMT_FT_SAE |
> > >>>>>>>>> WPA_KEY_MGMT_FT_SAE_EXT_KEY);
> > >>>>>>>>> #endif /* CONFIG_SAE */
> > >>>>>>>>> #ifdef CONFIG_IEEE80211R
> > >>>>>>>>> if (!(wpa_s->drv_flags & (WPA_DRIVER_FLAGS_SME |
> > >>>>>>>>>         WPA_DRIVER_FLAGS_UPDATE_FT_IES)))
> > >>>>>>>>> sel &=3D ~WPA_KEY_MGMT_FT;
> > >>>>>>>>> #endif /* CONFIG_IEEE80211R */
> > >>>>>>>>> wpa_dbg(wpa_s, MSG_DEBUG,
> > >>>>>>>>> "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
> > >>>>>>>>> available key_mgmt 0x%x",
> > >>>>>>>>> ie.key_mgmt, ssid->key_mgmt, sel);
> > >>>>>>>>>
> > >>>>>>>>> So 0x400 matches the expectation:
> > >>>>>>>>>
> > >>>>>>>>> #define WPA_KEY_MGMT_SAE BIT(10)
> > >>>>>>>>>
> > >>>>>>>>> You already confirmed that the driver reports SAE and SAE off=
load
> > >>>>>>>>> support. So it seems wpas_is_sae_avoided() must return true. =
That will
> > >>>>>>>>> check whether the AP and network profile are setup to MFP. Th=
is seems to
> > >>>>>>>>> be the fact as your hostapd.conf and wpa_supplicant.conf both=
 have
> > >>>>>>>>> ieee80211w=3D2 defined. This function can only return true wh=
en
> > >>>>>>>>> is enabled in configuration file:
> > >>>>>>>>>
> > >>>>>>>>> # sae_check_mfp: Require PMF support to select SAE key_mgmt
> > >>>>>>>>> # 0 =3D Do not check PMF for SAE (default)
> > >>>>>>>>> # 1 =3D Limit SAE when PMF is not enabled
> > >>>>>>>>> #
> > >>>>>>>>> # When enabled SAE will not be selected if PMF will not be us=
ed
> > >>>>>>>>> # for the connection.
> > >>>>>>>>> # Scenarios where this check will limit SAE:
> > >>>>>>>>> #  1) ieee80211w=3D0 is set for the network
> > >>>>>>>>> #  2) The AP does not have PMF enabled.
> > >>>>>>>>> #  3) ieee80211w is unset, pmf=3D1 is enabled globally, and
> > >>>>>>>>> #     the device does not support the BIP cipher.
> > >>>>>>>>> # Consider the configuration of global parameterss sae_check_=
mfp=3D1,
> > >>>>>>>>> pmf=3D1 and a
> > >>>>>>>>> # network configured with ieee80211w unset and key_mgmt=3DSAE=
 WPA-PSK.
> > >>>>>>>>> # In the example WPA-PSK will be used if the device does not =
support
> > >>>>>>>>> # the BIP cipher or the AP has PMF disabled.
> > >>>>>>>>> # Limiting SAE with this check can avoid failing to associate=
 to an AP
> > >>>>>>>>> # that is configured with sae_requires_mfp=3D1 if the device =
does
> > >>>>>>>>> # not support PMF due to lack of the BIP cipher.
> > >>>>>>>>>
> > >>>>>>>>> The default is not to check it and you wpa_supplicant.conf do=
es not
> > >>>>>>>>> specify it.
> > >>>>>>>>>
> > >>>>>>>>> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> > >>>>>>>>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> > >>>>>>>>> update_config=3D1
> > >>>>>>>>> network=3D{
> > >>>>>>>>> ssid=3D"deskSAE"
> > >>>>>>>>> sae_password=3D"secret123"
> > >>>>>>>>> proto=3DRSN
> > >>>>>>>>> key_mgmt=3DSAE
> > >>>>>>>>> pairwise=3DCCMP
> > >>>>>>>>> ieee80211w=3D2
> > >>>>>>>>> }
> > >>>>>>>>>
> > >>>>>>>>> $ cat /etc/hostapd/hostapd.conf
> > >>>>>>>>> # interface and driver
> > >>>>>>>>> interface=3Dap0
> > >>>>>>>>> driver=3Dnl80211
> > >>>>>>>>>
> > >>>>>>>>> # WIFI-Config
> > >>>>>>>>> ssid=3DdeskSAE
> > >>>>>>>>> channel=3D1
> > >>>>>>>>> hw_mode=3Dg
> > >>>>>>>>>
> > >>>>>>>>> wpa=3D2
> > >>>>>>>>> wpa_key_mgmt=3DSAE
> > >>>>>>>>> wpa_pairwise=3DCCMP
> > >>>>>>>>> sae_password=3Dsecret123
> > >>>>>>>>> sae_groups=3D19
> > >>>>>>>>> ieee80211w=3D2
> > >>>>>>>>> sae_pwe=3D0
> > >>>>>>>>>
> > >>>>>>>>> Regards,
> > >>>>>>>>> Arend
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>> 1718907734.308779: wlan0: WPA: Failed to select authenticate=
d key
> > >>>>>>>>>> management type
> > >>>>>>>>>> 1718907734.308787: wlan0: WPA: Failed to set WPA key managem=
ent and
> > >>>>>>>>>> encryption suites
> > >>>>>>>>
> > >>>>>>>> Arend,
> > >>>>>>>>
> > >>>>>>>> I find the wpa_supplicant docs really hard to understand. I ha=
ve read
> > >>>>>>>> through your response a few times and am still a bit confused.=
 Does
> > >>>>>>>> this have to do with a pure wpa3 versus a wpa2/3 AP?
> > >>>>>>>
> > >>>>>>> Correct. If I am not mistaken MFP aka PMF aka 802.11w is mandat=
ory for WPA3.
> > >>>>>>>
> > >>>>>>>> I have tried editing my hostapd.conf and my wpa_supplicant.con=
f and
> > >>>>>>>> still cannot get a connection, so I must be doing something wr=
ong.
> > >>>>>>>> I commented the ieee80211w line on both and it would not conne=
ct.
> > >>>>>>>> I tried changing the wpa_key_mgmt on both ends to be 'SAE WPA_=
PSK' and
> > >>>>>>>> it still would not connect.
> > >>>>>>>>
> > >>>>>>>> What *should* the configurations be in the hostapd.conf and
> > >>>>>>>> wpa_supplicant.conf to negotiate this as a pure wpa3 setup? Wh=
at
> > >>>>>>>> should it be to be a wpa2/3 setup? My phone worked fine to con=
nect
> > >>>>>>>> with the original hostapd setup, but I have no idea what it is=
 doing
> > >>>>>>>
> > >>>>>>> As I mentioned in my previous email both config files listed ab=
ove look
> > >>>>>>> okay to me (might be wrong though). The problem seems to be wit=
h
> > >>>>>>> wpas_is_sae_avoided(). For it to return true the config should =
have:
> > >>>>>>>
> > >>>>>>> sae_check_mfp=3D1
> > >>>>>>>
> > >>>>>>> But you don't have that and default is 0 so it should check for=
 MFP. This
> > >>>>>>> is where my trail ends. To learn more I would add additional de=
bug prints.
> > >>>>>>> Are you comfortable rebuilding wpa_supplicant from source?
> > >>>>>>>
> > >>>>>>> Regards,
> > >>>>>>> Arend
> > >>>>>>
> > >>>>>> Arend,
> > >>>>>>
> > >>>>>> Thanks for the reply. I could try to rebuild wpa_supplicant from
> > >>>>>> source. This is on RPi, so debian *.debs which are a pain, but I=
 think
> > >>>>>> I can do it.
> > >>>>>>
> > >>>>>> Do I understand correctly that 'sae_check_mfp=3D1' is supposed t=
o be in
> > >>>>>> the hostapd.conf and wpa_supplicant.conf? I can try that and see=
 if
> > >>>>>> anything changes.
> > >>>>>
> > >>>>> Ok. We can try first to put following in wpa_supplicant.conf:
> > >>>>>
> > >>>>> sae_check_mfp=3D0
> > >>>>>
> > >>>>> Let me know if that makes any difference.
> > >>>>>
> > >>>>>> Why would I have to re-build wpa_supplicant?
> > >>>>>
> > >>>>> I would provide a patch with additional debug prints so I get bet=
ter
> > >>>>> understanding what is going wrong. Would be great if you can appl=
y that and
> > >>>>> rebuild.
> > >>>>>
> > >>>>> Regards,
> > >>>>> Arend
> > >>>> Arend,
> > >>>>
> > >>>> I was able to try it this afternoon.
> > >>>> My hostapd is still:
> > >>>> # interface and driver
> > >>>> interface=3Dap0
> > >>>> driver=3Dnl80211
> > >>>>
> > >>>> # WIFI-Config
> > >>>> ssid=3DdeskSAE
> > >>>> channel=3D1
> > >>>> hw_mode=3Dg
> > >>>>
> > >>>> wpa=3D2
> > >>>> wpa_key_mgmt=3DSAE
> > >>>> wpa_pairwise=3DCCMP
> > >>>> sae_password=3Dsecret123
> > >>>> sae_groups=3D19
> > >>>> ieee80211w=3D2
> > >>>> sae_pwe=3D0
> > >>>>
> > >>>> and I can still connect from my phone to this AP.
> > >>>>
> > >>>> I tried this as my /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> > >>>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> > >>>> update_config=3D1
> > >>>> network=3D{
> > >>>> ssid=3D"deskSAE"
> > >>>> sae_password=3D"secret123"
> > >>>> proto=3DRSN
> > >>>> key_mgmt=3DSAE
> > >>>> pairwise=3DCCMP
> > >>>> ieee80211w=3D2
> > >>>> sae_check_mfp=3D1
> > >>>> }
> > >>>>
> > >>>> and when I try to connect, I get:
> > >>>> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wl=
an0.conf
> > >>>> Successfully initialized wpa_supplicant
> > >>>> Line 10: unknown network field 'sae_check_mfp'.
> > >>>> Line 11: failed to parse network block.
> > >>>
> > >>> Right. The setting sae_check_mfp is a global setting like update_co=
nfig. So
> > >>> it should be moved outside the network block.
> > >>>
> > >>> Regards,
> > >>> Arend
> > >> Arend,
> > >>
> > >> Thanks for the hand holding, I am out of my depth here!
> > >>
> > >> I tried this config and get a similar result.
> > >> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> > >> update_config=3D1
> > >> sae_check_mfp=3D1
> > >> network=3D{
> > >> ssid=3D"deskSAE"
> > >> sae_password=3D"secret123"
> > >> proto=3DRSN
> > >> key_mgmt=3DSAE
> > >> pairwise=3DCCMP
> > >> ieee80211w=3D2
> > >> }
> > >> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan=
0.conf
> > >> Successfully initialized wpa_supplicant
> > >> Line 3: unknown global field 'sae_check_mfp=3D1'.
> > >> Line 3: Invalid configuration line 'sae_check_mfp=3D1'.
> > >> Failed to read or parse configuration
> > >> '/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'.
> > >> : CTRL-EVENT-DSCP-POLICY clear_all
> > >>
> > >> seems it doesn't recognize this parameter.
> > >>
> > >> Keith
> > >
> > > Replying to my own post.
> > > I re-built wpa_supplicant from the current git:
> > > # wpa_supplicant -v
> > > wpa_supplicant v2.11-devel-hostap_2_10-2215-gc9db4925f
> > > Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
> > >
> > > It now seems to recognize the 'sae_check_mfp' parameter, but still
> > > does not connect:
> > > # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0=
.conf
> > > Successfully initialized wpa_supplicant
> > > wlan0: Trying to associate with SSID 'deskSAE'
> > > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> > > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 1=
0 seconds
> > > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > > wlan0: Trying to associate with SSID 'deskSAE'
> > > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> > > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 1=
0 seconds
> > > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > > wlan0: Trying to associate with SSID 'deskSAE'
> > > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> > > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 1=
0 seconds
> > > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > > wlan0: Trying to associate with SSID 'deskSAE'
> > > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> > > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 1=
0 seconds
> > > wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"deskSAE"
> > > auth_failures=3D1 duration=3D10 reason=3DCONN_FAILED
> > > wlan0: CTRL-EVENT-SSID-REENABLED id=3D0 ssid=3D"deskSAE"
> > > wlan0: BSSID d8:3a:dd:60:a3:0c ignore list count incremented to 2,
> > > ignoring for 10 seconds
> > > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > > wlan0: Trying to associate with SSID 'deskSAE'
> > > wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> > > wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 1=
0 seconds
> > > wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"deskSAE"
> > > auth_failures=3D2 duration=3D20 reason=3DCONN_FAILED
> > > ^Cp2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > > p2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > > nl80211: deinit ifname=3Dp2p-dev-wlan0 disabled_11b_rates=3D0
> > > p2p-dev-wlan0: CTRL-EVENT-TERMINATING
> > > wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > > wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> > > wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> > > nl80211: deinit ifname=3Dwlan0 disabled_11b_rates=3D0
> > > wlan0: CTRL-EVENT-TERMINATING
> > >
> > > I tried setting the 'sae_check_mfp' to both 1 and 0 and still cannot
> > > connect with this 'current' version of wpa_supplicant.
> >
> > Right. So I should have asked about the wpa_supplicant from the start. =
Let
> > me work on patch for debugging this based on git version (SHA1: c9db492=
5f).
> >
> > Regards,
> > Arend
> >
> Arend,
>
> I ran across this note today and investigated it with the
> wpa_supplicant I am now using:
> https://github.com/raspberrypi/linux/pull/5945
>
> It still will not connect with this firmware
> # dmesg | grep brcmfm
> [    1.995113] brcmfmac: F1 signature read @0x18000000=3D0x15264345
> [    2.002317] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    2.002497] usbcore: registered new interface driver brcmfmac
> [    2.223405] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=3D-2)
> [    2.224010] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
> 01-b677b91b
> [  109.454302] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save enable=
d
> [  109.508572] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save disabl=
ed
> [  113.543122] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail, rea=
son -52
>
> this config:
> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> update_config=3D1
>  network=3D{
>   ssid=3D"deskSAE"
>   sae_password=3D"secret123"
>   proto=3DRSN
>   key_mgmt=3DSAE
>   ieee80211w=3D2
> }
>
> # wpa_supplicant -v
> wpa_supplicant v2.11-devel-hostap_2_10-2215-gc9db4925f
> Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
>
> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.con=
f
> ...
> nl80211: kernel reports: Match already configured
> wlan0: Authentication with d8:3a:dd:60:a3:0c timed out.
> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 se=
conds
> nl80211: send_event_marker failed: Source based routing not supported
> wlan0: CTRL-EVENT-DISCONNECTED bssid=3Dd8:3a:dd:60:a3:0c reason=3D3
> locally_generated=3D1
> wlan0: BSSID d8:3a:dd:60:a3:0c ignore list count incremented to 2,
> ignoring for 10 seconds
> wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DCORE type=3DWORLD
> wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DUSER type=3DCOUNTRY alpha2=3DUS
> wlan0: Trying to associate with SSID 'deskSAE'
> ...
Take that and reverse it...
I was having a conflict and figured out that:
wpa_supplicant.service was running and failed to connect as it did not
have the proper config for teh SSID in question.

Once I stopped the service and tried to connect via cli, I was able to
get it to do so and was able to verify the connection worked:

# wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
Successfully initialized wpa_supplicant
nl80211: kernel reports: Registration to specific type not supported
wlan0: Trying to associate with SSID 'deskSAE'
wlan0: PMKSA-CACHE-ADDED d8:3a:dd:60:a3:0c 0
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
wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DCORE type=3DWORLD
wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DUSER type=3DCOUNTRY alpha2=3DUS
wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
wlan0: Trying to associate with SSID 'deskSAE'
wlan0: Associated with d8:3a:dd:60:a3:0c
wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
wlan0: WPA: Key negotiation completed with d8:3a:dd:60:a3:0c [PTK=3DCCMP GT=
K=3DCCMP]
wlan0: CTRL-EVENT-CONNECTED - Connection to d8:3a:dd:60:a3:0c
completed [id=3D0 id_str=3D]
ctrl c to break and restart
# wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.co=
nf
Successfully initialized wpa_supplicant
nl80211: kernel reports: Registration to specific type not supported
# dhclient wlan0
# ifconfig wlan0
wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.5.177  netmask 255.255.255.0  broadcast 192.168.5.255
        inet6 fe80::da3a:ddff:fed2:ae3c  prefixlen 64  scopeid 0x20<link>
        ether d8:3a:dd:d2:ae:3c  txqueuelen 1000  (Ethernet)
        RX packets 46  bytes 8973 (8.7 KiB)
        RX errors 0  dropped 4  overruns 0  frame 0
        TX packets 107  bytes 20686 (20.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

so, it appears that SAE does work, but you need to have a newer
cyfmac.bin file than what is shipped on the RPis.
This is what is reported, currently:
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

I do get a ton of this in the log, though:
[  113.543122] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail, reaso=
n -52
...


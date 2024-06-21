Return-Path: <linux-wireless+bounces-9429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E61912512
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B183F1F22A5E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4C1509B9;
	Fri, 21 Jun 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX+/GzZi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474C129A7E
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972660; cv=none; b=WLp5UwXBwUPlYuFAswNF5ykRQBmqY5cQYLs9FpkJ+GWjkvuYIsqJojmLbr3zlA116VYRNNjBKmmmBAP/SJlsBxesZJpqBpHCnWfNRvyVMpNmqVhwmK34KZvTTyHQfe5bq8azSTdXdOVlboJ3slev5uJnY7whkIAZ+uAk6CuX3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972660; c=relaxed/simple;
	bh=5csl0XyUsUFBmGcXYKqBD7NYTRwWEbtOFTnmkgrY90k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+QD8j7LAqUuIDHdTbABcac4GO8jmqRGXiUEJLG+NRS6hMLJe+AMrtCHYfVpDGbIHGRDqHGf2gXfAlgT2yuTYTkDQRDtD+ZNJ6iw/OdIEcdmwbjxgcbaGKc6MNp42J1LAzZfI5g8jXITG5b88p20Vh00N7JwONxeAekjKs76F5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX+/GzZi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9885d5c04so17451915ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718972658; x=1719577458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BYumKzEPIJ2+taQ2EhhDzMepCVQ30/T2f5DONRpdSs=;
        b=UX+/GzZiRHbR5AHyb5JBJsA2jAGN++FUYLFK2MSuh4PyKIVHbs4X/kAd8X+HMb5gIc
         eYIWQcz2pAqfJdBifhRutxthbRFEweDpLZWdY9kUua2Amx9RCBR0vkFBQF+H1DNEtaPX
         xQmKMpeMG6hhoUdo3UOoyzKPvw9cBAdKHDmjGh3DWwqz6ltjqQDcwxiTKldCPsjahzD6
         vwc9bBjqXlF9wlA4fUwRlZRokoUsdt5Oxv7BcQHMtAS00hDAflWDzfrRd/uOdWq3do98
         BF7ysvuA+4K339SufC6dqwYmL2k5/O7bxgLRSMOw1yPuxgTYrD8Z7N1Ray1/Bu/EjTu0
         JxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718972658; x=1719577458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BYumKzEPIJ2+taQ2EhhDzMepCVQ30/T2f5DONRpdSs=;
        b=tg320/7Fj3VUi/BL3e5hTBdm7c5jPoOpsgWAUqmtu7SNCH3Yup2lr80IVfS85DW3u6
         l0hH9NV/5oRdEa7me+WL5ylZ3IDXtMpcjH0VRtPie4um/ZqKdLN6+d22XnMp7hBiRLGg
         UkfgMTYLdyp6tMRaeZW4iLpuFbzcepWkAJ15KoVjtPf2WzX813rZB5BQwGGJEFsC4u7M
         ht6L2icLIf6wZJrVp8nL0RjsGeVxrqeqKfu8ZvXrhrRz12xPB9uEkRy5IYXkGuVahIyh
         XhsX5O5uf/DSDS7QIHgxrdjveKh+LqSISvWhZ6eo32u9n0EJKocixGbMbNtrBBOOGoAG
         Xa0A==
X-Forwarded-Encrypted: i=1; AJvYcCVFiRTPYkl2iStJk9r+ZWEnRnY5l33++kN4sjDI/0PTxfPVPonuM6SC2KdDkMFHloAzhpwqR2csHwSbl2yBuxT2RQ2pTXRStRRTB36IqP4=
X-Gm-Message-State: AOJu0YxXU2/7Y6vgTe1a3Wrj0dfxn+M+GpIrz48Q8xrj6AX72maUdeLb
	z3WaZHIHGijuQ326TNzzNIIefV/orhnVLDIAYgyDwpNoFKb4rZGGTuHys3aaKB9THNGEFDQIIbt
	gELMeHJcrAeGXEdaEod1NRWAoyxk=
X-Google-Smtp-Source: AGHT+IEWBsNVTlvhs50CF8JnWTKI2VGnKt2kIVugsk6+ZnQUzHoHmHezWliJZkRGinJTPi8O02jupyNweYr7XXtBLpk=
X-Received: by 2002:a17:90a:c287:b0:2c7:8fac:48bf with SMTP id
 98e67ed59e1d1-2c7b57f3c03mr8267831a91.2.1718972658513; Fri, 21 Jun 2024
 05:24:18 -0700 (PDT)
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
 <CAG17S_NHC7EqUMtc58eSY9Yoq4K0mvp=C1rcP8PTRzajXW3Csg@mail.gmail.com> <c065ae75-f89e-4b14-9fc3-6ef19e6d144b@broadcom.com>
In-Reply-To: <c065ae75-f89e-4b14-9fc3-6ef19e6d144b@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 21 Jun 2024 07:24:06 -0500
Message-ID: <CAG17S_OMV5TpCO+XwP-6dQNB_zVs+OCoawpngZUshuDOgFOF0w@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, Jouni Malinen <j@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:09=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> + Jouni
>
> On 6/20/2024 8:25 PM, KeithG wrote:
> > 1718907734.308740: wlan0: WPA: AP group 0x10 network profile group
> > 0x18; available group 0x10
> > 1718907734.308748: wlan0: WPA: using GTK CCMP
> > 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network profile
> > pairwise 0x10; available pairwise 0x10
> > 1718907734.308767: wlan0: WPA: using PTK CCMP
> > 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network profile
> > key_mgmt 0x400; available key_mgmt 0x0
>
>
> I suspect the message above indicates the problem as there is no
> available key_mgmt to select so looked it up in the code and here it is:
>
>          sel =3D ie.key_mgmt & ssid->key_mgmt;
> #ifdef CONFIG_SAE
>          if ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
>               !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) |=
|
>              wpas_is_sae_avoided(wpa_s, ssid, &ie))
>                  sel &=3D ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
>                           WPA_KEY_MGMT_FT_SAE |
> WPA_KEY_MGMT_FT_SAE_EXT_KEY);
> #endif /* CONFIG_SAE */
> #ifdef CONFIG_IEEE80211R
>          if (!(wpa_s->drv_flags & (WPA_DRIVER_FLAGS_SME |
>                                    WPA_DRIVER_FLAGS_UPDATE_FT_IES)))
>                  sel &=3D ~WPA_KEY_MGMT_FT;
> #endif /* CONFIG_IEEE80211R */
>          wpa_dbg(wpa_s, MSG_DEBUG,
>                  "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
> available key_mgmt 0x%x",
>                  ie.key_mgmt, ssid->key_mgmt, sel);
>
> So 0x400 matches the expectation:
>
> #define WPA_KEY_MGMT_SAE BIT(10)
>
> You already confirmed that the driver reports SAE and SAE offload
> support. So it seems wpas_is_sae_avoided() must return true. That will
> check whether the AP and network profile are setup to MFP. This seems to
> be the fact as your hostapd.conf and wpa_supplicant.conf both have
> ieee80211w=3D2 defined. This function can only return true when
> sae_check_mfp is enabled in configuration file:
>
> # sae_check_mfp: Require PMF support to select SAE key_mgmt
> # 0 =3D Do not check PMF for SAE (default)
> # 1 =3D Limit SAE when PMF is not enabled
> #
> # When enabled SAE will not be selected if PMF will not be used
> # for the connection.
> # Scenarios where this check will limit SAE:
> #  1) ieee80211w=3D0 is set for the network
> #  2) The AP does not have PMF enabled.
> #  3) ieee80211w is unset, pmf=3D1 is enabled globally, and
> #     the device does not support the BIP cipher.
> # Consider the configuration of global parameterss sae_check_mfp=3D1,
> pmf=3D1 and a
> # network configured with ieee80211w unset and key_mgmt=3DSAE WPA-PSK.
> # In the example WPA-PSK will be used if the device does not support
> # the BIP cipher or the AP has PMF disabled.
> # Limiting SAE with this check can avoid failing to associate to an AP
> # that is configured with sae_requires_mfp=3D1 if the device does
> # not support PMF due to lack of the BIP cipher.
>
> The default is not to check it and you wpa_supplicant.conf does not
> specify it.
>
> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> update_config=3D1
> network=3D{
>   ssid=3D"deskSAE"
>   sae_password=3D"secret123"
>   proto=3DRSN
>   key_mgmt=3DSAE
>   pairwise=3DCCMP
>   ieee80211w=3D2
> }
>
> $ cat /etc/hostapd/hostapd.conf
> # interface and driver
> interface=3Dap0
> driver=3Dnl80211
>
> # WIFI-Config
> ssid=3DdeskSAE
> channel=3D1
> hw_mode=3Dg
>
> wpa=3D2
> wpa_key_mgmt=3DSAE
> wpa_pairwise=3DCCMP
> sae_password=3Dsecret123
> sae_groups=3D19
> ieee80211w=3D2
> sae_pwe=3D0
>
> Regards,
> Arend
>
>
> > 1718907734.308779: wlan0: WPA: Failed to select authenticated key
> > management type
> > 1718907734.308787: wlan0: WPA: Failed to set WPA key management and
> > encryption suites

Arend,

I find the wpa_supplicant docs really hard to understand. I have read
through your response a few times and am still a bit confused. Does
this have to do with a pure wpa3 versus a wpa2/3 AP?

I have tried editing my hostapd.conf and my wpa_supplicant.conf and
still cannot get a connection, so I must be doing something wrong.
I commented the ieee80211w line on both and it would not connect.
I tried changing the wpa_key_mgmt on both ends to be 'SAE WPA_PSK' and
it still would not connect.

What *should* the configurations be in the hostapd.conf and
wpa_supplicant.conf to negotiate this as a pure wpa3 setup? What
should it be to be a wpa2/3 setup? My phone worked fine to connect
with the original hostapd setup, but I have no idea what it is doing.

Regards,

Keith


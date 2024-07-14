Return-Path: <linux-wireless+bounces-10215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B9930B3A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2024 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD461C20878
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2024 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D313C8F6;
	Sun, 14 Jul 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iekr4xhK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880511CB8
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jul 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720982530; cv=none; b=MNQ7dj//nRflaVn3n9tkPdHiUtWOD2VLRBjenmT+ClmjXNpnQ1KSP/NxE//pfYKtoXSvgt/4WmsZ/uu88+1uHrLPn1hmvmjCETDgbQbLsTdkGVHTsZi7LlJe37lqHILL/K5MukAHQrqn3hgrfDvjuLF1YzHp5BoYfBPEqzodAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720982530; c=relaxed/simple;
	bh=eDUVZB9zNPCiiK0smkXL5J9oXjOw/hEnw1Nn2CZ2nwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFvUcSR4ob16KUJyAAZXEPhM8XAmMtYqDlvzHPNKNqsuUzL7n/nZ1KRc7nUk7h442Xt1Jp+R35bcLWz14i1Ci4j/XBkd3d0WtYGwct/03tIDARbM9ThLIVh6hy5K/T34k84zXiYMBG5ObYR5SMyeVzLEWNj9d/98ag81qEnL4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iekr4xhK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b702be5e4so1555552b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jul 2024 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720982527; x=1721587327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fgdVhvYOf55lDDYn6TBrSIUwo03j+rIcEC5RkoaU98=;
        b=iekr4xhKmESeWTOFWoqaVbsiQAxXecdWZvVPPQlI5vwL/i8LA4fGs4FyZ27WdGzt3w
         u0mfRCBFcz8aK3KK7ld4H6NLeESpGkjE27cmgey+5mEsDK8NOVGl9qVkxI0JwU6ARmAi
         sBlqQSnTZUPCL68wF+ss4BciP3CscPpf7FY+1GU41wbLD9I48yQ76YAKhGrDWiwFooj3
         2VFZ48B9Ku/e9UtoffBGwtN8xlUY19SxCojQd+KsUUDfnP5SBkWPfbRxfyjeZxqLKj9/
         FxmUo8vTEGIoDtcBEOieUwLM6mMGqv1GKocsgI/tFXbxvp1FpuoXgIo/kBwY9c6fC6bB
         2odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720982527; x=1721587327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fgdVhvYOf55lDDYn6TBrSIUwo03j+rIcEC5RkoaU98=;
        b=OsqoY5/lyV9xOsqeoW85dQo1Y2gBiI2BQFwMVq5VM7fKMcpGDqS3hGetodJiWbk1Tx
         7VUZdVvY99myirS+GLkq740Y2ApDdKhVVLVjVi+vlmPbX0+tN6QkbOMMF6FB1Np5ZMMq
         1b6vDbZPB6EDgOFRtx/gWmFqPdHCiT6VOgrNa8RS8zLPl3mOOwDhUve2GVrBgGtER/L1
         PkQ8Hv3tf3dJQ7YTa/LwCyXttSc8eveVs4n8Y/x5HrabR76EqaEQLmoUlJTBC3i8QaYE
         T3ZUeeE0OHvg+7IahTTlBRYO49EqV0kl0+UbPn12ySzIH6bImm4Aif+8vozI2nY4A29d
         9JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIlCCvMwoj61T2fjGDoBKct1vLSZo1fAUNdOvYAyfO5LyfdBQYbQFiqfo3tvx1Z11M1RepGixoMtEz3tnhc29Mbzeg5ybetDfwhVyLXsQ=
X-Gm-Message-State: AOJu0YzINxUE08xV80poYA91ZAiZVtSW9+qSTgm+qLZjSGOpPC5w/60K
	u0vaYTwzbYbRNFc3PnQGX+MPKk4SR0xYpp8XyN1/+l9Fi26zupFaJ8dw0PbcdU8hxjWrakfzVsa
	Wf5jfkorxWOqqG+OuVRbnJTzkZbMG/6e0
X-Google-Smtp-Source: AGHT+IHozsKLN4DdKZ0nrPq/3eL8jcgakM53BT5Dtbf/DQqPFev1piSzYWnBn6hMRbrIxsnAiIvyuR0DNs07LU51Aw0=
X-Received: by 2002:a05:6a21:6e4b:b0:1c3:b211:67e3 with SMTP id
 adf61e73a8af0-1c3b211680fmr14053777637.50.1720982527471; Sun, 14 Jul 2024
 11:42:07 -0700 (PDT)
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
 <AS4PR10MB5575530BE31A71DC652B45F6F4DA2@AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM>
 <190ac032a58.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <190ac032a58.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 14 Jul 2024 13:42:00 -0500
Message-ID: <CAG17S_OXfEk+nxuNJ8ZYrGMAh4RxCuEGbEJ1b6dvbe7Qs+B4Pw@mail.gmail.com>
Subject: Re: AW: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi:
 brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: "Dembianny Sven (BSH GDE-EDSD5)" <Sven.Dembianny@bshg.com>, Peter Robinson <pbrobinson@gmail.com>, 
	Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	Jouni Malinen <j@w1.fi>, hostap@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 7:13=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On July 8, 2024 1:33:02 PM "Dembianny Sven (BSH GDE-EDSD5)"
> <Sven.Dembianny@bshg.com> wrote:
>
> >> On Thu, Jun 27, 2024 at 6:34=E2=80=AFAM KeithG <ys3al35l@gmail.com> wr=
ote:
> >>>
> >>> On Thu, Jun 27, 2024 at 12:01=E2=80=AFAM Arend Van Spriel
> >>> <arend.vanspriel@broadcom.com> wrote:
> >>>>
> >>>> On June 27, 2024 12:47:02 AM KeithG <ys3al35l@gmail.com> wrote:
> >>>>
> >>>>> On Wed, Jun 26, 2024 at 7:30=E2=80=AFAM Arend Van Spriel
> >>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>
> >>>>>> On June 26, 2024 2:05:07 PM KeithG <ys3al35l@gmail.com> wrote:
> >>>>>>
> >>>>>>> On Wed, Jun 26, 2024 at 2:48=E2=80=AFAM Arend Van Spriel
> >>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>
> >>>>>>>> On June 21, 2024 2:24:19 PM KeithG <ys3al35l@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>>> On Fri, Jun 21, 2024 at 4:09=E2=80=AFAM Arend van Spriel
> >>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> + Jouni
> >>>>>>>>>>
> >>>>>>>>>> On 6/20/2024 8:25 PM, KeithG wrote:
> >>>>>>>>>>> 1718907734.308740: wlan0: WPA: AP group 0x10 network profile
> >>>>>>>>>>> group 0x18; available group 0x10
> >>>>>>>>>>> 1718907734.308748: wlan0: WPA: using GTK CCMP
> >>>>>>>>>>> 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network
> >>>>>>>>>>> profile pairwise 0x10; available pairwise 0x10
> >>>>>>>>>>> 1718907734.308767: wlan0: WPA: using PTK CCMP
> >>>>>>>>>>> 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network
> >>>>>>>>>>> profile key_mgmt 0x400; available key_mgmt 0x0
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I suspect the message above indicates the problem as there is
> >>>>>>>>>> no available key_mgmt to select so looked it up in the code an=
d here it is:
> >>>>>>>>>>
> >>>>>>>>>> sel =3D ie.key_mgmt & ssid->key_mgmt; #ifdef CONFIG_SAE if
> >>>>>>>>>> ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
> >>>>>>>>>> !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) ||
> >>>>>>>>>> wpas_is_sae_avoided(wpa_s, ssid, &ie)) sel &=3D
> >>>>>>>>>> ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
> >>>>>>>>>> WPA_KEY_MGMT_FT_SAE | WPA_KEY_MGMT_FT_SAE_EXT_KEY); #endif /*
> >>>>>>>>>> CONFIG_SAE */ #ifdef CONFIG_IEEE80211R if (!(wpa_s->drv_flags
> >>>>>>>>>> & (WPA_DRIVER_FLAGS_SME |
> >>>>>>>>>>         WPA_DRIVER_FLAGS_UPDATE_FT_IES))) sel &=3D
> >>>>>>>>>> ~WPA_KEY_MGMT_FT; #endif /* CONFIG_IEEE80211R */
> >>>>>>>>>> wpa_dbg(wpa_s, MSG_DEBUG,
> >>>>>>>>>> "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
> >>>>>>>>>> available key_mgmt 0x%x", ie.key_mgmt, ssid->key_mgmt, sel);
> >>>>>>>>>>
> >>>>>>>>>> So 0x400 matches the expectation:
> >>>>>>>>>>
> >>>>>>>>>> #define WPA_KEY_MGMT_SAE BIT(10)
> >>>>>>>>>>
> >>>>>>>>>> You already confirmed that the driver reports SAE and SAE
> >>>>>>>>>> offload support. So it seems wpas_is_sae_avoided() must
> >>>>>>>>>> return true. That will check whether the AP and network
> >>>>>>>>>> profile are setup to MFP. This seems to be the fact as your
> >>>>>>>>>> hostapd.conf and wpa_supplicant.conf both have
> >>>>>>>>>> ieee80211w=3D2 defined. This function can only return true whe=
n
> >>>>>>>>>> is enabled in configuration file:
> >>>>>>>>>>
> >>>>>>>>>> # sae_check_mfp: Require PMF support to select SAE key_mgmt #
> >>>>>>>>>> 0 =3D Do not check PMF for SAE (default) # 1 =3D Limit SAE whe=
n
> >>>>>>>>>> PMF is not enabled # # When enabled SAE will not be selected
> >>>>>>>>>> if PMF will not be used # for the connection.
> >>>>>>>>>> # Scenarios where this check will limit SAE:
> >>>>>>>>>> #  1) ieee80211w=3D0 is set for the network #  2) The AP does
> >>>>>>>>>> not have PMF enabled.
> >>>>>>>>>> #  3) ieee80211w is unset, pmf=3D1 is enabled globally, and
> >>>>>>>>>> #     the device does not support the BIP cipher.
> >>>>>>>>>> # Consider the configuration of global parameterss
> >>>>>>>>>> sae_check_mfp=3D1,
> >>>>>>>>>> pmf=3D1 and a
> >>>>>>>>>> # network configured with ieee80211w unset and key_mgmt=3DSAE =
WPA-PSK.
> >>>>>>>>>> # In the example WPA-PSK will be used if the device does not
> >>>>>>>>>> support # the BIP cipher or the AP has PMF disabled.
> >>>>>>>>>> # Limiting SAE with this check can avoid failing to associate
> >>>>>>>>>> to an AP # that is configured with sae_requires_mfp=3D1 if the
> >>>>>>>>>> device does # not support PMF due to lack of the BIP cipher.
> >>>>>>>>>>
> >>>>>>>>>> The default is not to check it and you wpa_supplicant.conf
> >>>>>>>>>> does not specify it.
> >>>>>>>>>>
> >>>>>>>>>> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >>>>>>>>>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >>>>>>>>>> update_config=3D1
> >>>>>>>>>> network=3D{
> >>>>>>>>>> ssid=3D"deskSAE"
> >>>>>>>>>> sae_password=3D"secret123"
> >>>>>>>>>> proto=3DRSN
> >>>>>>>>>> key_mgmt=3DSAE
> >>>>>>>>>> pairwise=3DCCMP
> >>>>>>>>>> ieee80211w=3D2
> >>>>>>>>>> }
> >>>>>>>>>>
> >>>>>>>>>> $ cat /etc/hostapd/hostapd.conf # interface and driver
> >>>>>>>>>> interface=3Dap0
> >>>>>>>>>> driver=3Dnl80211
> >>>>>>>>>>
> >>>>>>>>>> # WIFI-Config
> >>>>>>>>>> ssid=3DdeskSAE
> >>>>>>>>>> channel=3D1
> >>>>>>>>>> hw_mode=3Dg
> >>>>>>>>>>
> >>>>>>>>>> wpa=3D2
> >>>>>>>>>> wpa_key_mgmt=3DSAE
> >>>>>>>>>> wpa_pairwise=3DCCMP
> >>>>>>>>>> sae_password=3Dsecret123
> >>>>>>>>>> sae_groups=3D19
> >>>>>>>>>> ieee80211w=3D2
> >>>>>>>>>> sae_pwe=3D0
> >>>>>>>>>>
> >>>>>>>>>> Regards,
> >>>>>>>>>> Arend
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> 1718907734.308779: wlan0: WPA: Failed to select
> >>>>>>>>>>> authenticated key management type
> >>>>>>>>>>> 1718907734.308787: wlan0: WPA: Failed to set WPA key
> >>>>>>>>>>> management and encryption suites
> >>>>>>>>>
> >>>>>>>>> Arend,
> >>>>>>>>>
> >>>>>>>>> I find the wpa_supplicant docs really hard to understand. I
> >>>>>>>>> have read through your response a few times and am still a bit
> >>>>>>>>> confused. Does this have to do with a pure wpa3 versus a wpa2/3=
 AP?
> >>>>>>>>
> >>>>>>>> Correct. If I am not mistaken MFP aka PMF aka 802.11w is mandato=
ry for WPA3.
> >>>>>>>>
> >>>>>>>>> I have tried editing my hostapd.conf and my
> >>>>>>>>> wpa_supplicant.conf and still cannot get a connection, so I mus=
t be doing
> >>>>>>>>> something wrong.
> >>>>>>>>> I commented the ieee80211w line on both and it would not connec=
t.
> >>>>>>>>> I tried changing the wpa_key_mgmt on both ends to be 'SAE
> >>>>>>>>> WPA_PSK' and it still would not connect.
> >>>>>>>>>
> >>>>>>>>> What *should* the configurations be in the hostapd.conf and
> >>>>>>>>> wpa_supplicant.conf to negotiate this as a pure wpa3 setup?
> >>>>>>>>> What should it be to be a wpa2/3 setup? My phone worked fine
> >>>>>>>>> to connect with the original hostapd setup, but I have no idea
> >>>>>>>>> what it is doing
> >>>>>>>>
> >>>>>>>> As I mentioned in my previous email both config files listed
> >>>>>>>> above look okay to me (might be wrong though). The problem
> >>>>>>>> seems to be with wpas_is_sae_avoided(). For it to return true th=
e config
> >>>>>>>> should have:
> >>>>>>>>
> >>>>>>>> sae_check_mfp=3D1
> >>>>>>>>
> >>>>>>>> But you don't have that and default is 0 so it should check for
> >>>>>>>> MFP. This is where my trail ends. To learn more I would add addi=
tional
> >>>>>>>> debug prints.
> >>>>>>>> Are you comfortable rebuilding wpa_supplicant from source?
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Arend
> >>>>>>>
> >>>>>>> Arend,
> >>>>>>>
> >>>>>>> Thanks for the reply. I could try to rebuild wpa_supplicant from
> >>>>>>> source. This is on RPi, so debian *.debs which are a pain, but I
> >>>>>>> think I can do it.
> >>>>>>>
> >>>>>>> Do I understand correctly that 'sae_check_mfp=3D1' is supposed to
> >>>>>>> be in the hostapd.conf and wpa_supplicant.conf? I can try that
> >>>>>>> and see if anything changes.
> >>>>>>
> >>>>>> Ok. We can try first to put following in wpa_supplicant.conf:
> >>>>>>
> >>>>>> sae_check_mfp=3D0
> >>>>>>
> >>>>>> Let me know if that makes any difference.
> >>>>>>
> >>>>>>> Why would I have to re-build wpa_supplicant?
> >>>>>>
> >>>>>> I would provide a patch with additional debug prints so I get
> >>>>>> better understanding what is going wrong. Would be great if you
> >>>>>> can apply that and rebuild.
> >>>>>>
> >>>>>> Regards,
> >>>>>> Arend
> >>>>> Arend,
> >>>>>
> >>>>> I was able to try it this afternoon.
> >>>>> My hostapd is still:
> >>>>> # interface and driver
> >>>>> interface=3Dap0
> >>>>> driver=3Dnl80211
> >>>>>
> >>>>> # WIFI-Config
> >>>>> ssid=3DdeskSAE
> >>>>> channel=3D1
> >>>>> hw_mode=3Dg
> >>>>>
> >>>>> wpa=3D2
> >>>>> wpa_key_mgmt=3DSAE
> >>>>> wpa_pairwise=3DCCMP
> >>>>> sae_password=3Dsecret123
> >>>>> sae_groups=3D19
> >>>>> ieee80211w=3D2
> >>>>> sae_pwe=3D0
> >>>>>
> >>>>> and I can still connect from my phone to this AP.
> >>>>>
> >>>>> I tried this as my /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >>>>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >>>>> update_config=3D1
> >>>>> network=3D{
> >>>>> ssid=3D"deskSAE"
> >>>>> sae_password=3D"secret123"
> >>>>> proto=3DRSN
> >>>>> key_mgmt=3DSAE
> >>>>> pairwise=3DCCMP
> >>>>> ieee80211w=3D2
> >>>>> sae_check_mfp=3D1
> >>>>> }
> >>>>>
> >>>>> and when I try to connect, I get:
> >>>>> # wpa_supplicant -i wlan0 -c
> >>>>> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >>>>> Successfully initialized wpa_supplicant Line 10: unknown network
> >>>>> field 'sae_check_mfp'.
> >>>>> Line 11: failed to parse network block.
> >>>>
> >>>> Right. The setting sae_check_mfp is a global setting like
> >>>> update_config. So it should be moved outside the network block.
> >>>>
> >>>> Regards,
> >>>> Arend
> >>> Arend,
> >>>
> >>> Thanks for the hand holding, I am out of my depth here!
> >>>
> >>> I tried this config and get a similar result.
> >>> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >>> update_config=3D1
> >>> sae_check_mfp=3D1
> >>> network=3D{
> >>> ssid=3D"deskSAE"
> >>> sae_password=3D"secret123"
> >>> proto=3DRSN
> >>> key_mgmt=3DSAE
> >>> pairwise=3DCCMP
> >>> ieee80211w=3D2
> >>> }
> >>> # wpa_supplicant -i wlan0 -c
> >>> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >>> Successfully initialized wpa_supplicant Line 3: unknown global field
> >>> 'sae_check_mfp=3D1'.
> >>> Line 3: Invalid configuration line 'sae_check_mfp=3D1'.
> >>> Failed to read or parse configuration
> >>> '/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'.
> >>> : CTRL-EVENT-DSCP-POLICY clear_all
> >>>
> >>> seems it doesn't recognize this parameter.
> >>>
> >>> Keith
> >>
> >> Replying to my own post.
> >> I re-built wpa_supplicant from the current git:
> >> # wpa_supplicant -v
> >> wpa_supplicant v2.11-devel-hostap_2_10-2215-gc9db4925f
> >> Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
> >>
> >> It now seems to recognize the 'sae_check_mfp' parameter, but still doe=
s not
> >> connect:
> >> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.=
conf
> >> Successfully initialized wpa_supplicant
> >> wlan0: Trying to associate with SSID 'deskSAE'
> >> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> >> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10=
 seconds
> >> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> >> wlan0: Trying to associate with SSID 'deskSAE'
> >> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> >> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10=
 seconds
> >> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> >> wlan0: Trying to associate with SSID 'deskSAE'
> >> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> >> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10=
 seconds
> >> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> >> wlan0: Trying to associate with SSID 'deskSAE'
> >> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> >> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10=
 seconds
> >> wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"deskSAE"
> >> auth_failures=3D1 duration=3D10 reason=3DCONN_FAILED
> >> wlan0: CTRL-EVENT-SSID-REENABLED id=3D0 ssid=3D"deskSAE"
> >> wlan0: BSSID d8:3a:dd:60:a3:0c ignore list count incremented to 2, ign=
oring
> >> for 10 seconds
> >> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> >> wlan0: Trying to associate with SSID 'deskSAE'
> >> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=3D00:00:00:00:00:00 status_code=
=3D16
> >> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10=
 seconds
> >> wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"deskSAE"
> >> auth_failures=3D2 duration=3D20 reason=3DCONN_FAILED
> >> ^Cp2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> >> p2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> >> nl80211: deinit ifname=3Dp2p-dev-wlan0 disabled_11b_rates=3D0
> >> p2p-dev-wlan0: CTRL-EVENT-TERMINATING
> >> wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> >> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
> >> wlan0: CTRL-EVENT-DSCP-POLICY clear_all
> >> nl80211: deinit ifname=3Dwlan0 disabled_11b_rates=3D0
> >> wlan0: CTRL-EVENT-TERMINATING
> >>
> >> I tried setting the 'sae_check_mfp' to both 1 and 0 and still cannot
> >> connect with this 'current' version of
> >> wpa_supplicant.
> >>
> >> Keith
> > Hi Keith,
> >
> > maybe you are missing sae_pwe=3D2 in your wpa_supplicant.conf
> > At least in our setup it works.
>
> I think Keith already reported success in earlier email.
>
> @Keith: If I am mistaken let me know.
>
> Regards,
> Arend
>
Arend,

Yes, I figured it out. As per the link shared: I had to put the latest
firmware on and use the latest wpa_supplicant, but with these 2
changes, it did connect.


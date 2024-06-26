Return-Path: <linux-wireless+bounces-9599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FC8918083
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E47F1F23D9A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C37180A95;
	Wed, 26 Jun 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAyF9rNI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C52180A8E
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403509; cv=none; b=MIH2ZmY0lH9Z7QYJvDkEkPh93QOCgZH0XdbWlDVRXqXq0vek/9CtyGYCV4fOhMUacjZGN2TynFAWQo9vJSYRUNTTAo6SNs2Xycjx7YeId36Z/dXwp7hi19Ik/jpma9y/huZ4ICN3f5rb2dh5hNeozNg9uK3hRLrkUk7iHfuUnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403509; c=relaxed/simple;
	bh=NBEFTzkklGFGDVG2/xtdV1orAF8Jslvtw0j0Fq+A/u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h69+oTx9XVKzYrYRVjchrqGOity9zIOJdSp07XQE+IDDpWVU5POxLgPWNzsbiE451f1nqjdcBMdc/t+o0Z7w5gbsJoPvPj37et9NcGc2XOjVgPbuI39cs0R3h+l6ElII95cc/wqeBp4JcsGJnSo1SbxviTjxoHssjq2LQIrYOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAyF9rNI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so4919122a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719403507; x=1720008307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UCfu79HmhWSdtl/1wXnfzkyBlaEjaZcIKqYIxg5bUw=;
        b=NAyF9rNILc9U4Aw8F4nOcRedgp4BnU1hUYDmRj6HRKvVpcfXcp0Zl2m9Gk6YxLUolS
         /17jp0oyrnnD0iRPcR+brrOlqsXGan1XRhzQM5PODz4WGBtsgWyRsPwhHIIfZZayERms
         p6aED7Kr9dEHpqWIwasgzcf1wyl4UobC/f4Q3Dl3viSlfQ4+ziC4CMlY+ORMs3uiDuqi
         y9gUvcwVK4adA0rjWSnFV8URKEEyi2J2/o5ZQWRxvtaAwkJDS3Bx0AY/w50mjc3N7gWt
         kNDCvexkZqdgjZuZPF3cQsAgGl/MCtU4XoH7RgzAz4o/XZknKvySVMnPAhq89BsxZlFV
         GBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403507; x=1720008307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UCfu79HmhWSdtl/1wXnfzkyBlaEjaZcIKqYIxg5bUw=;
        b=adhVeIfB6GwUFMEcIO5x5kiVmt5sTd2BmnuGu9Fl19zQAKmgw6I93MPlXwCEUSKwBf
         W2UFzeQkY+6vzmSWF+zqmCtafn5v02RFECxT3FzE5+UmPDRzfiv4B+SdnWgITUT3zdi8
         NYQNMKSXGJEMLjZBK0nhx9NvlRxQcsZvbFVYs6VtXXgUJbXWvExQX9Mdk7CgXvLuDU+K
         IKUgESUO2vzdvTz4JArMRL0vI/TE/UfENuIv0SwHUK5+hXlamnpXnJLrX5vLRSo3cKd+
         qRXvbIJvtvyRb/lZ2tWxo0EMkeXlrh+QbIx7kQbjytiGhLu37wL7lokmoY31CJXB29do
         3WKA==
X-Forwarded-Encrypted: i=1; AJvYcCWtXTnoMpVDBbEE+FRvuTpVGCSBr+fAoCOmwkfFyIyY74m494OWjtRJmBeO0SyvXJQi3QEVj4x8FqwkYCQwOk2MXjN4CXuNdYkJalN+ZlQ=
X-Gm-Message-State: AOJu0YyhBZy2g1++DPbh1vxlh4EDkPpbgIE4G2+Tv/3yXZOW6OuN6f9R
	6KybKA7w2pbFn688bF1likfUpMDAJ8PvvGTvYHwg0cAxaTuvZvSQGwQokkEz9XbWEs82NOzp8+t
	zXV/ia2rrevkd/6Y3eIO2ZKtvgIE=
X-Google-Smtp-Source: AGHT+IGd0NoEbFjS7olP1xxMX4lVfuZPb+3O2FokBowu6HNfyG/mz6ggTlIDanwox5pVv8HyeXp4S1l/zy7bVXc90iI=
X-Received: by 2002:a17:90a:f3d5:b0:2c2:d250:2813 with SMTP id
 98e67ed59e1d1-2c86127e27fmr8372737a91.1.1719403506903; Wed, 26 Jun 2024
 05:05:06 -0700 (PDT)
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
In-Reply-To: <1905383f7e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 26 Jun 2024 07:04:56 -0500
Message-ID: <CAG17S_MPwwgzup17zwHmNH87RS9mrwn7A8v0FkntQx2du6fLig@mail.gmail.com>
Subject: Re: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi: brcmsmac:
 advertise MFP_CAPABLE to enable WPA3
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, Jouni Malinen <j@w1.fi>, hostap@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:48=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 21, 2024 2:24:19 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Fri, Jun 21, 2024 at 4:09=E2=80=AFAM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> + Jouni
> >>
> >> On 6/20/2024 8:25 PM, KeithG wrote:
> >>> 1718907734.308740: wlan0: WPA: AP group 0x10 network profile group
> >>> 0x18; available group 0x10
> >>> 1718907734.308748: wlan0: WPA: using GTK CCMP
> >>> 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network profile
> >>> pairwise 0x10; available pairwise 0x10
> >>> 1718907734.308767: wlan0: WPA: using PTK CCMP
> >>> 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network profile
> >>> key_mgmt 0x400; available key_mgmt 0x0
> >>
> >>
> >> I suspect the message above indicates the problem as there is no
> >> available key_mgmt to select so looked it up in the code and here it i=
s:
> >>
> >> sel =3D ie.key_mgmt & ssid->key_mgmt;
> >> #ifdef CONFIG_SAE
> >> if ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
> >> !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) ||
> >> wpas_is_sae_avoided(wpa_s, ssid, &ie))
> >> sel &=3D ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
> >>          WPA_KEY_MGMT_FT_SAE |
> >> WPA_KEY_MGMT_FT_SAE_EXT_KEY);
> >> #endif /* CONFIG_SAE */
> >> #ifdef CONFIG_IEEE80211R
> >> if (!(wpa_s->drv_flags & (WPA_DRIVER_FLAGS_SME |
> >>                   WPA_DRIVER_FLAGS_UPDATE_FT_IES)))
> >> sel &=3D ~WPA_KEY_MGMT_FT;
> >> #endif /* CONFIG_IEEE80211R */
> >> wpa_dbg(wpa_s, MSG_DEBUG,
> >> "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
> >> available key_mgmt 0x%x",
> >> ie.key_mgmt, ssid->key_mgmt, sel);
> >>
> >> So 0x400 matches the expectation:
> >>
> >> #define WPA_KEY_MGMT_SAE BIT(10)
> >>
> >> You already confirmed that the driver reports SAE and SAE offload
> >> support. So it seems wpas_is_sae_avoided() must return true. That will
> >> check whether the AP and network profile are setup to MFP. This seems =
to
> >> be the fact as your hostapd.conf and wpa_supplicant.conf both have
> >> ieee80211w=3D2 defined. This function can only return true when
> >> is enabled in configuration file:
> >>
> >> # sae_check_mfp: Require PMF support to select SAE key_mgmt
> >> # 0 =3D Do not check PMF for SAE (default)
> >> # 1 =3D Limit SAE when PMF is not enabled
> >> #
> >> # When enabled SAE will not be selected if PMF will not be used
> >> # for the connection.
> >> # Scenarios where this check will limit SAE:
> >> #  1) ieee80211w=3D0 is set for the network
> >> #  2) The AP does not have PMF enabled.
> >> #  3) ieee80211w is unset, pmf=3D1 is enabled globally, and
> >> #     the device does not support the BIP cipher.
> >> # Consider the configuration of global parameterss sae_check_mfp=3D1,
> >> pmf=3D1 and a
> >> # network configured with ieee80211w unset and key_mgmt=3DSAE WPA-PSK.
> >> # In the example WPA-PSK will be used if the device does not support
> >> # the BIP cipher or the AP has PMF disabled.
> >> # Limiting SAE with this check can avoid failing to associate to an AP
> >> # that is configured with sae_requires_mfp=3D1 if the device does
> >> # not support PMF due to lack of the BIP cipher.
> >>
> >> The default is not to check it and you wpa_supplicant.conf does not
> >> specify it.
> >>
> >> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> >> ctrl_interface=3DDIR=3D/run/wpa_supplicant GROUP=3Dnetdev
> >> update_config=3D1
> >> network=3D{
> >> ssid=3D"deskSAE"
> >> sae_password=3D"secret123"
> >> proto=3DRSN
> >> key_mgmt=3DSAE
> >> pairwise=3DCCMP
> >> ieee80211w=3D2
> >> }
> >>
> >> $ cat /etc/hostapd/hostapd.conf
> >> # interface and driver
> >> interface=3Dap0
> >> driver=3Dnl80211
> >>
> >> # WIFI-Config
> >> ssid=3DdeskSAE
> >> channel=3D1
> >> hw_mode=3Dg
> >>
> >> wpa=3D2
> >> wpa_key_mgmt=3DSAE
> >> wpa_pairwise=3DCCMP
> >> sae_password=3Dsecret123
> >> sae_groups=3D19
> >> ieee80211w=3D2
> >> sae_pwe=3D0
> >>
> >> Regards,
> >> Arend
> >>
> >>
> >>> 1718907734.308779: wlan0: WPA: Failed to select authenticated key
> >>> management type
> >>> 1718907734.308787: wlan0: WPA: Failed to set WPA key management and
> >>> encryption suites
> >
> > Arend,
> >
> > I find the wpa_supplicant docs really hard to understand. I have read
> > through your response a few times and am still a bit confused. Does
> > this have to do with a pure wpa3 versus a wpa2/3 AP?
>
> Correct. If I am not mistaken MFP aka PMF aka 802.11w is mandatory for WP=
A3.
>
> > I have tried editing my hostapd.conf and my wpa_supplicant.conf and
> > still cannot get a connection, so I must be doing something wrong.
> > I commented the ieee80211w line on both and it would not connect.
> > I tried changing the wpa_key_mgmt on both ends to be 'SAE WPA_PSK' and
> > it still would not connect.
> >
> > What *should* the configurations be in the hostapd.conf and
> > wpa_supplicant.conf to negotiate this as a pure wpa3 setup? What
> > should it be to be a wpa2/3 setup? My phone worked fine to connect
> > with the original hostapd setup, but I have no idea what it is doing
>
> As I mentioned in my previous email both config files listed above look
> okay to me (might be wrong though). The problem seems to be with
> wpas_is_sae_avoided(). For it to return true the config should have:
>
> sae_check_mfp=3D1
>
> But you don't have that and default is 0 so it should check for MFP. This
> is where my trail ends. To learn more I would add additional debug prints=
.
> Are you comfortable rebuilding wpa_supplicant from source?
>
> Regards,
> Arend
>
>

Arend,

Thanks for the reply. I could try to rebuild wpa_supplicant from
source. This is on RPi, so debian *.debs which are a pain, but I think
I can do it.

Do I understand correctly that 'sae_check_mfp=3D1' is supposed to be in
the hostapd.conf and wpa_supplicant.conf? I can try that and see if
anything changes.

Why would I have to re-build wpa_supplicant?

Keith

Keith


Return-Path: <linux-wireless+bounces-9586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09008917A0E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62087B214F4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397215820F;
	Wed, 26 Jun 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E2itXQWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE44596E
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388084; cv=none; b=oIIaHSn6OTpNn4XVTj636CpWcx5mBQ/z43BOoMIYuk7Tu+iolfN7p7gll3YrEMuzYg5qpI4wOT/MijJCb8wKSGywOptbPOcx/nsBIA+fPS0A21Ip1mzRN1Sio0qHdoiY6uxwn6HLfSr3zOQCIeCvbORY3MJKcampUuLX3JKpo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388084; c=relaxed/simple;
	bh=MERRxSCsoYO3X66dpeIxid3GapOFDcvrk0ZAwVJAkkk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LKP+B61ST6CFuJVeBCXuzNc0zsvts+QLgNOWiLJqaUDxP+QnVDyxZ3WFTn32ejPJkDpxy+NJzJ9VKz1V7vidnsMrAQVIUHi7JwH4flim7UiRsHXfBU8lqvvkJBbumuBd/BcWWn2fF1xJ4vRGl0nSbFM2HCfa+Pp+2msKGUqRDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E2itXQWT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44502bfbb4bso5767031cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719388082; x=1719992882; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjLo6wCSkU9fAK/St7KW0SHWZ70y7/QZqoYuoeA44NY=;
        b=E2itXQWT3tLr3pl/aEybVDLls9eoHLYzQDRatkgicsjPMZKFgO33xmgaKi1kYKmSxL
         RQZ/TSB57tqvxr5JSLKG5yIsHf04e1bIPWZhWXa11UngZ0GNWbjhO+0stn2xt+KawU8P
         8BiYSRkN6D14l5RggEYHht8GKN2LBCVTHQ3OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388082; x=1719992882;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjLo6wCSkU9fAK/St7KW0SHWZ70y7/QZqoYuoeA44NY=;
        b=mml0ZrMw/eKCvXsGG/b1yXfhY721ChosahKMvxBLX9FLNcgxUNHjYLL2irDYqiPoZ+
         N7nt/MS4ppZZoWuqAXzjOC+FHPfkqOrOU/KBIYB0PnGW76RQNhE+YenijGM3j0UR0QMI
         O+VAwpJMV+r3ih8Z05TNnoAevhfdwMqhhuYsqmO5OoNtDcdZgVGldn/hGmebIaLIGEyv
         x+eN9uMv9KAf+xzhfRDau1RloXZfPWjP31f+fFjCteKRh1CrbdOj4VWZbpemQs5rk4fe
         bWIFwAoq7SmzC39JnvSAMGlyAdMoX3SW/Sj0aVsEOSu+TNH1ca+yDVU3iw7zx7qZSXUQ
         Woig==
X-Forwarded-Encrypted: i=1; AJvYcCXC6UnZPsFDmBjVTgOafI5UdOolq7EsiCewWJ5PZcbj1S50hnUiae1RSQ096fBQtkTIIluM51pMCA8BsZJEC5xPTm5qY6SKvYIFz5erwhw=
X-Gm-Message-State: AOJu0YxNeJFi7GprhKb+Wi/PdJp3OoUKfdXGk3Lzc3V3u941CThCY570
	xRQy4Wh0l0YXtt3/EcOHSO6VMYMIJgZNw5W0xU+TFlNbfsDXSg/QBMJJXivXwA==
X-Google-Smtp-Source: AGHT+IF6bITAHbnd9J/HjEyIOMs5v9PA2QyyLs7DpHT/lDuZQmqBxYL2hwHkblfbTz2ZBLG49cq0WA==
X-Received: by 2002:a05:622a:507:b0:43f:9ff5:1d6d with SMTP id d75a77b69052e-444d936c590mr108590121cf.46.1719388081874;
        Wed, 26 Jun 2024 00:48:01 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444fe365315sm13255251cf.28.2024.06.26.00.47.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 00:48:01 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, Jouni Malinen <j@w1.fi>, <hostap@lists.infradead.org>
Date: Wed, 26 Jun 2024 09:47:56 +0200
Message-ID: <1905383f7e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_OMV5TpCO+XwP-6dQNB_zVs+OCoawpngZUshuDOgFOF0w@mail.gmail.com>
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
 <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
 <CALeDE9M78so=roEFion9GGo4tV7c+M885=ZNZgi9zKyBur+iMQ@mail.gmail.com>
 <190355aedf0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NBO=tTBp9GX=S9C4REbT-Gx634n66+7JERcWbe-KXt-g@mail.gmail.com>
 <190369b8c10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NHC7EqUMtc58eSY9Yoq4K0mvp=C1rcP8PTRzajXW3Csg@mail.gmail.com>
 <c065ae75-f89e-4b14-9fc3-6ef19e6d144b@broadcom.com>
 <CAG17S_OMV5TpCO+XwP-6dQNB_zVs+OCoawpngZUshuDOgFOF0w@mail.gmail.com>
User-Agent: AquaMail/1.51.3 (build: 105103473)
Subject: Re: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000df9112061bc63b8c"

--000000000000df9112061bc63b8c
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 21, 2024 2:24:19 PM KeithG <ys3al35l@gmail.com> wrote:

> On Fri, Jun 21, 2024 at 4:09 AM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> + Jouni
>>
>> On 6/20/2024 8:25 PM, KeithG wrote:
>>> 1718907734.308740: wlan0: WPA: AP group 0x10 network profile group
>>> 0x18; available group 0x10
>>> 1718907734.308748: wlan0: WPA: using GTK CCMP
>>> 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network profile
>>> pairwise 0x10; available pairwise 0x10
>>> 1718907734.308767: wlan0: WPA: using PTK CCMP
>>> 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network profile
>>> key_mgmt 0x400; available key_mgmt 0x0
>>
>>
>> I suspect the message above indicates the problem as there is no
>> available key_mgmt to select so looked it up in the code and here it is:
>>
>> sel = ie.key_mgmt & ssid->key_mgmt;
>> #ifdef CONFIG_SAE
>> if ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
>> !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) ||
>> wpas_is_sae_avoided(wpa_s, ssid, &ie))
>> sel &= ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
>>          WPA_KEY_MGMT_FT_SAE |
>> WPA_KEY_MGMT_FT_SAE_EXT_KEY);
>> #endif /* CONFIG_SAE */
>> #ifdef CONFIG_IEEE80211R
>> if (!(wpa_s->drv_flags & (WPA_DRIVER_FLAGS_SME |
>>                   WPA_DRIVER_FLAGS_UPDATE_FT_IES)))
>> sel &= ~WPA_KEY_MGMT_FT;
>> #endif /* CONFIG_IEEE80211R */
>> wpa_dbg(wpa_s, MSG_DEBUG,
>> "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
>> available key_mgmt 0x%x",
>> ie.key_mgmt, ssid->key_mgmt, sel);
>>
>> So 0x400 matches the expectation:
>>
>> #define WPA_KEY_MGMT_SAE BIT(10)
>>
>> You already confirmed that the driver reports SAE and SAE offload
>> support. So it seems wpas_is_sae_avoided() must return true. That will
>> check whether the AP and network profile are setup to MFP. This seems to
>> be the fact as your hostapd.conf and wpa_supplicant.conf both have
>> ieee80211w=2 defined. This function can only return true when
>> is enabled in configuration file:
>>
>> # sae_check_mfp: Require PMF support to select SAE key_mgmt
>> # 0 = Do not check PMF for SAE (default)
>> # 1 = Limit SAE when PMF is not enabled
>> #
>> # When enabled SAE will not be selected if PMF will not be used
>> # for the connection.
>> # Scenarios where this check will limit SAE:
>> #  1) ieee80211w=0 is set for the network
>> #  2) The AP does not have PMF enabled.
>> #  3) ieee80211w is unset, pmf=1 is enabled globally, and
>> #     the device does not support the BIP cipher.
>> # Consider the configuration of global parameterss sae_check_mfp=1,
>> pmf=1 and a
>> # network configured with ieee80211w unset and key_mgmt=SAE WPA-PSK.
>> # In the example WPA-PSK will be used if the device does not support
>> # the BIP cipher or the AP has PMF disabled.
>> # Limiting SAE with this check can avoid failing to associate to an AP
>> # that is configured with sae_requires_mfp=1 if the device does
>> # not support PMF due to lack of the BIP cipher.
>>
>> The default is not to check it and you wpa_supplicant.conf does not
>> specify it.
>>
>> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
>> ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
>> update_config=1
>> network={
>> ssid="deskSAE"
>> sae_password="secret123"
>> proto=RSN
>> key_mgmt=SAE
>> pairwise=CCMP
>> ieee80211w=2
>> }
>>
>> $ cat /etc/hostapd/hostapd.conf
>> # interface and driver
>> interface=ap0
>> driver=nl80211
>>
>> # WIFI-Config
>> ssid=deskSAE
>> channel=1
>> hw_mode=g
>>
>> wpa=2
>> wpa_key_mgmt=SAE
>> wpa_pairwise=CCMP
>> sae_password=secret123
>> sae_groups=19
>> ieee80211w=2
>> sae_pwe=0
>>
>> Regards,
>> Arend
>>
>>
>>> 1718907734.308779: wlan0: WPA: Failed to select authenticated key
>>> management type
>>> 1718907734.308787: wlan0: WPA: Failed to set WPA key management and
>>> encryption suites
>
> Arend,
>
> I find the wpa_supplicant docs really hard to understand. I have read
> through your response a few times and am still a bit confused. Does
> this have to do with a pure wpa3 versus a wpa2/3 AP?

Correct. If I am not mistaken MFP aka PMF aka 802.11w is mandatory for WPA3.

> I have tried editing my hostapd.conf and my wpa_supplicant.conf and
> still cannot get a connection, so I must be doing something wrong.
> I commented the ieee80211w line on both and it would not connect.
> I tried changing the wpa_key_mgmt on both ends to be 'SAE WPA_PSK' and
> it still would not connect.
>
> What *should* the configurations be in the hostapd.conf and
> wpa_supplicant.conf to negotiate this as a pure wpa3 setup? What
> should it be to be a wpa2/3 setup? My phone worked fine to connect
> with the original hostapd setup, but I have no idea what it is doing

As I mentioned in my previous email both config files listed above look 
okay to me (might be wrong though). The problem seems to be with 
wpas_is_sae_avoided(). For it to return true the config should have:

sae_check_mfp=1

But you don't have that and default is 0 so it should check for MFP. This 
is where my trail ends. To learn more I would add additional debug prints. 
Are you comfortable rebuilding wpa_supplicant from source?

Regards,
Arend



--000000000000df9112061bc63b8c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCorXVtCv8mZACOPmfG
D40IA7jUWJ3nR3jeMYQC3PK2cDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA2MjYwNzQ4MDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKQOaDDb4uqoru/Jgh6AKbsecOCrdezYZ7zFp
NKu5xQ0U5hdK+pCICYQAgQLnpkEDzgJpDy6JfgF1ZPT+QnmvPhY9ItMNCUbu75+MoPuPlDqbY2AT
dei5acfiZ4wwJ1Ipi9pi0wH6WC5LTYBW5LEP/cf3iCRoXAStCN54D5vddQR9RG/NhuzgaA9lMhds
it9f5dNDoYGGICYN6ksbDBLR4HnktlUpICWh19Nb3LyKyqqGXe9by8XaZ7/fnvRUFUiloxT5uOqD
hYkbKdxQpFGT7B5NyzdeaC/fqIevg8wHezhvTugCnocg3eyew5sp4tuMO1oPqu8xoL0x6kDh0JiF
3A==
--000000000000df9112061bc63b8c--


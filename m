Return-Path: <linux-wireless+bounces-10216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A13930B3E
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2024 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B659628150D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054E13BAE9;
	Sun, 14 Jul 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ddNs/ZYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3FFC11
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jul 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720982862; cv=none; b=aVjqfJrU4VmoJrMAO/pcy5D4uLDaVobMbwKTTIGsCXZUVk6J9GsQ2XzzKMACg/DkNQqlUN8Fupb2dCni/c992ehHfwUg6wUUzYRi57oTqSc0OITJgtqOnBmfV4gei9cLc74rLdIlRUPVmROKdFGnZTA3Rf2PF2xvM4nPT32LSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720982862; c=relaxed/simple;
	bh=fxnGiCnmM6gAnmWlSvc5bbdwOVPiPnl0vobrOv/jB80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui90sfzZFLPSpJBRT3vqHHRNtNLAZ2ZMQ7uJ4QAmvhVgBbMS4bfltYTGt7dJHecMrWAU0dcbZVxHc+WmDB+BSw4xy+KuSPc9etA8ZcEYhMHEGwIiTu7uiA5go3bT/XRMu/iJ6uLEAEbYQZCGOxL7DTVKZfESpxzYQS2G5TfpdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ddNs/ZYb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77bf336171so601573766b.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jul 2024 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720982859; x=1721587659; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xSLa22eUlLMoNAA1A+n9T6W7eo6e+KbvvtWsm149P8=;
        b=ddNs/ZYbR+OV/QOypUIA+/cHFedYx2lbgDMjGy0xVdY25H80BrHDYtny15hMZth/7l
         9HDlGZKWgmSaDmKpn8SX0qgkSshF/D01Tm9awXPA16KURuxXnenuC0GlVO/St547jVwn
         OhYWxcfA+uYUZQogrxGiKsmIPf7OuWCF1y/qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720982859; x=1721587659;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xSLa22eUlLMoNAA1A+n9T6W7eo6e+KbvvtWsm149P8=;
        b=e5ekhhHMxsGI0Orj9fN7Q958/KIBHUiENLKG7/RUurQzlFI5n5HM5Yy2rkWmM6HkIr
         EtgENkeprfuuP7jLv92kSa/sXtn5XAYTMiR/An6CxXIm+MlnSFN62Y5IDdYDPmjOhn55
         hu792w7JDz++rPy1rYwiVduhGCF4l0Kxf/QGD0l71O26qktbbOWns3eRmFFQk0O3CHPj
         PIkF/tcOxR/RUKGpukoqtYolXHRzIUXhnMa8mUsBoQTUnoVOvcrBmlC7cdQoid4Xfbbh
         jl8EcK+3S9rUbtzpWWXPAdFWwPl+oddp/MOU5QSBPAgiUPq2iE3OSTTOYEjvt6xI+/KH
         zyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHnvUOFGRXTkUu9amKf7Hm609A9TValYW/P0g2hFBS1FPtgvMLpiCfGukNeI1boxv3iEQ9BTX4R+9uPIXByn8w1r57DS+BxU7sMLuM0bA=
X-Gm-Message-State: AOJu0YxxJuCr3M+fVCoOqkQWAxAKkyWwXSKZWQ/cbXyVee4sh3E6A2Wc
	/ddW/yVB9h7bDPMHp3CoLJpR4mY5AoD38Mn4tsqKwk4UOg+za7cHV4PvtVJ+yg==
X-Google-Smtp-Source: AGHT+IEw/F/u2feKRKESuIxel0ng7eRynl/7wvgrYgp6IJKmgqR36OqoX8BzzUcrec9B5gJWdOSm6A==
X-Received: by 2002:a17:906:abcf:b0:a72:66d5:892c with SMTP id a640c23a62f3a-a799d37ee6fmr554788266b.18.1720982858619;
        Sun, 14 Jul 2024 11:47:38 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff780sm151858366b.169.2024.07.14.11.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 11:47:38 -0700 (PDT)
Message-ID: <375197cd-907e-4d0a-9cae-bb76983741e1@broadcom.com>
Date: Sun, 14 Jul 2024 20:47:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi:
 brcmsmac: advertise MFP_CAPABLE to enable WPA3
To: KeithG <ys3al35l@gmail.com>
Cc: "Dembianny Sven (BSH GDE-EDSD5)" <Sven.Dembianny@bshg.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Jouni Malinen <j@w1.fi>, hostap@lists.infradead.org
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CAG17S_NHC7EqUMtc58eSY9Yoq4K0mvp=C1rcP8PTRzajXW3Csg@mail.gmail.com>
 <c065ae75-f89e-4b14-9fc3-6ef19e6d144b@broadcom.com>
 <CAG17S_OMV5TpCO+XwP-6dQNB_zVs+OCoawpngZUshuDOgFOF0w@mail.gmail.com>
 <1905383f7e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MPwwgzup17zwHmNH87RS9mrwn7A8v0FkntQx2du6fLig@mail.gmail.com>
 <19054769d10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NojmnuQqLyOAT6+Tq4OLaBVc1FY6J8cqwWvo_VxcNLiA@mail.gmail.com>
 <19058122ea8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_Paw=634Q5zNm8jM2c_66OMscN1ngxR53kF=DJHKU2N1A@mail.gmail.com>
 <CAG17S_OMU2QbeMnue+RWqFErhbPKVCmFR90VMOYkVy+aMcdoBQ@mail.gmail.com>
 <AS4PR10MB5575530BE31A71DC652B45F6F4DA2@AS4PR10MB5575.EURPRD10.PROD.OUTLOOK.COM>
 <190ac032a58.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_OXfEk+nxuNJ8ZYrGMAh4RxCuEGbEJ1b6dvbe7Qs+B4Pw@mail.gmail.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <CAG17S_OXfEk+nxuNJ8ZYrGMAh4RxCuEGbEJ1b6dvbe7Qs+B4Pw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fbe51d061d398bf7"

--000000000000fbe51d061d398bf7
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/2024 8:42 PM, KeithG wrote:
> On Sat, Jul 13, 2024 at 7:13 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On July 8, 2024 1:33:02 PM "Dembianny Sven (BSH GDE-EDSD5)"
>> <Sven.Dembianny@bshg.com> wrote:
>>
>>>> On Thu, Jun 27, 2024 at 6:34 AM KeithG <ys3al35l@gmail.com> wrote:
>>>>>
>>>>> On Thu, Jun 27, 2024 at 12:01 AM Arend Van Spriel
>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>
>>>>>> On June 27, 2024 12:47:02 AM KeithG <ys3al35l@gmail.com> wrote:
>>>>>>
>>>>>>> On Wed, Jun 26, 2024 at 7:30 AM Arend Van Spriel
>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>
>>>>>>>> On June 26, 2024 2:05:07 PM KeithG <ys3al35l@gmail.com> wrote:
>>>>>>>>
>>>>>>>>> On Wed, Jun 26, 2024 at 2:48 AM Arend Van Spriel
>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On June 21, 2024 2:24:19 PM KeithG <ys3al35l@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>>> On Fri, Jun 21, 2024 at 4:09 AM Arend van Spriel
>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> + Jouni
>>>>>>>>>>>>
>>>>>>>>>>>> On 6/20/2024 8:25 PM, KeithG wrote:
>>>>>>>>>>>>> 1718907734.308740: wlan0: WPA: AP group 0x10 network profile
>>>>>>>>>>>>> group 0x18; available group 0x10
>>>>>>>>>>>>> 1718907734.308748: wlan0: WPA: using GTK CCMP
>>>>>>>>>>>>> 1718907734.308758: wlan0: WPA: AP pairwise 0x10 network
>>>>>>>>>>>>> profile pairwise 0x10; available pairwise 0x10
>>>>>>>>>>>>> 1718907734.308767: wlan0: WPA: using PTK CCMP
>>>>>>>>>>>>> 1718907734.308772: wlan0: WPA: AP key_mgmt 0x400 network
>>>>>>>>>>>>> profile key_mgmt 0x400; available key_mgmt 0x0
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I suspect the message above indicates the problem as there is
>>>>>>>>>>>> no available key_mgmt to select so looked it up in the code and here it is:
>>>>>>>>>>>>
>>>>>>>>>>>> sel = ie.key_mgmt & ssid->key_mgmt; #ifdef CONFIG_SAE if
>>>>>>>>>>>> ((!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE) &&
>>>>>>>>>>>> !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS2_SAE_OFFLOAD_STA)) ||
>>>>>>>>>>>> wpas_is_sae_avoided(wpa_s, ssid, &ie)) sel &=
>>>>>>>>>>>> ~(WPA_KEY_MGMT_SAE | WPA_KEY_MGMT_SAE_EXT_KEY |
>>>>>>>>>>>> WPA_KEY_MGMT_FT_SAE | WPA_KEY_MGMT_FT_SAE_EXT_KEY); #endif /*
>>>>>>>>>>>> CONFIG_SAE */ #ifdef CONFIG_IEEE80211R if (!(wpa_s->drv_flags
>>>>>>>>>>>> & (WPA_DRIVER_FLAGS_SME |
>>>>>>>>>>>>          WPA_DRIVER_FLAGS_UPDATE_FT_IES))) sel &=
>>>>>>>>>>>> ~WPA_KEY_MGMT_FT; #endif /* CONFIG_IEEE80211R */
>>>>>>>>>>>> wpa_dbg(wpa_s, MSG_DEBUG,
>>>>>>>>>>>> "WPA: AP key_mgmt 0x%x network profile key_mgmt 0x%x;
>>>>>>>>>>>> available key_mgmt 0x%x", ie.key_mgmt, ssid->key_mgmt, sel);
>>>>>>>>>>>>
>>>>>>>>>>>> So 0x400 matches the expectation:
>>>>>>>>>>>>
>>>>>>>>>>>> #define WPA_KEY_MGMT_SAE BIT(10)
>>>>>>>>>>>>
>>>>>>>>>>>> You already confirmed that the driver reports SAE and SAE
>>>>>>>>>>>> offload support. So it seems wpas_is_sae_avoided() must
>>>>>>>>>>>> return true. That will check whether the AP and network
>>>>>>>>>>>> profile are setup to MFP. This seems to be the fact as your
>>>>>>>>>>>> hostapd.conf and wpa_supplicant.conf both have
>>>>>>>>>>>> ieee80211w=2 defined. This function can only return true when
>>>>>>>>>>>> is enabled in configuration file:
>>>>>>>>>>>>
>>>>>>>>>>>> # sae_check_mfp: Require PMF support to select SAE key_mgmt #
>>>>>>>>>>>> 0 = Do not check PMF for SAE (default) # 1 = Limit SAE when
>>>>>>>>>>>> PMF is not enabled # # When enabled SAE will not be selected
>>>>>>>>>>>> if PMF will not be used # for the connection.
>>>>>>>>>>>> # Scenarios where this check will limit SAE:
>>>>>>>>>>>> #  1) ieee80211w=0 is set for the network #  2) The AP does
>>>>>>>>>>>> not have PMF enabled.
>>>>>>>>>>>> #  3) ieee80211w is unset, pmf=1 is enabled globally, and
>>>>>>>>>>>> #     the device does not support the BIP cipher.
>>>>>>>>>>>> # Consider the configuration of global parameterss
>>>>>>>>>>>> sae_check_mfp=1,
>>>>>>>>>>>> pmf=1 and a
>>>>>>>>>>>> # network configured with ieee80211w unset and key_mgmt=SAE WPA-PSK.
>>>>>>>>>>>> # In the example WPA-PSK will be used if the device does not
>>>>>>>>>>>> support # the BIP cipher or the AP has PMF disabled.
>>>>>>>>>>>> # Limiting SAE with this check can avoid failing to associate
>>>>>>>>>>>> to an AP # that is configured with sae_requires_mfp=1 if the
>>>>>>>>>>>> device does # not support PMF due to lack of the BIP cipher.
>>>>>>>>>>>>
>>>>>>>>>>>> The default is not to check it and you wpa_supplicant.conf
>>>>>>>>>>>> does not specify it.
>>>>>>>>>>>>
>>>>>>>>>>>> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
>>>>>>>>>>>> ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
>>>>>>>>>>>> update_config=1
>>>>>>>>>>>> network={
>>>>>>>>>>>> ssid="deskSAE"
>>>>>>>>>>>> sae_password="secret123"
>>>>>>>>>>>> proto=RSN
>>>>>>>>>>>> key_mgmt=SAE
>>>>>>>>>>>> pairwise=CCMP
>>>>>>>>>>>> ieee80211w=2
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> $ cat /etc/hostapd/hostapd.conf # interface and driver
>>>>>>>>>>>> interface=ap0
>>>>>>>>>>>> driver=nl80211
>>>>>>>>>>>>
>>>>>>>>>>>> # WIFI-Config
>>>>>>>>>>>> ssid=deskSAE
>>>>>>>>>>>> channel=1
>>>>>>>>>>>> hw_mode=g
>>>>>>>>>>>>
>>>>>>>>>>>> wpa=2
>>>>>>>>>>>> wpa_key_mgmt=SAE
>>>>>>>>>>>> wpa_pairwise=CCMP
>>>>>>>>>>>> sae_password=secret123
>>>>>>>>>>>> sae_groups=19
>>>>>>>>>>>> ieee80211w=2
>>>>>>>>>>>> sae_pwe=0
>>>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> Arend
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> 1718907734.308779: wlan0: WPA: Failed to select
>>>>>>>>>>>>> authenticated key management type
>>>>>>>>>>>>> 1718907734.308787: wlan0: WPA: Failed to set WPA key
>>>>>>>>>>>>> management and encryption suites
>>>>>>>>>>>
>>>>>>>>>>> Arend,
>>>>>>>>>>>
>>>>>>>>>>> I find the wpa_supplicant docs really hard to understand. I
>>>>>>>>>>> have read through your response a few times and am still a bit
>>>>>>>>>>> confused. Does this have to do with a pure wpa3 versus a wpa2/3 AP?
>>>>>>>>>>
>>>>>>>>>> Correct. If I am not mistaken MFP aka PMF aka 802.11w is mandatory for WPA3.
>>>>>>>>>>
>>>>>>>>>>> I have tried editing my hostapd.conf and my
>>>>>>>>>>> wpa_supplicant.conf and still cannot get a connection, so I must be doing
>>>>>>>>>>> something wrong.
>>>>>>>>>>> I commented the ieee80211w line on both and it would not connect.
>>>>>>>>>>> I tried changing the wpa_key_mgmt on both ends to be 'SAE
>>>>>>>>>>> WPA_PSK' and it still would not connect.
>>>>>>>>>>>
>>>>>>>>>>> What *should* the configurations be in the hostapd.conf and
>>>>>>>>>>> wpa_supplicant.conf to negotiate this as a pure wpa3 setup?
>>>>>>>>>>> What should it be to be a wpa2/3 setup? My phone worked fine
>>>>>>>>>>> to connect with the original hostapd setup, but I have no idea
>>>>>>>>>>> what it is doing
>>>>>>>>>>
>>>>>>>>>> As I mentioned in my previous email both config files listed
>>>>>>>>>> above look okay to me (might be wrong though). The problem
>>>>>>>>>> seems to be with wpas_is_sae_avoided(). For it to return true the config
>>>>>>>>>> should have:
>>>>>>>>>>
>>>>>>>>>> sae_check_mfp=1
>>>>>>>>>>
>>>>>>>>>> But you don't have that and default is 0 so it should check for
>>>>>>>>>> MFP. This is where my trail ends. To learn more I would add additional
>>>>>>>>>> debug prints.
>>>>>>>>>> Are you comfortable rebuilding wpa_supplicant from source?
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Arend
>>>>>>>>>
>>>>>>>>> Arend,
>>>>>>>>>
>>>>>>>>> Thanks for the reply. I could try to rebuild wpa_supplicant from
>>>>>>>>> source. This is on RPi, so debian *.debs which are a pain, but I
>>>>>>>>> think I can do it.
>>>>>>>>>
>>>>>>>>> Do I understand correctly that 'sae_check_mfp=1' is supposed to
>>>>>>>>> be in the hostapd.conf and wpa_supplicant.conf? I can try that
>>>>>>>>> and see if anything changes.
>>>>>>>>
>>>>>>>> Ok. We can try first to put following in wpa_supplicant.conf:
>>>>>>>>
>>>>>>>> sae_check_mfp=0
>>>>>>>>
>>>>>>>> Let me know if that makes any difference.
>>>>>>>>
>>>>>>>>> Why would I have to re-build wpa_supplicant?
>>>>>>>>
>>>>>>>> I would provide a patch with additional debug prints so I get
>>>>>>>> better understanding what is going wrong. Would be great if you
>>>>>>>> can apply that and rebuild.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Arend
>>>>>>> Arend,
>>>>>>>
>>>>>>> I was able to try it this afternoon.
>>>>>>> My hostapd is still:
>>>>>>> # interface and driver
>>>>>>> interface=ap0
>>>>>>> driver=nl80211
>>>>>>>
>>>>>>> # WIFI-Config
>>>>>>> ssid=deskSAE
>>>>>>> channel=1
>>>>>>> hw_mode=g
>>>>>>>
>>>>>>> wpa=2
>>>>>>> wpa_key_mgmt=SAE
>>>>>>> wpa_pairwise=CCMP
>>>>>>> sae_password=secret123
>>>>>>> sae_groups=19
>>>>>>> ieee80211w=2
>>>>>>> sae_pwe=0
>>>>>>>
>>>>>>> and I can still connect from my phone to this AP.
>>>>>>>
>>>>>>> I tried this as my /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
>>>>>>> ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
>>>>>>> update_config=1
>>>>>>> network={
>>>>>>> ssid="deskSAE"
>>>>>>> sae_password="secret123"
>>>>>>> proto=RSN
>>>>>>> key_mgmt=SAE
>>>>>>> pairwise=CCMP
>>>>>>> ieee80211w=2
>>>>>>> sae_check_mfp=1
>>>>>>> }
>>>>>>>
>>>>>>> and when I try to connect, I get:
>>>>>>> # wpa_supplicant -i wlan0 -c
>>>>>>> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
>>>>>>> Successfully initialized wpa_supplicant Line 10: unknown network
>>>>>>> field 'sae_check_mfp'.
>>>>>>> Line 11: failed to parse network block.
>>>>>>
>>>>>> Right. The setting sae_check_mfp is a global setting like
>>>>>> update_config. So it should be moved outside the network block.
>>>>>>
>>>>>> Regards,
>>>>>> Arend
>>>>> Arend,
>>>>>
>>>>> Thanks for the hand holding, I am out of my depth here!
>>>>>
>>>>> I tried this config and get a similar result.
>>>>> ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
>>>>> update_config=1
>>>>> sae_check_mfp=1
>>>>> network={
>>>>> ssid="deskSAE"
>>>>> sae_password="secret123"
>>>>> proto=RSN
>>>>> key_mgmt=SAE
>>>>> pairwise=CCMP
>>>>> ieee80211w=2
>>>>> }
>>>>> # wpa_supplicant -i wlan0 -c
>>>>> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
>>>>> Successfully initialized wpa_supplicant Line 3: unknown global field
>>>>> 'sae_check_mfp=1'.
>>>>> Line 3: Invalid configuration line 'sae_check_mfp=1'.
>>>>> Failed to read or parse configuration
>>>>> '/etc/wpa_supplicant/wpa_supplicant-wlan0.conf'.
>>>>> : CTRL-EVENT-DSCP-POLICY clear_all
>>>>>
>>>>> seems it doesn't recognize this parameter.
>>>>>
>>>>> Keith
>>>>
>>>> Replying to my own post.
>>>> I re-built wpa_supplicant from the current git:
>>>> # wpa_supplicant -v
>>>> wpa_supplicant v2.11-devel-hostap_2_10-2215-gc9db4925f
>>>> Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
>>>>
>>>> It now seems to recognize the 'sae_check_mfp' parameter, but still does not
>>>> connect:
>>>> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
>>>> Successfully initialized wpa_supplicant
>>>> wlan0: Trying to associate with SSID 'deskSAE'
>>>> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=00:00:00:00:00:00 status_code=16
>>>> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 seconds
>>>> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
>>>> wlan0: Trying to associate with SSID 'deskSAE'
>>>> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=00:00:00:00:00:00 status_code=16
>>>> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 seconds
>>>> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
>>>> wlan0: Trying to associate with SSID 'deskSAE'
>>>> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=00:00:00:00:00:00 status_code=16
>>>> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 seconds
>>>> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
>>>> wlan0: Trying to associate with SSID 'deskSAE'
>>>> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=00:00:00:00:00:00 status_code=16
>>>> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 seconds
>>>> wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="deskSAE"
>>>> auth_failures=1 duration=10 reason=CONN_FAILED
>>>> wlan0: CTRL-EVENT-SSID-REENABLED id=0 ssid="deskSAE"
>>>> wlan0: BSSID d8:3a:dd:60:a3:0c ignore list count incremented to 2, ignoring
>>>> for 10 seconds
>>>> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
>>>> wlan0: Trying to associate with SSID 'deskSAE'
>>>> wlan0: CTRL-EVENT-ASSOC-REJECT bssid=00:00:00:00:00:00 status_code=16
>>>> wlan0: Added BSSID d8:3a:dd:60:a3:0c into ignore list, ignoring for 10 seconds
>>>> wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="deskSAE"
>>>> auth_failures=2 duration=20 reason=CONN_FAILED
>>>> ^Cp2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
>>>> p2p-dev-wlan0: CTRL-EVENT-DSCP-POLICY clear_all
>>>> nl80211: deinit ifname=p2p-dev-wlan0 disabled_11b_rates=0
>>>> p2p-dev-wlan0: CTRL-EVENT-TERMINATING
>>>> wlan0: CTRL-EVENT-DSCP-POLICY clear_all
>>>> wlan0: Removed BSSID d8:3a:dd:60:a3:0c from ignore list (clear)
>>>> wlan0: CTRL-EVENT-DSCP-POLICY clear_all
>>>> nl80211: deinit ifname=wlan0 disabled_11b_rates=0
>>>> wlan0: CTRL-EVENT-TERMINATING
>>>>
>>>> I tried setting the 'sae_check_mfp' to both 1 and 0 and still cannot
>>>> connect with this 'current' version of
>>>> wpa_supplicant.
>>>>
>>>> Keith
>>> Hi Keith,
>>>
>>> maybe you are missing sae_pwe=2 in your wpa_supplicant.conf
>>> At least in our setup it works.
>>
>> I think Keith already reported success in earlier email.
>>
>> @Keith: If I am mistaken let me know.
>>
>> Regards,
>> Arend
>>
> Arend,
> 
> Yes, I figured it out. As per the link shared: I had to put the latest
> firmware on and use the latest wpa_supplicant, but with these 2
> changes, it did connect.

Good to know.

Regards,
Arend

--000000000000fbe51d061d398bf7
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB0xUiYr1EZ4s2yacEw
WHO/FM8CwZkJS9g92aThwb21yTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA3MTQxODQ3MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAW0SHlX1UYPP+8nACIs3dQLbtbWW7Yl7Vey/T
yyqqvcnMAaO6WdVi2IaxB80H4Rtw9ksZWLouyXbsGGHj2rYqpxvxqI51QcWN1CICRUjpIOpPkG8z
bHZUAF7HvhMJTpGWNOzUJoIviyGRfKwwdtd963X0IIik50Mht+G5GTYniubDTOMJzEOIShBOCG4/
+hGNNOt6Ghjt0/GvxFavWyVy/LU5DXPC5VQfVet7KX4odkBvIuzT9eG6wUKMkHk/tKE99HPTJkvR
APGabJQ3NTt9IA6lBGyLECTlY+ISTmofxRD30eHPXM1zfo7ON4kRXxIho08e+ybYAdzdOwMbmRC+
hg==
--000000000000fbe51d061d398bf7--


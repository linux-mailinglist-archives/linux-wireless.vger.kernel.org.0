Return-Path: <linux-wireless+bounces-27944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FABCFFC1
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09B794E15FE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD81F5617;
	Sun, 12 Oct 2025 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fYD3P5O4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AD1E833D
	for <linux-wireless@vger.kernel.org>; Sun, 12 Oct 2025 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249757; cv=none; b=GonkjYa94GpmNEq0IN/Pt3KHVseZl1+bUCsRgKXipYodQTq1Lb64Ylt41zxrIqWPq+g8AGLG8sAubI5V1DWD53kXDZpGzgiocY+m3OyP8Bye1Bs0II7HeTtJsUMnT21X3ajniUvFyzG6HRl0ICVvBGhYeL44mKKbjfiGz0SqXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249757; c=relaxed/simple;
	bh=Ex99HcQ2K7x2ufsRjc7Lxmq6FBeEnKmd897J1BZVJXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duvJHPmS2ioL5E7AEiBiLBpB8AmqvYW8xU68Qsn4oDia0WbS4p8Vsujusj/vv5p2U/6yD363EqoVWEGbS3Wsqcb+GLwB05gnVWN5J4uTUIdjRATZFFnHH+mvyxGp5BgHQu+7Y/oNyaa+ZaRvBQUaRZSsa5KICEpfv3TtPdVKnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fYD3P5O4; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-330469eb750so4127796a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 11 Oct 2025 23:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760249756; x=1760854556;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoNG3GhcaN9M1znc7IxUx2dLvIQ3aEesmiB+jlAS96k=;
        b=hQ2/jcFH/p4PvjdYFcst95KJv/87bwQ3Ggy07tkWL+QmW/ODgFvZ9TuSpXiWAYAsbF
         9lQs0lOEl0xYYn0o6AIBqqOJYdGCAHzAhLvdy8o1KtHZGEAgU3WWiiOSDvUBowuts3p3
         h87ZUE1HcNenF0XiZQnhuHGmCH5bFw2ay1l+Lzpo32iGu0rZOxpyNcWSaEgWj5WZMjFe
         g5zQ3fgsl0MLsQveR54zM/A8GAWaM2EK+Qvy6Y3MOj1vmzm6VPM0crdXxOnLsVBDBYTO
         r+OH14NjFCzxaJhu9KBBD1bi8hfR9aqfWk931nt0Dz8KM/s8cBTz3ruJvYxmsecd/IK/
         80/g==
X-Forwarded-Encrypted: i=1; AJvYcCXyNoW4Q8bi6BjiGRvXZPaq3WgFYYCt9xrnhtTbX7xOEY0YCJAX3EuYrgveMYN5H1Jqft+HJenL73F7tMMtYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCvaOuyylyLc5KmNwznfVVwGO8bRC1TAN4JI5m9eyPtzwfcyg
	CiNJvOC4fY6DRkNTHx4YIVkHwatrsnaSb89cVbrEXzWWpX/FwHUQX6VUbbblYNTm2O6f6e57UJr
	DAP0MBGLX8tDlX25ozmo5Wz/Mpxhzt0yFa7H2o9uWr+Vnc3nFSM+QbO+BahkbQIYXc4diC8z7qb
	0FozvkPhzrlVBhU1GWhrk0IVSidj8MfRK7E6XhCC8ilXtGZakF25NT8Vtt/1F3i4dLpq8AM94vK
	a08jmBJLttIxMbR4fbgMKaU4NJP
X-Gm-Gg: ASbGnctCbhLv3S++sWkrIZ6a4ujj3KK0HQUxRhog9aD6Q2M3ohl02QL/Newsa0WpxWV
	t5rh+EZef4pVlhPKpSfroDgTMXEe6O+7N6PxwSdcsf6J22x6V7/AYBmcPHGTBwiltIrhqkGEvPy
	put7rF76GTZQtjK0zJt0QqgdZGtlh4GTzvPbaQOzdzcOh/6hprk55nckzMFIS9s06SNE353VN7u
	ZJWRbJQ0N7MsfVYaecvYb9GGsJEF+YFW4qhn2Z1f0a2ZonE+5xTChMyY7LZrMOjQ2aoS4Uzd6gA
	CM98OkPIAx88l5fXNH9cHAZC34NLugizZ3+nxVOI2CQMzL/k4aj8iWrPBwNgkFqJ19SRQFMATFG
	pp2gLr7Dd7lk107ZIenRBxQ5JtLSL2YXOxGVvA+pfQcgSGcEf+uvVLJr1aydrfmqyog7HlFOiPK
	Tpmku2TQ==
X-Google-Smtp-Source: AGHT+IHStimnvrt2KixFmHS4qq/D5hBhJBSSxYePBMkNOm4v3lNaK+y1FELbbd52ZLXo1y/eh43Ls1NrjZxT
X-Received: by 2002:a17:90b:4b45:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33b51106a08mr24204587a91.8.1760249755672;
        Sat, 11 Oct 2025 23:15:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-33b61a1d3e7sm669558a91.2.2025.10.11.23.15.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:15:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3d525fb67eso414778166b.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Oct 2025 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760249754; x=1760854554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JoNG3GhcaN9M1znc7IxUx2dLvIQ3aEesmiB+jlAS96k=;
        b=fYD3P5O4AaPLFIcIal9P1s9GVAPYFwL+ejt6oQU9SK2gOQcJu+7+VQxODdTBlcKSCP
         WmvO6OwA9htE1gdtNkkBe173gXNwEd19uHDHin56y9CeG/tgVH8YG2OYoTB5zgCpfjwS
         IbtuNRK2v9UoaeRpyTr5SMRWo9rLt4eb6lIos=
X-Forwarded-Encrypted: i=1; AJvYcCUzEBpo97Vpzl9J+60lFJtYzSvlXU3FjWidGOCe8o0vqULas8GbZf5a7yvQ+SFCBmGMOH3V4mG5tj5QD/tHTA==@vger.kernel.org
X-Received: by 2002:a17:906:4fd3:b0:b4c:137d:89bb with SMTP id a640c23a62f3a-b50aae952eamr1420711566b.29.1760249753726;
        Sat, 11 Oct 2025 23:15:53 -0700 (PDT)
X-Received: by 2002:a17:906:4fd3:b0:b4c:137d:89bb with SMTP id a640c23a62f3a-b50aae952eamr1420708966b.29.1760249753297;
        Sat, 11 Oct 2025 23:15:53 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12d2bsm656576266b.49.2025.10.11.23.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:15:52 -0700 (PDT)
Message-ID: <e5903078-7bd3-4267-ab79-b97190ef3bc3@broadcom.com>
Date: Sun, 12 Oct 2025 08:15:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: fix crash while sending
 Action Frames in standalone AP Mode
To: Richard Reigh <richard@govivid.ai>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 chris@streetlogic.pro, linux-wireless@vger.kernel.org, s311332@gmail.com,
 wahrenst@gmx.net, wlan-kernel-dev-list@infineon.com,
 johannes@sipsolutions.net
References: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
 <20251009073928.6803-1-gokulkumar.sivakumar@infineon.com>
 <CAFwtOaU45QEO=1jMsvM9EqbQ8NVYgDnXzV5k2s5xVaZo-z2zVw@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAFwtOaU45QEO=1jMsvM9EqbQ8NVYgDnXzV5k2s5xVaZo-z2zVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/10/2025 8:35 PM, Richard Reigh wrote:
> On Thu, Oct 9, 2025 at 2:41 AM Gokul Sivakumar
> <gokulkumar.sivakumar@infineon.com> wrote:
>>
>> Currently, whenever there is a need to transmit an Action frame,
>> the brcmfmac driver always uses the P2P vif to send the "actframe" IOVAR to
>> firmware. The P2P interfaces were available when wpa_supplicant is managing
>> the wlan interface.
>>
>> However, the P2P interfaces are not created/initialized when only hostapd
>> is managing the wlan interface. And if hostapd receives an ANQP Query REQ
>> Action frame even from an un-associated STA, the brcmfmac driver tries
>> to use an uninitialized P2P vif pointer for sending the IOVAR to firmware.
>> This NULL pointer dereferencing triggers a driver crash.

[...]

>> +bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
>>                                   struct brcmf_fil_af_params_le *af_params);
>>   bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
>>                                             struct brcmf_bss_info_le *bi);
>>
>> base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
>> --
>> 2.25.1
> 
> 
> Hi Gokul,
> 
> I tested your patch on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
> and can confirm it fixes the crash. The iPhone now successfully
> queries network information without causing a NULL pointer
> dereference.
> 
> Tested-by: Richard Reigh <richard@govivid.ai>

Hi Richard,

Thanks for testing the patch.

Regards,
Arend


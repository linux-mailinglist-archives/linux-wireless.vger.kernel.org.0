Return-Path: <linux-wireless+bounces-22189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB78AA05B2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B4C8440BB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE826772E;
	Tue, 29 Apr 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JsbZ+NNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5F29E056
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914948; cv=none; b=g6lM8FUSDFpy08K5RAGVCIgXx47JNJpG3NuUn/WhLjE/HjLCpVAZNuFvh+CYObzv1fRwGR6U2yeAKYsfa1Den5vZ+DiGFEwsQRSXNKaMPccVBEbvZqalx/HHJg8/FW0WXr5sOLzMB3rqS1V2dixkCK+zh07Lbctncw/XdnoxE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914948; c=relaxed/simple;
	bh=5p/zcSDh0hhVd88OFMvabka15+DBfpjFSUq15aAU93E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYKH3Fh1yr0Tb9kDjSFSkJuheocCI4i3FWrYFErNS/lUPqAaxDsUiq2UDicsHyB9guIEJVmP8GVIPueomuDbSwHdezl8NNmsO9a5XD0l9rE8YYtM5JdLPYPMDXslLdIre82kUXgzH9xQw/lL5OdEhMd+YfhpCTwrEd2QGuec7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JsbZ+NNE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736b34a71a1so6748990b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745914945; x=1746519745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HnYE+50A1klUyOeCOMCEsxLSYZkeSm32Zm+myFpegRY=;
        b=JsbZ+NNEXKJNLOyOWEWEVuzZSVIMfcmhPE8wMfMEras6mPGIRZYqBW/NUE1B2QrHO0
         GzZW/KLMaU7n1lJPa5wnJ4bf0LMixqNxKN0c0RR8wK+ybYtXWj15Jb80hmjENTE7NRyT
         eE5LK4WyUzLiyTVNHOc40l4pmmGiRwVuNNqZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914945; x=1746519745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnYE+50A1klUyOeCOMCEsxLSYZkeSm32Zm+myFpegRY=;
        b=YA4fsjlG1McGQmKL9btKWAx3h8j7bdNJh0lIKpbnkoiRKOUbFC9NjrU2WUYQ7Q2VRR
         7xfxBZpO1C+U2njDUtDuOKKoVNM0qXLfCqbJzqKKQrFtuAuZXAQ5DSd3/49lN+hwJyqo
         ZKXVIfV1PGM1dPNUY3EzHz8NaIoQItltAJYElayZQVUDuvtWbrkOk3q/wsCJ+JFKyyAZ
         wWgWFGNAzRNqXNDdStR094i3mUIpmVaTRnlHHPoWYF4QXOshoVeOjQyLElELydGFqz29
         bgglLOn8XNkddC8TPAOILZaIf5Qs3CAgJn93AN1L0Si2Ut8UF2TkhrkVHs/bzRsooWu5
         fWGA==
X-Gm-Message-State: AOJu0YzXMw2dG5rMLmhPsL1WxL+6a1ew4ULcJEmVoRABJDhE1eMkMKCl
	+lebd0M6NLJ2DND7YZVED5g/ZaFX3oXeExHBby6pIZAOpHbZa6x7GWfV/4m2L8WgxiYd7+cgYHO
	dBQ==
X-Gm-Gg: ASbGncso+9x0MiPg8m+E6MAVesZ89n28CtLKSwM+yFh3vyONvMPPpfd9CnPNhiRq8Jy
	rXXNtqT1Zddo7Z2eEyMGI/czGLFYZniuQeRuZzOiruLXt/3cXOxxFfmXXIhc1ozdXlj+ShYlQ+g
	HOArRFTfjasRY+NibeqEz+3FCvhDDCuar01Pi6Bv5Kx9S/k6FTF8ahnyM+PODTP9s/aHitEbTC1
	MWsK+eMHMT8AlLYHgcT2zkcgEm6hqk2Jdi2VkQuUYrzexqIycLtsN7hZiT60QSeL4cAE1Qxcu0s
	FSwlXCskG3AbfJ5f3F8PtFARoKMBStwY1n8q15LvFvs7VRyWWA/bmlJdhw5mGPlGZnyMNjMfy0b
	ffgV2CCxjAfJ9zFrWgztM6XShK54=
X-Google-Smtp-Source: AGHT+IHFYtmoS8Sx2nmZkB+WjW3fNE2vaUxtWEY7dOXY5E03LuOPaYCLFnnFKT5vId9rcfnoxdrQhg==
X-Received: by 2002:a05:6a00:ac3:b0:73e:30de:bacc with SMTP id d2e1a72fcca58-73ff7255031mr16826698b3a.3.1745914945452;
        Tue, 29 Apr 2025 01:22:25 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740274ff852sm1300065b3a.60.2025.04.29.01.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 01:22:24 -0700 (PDT)
Message-ID: <dca65ca5-56ee-4082-b5c7-68e49435c06c@broadcom.com>
Date: Tue, 29 Apr 2025 10:22:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
To: Johannes Berg <johannes@sipsolutions.net>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com, Jouni Malinen <j@w1.fi>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
 <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
 <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
 <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
 <c4b1d809-59fc-4d65-a840-d35598e8dfe5@broadcom.com>
 <aAyQma_qLrH_7S2a@ISCN5CG14747PP.infineon.com>
 <09f9a8700163a509846418354235bd3b84e8d532.camel@sipsolutions.net>
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
In-Reply-To: <09f9a8700163a509846418354235bd3b84e8d532.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/2025 10:37 AM, Johannes Berg wrote:
> On Sat, 2025-04-26 at 13:21 +0530, Gokul Sivakumar wrote:
>> IMHO, In CFG80211, if we introduce a bitmap to track which BSS Parameter
>> is changed by the userspace in the SET_BSS operation and then used this
>> bitmap while handling the request, then the WLAN Driver would reject the
>> operation with "EOPTNOTSUPP", instead of doing AP Isolation, because it
>> does not support setting the other BSS params in the request.
> 
> Not necessarily?
> 
>> For Example, considering hostapd (iwd doesn't support SET BSS operation)
>> if the user only enabled the config file param "ap_isolate", but didn't
>> explicitly set "preamble", hostapd would implicitly set default value
>> (0 - LONG_PREAMBLE) in the preamble param while sending the SET_BSS
>> operation request to CFG80211.
> 
> But presumably that's still the default value in the driver too?
> 
> Hostapd could also be fixed too, to not change it if not requested.

To me this raises the question as to when this SET_BSS primitive should 
be used. As I recall one of the goals of nl80211 was to get rid of doing 
individual configuration change like we had in wext which even sometimes 
required specific order to get what we want. So why are these parameters 
not in the START_AP primitive (actually the P2P parameter are). Some of 
the parameters are probably implicit as they are represented in the 
beacon data passed in START_AP. The ap_isolate however is not expressed 
in the beacon afaik.

When all parameters would be handled by START_AP what would be the need 
for SET_BSS. I think it would be to modify the parameters for a BSS that 
is active, ie. beaconing, and possibly serving client STAs. However, 
this is where I get a bit confused. There is also a SET_BEACON primitive 
which looks like it supports a similar scenario.

>> CFG80211 would then mark the bit corresponding to the SHORT_PREAMBLE BSS
>> param as "changed" in the bitmap. WLAN Driver on receiving this SET_BSS
>> request, would then have to reject the entire operation without enabling
>> the user requested "ap_isolation" param, because of the preamble param
>> that is not even explicitly requested by the user.
> 
> Or the driver can accept short-preamble setting, and reject it only if
> it's set to short-preamble, rather than long-preamble.
> 
>> However, for other AP BSS Parammeters, we don't have the corresponding
>> NL80211 feature flags.
> 
> Uh such a long time ago :) I don't remember why we had these. Given the
> above do we need new ones? We can I guess, but I'm not sure it's needed
> even if we change hostapd - if we do change it then it can just set only
> the ones that were set in the config file?

The drivers that implement .change_bss() today have a relaxed policy. If 
we add restrictions in .change_bss() for brcmfmac that means from 
user-space perspective the API is not driver agnostic. Restricting the 
.change_bss() in the other drivers will likely cause user-space 
regression. So there should be a capability exchange between driver and 
user-space. My idea here is to have the driver add a nested attribute in 
NL80211_CMD_GET_WIPHY listing the bss parameters supported. Probably can 
use the same attribute as flag in NL80211_CMD_SET_BSS to indicate 
user-space does handle the bss parameter support info from the driver. 
Will try to get something implemented to see how that goes.

Regards,
Arend


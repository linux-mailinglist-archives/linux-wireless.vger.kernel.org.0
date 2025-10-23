Return-Path: <linux-wireless+bounces-28183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B4C008BE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1468B19C66F7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475C3064BB;
	Thu, 23 Oct 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="envHnqgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844C1804A
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216169; cv=none; b=RXnaUCGc7ANxw0oa0BKaFeYOtpAHBt0hXxWH5phQXU8+Ka7IO/jkFclqSk7thLsTrF465g11U3iVUXQ9Ytxxb9T6F4ccjrNh73fptIXt7dVHzAo5Y4JMXHGr3p+iK8EZg4doDBcEWDYa7pbt/zUThM+S9O8kqxJFIyBhib6cLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216169; c=relaxed/simple;
	bh=n/xZM8n22nFHKZ6e6otWxRw0eIWjOIdonEm1GvVupwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pwfSa042kuHdSGFI6bClvZs3qm8hEgz4NQzupV6ySkMwGna6upa3otc1o4ocTvOeK2mmvll//WwKfW1gQTPYJo3YHBIQHI1ccWtI3eO6amNT2DWdVmvDr0CXmNHd9SWwX3Hz5/kW/yQLkuUR8NL65aj8aYKauySk+fO0YPoU64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=envHnqgn; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29476dc9860so3313735ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 03:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216167; x=1761820967;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlVa3o8KCZev/Xc6g+qB46PrsHJwpamp8X7A9zs/vC4=;
        b=ISBEGkSSATQMO/s6zBw09/b257sXzGtMv938ErvkkbzaJnD1/HWORwEWwFBKIhDAoh
         axUHhtr91spvP4+kU7xwk8a3DLFPqo10X6DTTTZrdXXQYvzC1qb4YUlowmr4j4jVa2v0
         Gw+xfBpysLP9JMWq+SnGPLVZPqfq+dTLw0mxYUrIR28lmsk5alGo0E2DZl9f0sOZbLR0
         AzhUS/STAZOUdxwiKRWsDiqm/ywxDWuRzsokME2bQ9p5CLS4YLoug4JwUuwNevPUtCeo
         nsSS1GRz+bTwznYXNTOb64xbz8CXAGOhNWr++XX4QFNlmYC0+C+vCXz0X+BO3LGaAPIB
         snmg==
X-Forwarded-Encrypted: i=1; AJvYcCUq4wTkE4OlHeN6bX4Py7BEhXT6gAiArYsG8egfUw9Si65Y6VwuTSTcI8hRnVblEI8HHMTR2olkXDf/+ysXEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkkiC5aVWeVFAVUoweE3mi/xh3rTRnyTgpTxJXE1VwxdKJ47d
	8zCt7+MTkHOC3JJFjpvoQIXIX/ZI5/NO//zPiGk2eKxUjZ7gnBPmuDG8zKNesaErq8Nyw0VBpS2
	JHfiTU6DAIZo7u0spfIXaslJmIno76RY7On9R9EUg+7DgeWIiSgl5/v75/79ftfL4X2BMprBgit
	ZNemhtOEi2UP43x7etDlvsyfol/APODHOBqFNroCnQRLhLIFiiV+jyXDmUk8igvGWj0NNbxgQ8W
	NDclzSRob8rvBPy1btXh9NhkPg+
X-Gm-Gg: ASbGncuvsmQaGhm3I9Ad8YZq3Utv+W3EQ9r/31vVSYw7zdqTvBvr0vipQyMVaEEd2hr
	hGBt5b0fuZu56vz2taYLp07uxZrSJDnIHnatal8qWrdG0bc7eyJTiELyNSh6YjELk1SWv3HbdfU
	XD5bCc0dusfrpN2tUAFE/OouZOe0RZ/TSiO6t04l/3ql9EoewKAYlijAhS7wnb7JWYQDNk3inVx
	SIzBJnQKL4XE419WZQJTA+ObU801RdFcHpDP+cQu8fWx5thqMPDIX+OFoSKykO+Wfzt5HZX9ZjS
	i+Tg6Eq/GbQml7+ufg+hGiEOv7f/ZFSHjiPQRh1CX9Fp+YLF3a3CGjFHoi7kWaODBAPbbBVxCTh
	uLYkommzXRDs7/K0ShiUv/IH0y90K81SusxsYg+t+4QSrYPSdUhVpH4xefNIPwc1I/2Iluf6BT2
	PY72OU1YL6Nd+Cv4ijWrkXE2x3um9W9xx7z6cf1Kfz
X-Google-Smtp-Source: AGHT+IGWdBHQfMJ1qiyvNRDvSdJN807hj9NSvgMNl/kwI3ejdjwyzXbWVROqCBbr5oa5D/4nlz16iU3wGCDF
X-Received: by 2002:a17:902:e843:b0:290:c0ed:de3a with SMTP id d9443c01a7336-290ca30e492mr295728495ad.30.1761216165773;
        Thu, 23 Oct 2025 03:42:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2946df1b2aesm1887815ad.41.2025.10.23.03.42.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:42:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471144baa6bso2863125e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761216163; x=1761820963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AlVa3o8KCZev/Xc6g+qB46PrsHJwpamp8X7A9zs/vC4=;
        b=envHnqgntFbqSyjUtsTVkpbYOBeokXURBWBrOmqrWAxGFxtgoasqdLYbsT4ePEMZeJ
         BRszEnpXOxyyMy5g66+dMVBXIUXqqgZVs0ypWauQlJ2CXFHryQKNPyqTnGPhP3bSOpMG
         C0sul/ABKRwYqnrlMzCunVJeFu6OCohBlhex8=
X-Forwarded-Encrypted: i=1; AJvYcCXEOPkFSFc0RSFSPPi14qT91X73aAXuRbfwpk3et8zxTD6P0v1klmsETxtxXUx2xVuiG57VLtXyVU/F3dG/nw==@vger.kernel.org
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-471179202famr168147515e9.36.1761216163451;
        Thu, 23 Oct 2025 03:42:43 -0700 (PDT)
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-471179202famr168147345e9.36.1761216163002;
        Thu, 23 Oct 2025 03:42:43 -0700 (PDT)
Received: from [10.176.3.11] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm87788295e9.6.2025.10.23.03.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:42:42 -0700 (PDT)
Message-ID: <6c5c0180-fc6b-421b-a2cf-3342cb6dc21b@broadcom.com>
Date: Thu, 23 Oct 2025 12:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broadcom brcm80211 Displays WPA3 as WEP in OpenWRT
To: Stephen C Goodman <Stephen.C.Goodman2@outlook.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
References: <AS8P194MB1919C4BF0BF0BF222F65BA449DF2A@AS8P194MB1919.EURP194.PROD.OUTLOOK.COM>
 <AS8P194MB19190A3E9648FD04DCFD5A789DF2A@AS8P194MB1919.EURP194.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P194MB19190A3E9648FD04DCFD5A789DF2A@AS8P194MB1919.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/21/2025 2:45 PM, Stephen C Goodman wrote:
> I would like to report a bug concerning the Broadcom bcm4366c0 driver, which affects most brcmfmac PCIe chips.
> Issue Details:
> Chipset: Broadcom bcm4366c0
> Environment: OpenWRT
> Kernel Version: 6.12.54
> mac80211 Version: 6.16 (backports)
> Description: While WPA3 is shown as SAE in OpenWRT LuCI, attempts to connect to the network or using a Wi-Fi analyzer reveal that it is actually operating as WEP. This discrepancy creates confusion and undermines security expectations.
> Steps to Reproduce:
> Use the Broadcom bcm4366c0 in an OpenWRT environment.
> Configure a wireless network with WPA3 security via LuCI.
> Attempt to connect to the network or perform a scan with a Wi-Fi analyzer.
> Observe that it identifies WPA3 as WEP.
> Please let me know if you require any additional information or logs to help diagnose this issue. Thank you for addressing this matter promptly.

Can you get radio info using the iw utility? Also please share the 
contents of /sys/kernel/debug/ieee80211/phy0/features and 
/sys/kernel/debug/ieee80211/phy0/fwcap.

Regards,
Arend


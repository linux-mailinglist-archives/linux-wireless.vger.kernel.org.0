Return-Path: <linux-wireless+bounces-11256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390B794DC68
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB94D1F21B59
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7036146D75;
	Sat, 10 Aug 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SGV7QIL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B72941C
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723288523; cv=none; b=rhzAqu85UFTO72XJIL40UpuSdQoworCvuU8kaqn1e6mar3JYdB9j2RJTSsDQ7D5IWDdEKUEJEipR492vQg7Y3TiQ1Sq3mUZVVvfAOv6lVV33lIuu9UD9KYATvkcY6w4RpSEOA5yPW2SpesZhcFL6dkK8JinX/5DvZ7Kfeaqv4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723288523; c=relaxed/simple;
	bh=/AGpnyCGOcrUhFH+QhwHIGn0YZ4bQIeXQ/kX5/UzP/8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UxXZXgYMBLAMP/9ENsIKXWdMuED5gxbK1OhKz94zGW/mKlql+NFzm2xzOm0ww7IiU0Gz7tB8GxgEQPxtieqPeZVASe7Rv+xc6YK3oghN7pWpjD/mtd9dkN+kLawYnRd/iAAEd+eBO9mdtNqdS7yeLt52/Hr+TlCe2h2da38RdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SGV7QIL/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so309333666b.2
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723288520; x=1723893320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyREcqbRzvE7tBa4QH5d0FeClLIHYh+fPSCpyZ6XaX0=;
        b=SGV7QIL/EGOlhAgNXrZK27KglT6ZkRDQbtdfutx40odszKFES6t0j6CN3byYJiyQzC
         PfqTc42QVleAiZN0tYcfhcEyxFQ5XJj1VNPYXFfLkmpz6l+VIxLNqvOSZ03Mi8pogz59
         01zoGfT5stawvA9GOOKivCQexmDgHIGJ3dIDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723288520; x=1723893320;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyREcqbRzvE7tBa4QH5d0FeClLIHYh+fPSCpyZ6XaX0=;
        b=dHqUr/7jhn7JTBsy4D6LKcDxhO1s15Hj+0T9GuAJfbhi7nuBD99jlQEcpeaYgrSZ+g
         dg+NtGAbqxUWiga43fmMZvaFBnhLP9on1erbjt0akA/cDJGuL3ddZaP4kxydPLEJ3+Uv
         zP3TguxHP5poQv9PscOwwjYZgF7qePKmg74Evj7lXrBM4t1m+7yYK3MvIaaj1EcJAF16
         oeHBqisrOh+eiPJ3M2/tPLBd/qk7qUnjYihjpwA4zpEYSDQCCDZAT8UmfKWxqkE+7rht
         3BYFagCW/IZeL/Lk8ZxxNPtBmqszPSfxAdQ9KdzRMw83JXizK8ND7v811qyUOLcbWhWL
         2Uhw==
X-Forwarded-Encrypted: i=1; AJvYcCVdNesKtxG+bYH0IkenvL3gl2MHJeOQ4pSdWx7kb3K6Xh/7VpPyLbSXsyBQCKRZDNAfDypgKItGxjxUwHopmNoNj3NPDdXple1G+ZILnuk=
X-Gm-Message-State: AOJu0YyGidXR87YVAAqTwiRlgna+L6eEo2urG0LiC9Y1v63MAeOKEzGA
	Rc7UrDv7L4MHyFlMV27KddltUF0QYxsxfgRbdAd4l8C+xB9dnh0ThHu3PqPKww==
X-Google-Smtp-Source: AGHT+IHpXql5JpAa5ikTcA+o71dpL0i1v1hx9upMm8hoO62se/4vP1cyYBrGhn2WcAyzVkbs7yhovQ==
X-Received: by 2002:a17:907:c7c5:b0:a7a:9f0f:ab26 with SMTP id a640c23a62f3a-a80aa59b3dfmr344277366b.23.1723288520055;
        Sat, 10 Aug 2024 04:15:20 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80c7ceaf06sm7942166b.88.2024.08.10.04.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 04:15:19 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Janne Grunau <j@jannau.net>, Jouni Malinen <j@w1.fi>
CC: <hostap@lists.infradead.org>, Vinayak Yadawad <vinayak.yadawad@broadcom.com>, Aditya Garg <gargaditya08@live.com>, Hector Martin <marcan@marcan.st>, <linux-wireless@vger.kernel.org>, <asahi@lists.linux.dev>
Date: Sat, 10 Aug 2024 13:15:19 +0200
Message-ID: <1913bfffd70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1913be30f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
 <ZrclLHJ63RxnG/B3@w1.fi>
 <d82c88a2-77f7-4308-97fa-c5b4446e2cf5@app.fastmail.com>
 <1913be30f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: wpa_supplicant 2.11 breaks WPA2-PSK / WPA3-SAE authentication on Linux' brcmfmac
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 10, 2024 12:43:43 PM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On August 10, 2024 11:17:56 AM "Janne Grunau" <j@jannau.net> wrote:
>
>> Hej,
>>
>> On Sat, Aug 10, 2024, at 10:30, Jouni Malinen wrote:
>>> On Sun, Aug 04, 2024 at 02:23:56PM +0200, Janne Grunau wrote:
>>>> wpa_supplicant 2.11 on Linux's 6.9.y / 6.10.y brcmfmac driver runs in
>>>> authentication timeouts with WPA2-PSK and WPA3-SAE. This was reported
>>>> with Apple silicon devices using Fedora Asahi remix with a patched
>>>> driver as well as other devices without additional brcmfmac patches.
>>>> See https://bugzilla.redhat.com/show_bug.cgi?id=2302577 for some
>>>> reports.
>>>>
>>>> I've bisected this to
>>>> https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5
>>>> "Mark authorization completed on driver indication during 4-way HS
>>>> offload". Reverting this commit on top of hostap_2_11 properly
>>>> authenticates the connections. Looking at that change and the code it
>>>> looks clearly broken to to me. As far as I can see is
>>>> `assoc_info.authorized` for the nl80211 driver only set when
>>>> QCA_WLAN_VENDOR_ATTR_ROAM_AUTH_AUTHORIZED is set (in main, I did not
>>>> check older revisions). This doesn't seem appropriate to expect this
>>>> on chipsets from different vendors.
>>>
>>> This commit is from Broadcom to fix some race conditions with the 4-
>>> way handshake offload which I'm assuming is for a Broadcom driver..
>>> Whether that is for brcmfmac is unknown to me, though.
>>>
>>> It looks like the goal here was to move completion of the connection
>>> from the association event to EVENT_PORT_AUTHORIZED, i.e., the
>>> NL80211_CMD_PORT_AUTHORIZED event from the driver. Is that event not
>>> delivered by brcmfmac? I did not see any full wpa_supplicant debug
>>> logs for these issues based on a quick look, so I could not check
>>> that myself.
>
> I was surprised to see this was coming from Broadcom. I did not yet contact
> the author for more details.
>
>>>
>>
>> The following place in brcmf_bss_roaming_done() is the only place where
>> NL80211_CMD_PORT_AUTHORIZED event is posted.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c#n6402
>
> Right. This seems to be added exclusively for Fast BSS transition scenario.
>
>>
>> In my initial analysis I missed that the NL80211_CMD_PORT_AUTHORIZED is
>> delivered directly to wpa_supplicant.
>>
>>>> A revert looks to me like a possible/proper fix. I can send that
>>>> later if no alternative materializes.
>>>
>>> I'm inclined to revert this if it is indeed the case that
>>> NL80211_CMD_PORT_AUTHORIZED is not delivered reliably by the upstream
>>> driver and this commit was tested only with some non-upstream
>>> versions.
>>
>> I intend extend the upstream kernel driver to post
>> NL80211_CMD_PORT_AUTHORIZED after successful connection with
>> authentication offload. I expect that the change will be accepted for
>> the stable kernel. Infineon/Cypress have non-upstream patches for the
>> brcmfmac driver which implement it already.
>
> Do you have a reference to see what they have done?
>
>> A revert in wpa_supplicant might be still appropriate until exteded
>> kernel drivers are deployed. The wpa_supplicant Fedora package carries
>> the revert as patch:
>> https://src.fedoraproject.org/rpms/wpa_supplicant/c/c2eac195adadd2c48b04f8752cc46b12a351e69
>
> Agree that revert makes most sense here. So what upstream drivers use WPA
> offload. Only brcmsmac and QCA drivers?

Obviously mean brcmfmac here. Autocorrect is mostly wrong ;-)

Regards,
Arend





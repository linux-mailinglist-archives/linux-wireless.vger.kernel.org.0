Return-Path: <linux-wireless+bounces-11255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D394DC59
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 12:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2608D281BC6
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A186157467;
	Sat, 10 Aug 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXAiX9X4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5A2F2A
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723286629; cv=none; b=o9gYKek0H2/Yg1KH9SpS+WnSx2wPwnzt3VkKq6H6ys6ZN8kzslqmWPJxDhkGMal40mSV844famQZXJQhdI7BCiHDGeJefJlU4jxELFZySAl9dQBPEJI780GpQYA1LXZcas3fbM9neCNDT1tPN+Obf9+CWL4JKEJ8QLswhC+oszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723286629; c=relaxed/simple;
	bh=4kbJcO4yQBxxX6bDmKirDLsjqrZ4GKcbtgr7h3VBrko=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LBcwUh6vUh+9xAJpuonXUaDin4NWNT0KzInHMu7aqPOUgOe/vEwqEvIIGSP3KywnxIOdwZCtF0NoFSxvvdF6OfUZf8KZHxBYTh5mnrMOy3/oV1eA6EPHxcN3nBdVHM8jbazrwJDcyiJwzeT9cvm/Zd8Xn7NZ46612H9VONlgTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SXAiX9X4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a843bef98so307675766b.2
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723286624; x=1723891424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z4Qb6leldLOtOon5tDrbo2KB77r7pOOl+XtSRnlHlU=;
        b=SXAiX9X4vIO4C8YTyEDBGkJbjcHHin5CxP0O5EGxU6F3ZIs5kSVM2iz3GLyvdsnr2K
         WnbJuy4jsoIeFNlGgDho/Ac56h+FrlwN2U3Acky9PzpoSTInFUhkbbTVJxCyOXQcBJDI
         xYJmdAPl0dD95N+eRRfBhuU6AyUp+wNmqROko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723286624; x=1723891424;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3z4Qb6leldLOtOon5tDrbo2KB77r7pOOl+XtSRnlHlU=;
        b=Ypia7yGz4AkTvwxF1woi8Yd0EipvdLAFWpCDcDiLTknCSvOhJTWdH0JtN0kjb1K5dX
         qqsK0R7/66e/7zh2slPDq6d6VbO/UYa9OYQEDcX1LmzlcgZGgKExI/LT9MfjE/utjDUm
         HF1J3TbGsrceAETAuegF7/iKArtV17MDkqEvWSnULgQhJCRT3dYe3dbjISxi9yUasCL9
         Zj2XFoSXjHgrQe03LYnrL0bdvF8uNrboyNA3hQujzx1mJhdWd5zI0xdx5d6mTdLsjr8j
         fyMJ9/PNnD8NFBcvgM1gRDroKm/z7iF8C8IeYCIg+n8nGdPQS4ptI7AukRX6Bq5y61GZ
         ct8w==
X-Forwarded-Encrypted: i=1; AJvYcCX+wgZ2GjJo69tcB1P71O9hukwnS2p8Rudg7a6WQR0fapd4q+Sc5f0zokKR+q6r69x6U5EIuUyyAFbS+3QNtsbCzenBNr1+0YIyttUVii4=
X-Gm-Message-State: AOJu0Yz1LkTU1mLpOtdFjSqfgieE2Cd3XTHBuL7A1JJeHRKPt07rrnhy
	+Ubbb2ytvBAaM9P/mNn7fHhqvQcTUQ3LY0HrcUqKi8kSL3LROGsk/DkURXRb7FEhvGe1kTLR2Fb
	AjQ==
X-Google-Smtp-Source: AGHT+IEahdZ12zM1rAf/OmMoEVBM7vsmLmoslqqHxqVdRcMkCF6n0YrdrAvtTsbaZef6xcptLBPzUQ==
X-Received: by 2002:a17:907:e644:b0:a77:d85c:86fa with SMTP id a640c23a62f3a-a80aa558c8emr334626366b.13.1723286624011;
        Sat, 10 Aug 2024 03:43:44 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce2csm59143766b.98.2024.08.10.03.43.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 03:43:43 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Janne Grunau <j@jannau.net>, Jouni Malinen <j@w1.fi>
CC: <hostap@lists.infradead.org>, Vinayak Yadawad <vinayak.yadawad@broadcom.com>, Aditya Garg <gargaditya08@live.com>, Hector Martin <marcan@marcan.st>, <linux-wireless@vger.kernel.org>, <asahi@lists.linux.dev>
Date: Sat, 10 Aug 2024 12:43:43 +0200
Message-ID: <1913be30f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <d82c88a2-77f7-4308-97fa-c5b4446e2cf5@app.fastmail.com>
References: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
 <ZrclLHJ63RxnG/B3@w1.fi>
 <d82c88a2-77f7-4308-97fa-c5b4446e2cf5@app.fastmail.com>
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

On August 10, 2024 11:17:56 AM "Janne Grunau" <j@jannau.net> wrote:

> Hej,
>
> On Sat, Aug 10, 2024, at 10:30, Jouni Malinen wrote:
>> On Sun, Aug 04, 2024 at 02:23:56PM +0200, Janne Grunau wrote:
>>> wpa_supplicant 2.11 on Linux's 6.9.y / 6.10.y brcmfmac driver runs in
>>> authentication timeouts with WPA2-PSK and WPA3-SAE. This was reported
>>> with Apple silicon devices using Fedora Asahi remix with a patched
>>> driver as well as other devices without additional brcmfmac patches.
>>> See https://bugzilla.redhat.com/show_bug.cgi?id=2302577 for some
>>> reports.
>>>
>>> I've bisected this to
>>> https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5
>>> "Mark authorization completed on driver indication during 4-way HS
>>> offload". Reverting this commit on top of hostap_2_11 properly
>>> authenticates the connections. Looking at that change and the code it
>>> looks clearly broken to to me. As far as I can see is
>>> `assoc_info.authorized` for the nl80211 driver only set when
>>> QCA_WLAN_VENDOR_ATTR_ROAM_AUTH_AUTHORIZED is set (in main, I did not
>>> check older revisions). This doesn't seem appropriate to expect this
>>> on chipsets from different vendors.
>>
>> This commit is from Broadcom to fix some race conditions with the 4-
>> way handshake offload which I'm assuming is for a Broadcom driver..
>> Whether that is for brcmfmac is unknown to me, though.
>>
>> It looks like the goal here was to move completion of the connection
>> from the association event to EVENT_PORT_AUTHORIZED, i.e., the
>> NL80211_CMD_PORT_AUTHORIZED event from the driver. Is that event not
>> delivered by brcmfmac? I did not see any full wpa_supplicant debug
>> logs for these issues based on a quick look, so I could not check
>> that myself.

I was surprised to see this was coming from Broadcom. I did not yet contact 
the author for more details.

>>
>
> The following place in brcmf_bss_roaming_done() is the only place where
> NL80211_CMD_PORT_AUTHORIZED event is posted.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c#n6402

Right. This seems to be added exclusively for Fast BSS transition scenario.

>
> In my initial analysis I missed that the NL80211_CMD_PORT_AUTHORIZED is
> delivered directly to wpa_supplicant.
>
>>> A revert looks to me like a possible/proper fix. I can send that
>>> later if no alternative materializes.
>>
>> I'm inclined to revert this if it is indeed the case that
>> NL80211_CMD_PORT_AUTHORIZED is not delivered reliably by the upstream
>> driver and this commit was tested only with some non-upstream
>> versions.
>
> I intend extend the upstream kernel driver to post
> NL80211_CMD_PORT_AUTHORIZED after successful connection with
> authentication offload. I expect that the change will be accepted for
> the stable kernel. Infineon/Cypress have non-upstream patches for the
> brcmfmac driver which implement it already.

Do you have a reference to see what they have done?

> A revert in wpa_supplicant might be still appropriate until exteded
> kernel drivers are deployed. The wpa_supplicant Fedora package carries
> the revert as patch:
> https://src.fedoraproject.org/rpms/wpa_supplicant/c/c2eac195adadd2c48b04f8752cc46b12a351e69

Agree that revert makes most sense here. So what upstream drivers use WPA 
offload. Only brcmsmac and QCA drivers?

Regards,
Arend





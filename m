Return-Path: <linux-wireless+bounces-10224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5A931381
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030D4283636
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD218A935;
	Mon, 15 Jul 2024 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKJjVft1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB8189F5C
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044448; cv=none; b=j1yc8QWMMXv735Lfo/zPbV8KTsvwBXQOOnfttzp5DEnlbHM2AI8LcnyFiM84PHTyAUVsbWr522/6jLxiWOyqnPHb9mfctzBRwsaB8o1RXnnb06do6vIFBo0MIXoUJDpQswn+DxAE+Us2LQjsim6bX/UfY6rqclXn5BhId5ZWyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044448; c=relaxed/simple;
	bh=irNZRSlARA7IEB+8miQitO2pRURJN+h5BcD0LDQORjE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LGkcM5Zin6/PGKbScc2AAz48mpnIoz0Jw0QcJfRVCgL52qPcKOq7HJxQBqBg4K/3H/RHLldkgLIuFOQD0ym9Ij8w6Se3I3SYxL9oXC/zXrsmJr0h0Si06QCVLHCzc3oSWpQoxtvUhcKjO3ns7PKwiWiontCWBq+MF3Xh+Z0v0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKJjVft1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so4272285276.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721044445; x=1721649245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlxhlv4sEtMXzC1YTV5kDxkXImNQxemkqe4YaLjnH5s=;
        b=kKJjVft1qK2gB8Ofs4M9SFTly0LUQBvfphf41O/IQAKRs8F5jz/H2+cnEbhHawX/Dq
         d5CRF3kZhmIkgmk1ypnMgffdXitvKyJKZktKQapMl7ZCIkRInhXMRbhHdHr7h9VtOCNQ
         Hzy3gZwqDpRrW+aDWBlwp35+pNrCoz2mkc1KZ5n5Wb0oFahFc4ZLr7bLo52zVneYGs/i
         URC3byAwYsnKj+FRVKGRaODlA7HzHtATyuaa5UPBplOLggHK4vDOqRwrUiHRRQH0F8bC
         Ee5VT+fCBHyxxTMVGHSfegYUVjpSG9n9zHhllE1yx/eaulFp5lSD1m7RHozgjAMeMhVa
         PilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721044445; x=1721649245;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlxhlv4sEtMXzC1YTV5kDxkXImNQxemkqe4YaLjnH5s=;
        b=Iy+93EPEMC5ULtXVy/RolIGQ9pkQzXMezlYNBstrnCZwxjB5j+9Sn9u0Ykp1259JJs
         pKNiJK3AFHRx7mC7FseKoC1CvLNnDGTlB5VVWUtvk96k2uMPNy+uGCDwEFpy2rxxxddj
         GFmjfkqb/fQkqo7EJsVPSTV6a+6BZwBSAgZ4X1sPhGn81NAborvTb/BSJrR6t5KfSCDW
         2iEqFJTNvxoL+B6RP23SqFWHUGMZxjTu41UTpSg3V1vUkJlvmAHK//rlbXO/Zvh/EUEK
         LJPKd1VixgJLTjpOk2bq2CBspyIygOm7ObNsIP0opd9UDRK/HX2u22c19VmpTPVgVgd3
         1jHw==
X-Gm-Message-State: AOJu0YxEs9Q2x2f/yNWHU9PwAamhbeZy+dBQovuO11ACdyhpXjchijlB
	M2ajZ+o9Oc9WXzHDcMeT/s3kltzxSDFUvaaS1VVYYTVl1S/FMOy4UCpawA==
X-Google-Smtp-Source: AGHT+IEJmXThxojsIZ+WjF1f4KWp/8RJs/LynNKJvDBDQusPvQlX0tkx4rkLWpDAKvI6jGlCQHQh2w==
X-Received: by 2002:a25:a369:0:b0:e03:48ed:d275 with SMTP id 3f1490d57ef6-e041b173dfemr19456559276.61.1721044444776;
        Mon, 15 Jul 2024 04:54:04 -0700 (PDT)
Received: from [10.102.4.159] ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761a0f7e2sm20369516d6.100.2024.07.15.04.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 04:54:04 -0700 (PDT)
Message-ID: <c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
Date: Mon, 15 Jul 2024 04:54:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
From: James Prestwood <prestwoj@gmail.com>
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
Content-Language: en-US
In-Reply-To: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I forgot to mention:

QCA6174 hw3.0 firmware WLAN.RM.4.4.1-00288-

The higher rate of frequency is happening on kernel 5.15, although as I 
said only at one location with a different AP vendor. We have many other 
5.15 devices with significantly less instances of this happening. I also 
checked a few of our newer software releases using kernel 6.2, and the 
timeout occurred there as well, but no real impact (no disconnect, no 
assoc timeout).

On 7/12/24 6:11 AM, James Prestwood wrote:
> Hi,
>
> I've seen this error mentioned on random forum posts, but its always 
> associated with a kernel crash/warning or some very obvious negative 
> behavior. I've noticed this occasionally and at one location very 
> frequently during FT roaming, specifically just after CMD_ASSOCIATE is 
> issued. For our company run networks I'm not seeing any negative 
> behavior apart from a 3 second delay in sending the re-association 
> frame since the kernel waits for this timeout. But we have some 
> networks our clients run on that we do not own (different vendor), and 
> we are seeing association timeouts after this error occurs and in some 
> cases the AP is sending a deauthentication with reason code 8 instead 
> of replying with a reassociation reply and an error status, which is 
> quite odd.
>
> We are chasing down this with the vendor of these APs as well, but the 
> behavior always happens after we see this key removal failure/timeout 
> on the client side. So it would appear there is potentially a problem 
> on both the client and AP. My guess is _something_ about the 
> re-association frame changes when this error is encountered, but I 
> cannot see how that would be the case. We are working to get PCAPs 
> now, but its through a 3rd party, so that timing is out of my control.
>
> From the kernel code this error would appear innocuous, the old key is 
> failing to be removed but it gets immediately replaced by the new key. 
> And we don't see that addition failing. Am I understanding that logic 
> correctly? I.e. this logic:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503 
>
>
> Below are a few kernel logs of the issue happening, some with the 
> deauth being sent by the AP, some with just timeouts:
>
> --- No deauth frame sent, just association timeouts after the error ---
>
> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for 
> new assoc to <new BSS>
> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key 
> for vdev 0 peer <previous BSS>: -110
> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous 
> BSS>) from hardware (-110)
> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
> Jul 11 00:05:36 kernel: wlan0: authenticated
> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> 
> (capab=0x1111 status=0 aid=16)
> Jul 11 00:05:36 kernel: wlan0: associated
>
> --- Deauth frame sent amidst the association timeouts ---
>
> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for 
> new assoc to <new BSS>
> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key 
> for vdev 0 peer <previous BSS>: -110
> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous 
> BSS>) from hardware (-110)
> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while 
> associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
> Jul 11 00:43:24 kernel: wlan0: authenticated
> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> 
> (capab=0x1111 status=0 aid=101)
> Jul 11 00:43:24 kernel: wlan0: associated
>


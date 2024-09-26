Return-Path: <linux-wireless+bounces-13233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B869877D6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A1B266BC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196DA14884F;
	Thu, 26 Sep 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHAq2G4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60D3F9D5
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369489; cv=none; b=ub2vs3v+gRzWefxt8prs3TtzKjnSN7JYxfgOiODKkmjGQcBui1LyJbwR9sqZ1uAOL5WqcVoScFFi8E04jjYTASvzVakN4UA0cXxkqgpkj0acATOGfjbl/uYDHRkcqJ2qfdJdD9P+AU5iUo19v7yltAF5s4ZsSCfEXvJYzxEhsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369489; c=relaxed/simple;
	bh=+gbu+bqOiU0kaXD23savP097+/ccGTS8alYuYjbP0z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CG+ByBrNIeay3ihDGVp9T6Ppe/WGtg29+oA5OuRrYj4hNEjEHbQe+THS7jvKJuypbiTQOBYOE9iz/ndDw03jm5d+RJ4LCsd7EPnJEqnCJ+heCmImDGto7255FJoL2rRtoNDFX1dUpmXh8At41UNaRL4yqiS5yEPTnJ3QirWRei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHAq2G4m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c3eef39eso800205f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727369485; x=1727974285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gbu+bqOiU0kaXD23savP097+/ccGTS8alYuYjbP0z4=;
        b=hHAq2G4mjwUZMfzN1a++twgkZsOQr1CEAJ3LYcM+SFHi36kbQ9eFpb2ZKz54I4yhKl
         V3BoyNWmhU9vuKEUcbGRCUKzYNHXAGD4V0i7PuRAkyJpFQeHLHOsXc/UQsna6TBXK0ze
         N1PvuvWNLncJglO0OIwgfb41t3vKoMBZlSDekdEk4T38RDl15tgfq+RlNQKoPklzM4gc
         twg7zz2sVAMu+50yGS0/8IiRapevsMtNUNdPGYXBmcX5yYMD+fmSeVbm00hTD+7CJeI1
         V9COs8yoe6iZe4ocecO2fIWYYqJn6AhFaWOT9ymR4/pRY3K9Plewm0KPwHCi/2fyUmzx
         hLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727369485; x=1727974285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gbu+bqOiU0kaXD23savP097+/ccGTS8alYuYjbP0z4=;
        b=Mvg8VIFe1wNiklI5eOxK8BBhjJp0ucYa8s+l5DumEbSyeoPMxoU9fdhfexHze/9QlQ
         VEFNW4w4H9dwrUhEJb6BAUG9B3Bd/7fTs8/ISJ1C77eQ61zZ+GrXmlrGJpMncgNN8xoY
         1zMjjMLimNQGlbJU19VGoLqEjm9e/wfjO1FBmv1ajN7PGHslbarPROeVhrbXA9WFteBT
         SH7joBn3O9eS8Xpo8JQ5TzejwSt/ebiLRxENI89yx0fJA8Uy3MvGLavvp+FwpTLVFdEo
         +g+YekvXcK+8bTGBKtHo85hM0mBmpNS3zmMJri26HqCNQ/Ua7/ux07BpPKGKPQHpCCNm
         NcUA==
X-Gm-Message-State: AOJu0Yx7Qf+kqWOAMDLwpIwrtizAmtbGrSZViI3NH8WiFPajvHxa0pDw
	FrNCI90TeQEjXCjNiXEbHRb9pRsUAEGkalLpSNPPLCM0zziWqFHD
X-Google-Smtp-Source: AGHT+IFtR8NMgOVgr4Ac/BLOrR7ea521lpjWVufuNOhpC33AjeZt2UCQirdqHr4yUUgA7sM8qn5zjg==
X-Received: by 2002:a05:6000:d09:b0:374:c614:73df with SMTP id ffacd0b85a97d-37cd5b108b0mr115206f8f.57.1727369484977;
        Thu, 26 Sep 2024 09:51:24 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d27csm328379f8f.23.2024.09.26.09.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:51:24 -0700 (PDT)
Message-ID: <0ce86878-7baf-45ac-acc4-4fd9e717102d@gmail.com>
Date: Thu, 26 Sep 2024 19:51:22 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: USB devices randomly stop receiving anything
To: petter@technux.se
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
 <ea1e7d48c1724dfbda8e7d28acb386a9@technux.se>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ea1e7d48c1724dfbda8e7d28acb386a9@technux.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/09/2024 16:04, petter@technux.se wrote:
> On 2024-09-25 13:46, Bitterblue Smith wrote:
>> Hi,
>>
>> I have this problem with RTL8811CU, RTL8723DU, RTL8811AU, RTL8812AU.
>> I assume all USB devices are affected. If I have qBittorrent running,
>> the wifi stops working after a few hours:
>>
>> Sep 24 00:48:21 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:21 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:23 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:23 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:25 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:25 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:27 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:27 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:29 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:29 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:31 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:31 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:33 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:33 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:35 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:35 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:37 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:37 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:39 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:39 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:41 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-BEACON-LOSS
>> Sep 24 00:48:41 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVEN=
T-DISCONNECTED bssid=3D... reason=3D4 locally_generated=3D1
>> Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Added BSS=
ID ... into ignore list, ignoring for 10 seconds
>> Sep 24 00:48:42 ideapad2 NetworkManager[433]: <info>=C2=A0 [1727128122=
=2E0377] device (wlp3s0f3u2i2): supplicant interface state: completed -> =
disconnected
>> Sep 24 00:48:45 ideapad2 NetworkManager[433]: <info>=C2=A0 [1727128125=
=2E6030] device (wlp3s0f3u2i2): supplicant interface state: disconnected =
-> scanning
>> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Removed B=
SSID ... from ignore list (clear)
>> Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: SME: Tryi=
ng to authenticate with ... (SSID=3D'...' freq=3D2472 MHz)
>> Sep 24 00:48:50 ideapad2 kernel: wlp3s0f3u2i2: authenticate with ... (=
local address=3D,,,)
>> Sep 24 00:48:51 ideapad2 NetworkManager[433]: <info>=C2=A0 [1727128131=
=2E2488] device (wlp3s0f3u2i2): supplicant interface state: scanning -> a=
uthenticating
>> Sep 24 00:48:51 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 1=
/3)
>> Sep 24 00:48:51 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:52 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 2=
/3)
>> Sep 24 00:48:52 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:53 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 3=
/3)
>> Sep 24 00:48:53 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx =
report from firmware
>> Sep 24 00:48:54 ideapad2 kernel: wlp3s0f3u2i2: authentication with ...=
 timed out
>>
>> After this all scans return nothing. The chip is still alive,
>> though. The LED blinks during the scans (it's hardware-controlled)
>> and another device in monitor mode can see the probe requests.
>>
>> I confirmed that even C2H stop coming. I used aireplay-ng to send
>> some authentication or association frames (can't remember) which
>> require TX ACK report. I saw "failed to get tx report from firmware"
>> and no C2H.
>>
>> While qBittorrent is needed to trigger this bug, simply downloading
>> a random Linux iso did not do the job. "Other" torrents did. It's
>> unclear why. Maybe it's uploading that triggers the bug.
>>
>> I left iperf3 running all day and nothing happened. Only qBittorrent
>> can break it.
>>
>> RTL8822CE doesn't have this problem. I can use qBittorrent with it
>> just fine.
>>
>> I mounted debugfs and dumped the MAC registers during a scan using
>> this command:
>>
>> for i in {00..20}; do sleep 0.5; cat /sys/kernel/debug/ieee80211/phy2/=
rtw88/mac_{0..7} > dead-$i.txt; done
>>
>> I thought maybe some RX URBs failed silently and rtw88 stopped
>> sending them to the device (=3D=3D stopped requesting data from it),
>> but that's not the case. [1]
>>
>> I have the device in this state right now. Is there anything else
>> I should look at?
>=20
> What hardware are you running on? This looks very similar to some issue=
 me and some colleagues have seen from time-to-time when using LM842 (882=
2cu)[1][2][3], when running it on our i.MX6SX arm board. It has thou been=
 harder and harder to trigger that issue on our board. But the outcome wh=
en it happens is identical to your. In our case we get it when running a =
number of mender streamed installations. We also can trigger something si=
milar when doing hw-offload scanning, so we have disabled that in our set=
up. For us however it seems related to slower platforms, we haven't seen =
it on systems with better performance. Also it become a lot better when t=
he USB RX aggregation was added to the chip + running with the patch in [=
3]. We also got it on LM808 (8812AU) then after suggestion we tried morro=
wnr driver [4] with USB aggregation enabled and couldn't trigger it anymo=
re. But feels like all these things are just ways to reduce the risk of g=
etting into this state. So I think you just
> found yet another way to reproduce the behavior. So hopefully that is t=
he first step of finding the root cause of it. I will gladly help to test=
 things in this area if you guys find something interesting.
>=20
> [1] https://lore.kernel.org/all/20230526055551.1823094-1-petter@technux=
=2Ese/t/
> [2] https://lore.kernel.org/linux-wireless/20230616122612.GL18491@pengu=
tronix.de/T/#t
> [3] https://lore.kernel.org/linux-wireless/20230612134048.321500-1-pett=
er@technux.se/
> [4] https://github.com/morrownr/8812au-20210820
>=20
>>
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/t=
ree/drivers/net/wireless/realtek/rtw88/usb.c?h=3Dv6.10.11&id=3D25eaef533b=
f3ccc6fee5067aac16f41f280e343e#n641

The hardware is a Lenovo Ideapad 3 15ADA6 with AMD Athlon Gold 3150U.

How does Mender handle the data transfers? Does it have something
in common with torrents?


Return-Path: <linux-wireless+bounces-26684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03380B37E41
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08557B1AB0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C29319867;
	Wed, 27 Aug 2025 09:02:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397A280318;
	Wed, 27 Aug 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285332; cv=none; b=I70opw6EDsXjQLmxfn7H1uGqBndabz+Lkf8s40K8xCWsh8kNIWVuF30NcFZS3KNbo2B4rZfz5XkouAj77OBzY1CtcGHGWNunDjOfIud1PApeceBZ3otQ5/uw1kCrGEC2wy8k4j4N43lVghBCMbtTv3H0xdou/IBFYkCSOjN5xFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285332; c=relaxed/simple;
	bh=gyXdV3Fm6tpbgHLCfqzHabPrfXgMpFMGZN1AVphxpcE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PtZQuWh+nEM39tE+KnbWjmOb1AAHSl6VGxOhQH8s3E8zghytfxlpHi6bTdLNMlWJocjyeXvKhCJflNEVzn8rRI1FBsG37da1XSjdH09xLKLsCCYJZeBPi/NDQGXTA2Ln7EvUvx/kLRTkQ+NOlxQlTtv+Rt/OMQNvSZGZ1yKKaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a549.dip0.t-ipconnect.de [91.19.165.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A622660288271;
	Wed, 27 Aug 2025 11:01:42 +0200 (CEST)
Message-ID: <52be19a8-2ae5-4a8e-bcdc-4ff646def208@molgen.mpg.de>
Date: Wed, 27 Aug 2025 11:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jeff Johnson <jjohnson@kernel.org>,
 Baochen Qiang <quic_bqiang@quicinc.com>
Cc: =?UTF-8?Q?Andrea_Pierr=C3=A9?= <andrea_pierre@brown.edu>,
 James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: qca6174: wmi command 90124 timeout, restarting hardware/failed to
 receive initialized event from target: 00000000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Yesterday, on my Intel Kaby Lake laptop Dell XPS 13 9360, the Wi-Fi 
stopped working again. Looking at the logs, the driver claimed, that the 
reset/recovery was successful, but – although NetworkManager showed an 
established Wi-Fi connection – it didn’t work. I worked around it by 
disabling Wi-Fi over the function keys (rfkill), and enabling it again. 
Then it started working. This time no firmware crash was recorded 
beforehand.

```
[    0.000000] Linux version 6.17.0-rc3 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.3.0-5) 14.3.0, 
GNU ld (GNU Binutils for Debian) 2.45) #122 SMP PREEMPT_DYNAMIC Mon Aug 
25 08:27:23 CEST 2025
[…]
[   46.308531] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 
chip_id 0x00340aff sub 1a56:1535
[   46.308538] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 
tracing 0 dfs 0 testmode 0
[   46.308637] ath10k_pci 0000:3a:00.0: firmware ver 
WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
[   46.387972] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A 
crc32 d2863f91
[…]
[33027.934900] wlp58s0: Limiting TX power to 20 (20 - 0) dBm as 
advertised by 1e:49:bc:44:95:52
[33312.525898] ath10k_pci 0000:3a:00.0: timed out waiting peer stats info
[33318.669751] ath10k_pci 0000:3a:00.0: timed out waiting peer stats info
[33324.561674] ath10k_pci 0000:3a:00.0: wmi command 90124 timeout, 
restarting hardware
[33324.561705] ath10k_pci 0000:3a:00.0: could not request peer stats 
info: -11
[33327.600837] ath10k_pci 0000:3a:00.0: failed to receive initialized 
event from target: 00000000
[33330.616356] ath10k_pci 0000:3a:00.0: failed to receive initialized 
event from target: 00000000
[33330.616370] ath10k_pci 0000:3a:00.0: failed to wait for target init: -110
[33330.618779] ieee80211 phy0: Hardware restart was requested
[33330.618923] ath10k_pci 0000:3a:00.0: failed to start hw scan: -108
[33330.942314] ath10k_pci 0000:3a:00.0: device successfully recovered
[33441.598552] wlp58s0: deauthenticating from 1e:49:bc:44:95:52 by local 
choice (Reason: 3=DEAUTH_LEAVING)

Aug 26 17:56:26 abreu wpa_supplicant[683]: rfkill: WLAN soft blocked
Aug 26 17:56:26 abreu wpa_supplicant[683]: rfkill: WLAN soft blocked

[33448.628415] wlp58s0: authenticate with 1e:49:bc:44:95:52 (local 
address=9c:b6:d0:d1:6a:b1)
[33448.628425] wlp58s0: send auth to 1e:49:bc:44:95:52 (try 1/3)
[33448.744099] wlp58s0: authenticate with 1e:49:bc:44:95:52 (local 
address=9c:b6:d0:d1:6a:b1)
[33448.744108] wlp58s0: send auth to 1e:49:bc:44:95:52 (try 1/3)
[33448.783610] wlp58s0: authenticated
[33448.787382] wlp58s0: associate with 1e:49:bc:44:95:52 (try 1/3)
[33448.793745] wlp58s0: RX AssocResp from 1e:49:bc:44:95:52 
(capab=0x1431 status=0 aid=132)
[33448.797057] wlp58s0: associated
[33448.982505] wlp58s0: Limiting TX power to 20 (20 - 0) dBm as 
advertised by 1e:49:bc:44:95:52
```

Looking through the logs since November 26th, 2024, this has happened in 
the past. Sometimes without the error `failed to receive initialized 
event from target`.

```
Mär 20 07:52:48 abreu kernel: Linux version 
6.14.0-rc7-00074-ga7f2e10ecd8f (build@bohemianrhapsody.molgen.mpg.de) 
(gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) 
#110 SMP PREEMPT_DYNAMIC Thu Mar 20 00:43:24 CET 2025
[…]
Mär 21 10:12:04 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Mär 21 10:12:10 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Mär 21 10:12:16 abreu kernel: ath10k_pci 0000:3a:00.0: wmi command 90124 
timeout, restarting hardware
Mär 21 10:12:16 abreu kernel: ath10k_pci 0000:3a:00.0: could not request 
peer stats info: -11
Mär 21 10:12:19 abreu kernel: ath10k_pci 0000:3a:00.0: failed to receive 
initialized event from target: 00000000
Mär 21 10:12:22 abreu kernel: ath10k_pci 0000:3a:00.0: failed to receive 
initialized event from target: 00000000
Mär 21 10:12:22 abreu kernel: ath10k_pci 0000:3a:00.0: failed to wait 
for target init: -110
Mär 21 10:12:22 abreu kernel: ieee80211 phy0: Hardware restart was requested
Mär 21 10:12:23 abreu kernel: ath10k_pci 0000:3a:00.0: device 
successfully recovered
Mär 21 10:12:23 abreu kernel: wlp58s0: deauthenticated from 
5c:b1:2e:5f:19:00 (Reason: 7=CLASS3_FRAME_FROM_NONASSOC_STA)
```

```
Jun 05 08:46:30 abreu kernel: Linux version 6.15.0-11980-g16b70698aa3a 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-19) 14.2.0, 
GNU ld (GNU Binutils for Debian) 2.44) #62 SMP PREEMPT_DYNAMIC Wed Jun 
4 23:51:52 CEST 2025
[…]
Jun 05 12:31:50 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Jun 05 12:31:56 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Jun 05 12:32:02 abreu kernel: ath10k_pci 0000:3a:00.0: wmi command 90124 
timeout, restarting hardware
Jun 05 12:32:02 abreu kernel: ath10k_pci 0000:3a:00.0: could not request 
peer stats info: -11
Jun 05 12:32:05 abreu kernel: ath10k_pci 0000:3a:00.0: failed to receive 
initialized event from target: 00000000
Jun 05 12:32:08 abreu kernel: ath10k_pci 0000:3a:00.0: failed to receive 
initialized event from target: 00000000
Jun 05 12:32:08 abreu kernel: ath10k_pci 0000:3a:00.0: failed to wait 
for target init: -110
Jun 05 12:32:08 abreu kernel: ieee80211 phy0: Hardware restart was requested
Jun 05 12:32:08 abreu kernel: ath10k_pci 0000:3a:00.0: device 
successfully recovered
```

```
Jun 30 15:19:54 abreu kernel: Linux version 
6.16.0-rc4-00004-g30643e084e03 (build@bohemianrhapsody.molgen.mpg.de) 
(gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) 
#82 SMP PREEMPT_DYNAMIC Mon Jun 30 11:01:16 CEST 2025
[…]
Jun 30 15:31:48 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Jun 30 15:31:54 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Jun 30 15:32:00 abreu kernel: ath10k_pci 0000:3a:00.0: wmi command 90124 
timeout, restarting hardware
Jun 30 15:32:00 abreu kernel: ath10k_pci 0000:3a:00.0: could not request 
peer stats info: -11
Jun 30 15:32:00 abreu kernel: ieee80211 phy0: Hardware restart was requested
Jun 30 15:32:00 abreu kernel: ath10k_pci 0000:3a:00.0: device 
successfully recovered
```

```
Aug 14 06:36:18 abreu kernel: Linux version 
6.17.0-rc1-00016-g8742b2d8935f (build@bohemianrhapsody.molgen.mpg.de) 
(gcc (Debian 14.3.0-5) 14.3.0, GNU ld (GNU Binutils for Debian) 2.45) 
#112 SMP PREEMPT_DYNAMIC Wed Aug 13 14:29:07 CEST 2025
[…]
Aug 15 13:59:05 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Aug 15 13:59:11 abreu kernel: ath10k_pci 0000:3a:00.0: timed out waiting 
peer stats info
Aug 15 13:59:17 abreu kernel: ath10k_pci 0000:3a:00.0: wmi command 90124 
timeout, restarting hardware
Aug 15 13:59:17 abreu kernel: ath10k_pci 0000:3a:00.0: could not request 
peer stats info: -11
Aug 15 13:59:17 abreu kernel: ieee80211 phy0: Hardware restart was requested
Aug 15 13:59:18 abreu kernel: ath10k_pci 0000:3a:00.0: device 
successfully recovered
Aug 15 13:59:29 abreu kernel: wlp58s0: deauthenticated from 
98:9d:5d:4b:e4:40 (Reason: 7=CLASS3_FRAME_FROM_NONASSOC_STA)
```

James, Andrea (added because of report in 2024 [1]), do you see these 
things in your logs? Should you use systemd-journald you could run 
`journalctl -g 'failed to receive initialized event from target:'.`

Jeff, Baochen, is Qualcomm aware of such issues? Do I need to run the 
driver always in full debug mode to get you more information for debugging?


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/4ade6459-bfe3-4180-8586-9e4d7b8e5825@brown.edu/


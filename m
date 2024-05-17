Return-Path: <linux-wireless+bounces-7764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF4D8C80C0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 07:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45806B20E80
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2F125C7;
	Fri, 17 May 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kvRN72Qm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57E125AE;
	Fri, 17 May 2024 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925528; cv=none; b=OAQobSlRr2R7U5hOglQKHqnT+d2VbesP7YoFZVPTuMCp1BeaE9IY08XK4scBv1n9Z4PkBWME2MDOHBH9ukT3mWAoyPgWtXQToJVZcQiyKpkPYQPGxaFRJCWwQUIKrb6DTN+Gn83H4Vphs5/h/yQdnFDAtTUXkcKtDN6NlAGUTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925528; c=relaxed/simple;
	bh=t/qR0+uzwdRqPr67wOlbtWKJxdxxKAtdazalxr8QTFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loF8zEwD9La7+rGwj96Nws/yo84rSfAp5DJhptoMqjiIzaAZNjdQqRh+FwCyYqefPCSB0jTs0WYWMNwI7ocZd8xk1supYegtR2sM5e2Y2GINWxKh763LRikgYzgZKQk0a0iLtbUdZagHNRrBQzedm1rVKjQKzju+2FyY1j3umOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kvRN72Qm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=J6EW9+HknPjdDQE9CUXbc5grDyBLnEE1IdZiwV9lN7A=;
	t=1715925526; x=1716357526; b=kvRN72QmnmqeHNv2KCS1VT1X2ov8vWejThNkm1tc3C9Gn3M
	6GsChzCtomfD237G8oeCywtaCQlFfrNlg+Oesy0HKQ3HIeD3dlVa+Qsb1l3xdupUTaaqnsI4lgE7w
	kiewB6xNM6AwPklTEtseFW4Wj4wI8e7Yig9Ptd6hmczAdqnVf6pXVz4BqzOax5bMlqTuYy+e6Mkv0
	tiesK+LmfF1wXXbH+K0tW3M9ja5mCPWUxUuZsrN02JyQEgQap5oW5J7N6H/0ai6Kv1wyqCW6ghaQR
	BWq0Wi97oiGoQxWsUv8UU68l+xbogh5cGh5r9PLWh+y6cmTAle2+R7K5cEYHMYvQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s7qc1-0006tf-5q; Fri, 17 May 2024 07:58:37 +0200
Message-ID: <f433f7d4-a9c5-4077-a7d8-c858efebaa85@leemhuis.info>
Date: Fri, 17 May 2024 07:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
To: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
 <87wmo0k71i.fsf@kernel.org>
 <3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715925526;1748802e;
X-HE-SMSGID: 1s7qc1-0006tf-5q

On 17.05.24 04:14, Baochen Qiang wrote:
> On 5/11/2024 5:54 PM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>
>>> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>>> ath11k fails to connect to 6 GHz AP.
>>>
>>> This is because currently ath11k checks AP's power type in
>>> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
>>> However with above commit power type is not available until ASSOC stage.
>>> As a result power type check fails and therefore connection fails.
>>>
>>> Fix this by moving power type check to ASSOC stage, also move regulatory
>>> rules update there because it depends on power type.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Quick question: how does the error actually look like? I noticed a bug
report where someone complained problems connecting "to my Wifi 7 AP on
6GHz band using my Lenovo P14s Gen 4 laptop" and wonder if it's the same
or a different problem: https://bugzilla.kernel.org/show_bug.cgi?id=218838

To quote part of it:

"""
Sometimes when the connection fails the following appears on the logs

invalid HE MCS: bw:6, ru:6
WARNING: CPU: 13 PID: 1242 at net/wireless/util.c:1551
cfg80211_calculate_bitrate_he+0x1b7/0x3c0 [cfg80211]
CPU: 13 PID: 1242 Comm: NetworkManager Not tainted
6.9.0-0.rc7.20240510git448b3fe5a0ea.62.fc41.x86_64 #1
Hardware name: LENOVO 21K5000DMX/21K5000DMX, BIOS R2FET56W (1.36 )
03/13/2024
RIP: 0010:cfg80211_calculate_bitrate_he+0x1b7/0x3c0 [cfg80211]
Code: 00 40 80 fe 06 0f 84 a1 00 00 00 40 80 fe 03 0f 84 d6 00 00 00 40
84 f6 0f 84 0b 01 00 00 48 c7 c7 41 33 96 c1 e8 59 cd 8d e8 <0f> 0b 31
c0 eb 53 44 0f b6 e8 3c 02 0f 87 62 01 00 00 42 8b 44 ac
RSP: 0018:ffffa5f2c6df7320 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffa5f2c6df7518 RCX: 0000000000000027
RDX: ffff9166df0a18c8 RSI: 0000000000000001 RDI: ffff9166df0a18c0
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc196335e R11: 0000000000000001 R12: 0000000000000009
R13: ffff91580eae0000 R14: ffff915b0ed33ef0 R15: ffff915a8b051b00
FS:  00007f7d396cd580(0000) GS:ffff9166df080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00003d7c6e07d000 CR3: 0000000137282000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? cfg80211_calculate_bitrate_he+0x1b7/0x3c0 [cfg80211]
 ? __warn.cold+0x8e/0xe8
 ? cfg80211_calculate_bitrate_he+0x1b7/0x3c0 [cfg80211]
 ? report_bug+0xff/0x140
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? cfg80211_calculate_bitrate_he+0x1b7/0x3c0 [cfg80211]
 nl80211_put_sta_rate+0x5b/0x4f0 [cfg80211]
 nl80211_send_station+0x9f0/0x1060 [cfg80211]
 nl80211_dump_station+0xef/0x280 [cfg80211]
 genl_dumpit+0x33/0x90
 netlink_dump+0x151/0x3b0
[...]
"""

>> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
>> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
>> need to queue this for v6.10 via wireless tree.
>>
>> Adding the regression also to regzbot:
>>
>> #regzbot introduced: bc8a0fac8677
>> #regzbot title: ath11k: connection to 6 GHz AP fails
>
> Hi Kalle, with an upcoming patch this regression is expected to be fixed:
> 
> https://lore.kernel.org/all/20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid/#t
>
> So here the ath11k fix would not be needed any more once above patch got merged.
> 
> But I don't have time to test this, so suggest keeping it pending. We could drop it once above analysis got verified.

Thx for the update. If that's the way forward I wonder if that change
should have Fixes: and Stable: tags to ensure it ends up in 6.9.y --
ideally rather sooner than later if this is a regression users run into.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


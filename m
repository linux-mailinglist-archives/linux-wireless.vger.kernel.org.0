Return-Path: <linux-wireless+bounces-1846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFE82C656
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 21:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0151C22992
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6264616419;
	Fri, 12 Jan 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="E4QQ7lTB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41316408
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7AAE52A1BA1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 19:58:35 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E78E324006E;
	Fri, 12 Jan 2024 19:58:26 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D07E713C2B0;
	Fri, 12 Jan 2024 11:58:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D07E713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1705089503;
	bh=SNr9CT9/p9Tr06YFlc9LY7xL1bszjD0GMbUf7CQrvP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E4QQ7lTBcXzXP+sHmECc3xQF/54rjFIa4GzAcCCVcNjSqq3xHahfVWKPY9VjYQb10
	 X7xMTPh2FzA4GU6Y0IFI/tSYjH7IHMeOozBkWc4iWyO6+gd+aABC029LifQ/9lnZlT
	 xNpvqYVeUJPFGoFoKxnL80hg69F4j3bW37boAkn0=
Message-ID: <b1046a3b-8c29-aa64-2954-adec6c5d9bc9@candelatech.com>
Date: Fri, 12 Jan 2024 11:58:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
 Gregory Greenman <gregory.greenman@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
 <87wmsehf3d.fsf@kernel.org>
 <aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1705089508-S1t5olUemjl8
X-MDID-O:
 us5;ut7;1705089508;S1t5olUemjl8;<greearb@candelatech.com>;6ed5a8f8c51578afd12669094ba34ba9

On 1/12/24 10:42, Johannes Berg wrote:
> On Fri, 2024-01-12 at 15:10 +0200, Kalle Valo wrote:
>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>>
>>> +			/* currently no support for HE client where HT has 40 MHz but not HT */
>>> +			if (iftd->he_cap.has_he &&
>>> +			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
>>> +						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
>>> +			    sband->ht_cap.ht_supported &&
>>> +			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
>>> +			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
>>> +				return -EINVAL;
>>
>> Should there be a warning message so that this is noticed if it ever
>> happens? I don't know.
> 
> Yeah I don't really know either. I've done that a lot in the past, but
> these days I'm kind of thinking that people who develop their drivers
> should have some debug story and be able to figure it out? You know
> better perhaps ...
> 
> Though it'd kind of suck to indent this further with WARN_ON ;-)
> 
> johannes

I tried backporting this patch into my 6.7 tree.  An mtk7915 radio system blows up badly
in this case.  Likely this is mt76 bug, but also...it used to work and the crash doesn't
make it very obvious that the above code is to blame.

So, I suggest making this a WARN_ON with appropriate debugging output, let that get some
testing, and then when drivers are fixed, maybe add in the 'return -EINVAL'.


mt7915e 0000:06:00.0: mt7915_register_device failed, ret: -22
mt7915e 0000:06:00.0: mt7915_pci_probe had error on try 3/3, ret: -22
stack segment: 0000 [#1] PREEMPT SMP
CPU: 3 PID: 35 Comm: ksoftirqd/3 Tainted: G        WC         6.7.0+ #31
Hardware name: Broachlink NOAH V2 E3845/Aptio CRB, BIOS 5.6.10 08/19/2021
RIP: 0010:tasklet_action_common.constprop.0+0x80/0x220
Code: 00 00 00 00 49 8b 44 24 08 48 89 18 49 89 5c 24 08 66 90 65 66 44 09 35 9e a6 ea 7e fb 0f 1f 44 00 00 48 85 ed 74 53 48 89 eb <48> 8b 6d 000
RSP: 0018:ffffc90000153e50 EFLAGS: 00010202
RAX: ffff8881283271a8 RBX: 005fff800002012c RCX: 0000000000000006
RDX: ffffffff82606ad0 RSI: 0000000000000006 RDI: ffffea0004435488
RBP: 005fff800002012c R08: 0000000000000002 R09: 0000000080000100
R10: ffffffff826060c0 R11: 000000000002e000 R12: ffff88813bd9c230
R13: ffffea0004435488 R14: 0000000000000040 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565149684ff4 CR3: 000000012176b000 CR4: 00000000001006f0
Call Trace:
  <TASK>
  ? die+0x2d/0x80
  ? do_trap+0xcd/0xf0
  ? do_error_trap+0x65/0x80
  ? exc_stack_segment+0x33/0x50
  ? asm_exc_stack_segment+0x22/0x30
  ? tasklet_action_common.constprop.0+0x80/0x220
  __do_softirq+0xb4/0x293
  ? sort_range+0x20/0x20
  run_ksoftirqd+0x1f/0x30
  smpboot_thread_fn+0xc2/0x1a0
  kthread+0xdc/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x40
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
Modules linked in: qrtr ofpart spi_nor mtd intel_rapl_msr at24 spi_intel_platform regmap_i2c spi_intel iTCO_wdt intel_pmc_bxt iTCO_vendor_supports
---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




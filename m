Return-Path: <linux-wireless+bounces-129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24867FAC27
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 22:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC10B20DE8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00A3EA60;
	Mon, 27 Nov 2023 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="uOgFudrt";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="OObMAF9W"
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 13:02:20 PST
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F02C0
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 13:02:20 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 74432480A86;
	Mon, 27 Nov 2023 15:55:38 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701118538;
 h=message-id : date : mime-version : to : from : subject :
 content-type : content-transfer-encoding : from;
 bh=KrqJHHZlhcMPs21jM++pfkaSqj8xH+Q8Qn59eDqhwOU=;
 b=uOgFudrtiuy/3Zljq65eSv529kpo39Hc7H39rHKlfm0NNHLOqwPlILspeympNukfi5Lac
 eyAPj0BHwCgcbp/Dw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701118538;
	cv=none; b=XcqmLnQbOz5zyC5cTLmwZH7Dc9gIV1wjycKnWZLL4gydp6YJA5Bn9ftYpYs8OoqQzdgxyj08eVsP1l1R9T46TjjgdgAF4JZRrtOVEdpaMqoJeMtUlCd2T/lLCeL9OMqFWJuIE/oZNHJo29zzMKjFCw6zHUq2JUQl+VyRE+JWBDaVqpTkxeRCKeXKZBSnOHPk27gOjar8QvRlHTq+eFnY0WATK6yCb5gpDd/jIXzpTg7UOeARjgz49iLXfT3EjVJeMp3euBqvLRYrHjAZzyc7cGew0xsOQOEofxSPjqGFm+zB2ITRI1xn3AjzNJC1KEWEpgsNMt6F085UbadxzBxMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1701118538; c=relaxed/simple;
	bh=muQihC0eeNu3uKr3AXbBkhAcsPU7nCNDqbNK21KQbPI=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding; b=Yd/6oD+eBLMamvDfs++RJr1MrnS4K063Rcv+SpPWA33ywlxJm/RnsC2hdE8WnZGJJG4fhpOdcD9tpmrCtaiUJCVGDaAKkoY8RDdEE0wJNfNRAB4BdVcFQZhHDG8eeLf/i80L3yhn+2lEm3LQVwptlA4a/tJwfrKTlQ0mvb5YbG+Rnttr9vD5lq+L5aM7mqqQxmvfJfliFNeq9bAZtbVhgBH257B0AW2gRSIqj9UEMGbfT6K21sT9rIXtZqIqPXS/4qZiE4Pq8TOGTFP7nmrdCWwMUe9/8aB4sPi2HqRLy9CekgFSo5sIraxEuoe6yxcXp/0J+myPuFmtRk0XzIxGVw==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701118538;
 h=message-id : date : mime-version : to : from : subject :
 content-type : content-transfer-encoding : from;
 bh=KrqJHHZlhcMPs21jM++pfkaSqj8xH+Q8Qn59eDqhwOU=;
 b=OObMAF9WbCkfhmcH8pnBqjV8rAP9qvhk6pdTk6pQ5IGpDbpOf6B67dPTTQgjaXvKl+Swc
 2l4kOWq6I8Msm3gqU9NY8rQkJKwYAfNfJfsRZ2VfNhWJdz+CyVwbPIiGDqrzJdD1cPPiAjx
 EONrz6FZ246uiyBGoYUqryRTq97eTrQSyN55B93Vfzskgu4V0842VDaDZ5UCukU5tXWYFtE
 JE7PP9Qe/mWFLUoPIqe/zDxHYaZ8oCMZCxOxnejT0CTVXHaYKcpAviRAnUaEE5f/QpONf41
 21kxlraeqqdOn3mwYHQT8LPTfn7gQhCduSvP2QoooEST7vCqv6BeTQilxZVQ==
Message-ID: <c46a6462-8263-455c-a6ea-1860020f5fab@sapience.com>
Date: Mon, 27 Nov 2023 15:55:37 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 gregory.greenman@intel.com, kvalo@kernel.org, linux-wireless@vger.kernel.org
From: Genes Lists <lists@sapience.com>
Subject: crash with 6.7 rc2 and rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


lenovo laptop boots fine under 6.7rc1 and older including 6.6.2 stable.
but not for 6.7 rc2 or rc3.

It has a intel 7260 (rev 3) wireless and :

cpu family	: 6
model		: 60
model name	: Intel(R) Core(TM) i7-4800MQ CPU @ 2.70GHz
stepping	: 3
microcode	: 0x28


As of 6.7 rc2 / rc3 it crashes towards the end of boot bringing up 
services -  some parts of crash scrolled off the screen so I apologize 
if this (manually transcribed) trace didn't catch the first part.

I did a git bisect between rc1 and rc2 but was unable to reproduce the 
crash for some reason. (I did not do make clean between each bisects).

During the bisect it booted every time, but networking was not 
functional for any of the bisects.

Hope it's okay to report even though git bisect didn't get anywhere.

Gene

This is the what I got from screen :

CS: 0010 DS: 000 ES: 0000 CR0: 0000000080050033
CR2: 00007f30cf49ba38 CR3: 000000025b620004 CR4: 00000000001706f0
Call Trace:
  <IRQ>
  ? die_addr+0x36/0x90
  ? exc_general_protection+0x1c5/0x430
  ? asm_exc_gemeral_protection+0x26/0x30
  ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
  ? __kmem_cache_alloc_node+0x1d5/0x2b0
  ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
  ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
  __kmalloc_node_track_caller+0x51/0x160
  kmemdup+0x20/0x50
  iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
  iwl_wait_phy_db_entry+0x2f/0x40 [iwlmvm]
  iwl_notification_wait+0xb0/0xf0 [iwlwifi]
  iwl_mvm_rx_common+0x8e/0x320 [iwlwifi]
  iwl_pcie_napi_poll+0x2d/0x150 [iwlwifi]
  __napi_poll+0x2b/0x1c0
  net_rx_action+0x2b4/0x320
  __do_softirq+0xff/0x339
  net_rx_action+0x2b4/0x320
  __do_softirq.part.0+0x88/0xa0
</IRQ>
<TASK>
__local_bh_enable_ip+0x91/0xa0
iwl_pcie_irq_handler+0x58d/0xc40 [iwlwifi]
? __pfx_irq_thread_fn+0x10/0x10
irq_thread_fn+0x23/0x60
irq_thread+0xfe/0x60
? __pfx_irq_thread_dtor+0x10/0x10
? __pfx_irq_thread+0x10/0x10
kthread+0xfa/0x130
? pff_kthread+0x10/0x10
ret_from_fork+0x34/0x50
? __pfx_kthread+0x10/0x10
ret_from_fork_asm+0x1b/0x30


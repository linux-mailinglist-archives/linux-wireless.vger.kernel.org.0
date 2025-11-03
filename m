Return-Path: <linux-wireless+bounces-28484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C081C2A3CB
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 08:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAFD3B14E4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F800153BED;
	Mon,  3 Nov 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioTUDku6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B851D6BB;
	Mon,  3 Nov 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153253; cv=none; b=CGi4B50LNZXnFbQqR7WtxkScy7szpBN/nyv9igyhvz1ma5DrjzRxaPE+sT1PBvfXpmP+6n7DdA3Xr0QKdoDsno+TsnaQOKzeSxS+lXfFmajQe6Zd9tTWlLjNqf8oZGnEvhE3tDNwQAMUdr7SHZl/UXHtJH3+C4u95tEyK3FhKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153253; c=relaxed/simple;
	bh=++BYz3wLy7KKNt9WCxuevvrNqcu/xEFmWOkqS6cYeMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qb56SpvdVRlYbq1l8ojIkBg4Jq9Lr5hL1CZeOdYMeUst2BnOoJSn2JEIWVvwgYK2Or+iM2U69BIVRi+UnSpG5sUrk7t6yLRsYvrXCVWtCgrOl9F1AhEWLVx3qxhDzD29F9qBFEQ8HpMI0y6SvsAayNLYQjZA79ZrtRDd2AtCYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioTUDku6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5009EC4CEE7;
	Mon,  3 Nov 2025 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762153252;
	bh=++BYz3wLy7KKNt9WCxuevvrNqcu/xEFmWOkqS6cYeMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ioTUDku6ZOD8T4EjhS354K4+deuOuw4zzEn3adYig37RaNye+zNltsGydLfmv1I5J
	 7VCrlu426sm2nd07WWMlat+zSBLQp9100V9rYYtXMGAcUospIPSY9A9xgK1gTO7PvA
	 UoVXPZP0VCOnQHSik0egqITB6MAT5H/LhhzOBYSOLQ/1Gb+9+CwHYdN9pj5rQ7gBwW
	 oxepNagOZHQ7APUaBTggHAeZQG5eXfJBmu7GLqNrrJ7Kqa6wL3iB5Q/ZREGZYodyKJ
	 f0YJxDTk+sQ+2Bbi7k5EzLa1YHzKiUUMU2ftnjoRzDiBK/mYoA0BXrzi0leQ/GjoVZ
	 ScIdW3exDQuCQ==
Message-ID: <791a9e59-7819-4d63-b737-65ff1de6d73d@kernel.org>
Date: Mon, 3 Nov 2025 08:00:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSAN array-index-out-of-bounds in ath5k driver
To: Salvatore Bonaccorso <carnil@debian.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vincent Danjean <vdanjean@debian.org>, 1119093@bugs.debian.org
References: <aQYUkIaT87ccDCin@eldamar.lan>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <aQYUkIaT87ccDCin@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 01. 11. 25, 15:09, Salvatore Bonaccorso wrote:
> In Debian, https://bugs.debian.org/1119093, Vincent Danjean reported
> the following:
>>    The ath5k driver seems to do an array-index-out-of-bounds access
>> as shown by the UBSAN kernel message.
>> [   17.954484] ------------[ cut here ]------------
>> [   17.954487] UBSAN: array-index-out-of-bounds in /build/reproducible-path/linux-6.16.3/drivers/net/wireless/ath/ath5k/base.c:1741:20
>> [   17.955289] index 4 is out of range for type 'ieee80211_tx_rate [4]'
>> [   17.956134] CPU: 1 UID: 0 PID: 1745 Comm: 16 Not tainted 6.16.3+deb13-amd64 #1 PREEMPT(lazy)  Debian 6.16.3-1~bpo13+1
>> [   17.956137] Hardware name: Gigabyte Technology Co., Ltd. H67A-UD3H-B3/H67A-UD3H-B3, BIOS F8 03/27/2012
>> [   17.956139] Call Trace:
>> [   17.956142]  <TASK>
>> [   17.956145]  dump_stack_lvl+0x5d/0x80
>> [   17.956154]  ubsan_epilogue+0x5/0x2b
>> [   17.956158]  __ubsan_handle_out_of_bounds.cold+0x46/0x4b
>> [   17.956162]  ath5k_tasklet_tx+0x4e0/0x560 [ath5k]
>> [   17.956173]  tasklet_action_common+0xb5/0x1c0
>> [   17.956178]  handle_softirqs+0xdf/0x320
>> [   17.956181]  __irq_exit_rcu+0xbc/0xe0
>> [   17.956184]  common_interrupt+0x47/0xa0
>> [   17.956188]  asm_common_interrupt+0x26/0x40
>> [   17.956191] RIP: 0033:0x7f4fa439067d
>> [   17.956204] Code: 0f b6 14 16 45 85 c0 74 01 92 29 d0 c3 48 8d 3c 07 48 8d 34 0e 45 85 c0 74 03 48 87 f7 48 0f bc d2 49 29 d3 76 0b 0f b6 0c 16 <0f> b6 04 17 29 c8 c3 31 c0 c3 66 0f 1f 84 00 00 00 00 00 0f b6 0e
>> [   17.956206] RSP: 002b:00007ffd8cc32f08 EFLAGS: 00000212
>> [   17.956209] RAX: 0000000000000020 RBX: 0000556dfab414a0 RCX: 0000000000000070
>> [   17.956210] RDX: 000000000000000d RSI: 00007f4fa4b7a05f RDI: 0000556dfab414a0
>> [   17.956211] RBP: 00007f4fa4b7a05f R08: 0000000000000400 R09: 0000000000000008
>> [   17.956213] R10: fffffffffffff4b8 R11: 000000000000000e R12: 000000000000001b
>> [   17.956214] R13: 0000556dfab412c0 R14: 00007ffd8cc32f80 R15: 00007f4fa4b79eaf
>> [   17.956217]  </TASK>
>> [   17.956217] ---[ end trace ]---
>>
>> It occurs once at each boot.
>> According to
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable/+blame/master/drivers/net/wireless/ath/ath5k/base.c
>> the line of code has not changed for about 15 years.
>> And I'm using this driver for more than 10 years.
>> So, the array-index-out-of-bounds does not seem to
>> have hard consequences for now (by luck?)
> 
> Does that ring any bell?

No, but it is real. ts_final_idx is at most 3 on 5212, so:
   info->status.rates[ts->ts_final_idx + 1].idx = -1;
with:
   struct ieee80211_tx_rate rates[IEEE80211_TX_MAX_RATES];
and:
   #define IEEE80211_TX_MAX_RATES  4
is indeed bogus.

IMO we should just *not* set idx = -1 if ts->ts_final_idx is >= 3. As 
mac80211 won't look at rates beyond IEEE80211_TX_MAX_RATES.

FWIW, the effect of the UB is it just overwrites the next member of 
info->status, i.e. ack_signal.

thanks,
-- 
js
suse labs


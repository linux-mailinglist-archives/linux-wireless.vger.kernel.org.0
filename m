Return-Path: <linux-wireless+bounces-32478-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAEHJaaHqGn2vQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32478-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:27:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA20207105
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B807630247EA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AA3DA5D5;
	Wed,  4 Mar 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="oB0Ndvav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816F3D75AA
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652369; cv=none; b=Eq4ZI91cloWF3bWY8R7xAdDd/hMROMbes74mTvc/Vg7NvSw/xCQFd9+jNouvR5K2woxXMLP7tg5gnKWnopqyZbRpZOdCqUJ3xMu/x5o3ZSZ74ZcaCPcCBe1etsQKhLj55jwIUJqEIQkX41Z27C3Q/OoI8MC7v1N0GdHq42tEy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652369; c=relaxed/simple;
	bh=C5PT8dghrgXMQjxKJMJyl1inc/ZZeF/H31Sj+Ng5qg0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PVn9gMebLZll2JNcSexQlPdFf3pnnPio1XfHJaKcAJePSqZeSbNgRGvI/B4Y/o1gEHThaxQHs5T5PHZsPYPk7zPCXwKwdOvp9ULqTsNAI8DBCgmIdD67pEO+E7ClsszwmbWDwVmg8+oHHPHoqLjjOsysN9PrtIDjd4fm+n1rCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=oB0Ndvav; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 35F21240077;
	Wed,  4 Mar 2026 19:26:04 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1EFDB13C2B0;
	Wed,  4 Mar 2026 11:26:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1EFDB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772652362;
	bh=C5PT8dghrgXMQjxKJMJyl1inc/ZZeF/H31Sj+Ng5qg0=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=oB0NdvavuWYBmnobr356/HUbjywHEIVqZ2XGDPTAr6AlcCQbCVySufU8Sj072IsRQ
	 hJsgLnRgUrotlczbs98besw/gt5MtjM5xFqxjMizYXED/QmhDIrpb/LT8hPchbkYgK
	 wJLjhseWLZdvotWM7yNU40nexYyVYZJ9XodryJh0=
Message-ID: <57f29f81-9a05-ffef-342f-818a25842c6e@candelatech.com>
Date: Wed, 4 Mar 2026 11:26:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Use-after-free in iwl-mld after hardware fails to restart.
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <3b570a13-7570-52c7-faff-df32c3f9ef13@candelatech.com>
 <DM3PPF63A6024A9188ACD0856EDD0826643A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <b5803b14-c421-4a05-96c7-56ba7d1b8edb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <b5803b14-c421-4a05-96c7-56ba7d1b8edb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1772652365-pG8qV8yrC3Vj
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772652365;pG8qV8yrC3Vj;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 0BA20207105
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32478-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/3/26 06:27, Ben Greear wrote:
> On 3/2/26 23:19, Korenblit, Miriam Rachel wrote:
>>
>>
>>> -----Original Message-----
>>> From: Ben Greear <greearb@candelatech.com>
>>> Sent: Monday, March 2, 2026 9:00 PM
>>> To: linux-wireless <linux-wireless@vger.kernel.org>; Korenblit, Miriam Rachel
>>> <miriam.rachel.korenblit@intel.com>
>>> Subject: Use-after-free in iwl-mld after hardware fails to restart.
>>>
>>> Hello,
>>>
>>> Here's another failure case from my torture test system.
>>>
>>> This is from a patched 6.18.14+ kernel, but from a look at upstream Linux
>>> kernel, the problems are there as well.
>>>
>>> I believe the problem is something like this:
>>>
>>> firmware crashes several times and cannot recover.  Maybe
>>> Intel folks can tell why it is crashing?  I'd love to know if that
>>> is something that can be fixed in the driver.
>>>
>>>   From mac80211/util.c:
>>>
>>> int ieee80211_reconfig(struct ieee80211_local *local)
>>> is called, and gets to the failure case in this code (I see that second WARN in the
>>> crash logs)
>>> .....
>>>     /*
>>>      * Upon resume hardware can sometimes be goofy due to
>>>      * various platform / driver / bus issues, so restarting
>>>      * the device may at times not work immediately. Propagate
>>>      * the error.
>>>      */
>>>     res = drv_start(local);
>>>     if (res) {
>>>         if (suspended)
>>>             WARN(1, "Hardware became unavailable upon resume.
>>> This could be a software issue prior to suspend or a hardware issue.\n");
>>>         else
>>>             WARN(1, "Hardware became unavailable during
>>> restart.\n");
>>>         ieee80211_wake_queues_by_reason(hw,
>>> IEEE80211_MAX_QUEUE_MAP,
>>>
>>>     IEEE80211_QUEUE_STOP_REASON_SUSPEND,
>>>                         false);
>>>         ieee80211_handle_reconfig_failure(local);
>>>         return res;
>>>
>>>
>>> This method has comments about cleaning things up, but I don't see where it
>>> actually
>>> cleans up the driver.  And it sets SDATA_IN_DRIVER to false, so a lot of the calls
>>> in driver-ops.h that would otherwise tell the driver to clean up skip calls to
>>> the driver.
>>>
>>> static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
>>> {
>>>     struct ieee80211_sub_if_data *sdata;
>>>     struct ieee80211_chanctx *ctx;
>>>
>>>     lockdep_assert_wiphy(local->hw.wiphy);
>>>
>>>     /*
>>>      * We get here if during resume the device can't be restarted properly.
>>>      * We might also get here if this happens during HW reset, which is a
>>>      * slightly different situation and we need to drop all connections in
>>>      * the latter case.
>>>      *
>>>      * Ask cfg80211 to turn off all interfaces, this will result in more
>>>      * warnings but at least we'll then get into a clean stopped state.
>>>      */
>>>
>>>     local->resuming = false;
>>>     local->suspended = false;
>>>     local->in_reconfig = false;
>>>     local->reconfig_failure = true;
>>>
>>>     ieee80211_flush_completed_scan(local, true);
>>>
>>>     /* scheduled scan clearly can't be running any more, but tell
>>>      * cfg80211 and clear local state
>>>      */
>>>     ieee80211_sched_scan_end(local);
>>>
>>>     list_for_each_entry(sdata, &local->interfaces, list)
>>>         sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
>>>
>>>     /* Mark channel contexts as not being in the driver any more to avoid
>>>      * removing them from the driver during the shutdown process...
>>>      */
>>>     list_for_each_entry(ctx, &local->chanctx_list, list)
>>>         ctx->driver_present = false;
>>> }
>>>
>>>
>>> So, how is the driver supposed to be cleaned up in this scenario?
>> Driver was cleaned up in drv_start. See iwl_mld_restart_cleanup.
>> Could you please share the iwlmld.ko and iwlwifi.ko files?
> 
> I have already made code changes and re-compiled to try to track it down.
> 
> If you can let me know what sort of information you'd like to see (like
> gdb code listings?) I can gather it next time I can reproduce the problem.
> 
> Any idea why the firmware is crashing?
> 
> Thanks,
> Ben
> 

I hit something like this again just now, here is the logs from the kdump vmcore-dmesg
file.   wlan11 is on the bus 0000:36:00.0 radio.  My previously posted work-arounds help in
other cases, but seems it does not fully solve use-after-free down in iwlmld.  I'll work on
on a way to fix this, but suggestions are welcome.


[start of file, but obviously more logs above this]

[ 3494.878836] iwlwifi 0000:36:00.0: Transport status: 0x0000014A, valid: 7
[ 3494.884282] iwlwifi 0000:36:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[ 3494.889638] iwlwifi 0000:36:00.0: 0x00000000 | umac branchlink1
[ 3494.894369] iwlwifi 0000:36:00.0: 0xC00808AA | umac branchlink2
[ 3494.899033] iwlwifi 0000:36:00.0: 0x80287BFE | umac interruptlink1
[ 3494.903939] iwlwifi 0000:36:00.0: 0xC008462C | umac interruptlink2
[ 3494.908882] iwlwifi 0000:36:00.0: 0x00000002 | umac data1
[ 3494.913001] iwlwifi 0000:36:00.0: 0xC008462C | umac data2
[ 3494.917134] iwlwifi 0000:36:00.0: 0x00000000 | umac data3
[ 3494.921275] iwlwifi 0000:36:00.0: 0x00000065 | umac major
[ 3494.925428] iwlwifi 0000:36:00.0: 0x6EF20B19 | umac minor
[ 3494.929553] iwlwifi 0000:36:00.0: 0x0007295B | frame pointer
[ 3494.933953] iwlwifi 0000:36:00.0: 0xD00D6258 | stack pointer
[ 3494.938360] iwlwifi 0000:36:00.0: 0x0001016A | last host cmd
[ 3494.942921] iwlwifi 0000:36:00.0: 0x00000000 | isr status reg
[ 3494.947502] iwlwifi 0000:36:00.0: TCM1 status:
[ 3494.950682] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[ 3494.954654] iwlwifi 0000:36:00.0: 0x00001D2E | tcm branchlink2
[ 3494.959297] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink1
[ 3494.964135] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink2
[ 3494.968954] iwlwifi 0000:36:00.0: 0x40000000 | tcm data1
[ 3494.973032] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data2
[ 3494.977066] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data3
[ 3494.981105] iwlwifi 0000:36:00.0: 0x00001DAC | tcm log PC
[ 3494.985235] iwlwifi 0000:36:00.0: 0x00803FF0 | tcm frame pointer
[ 3494.990031] iwlwifi 0000:36:00.0: 0x00803F5C | tcm stack pointer
[ 3494.994792] iwlwifi 0000:36:00.0: 0x00000000 | tcm msg ID
[ 3494.998921] iwlwifi 0000:36:00.0: 0x40080000 | tcm ISR status
[ 3495.003417] iwlwifi 0000:36:00.0: 0x000002F0 | tcm HW status[0]
[ 3495.008143] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[1]
[ 3495.012785] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[2]
[ 3495.017447] iwlwifi 0000:36:00.0: 0x00008100 | tcm HW status[3]
[ 3495.022154] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[4]
[ 3495.026812] iwlwifi 0000:36:00.0: 0x00000000 | tcm SW status[0]
[ 3495.031608] iwlwifi 0000:36:00.0: RCM1 status:
[ 3495.034792] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[ 3495.038840] iwlwifi 0000:36:00.0: 0x00001E2E | rcm branchlink2
[ 3495.043414] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink1
[ 3495.048248] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink2
[ 3495.053182] iwlwifi 0000:36:00.0: 0x20000000 | rcm data1
[ 3495.057450] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data2
[ 3495.061499] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data3
[ 3495.065536] iwlwifi 0000:36:00.0: 0x00001E98 | rcm log PC
[ 3495.069770] iwlwifi 0000:36:00.0: 0x00803FF0 | rcm frame pointer
[ 3495.074511] iwlwifi 0000:36:00.0: 0x00803F5C | rcm stack pointer
[ 3495.079238] iwlwifi 0000:36:00.0: 0x00000000 | rcm msg ID
[ 3495.083362] iwlwifi 0000:36:00.0: 0x20000000 | rcm ISR status
[ 3495.087864] iwlwifi 0000:36:00.0: 0x00420500 | frame HW status
[ 3495.092420] iwlwifi 0000:36:00.0: 0x00000000 | LMAC-to-RCM request mbox
[ 3495.097785] iwlwifi 0000:36:00.0: 0x00000000 | RCM-to-LMAC request mbox
[ 3495.103207] iwlwifi 0000:36:00.0: 0x00000000 | MAC header control
[ 3495.108022] iwlwifi 0000:36:00.0: 0x00000000 | MAC header addr1 low
[ 3495.113015] iwlwifi 0000:36:00.0: 0x003C0000 | MAC header info
[ 3495.117652] iwlwifi 0000:36:00.0: 0x00000000 | MAC header error
[ 3495.122379] iwlwifi 0000:36:00.0: TCM2 status:
[ 3495.125549] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[ 3495.129511] iwlwifi 0000:36:00.0: 0x00001D2E | tcm branchlink2
[ 3495.134131] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink1
[ 3495.138958] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink2
[ 3495.143789] iwlwifi 0000:36:00.0: 0x40000000 | tcm data1
[ 3495.148002] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data2
[ 3495.152057] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data3
[ 3495.156113] iwlwifi 0000:36:00.0: 0x00001DAC | tcm log PC
[ 3495.160241] iwlwifi 0000:36:00.0: 0x00803FF0 | tcm frame pointer
[ 3495.165010] iwlwifi 0000:36:00.0: 0x00803F5C | tcm stack pointer
[ 3495.169754] iwlwifi 0000:36:00.0: 0x00000000 | tcm msg ID
[ 3495.173894] iwlwifi 0000:36:00.0: 0x40080000 | tcm ISR status
[ 3495.178380] iwlwifi 0000:36:00.0: 0x000002F0 | tcm HW status[0]
[ 3495.183093] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[1]
[ 3495.187778] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[2]
[ 3495.192457] iwlwifi 0000:36:00.0: 0x00008000 | tcm HW status[3]
[ 3495.197171] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[4]
[ 3495.201818] iwlwifi 0000:36:00.0: 0x00000000 | tcm SW status[0]
[ 3495.206557] iwlwifi 0000:36:00.0: RCM2 status:
[ 3495.209741] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[ 3495.213759] iwlwifi 0000:36:00.0: 0x00001E2E | rcm branchlink2
[ 3495.218334] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink1
[ 3495.223171] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink2
[ 3495.228036] iwlwifi 0000:36:00.0: 0x20000000 | rcm data1
[ 3495.232073] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data2
[ 3495.236110] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data3
[ 3495.240163] iwlwifi 0000:36:00.0: 0x00001E98 | rcm log PC
[ 3495.244352] iwlwifi 0000:36:00.0: 0x00803FF0 | rcm frame pointer
[ 3495.249099] iwlwifi 0000:36:00.0: 0x00803F5C | rcm stack pointer
[ 3495.253841] iwlwifi 0000:36:00.0: 0x00000000 | rcm msg ID
[ 3495.257984] iwlwifi 0000:36:00.0: 0x20000000 | rcm ISR status
[ 3495.262512] iwlwifi 0000:36:00.0: 0x00420500 | frame HW status
[ 3495.267085] iwlwifi 0000:36:00.0: 0x00000000 | LMAC-to-RCM request mbox
[ 3495.272467] iwlwifi 0000:36:00.0: 0x00000000 | RCM-to-LMAC request mbox
[ 3495.277912] iwlwifi 0000:36:00.0: 0x00000000 | MAC header control
[ 3495.282758] iwlwifi 0000:36:00.0: 0x00000000 | MAC header addr1 low
[ 3495.287772] iwlwifi 0000:36:00.0: 0x003C0000 | MAC header info
[ 3495.292384] iwlwifi 0000:36:00.0: 0x00000000 | MAC header error
[ 3495.297079] iwlwifi 0000:36:00.0: IML/ROM dump:
[ 3495.300348] iwlwifi 0000:36:00.0: 0x00000B03 | IML/ROM error/state
[ 3495.305291] iwlwifi 0000:36:00.0: 0x0000EF94 | IML/ROM data1
[ 3495.309772] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[ 3495.315054] iwlwifi 0000:36:00.0: Fseq Registers:
[ 3495.318508] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[ 3495.323084] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[ 3495.328205] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[ 3495.333479] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[ 3495.338133] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[ 3495.343515] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 3495.348165] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[ 3495.352470] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[ 3495.356777] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[ 3495.361619] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[ 3495.366456] iwlwifi 0000:36:00.0: 0x8F0F1BED | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 3495.373018] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 3495.379941] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[ 3495.385643] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[ 3495.390826] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[ 3495.395833] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[ 3495.401013] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x8028b720
[ 3495.405529] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0xd0
[ 3495.409573] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0xd0
[ 3495.413616] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x8028b71e
[ 3495.418273] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0xd0
[ 3495.422241] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0xd0
[ 3495.426197] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0xd0
[ 3495.430238] iwlwifi 0000:36:00.0: Function Scratch status:
[ 3495.434468] iwlwifi 0000:36:00.0: 0x01010101 | Func Scratch
[ 3496.372015] iwlwifi 0000:36:00.0: Failed to get INIT_COMPLETE -110
[ 3496.376948] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[ 3498.129835] iwlwifi 0000:36:00.0: Failed start-fw. ret=-110
[ 3498.134138] ------------[ cut here ]------------
[ 3498.134142] Hardware became unavailable during restart.
[ 3498.134249] WARNING: CPU: 3 PID: 52511 at net/mac80211/util.c:1927 ieee80211_reconfig+0x1df/0x4790 [mac80211]
[ 3498.134445] Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc macvlan pktgen rfcomm 
rpcrdma rdma_cm iw_cm nfsv3 ib_cm ib_core nfs netfs qrtr bnep snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc662 snd_hda_codec_realtek_lib 
snd_hda_codec_generic ee1004 iTCO_wdt snd_hda_intel intel_rapl_msr intel_pmc_bxt snd_intel_dspcfg iTCO_vendor_support snd_hda_codec coretemp snd_hda_core 
snd_hwdep intel_rapl_common intel_uncore_frequency snd_seq intel_uncore_frequency_common snd_seq_device snd_pcm iwlmld snd_timer intel_tcc_cooling snd i2c_i801 
x86_pkg_temp_thermal i2c_smbus intel_powerclamp pcspkr intel_wmi_thunderbolt soundcore mac80211 i2c_mux btusb btbcm iwlwifi btmtk btrtl btintel bluetooth 
cfg80211 ftdi_sio mei_pxp mei_hdcp intel_pmc_core intel_pch_thermal pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq nfsd 
sch_fq_codel auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc zram raid1 dm_raid raid456
[ 3498.134640]  async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper 
drm_kms_helper cec rc_core ttm igb agpgart dca i2c_algo_bit hwmon mei_wdt drm video intel_oc_wdt wmi i2c_core scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath 
fuse [last unloaded: nfnetlink]
[ 3498.134776] CPU: 3 UID: 0 PID: 52511 Comm: kworker/3:2 Kdump: loaded Tainted: G        W           6.18.14+ #28 PREEMPT(full)
[ 3498.134784] Tainted: [W]=WARN
[ 3498.134787] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 3498.134792] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[ 3498.134914] RIP: 0010:ieee80211_reconfig+0x1df/0x4790 [mac80211]
[ 3498.135012] Code: 89 5c 24 08 e8 42 e6 ec ff 4c 8b 5c 24 08 85 c0 89 04 24 0f 84 a7 08 00 00 48 c7 c7 00 8f 41 a2 4c 89 5c 24 08 e8 b1 1e d1 de <0f> 0b 48 b8 
00 00 00 00 00 fc ff df 4c 8b 5c 24 08 49 8d bb 44 44
[ 3498.135018] RSP: 0018:ffff888163ddfa60 EFLAGS: 00010282
[ 3498.135024] RAX: 0000000000000000 RBX: ffff8881635d2080 RCX: 0000000000000001
[ 3498.135028] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88841dba4e48
[ 3498.135032] RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed1083b749c9
[ 3498.135036] R10: ffff88841dba4e4b R11: 00000000000b05e0 R12: ffffed102c6ba1e5
[ 3498.135040] R13: ffff8881635d4d00 R14: ffff8881635d0f28 R15: ffff8881635d52c8
[ 3498.135044] FS:  0000000000000000(0000) GS:ffff8884974c6000(0000) knlGS:0000000000000000
[ 3498.135049] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3498.135052] CR2: 00007f38f1bc2ff8 CR3: 000000000509a003 CR4: 00000000003706f0
[ 3498.135057] Call Trace:
[ 3498.135061]  <TASK>
[ 3498.135066]  ? find_held_lock+0x2b/0x80
[ 3498.135077]  ? schedule+0x2cc/0x3a0
[ 3498.135093]  ? ieee80211_stop_device+0x110/0x110 [mac80211]
[ 3498.135219]  ? synchronize_rcu_expedited+0x379/0x3e0
[ 3498.135227]  ? rcu_exp_wait_wake+0x13c0/0x13c0
[ 3498.135231]  ? do_raw_spin_lock+0x12c/0x270
[ 3498.135240]  ? swake_up_locked+0x1b0/0x1b0
[ 3498.135252]  ? cond_synchronize_rcu_expedited_full+0x90/0x90
[ 3498.135264]  ieee80211_restart_work+0x261/0x3c0 [mac80211]
[ 3498.135376]  process_one_work+0x83f/0x17b0
[ 3498.135392]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[ 3498.135416]  ? ieee80211_ifcomb_check+0x180/0x180 [mac80211]
[ 3498.135513]  worker_thread+0x58c/0xfb0
[ 3498.135524]  ? __kthread_parkme+0xc6/0x1f0
[ 3498.135534]  ? rescuer_thread+0x1340/0x1340
[ 3498.135539]  kthread+0x3b7/0x770
[ 3498.135546]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.135550]  ? ret_from_fork+0x17/0x3a0
[ 3498.135557]  ? lock_release+0xce/0x290
[ 3498.135565]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.135571]  ret_from_fork+0x28b/0x3a0
[ 3498.135575]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.135580]  ret_from_fork_asm+0x11/0x20
[ 3498.135599]  </TASK>
[ 3498.135602] irq event stamp: 163557
[ 3498.135605] hardirqs last  enabled at (163563): [<ffffffff8161233e>] __up_console_sem+0x5e/0x70
[ 3498.135612] hardirqs last disabled at (163568): [<ffffffff81612323>] __up_console_sem+0x43/0x70
[ 3498.135616] softirqs last  enabled at (162518): [<ffffffff81470b5c>] __irq_exit_rcu+0xcc/0x100
[ 3498.135625] softirqs last disabled at (162513): [<ffffffff81470b5c>] __irq_exit_rcu+0xcc/0x100
[ 3498.135630] ---[ end trace 0000000000000000 ]---
[ 3498.135791] wlan11: deauthenticating from 02:58:a4:ff:75:59 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 3498.144135] wlan11: sta-info-move-state to NONE: current state: 4 (NOT AUTH) is invalid
[ 3498.144154] wlan11: HW problem - can not stop rx aggregation for 02:58:a4:ff:75:59 tid 0
[ 3498.144160] wlan11: HW problem - can not stop rx aggregation for 02:58:a4:ff:75:59 tid 4
[ 3498.144165] wlan11: HW problem - can not stop rx aggregation for 02:58:a4:ff:75:59 tid 6
[ 3498.144191] iwlwifi 0000:36:00.0: Failed to trigger RX queues sync (-5)
[ 3498.174792] wlan11: drv-sta-state, sdata-not-in-driver, old_state: 4  new_state: 3
[ 3498.184599] wlan11: failed to remove key (0, 02:58:a4:ff:75:59) from hardware (-5)
[ 3498.192202] wlan11: drv-sta-state, sdata-not-in-driver, old_state: 3  new_state: 2
[ 3498.198503] wlan11: drv-sta-state, sdata-not-in-driver, old_state: 2  new_state: 1
[ 3498.205662] wlan11: drv-sta-state, sdata-not-in-driver, old_state: 1  new_state: 0
[ 3498.214838] ------------[ cut here ]------------
[ 3498.214847] WARNING: CPU: 3 PID: 52511 at net/mac80211/driver-ops.h:1055 ieee80211_del_chanctx+0x336/0x3d0 [mac80211]
[ 3498.215059] Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc macvlan pktgen rfcomm 
rpcrdma rdma_cm iw_cm nfsv3 ib_cm ib_core nfs netfs qrtr bnep snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc662 snd_hda_codec_realtek_lib 
snd_hda_codec_generic ee1004 iTCO_wdt snd_hda_intel intel_rapl_msr intel_pmc_bxt snd_intel_dspcfg iTCO_vendor_support snd_hda_codec coretemp snd_hda_core 
snd_hwdep intel_rapl_common intel_uncore_frequency snd_seq intel_uncore_frequency_common snd_seq_device snd_pcm iwlmld snd_timer intel_tcc_cooling snd i2c_i801 
x86_pkg_temp_thermal i2c_smbus intel_powerclamp pcspkr intel_wmi_thunderbolt soundcore mac80211 i2c_mux btusb btbcm iwlwifi btmtk btrtl btintel bluetooth 
cfg80211 ftdi_sio mei_pxp mei_hdcp intel_pmc_core intel_pch_thermal pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq nfsd 
sch_fq_codel auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc zram raid1 dm_raid raid456
[ 3498.215403]  async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper 
drm_kms_helper cec rc_core ttm igb agpgart dca i2c_algo_bit hwmon mei_wdt drm video intel_oc_wdt wmi i2c_core scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath 
fuse [last unloaded: nfnetlink]
[ 3498.215521] CPU: 3 UID: 0 PID: 52511 Comm: kworker/3:2 Kdump: loaded Tainted: G        W           6.18.14+ #28 PREEMPT(full)
[ 3498.215529] Tainted: [W]=WARN
[ 3498.215532] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 3498.215537] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[ 3498.215644] RIP: 0010:ieee80211_del_chanctx+0x336/0x3d0 [mac80211]
[ 3498.215856] Code: fe ff ff 80 3d 68 6a a3 ff 00 0f 85 fe fd ff ff 48 c7 c7 60 aa 41 a2 c6 05 54 6a a3 ff 01 e8 a1 41 cf de 0f 0b e9 e4 fd ff ff <0f> 0b 48 c7 
c7 80 ab 41 a2 e8 0c ec ea de e9 65 fe ff ff 48 89 ef
[ 3498.215865] RSP: 0018:ffff888163ddf108 EFLAGS: 00010246
[ 3498.215877] RAX: 0000000000000000 RBX: ffff8881635d0ee0 RCX: 0000000000000000
[ 3498.215884] RDX: 0000000000000004 RSI: ffff8881635d0788 RDI: ffff8881f5f4b718
[ 3498.215891] RBP: ffff88815e94d454 R08: 0000000000000001 R09: 000000005102af7d
[ 3498.215898] R10: ffff8881f5f4ac00 R11: ffff8881f5f4b6a0 R12: ffff88815e94d400
[ 3498.215903] R13: 0000000000000000 R14: ffff8881635d4f00 R15: ffff88815e94d4b0
[ 3498.215907] FS:  0000000000000000(0000) GS:ffff8884974c6000(0000) knlGS:0000000000000000
[ 3498.215912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3498.215916] CR2: 00007f38f1bc2ff8 CR3: 00000001ca0eb002 CR4: 00000000003706f0
[ 3498.215920] Call Trace:
[ 3498.215925]  <TASK>
[ 3498.215932]  ieee80211_free_chanctx+0x144/0x210 [mac80211]
[ 3498.216047]  __ieee80211_link_release_channel+0x394/0x4a0 [mac80211]
[ 3498.216146]  ieee80211_set_disassoc+0x9dc/0x1c10 [mac80211]
[ 3498.216244]  ? ieee80211_add_link_elems+0x35b0/0x35b0 [mac80211]
[ 3498.216347]  ieee80211_mgd_deauth+0x526/0x1780 [mac80211]
[ 3498.216517]  ? check_irq_usage+0xb5/0xa20
[ 3498.216536]  ? ieee80211_mgd_assoc+0x5be0/0x5be0 [mac80211]
[ 3498.216724]  ? check_path.constprop.0+0x24/0x50
[ 3498.216735]  ? check_noncircular+0x7e/0x140
[ 3498.216755]  ? lock_is_held_type+0xa5/0x110
[ 3498.216773]  cfg80211_mlme_deauth+0x333/0x7a0 [cfg80211]
[ 3498.216975]  ? prb_final_commit+0x40/0x40
[ 3498.216990]  ? cfg80211_mlme_assoc+0x960/0x960 [cfg80211]
[ 3498.217170]  cfg80211_mlme_down+0x16f/0x230 [cfg80211]
[ 3498.217333]  ? cfg80211_mlme_disassoc+0x450/0x450 [cfg80211]
[ 3498.217492]  ? kfree+0x2ae/0x580
[ 3498.217515]  cfg80211_disconnect+0x4d2/0x700 [cfg80211]
[ 3498.217694]  cfg80211_netdev_notifier_call+0x661/0x10a0 [cfg80211]
[ 3498.217855]  ? prb_next_reserve_seq+0x2a0/0x2a0
[ 3498.217869]  ? cfg80211_register_netdevice+0x2a0/0x2a0 [cfg80211]
[ 3498.218022]  ? up+0x102/0x180
[ 3498.218030]  ? __bfs+0x12e/0x220
[ 3498.218035]  ? do_raw_spin_unlock+0x54/0x220
[ 3498.218043]  ? check_irq_usage+0xb5/0xa20
[ 3498.218049]  ? __bfs+0x12e/0x220
[ 3498.218056]  ? check_irq_usage+0xb5/0xa20
[ 3498.218064]  ? check_path.constprop.0+0x24/0x50
[ 3498.218070]  ? __bfs+0x12e/0x220
[ 3498.218094]  ? __lock_acquire+0x432/0x23b0
[ 3498.218107]  ? lock_acquire+0x155/0x2e0
[ 3498.218113]  ? packet_notifier+0xd3/0xa70
[ 3498.218120]  ? find_held_lock+0x2b/0x80
[ 3498.218126]  ? packet_notifier+0x1f0/0xa70
[ 3498.218132]  ? lock_release+0xce/0x290
[ 3498.218140]  ? packet_notifier+0x1fa/0xa70
[ 3498.218149]  ? packet_getname_spkt+0x290/0x290
[ 3498.218154]  ? lock_is_held_type+0xa5/0x110
[ 3498.218166]  notifier_call_chain+0x97/0x280
[ 3498.218178]  __dev_close_many+0xe8/0x670
[ 3498.218187]  ? netdev_notify_peers+0x20/0x20
[ 3498.218194]  ? try_to_wake_up+0xa09/0x1450
[ 3498.218206]  netif_close_many+0x1e6/0x5c0
[ 3498.218215]  ? __dev_close_many+0x670/0x670
[ 3498.218222]  ? wake_up_q+0xaf/0x130
[ 3498.218231]  netif_close+0x141/0x1d0
[ 3498.218237]  ? netif_close_many+0x5c0/0x5c0
[ 3498.218249]  dev_close+0x89/0x1f0
[ 3498.218255]  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
[ 3498.218344]  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
[ 3498.218440]  process_one_work+0x83f/0x17b0
[ 3498.218455]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[ 3498.218466]  ? ieee80211_ifcomb_check+0x180/0x180 [mac80211]
[ 3498.218562]  worker_thread+0x58c/0xfb0
[ 3498.218573]  ? __kthread_parkme+0xc6/0x1f0
[ 3498.218582]  ? rescuer_thread+0x1340/0x1340
[ 3498.218588]  kthread+0x3b7/0x770
[ 3498.218594]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.218599]  ? ret_from_fork+0x17/0x3a0
[ 3498.218605]  ? lock_release+0xce/0x290
[ 3498.218612]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.218619]  ret_from_fork+0x28b/0x3a0
[ 3498.218624]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.218629]  ret_from_fork_asm+0x11/0x20
[ 3498.218646]  </TASK>
[ 3498.218649] irq event stamp: 168549
[ 3498.218652] hardirqs last  enabled at (168555): [<ffffffff8161233e>] __up_console_sem+0x5e/0x70
[ 3498.218658] hardirqs last disabled at (168560): [<ffffffff81612323>] __up_console_sem+0x43/0x70
[ 3498.218663] softirqs last  enabled at (167244): [<ffffffffa261e604>] __cleanup_single_sta+0x224/0x530 [mac80211]
[ 3498.218797] softirqs last disabled at (167242): [<ffffffffa271ee1d>] ieee80211_txq_purge+0x1bd/0x3c0 [mac80211]
[ 3498.218893] ---[ end trace 0000000000000000 ]---
[ 3498.219198] drv-remove-chanctx, NOT driver_present, not sending request to driver.
[ 3498.219208] ==================================================================
[ 3498.231427] BUG: KASAN: slab-use-after-free in iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[ 3498.238423] Read of size 8 at addr ffff88813ef850a8 by task kworker/3:2/52511
[ 3498.244271]
[ 3498.244477] CPU: 3 UID: 0 PID: 52511 Comm: kworker/3:2 Kdump: loaded Tainted: G        W           6.18.14+ #28 PREEMPT(full)
[ 3498.244483] Tainted: [W]=WARN
[ 3498.244484] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 3498.244486] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[ 3498.244599] Call Trace:
[ 3498.244601]  <TASK>
[ 3498.244603]  dump_stack_lvl+0x73/0xa0
[ 3498.244609]  print_report+0xce/0x620
[ 3498.244615]  ? __virt_addr_valid+0x205/0x3f0
[ 3498.244620]  ? iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[ 3498.244643]  kasan_report+0xc6/0xf0
[ 3498.244648]  ? iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[ 3498.244666]  iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[ 3498.244690]  __ieee80211_flush_queues+0x4e4/0x950 [mac80211]
[ 3498.244787]  ? ieee80211_get_vif_queues+0x270/0x270 [mac80211]
[ 3498.244880]  ? printk_get_console_flush_type+0x2d0/0x2d0
[ 3498.244884]  ? lock_is_held_type+0xa5/0x110
[ 3498.244890]  __ieee80211_recalc_idle+0x375/0x4a0 [mac80211]
[ 3498.244982]  ieee80211_recalc_idle+0x10/0x30 [mac80211]
[ 3498.245074]  ieee80211_del_chanctx+0x27d/0x3d0 [mac80211]
[ 3498.245167]  ieee80211_free_chanctx+0x144/0x210 [mac80211]
[ 3498.245260]  __ieee80211_link_release_channel+0x394/0x4a0 [mac80211]
[ 3498.245353]  ieee80211_set_disassoc+0x9dc/0x1c10 [mac80211]
[ 3498.245444]  ? ieee80211_add_link_elems+0x35b0/0x35b0 [mac80211]
[ 3498.245534]  ieee80211_mgd_deauth+0x526/0x1780 [mac80211]
[ 3498.245622]  ? check_irq_usage+0xb5/0xa20
[ 3498.245627]  ? ieee80211_mgd_assoc+0x5be0/0x5be0 [mac80211]
[ 3498.245728]  ? check_path.constprop.0+0x24/0x50
[ 3498.245732]  ? check_noncircular+0x7e/0x140
[ 3498.245737]  ? lock_is_held_type+0xa5/0x110
[ 3498.245742]  cfg80211_mlme_deauth+0x333/0x7a0 [cfg80211]
[ 3498.245858]  ? prb_final_commit+0x40/0x40
[ 3498.245863]  ? cfg80211_mlme_assoc+0x960/0x960 [cfg80211]
[ 3498.245949]  cfg80211_mlme_down+0x16f/0x230 [cfg80211]
[ 3498.246034]  ? cfg80211_mlme_disassoc+0x450/0x450 [cfg80211]
[ 3498.246116]  ? kfree+0x2ae/0x580
[ 3498.246123]  cfg80211_disconnect+0x4d2/0x700 [cfg80211]
[ 3498.246208]  cfg80211_netdev_notifier_call+0x661/0x10a0 [cfg80211]
[ 3498.246291]  ? prb_next_reserve_seq+0x2a0/0x2a0
[ 3498.246295]  ? cfg80211_register_netdevice+0x2a0/0x2a0 [cfg80211]
[ 3498.246378]  ? up+0x102/0x180
[ 3498.246382]  ? __bfs+0x12e/0x220
[ 3498.246385]  ? do_raw_spin_unlock+0x54/0x220
[ 3498.246390]  ? check_irq_usage+0xb5/0xa20
[ 3498.246394]  ? __bfs+0x12e/0x220
[ 3498.246398]  ? check_irq_usage+0xb5/0xa20
[ 3498.246402]  ? check_path.constprop.0+0x24/0x50
[ 3498.246405]  ? __bfs+0x12e/0x220
[ 3498.246410]  ? __lock_acquire+0x432/0x23b0
[ 3498.246417]  ? lock_acquire+0x155/0x2e0
[ 3498.246420]  ? packet_notifier+0xd3/0xa70
[ 3498.246425]  ? find_held_lock+0x2b/0x80
[ 3498.246428]  ? packet_notifier+0x1f0/0xa70
[ 3498.246432]  ? lock_release+0xce/0x290
[ 3498.246436]  ? packet_notifier+0x1fa/0xa70
[ 3498.246440]  ? packet_getname_spkt+0x290/0x290
[ 3498.246443]  ? lock_is_held_type+0xa5/0x110
[ 3498.246449]  notifier_call_chain+0x97/0x280
[ 3498.246456]  __dev_close_many+0xe8/0x670
[ 3498.246461]  ? netdev_notify_peers+0x20/0x20
[ 3498.246466]  ? try_to_wake_up+0xa09/0x1450
[ 3498.246472]  netif_close_many+0x1e6/0x5c0
[ 3498.246477]  ? __dev_close_many+0x670/0x670
[ 3498.246481]  ? wake_up_q+0xaf/0x130
[ 3498.246486]  netif_close+0x141/0x1d0
[ 3498.246489]  ? netif_close_many+0x5c0/0x5c0
[ 3498.246495]  dev_close+0x89/0x1f0
[ 3498.246498]  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
[ 3498.246639]  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
[ 3498.246751]  process_one_work+0x83f/0x17b0
[ 3498.246758]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[ 3498.246763]  ? ieee80211_ifcomb_check+0x180/0x180 [mac80211]
[ 3498.246887]  worker_thread+0x58c/0xfb0
[ 3498.246893]  ? __kthread_parkme+0xc6/0x1f0
[ 3498.246898]  ? rescuer_thread+0x1340/0x1340
[ 3498.246901]  kthread+0x3b7/0x770
[ 3498.246904]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.246907]  ? ret_from_fork+0x17/0x3a0
[ 3498.246911]  ? lock_release+0xce/0x290
[ 3498.246915]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.246918]  ret_from_fork+0x28b/0x3a0
[ 3498.246921]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3498.246924]  ret_from_fork_asm+0x11/0x20
[ 3498.246932]  </TASK>
[ 3498.246933]
[ 3498.519343] Allocated by task 57169:
[ 3498.521634]  kasan_save_stack+0x1c/0x40
[ 3498.521644]  kasan_save_track+0x10/0x30
[ 3498.521648]  __kasan_kmalloc+0x83/0x90
[ 3498.521652]  __kmalloc_noprof+0x24e/0x7d0
[ 3498.521657]  __sta_info_alloc+0x9c/0x1980 [mac80211]
[ 3498.521817]  ieee80211_prep_connection+0x1e3/0x1550 [mac80211]
[ 3498.521919]  ieee80211_mgd_auth+0xec6/0x1960 [mac80211]
[ 3498.522034]  cfg80211_mlme_auth+0x458/0x7f0 [cfg80211]
[ 3498.522154]  nl80211_authenticate+0xa90/0x1180 [cfg80211]
[ 3498.522249]  genl_family_rcv_msg_doit+0x1cb/0x2a0
[ 3498.522255]  genl_rcv_msg+0x3f7/0x6b0
[ 3498.522258]  netlink_rcv_skb+0x125/0x380
[ 3498.522261]  genl_rcv+0x24/0x40
[ 3498.522265]  netlink_unicast+0x5dd/0x9d0
[ 3498.522268]  netlink_sendmsg+0x749/0xc00
[ 3498.522271]  __sock_sendmsg+0xc1/0x150
[ 3498.522277]  ____sys_sendmsg+0x5f4/0x8f0
[ 3498.522281]  ___sys_sendmsg+0xed/0x170
[ 3498.522285]  __sys_sendmsg+0x107/0x1a0
[ 3498.522288]  do_syscall_64+0x69/0x1210
[ 3498.522294]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 3498.522299]
[ 3498.522508] Freed by task 52511:
[ 3498.524450]  kasan_save_stack+0x1c/0x40
[ 3498.524456]  kasan_save_track+0x10/0x30
[ 3498.524460]  __kasan_save_free_info+0x37/0x50
[ 3498.524464]  __kasan_slab_free+0x3b/0x60
[ 3498.524468]  kfree+0x164/0x580
[ 3498.524473]  __sta_info_flush+0x409/0x610 [mac80211]
[ 3498.524568]  ieee80211_set_disassoc+0x14fb/0x1c10 [mac80211]
[ 3498.524658]  ieee80211_mgd_deauth+0x526/0x1780 [mac80211]
[ 3498.524762]  cfg80211_mlme_deauth+0x333/0x7a0 [cfg80211]
[ 3498.524888]  cfg80211_mlme_down+0x16f/0x230 [cfg80211]
[ 3498.524983]  cfg80211_disconnect+0x4d2/0x700 [cfg80211]
[ 3498.525065]  cfg80211_netdev_notifier_call+0x661/0x10a0 [cfg80211]
[ 3498.525173]  notifier_call_chain+0x97/0x280
[ 3498.525179]  __dev_close_many+0xe8/0x670
[ 3498.525184]  netif_close_many+0x1e6/0x5c0
[ 3498.525188]  netif_close+0x141/0x1d0
[ 3498.525192]  dev_close+0x89/0x1f0
[ 3498.525196]  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
[ 3498.525277]  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
[ 3498.525365]  process_one_work+0x83f/0x17b0
[ 3498.525370]  worker_thread+0x58c/0xfb0
[ 3498.525373]  kthread+0x3b7/0x770
[ 3498.525377]  ret_from_fork+0x28b/0x3a0
[ 3498.525394]  ret_from_fork_asm+0x11/0x20
[ 3498.525400]
[ 3498.525610] The buggy address belongs to the object at ffff88813ef84000
  which belongs to the cache kmalloc-8k of size 8192
[ 3498.535533] The buggy address is located 4264 bytes inside of
  freed 8192-byte region [ffff88813ef84000, ffff88813ef86000)
[ 3498.545368]
[ 3498.545577] The buggy address belongs to the physical page:
[ 3498.549863] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ef80
[ 3498.549868] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 3498.549871] anon flags: 0x5fff8000000040(head|node=0|zone=2|lastcpupid=0x3fff)
[ 3498.549877] page_type: f5(slab)
[ 3498.549882] raw: 005fff8000000040 ffff888120043180 ffffea0005cb8600 0000000000000005
[ 3498.549885] raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
[ 3498.549889] head: 005fff8000000040 ffff888120043180 ffffea0005cb8600 0000000000000005
[ 3498.549893] head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
[ 3498.549896] head: 005fff8000000003 ffffea0004fbe001 00000000ffffffff 00000000ffffffff
[ 3498.549899] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000000
[ 3498.549902] page dumped because: kasan: bad access detected
[ 3498.549905]
[ 3498.550110] Memory state around the buggy address:
[ 3498.553615]  ffff88813ef84f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3498.559547]  ffff88813ef85000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3498.565482] >ffff88813ef85080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3498.571409]                                   ^
[ 3498.574652]  ffff88813ef85100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3498.580588]  ffff88813ef85180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 3498.586522] ==================================================================
[ 3498.629921] Disabling lock debugging due to kernel taint: 0x5 (lockdep)

Thanks,
Ben



Return-Path: <linux-wireless+bounces-32402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCAwKuXwpmk/agAAu9opvQ
	(envelope-from <linux-wireless+bounces-32402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:32:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEF1F1839
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D843124FAE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6935B138;
	Tue,  3 Mar 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nWZeiiCj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDE2459C6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548052; cv=none; b=tQ28StYIEGoETlkpbok4b3kR9ln/tOAKr/Tf2bgjJlqDVHYfO4WmEkFowqQFgd4Dqvd8tr7cY9EkSj3MjX+gC76WHJEiWH+FsA0yFAlDE07JItT4qz7UviNQM0VymhDWLTBtbGY6uQMHPZbR/E2FAUxhQx4PfTWXJAiKnY3QG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548052; c=relaxed/simple;
	bh=gRr4MESdFNZgPASXIWr/Eqjrn3FKORLOIZxm3vyPyA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qYq98KWG/CC0xwR39SzZtaktzYpkkzbKaroEsbLNxUJjbnL6XqWLgeNLJB9/Ex+K1rInS95vCCevE8XT3nK3xFRCEZhJ069NPMdjdHCEuZVQcPe8wzAAKCj+apPL3w3RnF3WSbxH/kLw8IBHCoe81O6hJXfiH0YPymVGqCxG16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nWZeiiCj; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0AFA810009D;
	Tue,  3 Mar 2026 14:27:22 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C287F13C2B0;
	Tue,  3 Mar 2026 06:27:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C287F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772548040;
	bh=gRr4MESdFNZgPASXIWr/Eqjrn3FKORLOIZxm3vyPyA8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nWZeiiCjufr3s7hrcysK5ZvLqMSFcznu27iGnxONOMcIR7pB/ChyZt7enieOPT1xN
	 LXu5gEYhF1aJe3QSsTiDCuEIuJ7k07YXWCJfjbuPxSWBA2fK6XL9AFr4OvREr9tbkP
	 G2Rrx5T3AxWMJ1MVn+AN9XkRCH5S2ndSN1DqozKA=
Message-ID: <b5803b14-c421-4a05-96c7-56ba7d1b8edb@candelatech.com>
Date: Tue, 3 Mar 2026 06:27:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use-after-free in iwl-mld after hardware fails to restart.
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <3b570a13-7570-52c7-faff-df32c3f9ef13@candelatech.com>
 <DM3PPF63A6024A9188ACD0856EDD0826643A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <DM3PPF63A6024A9188ACD0856EDD0826643A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772548044-I8yiNSqI87Qi
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772548044;I8yiNSqI87Qi;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 09CEF1F1839
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-32402-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 23:19, Korenblit, Miriam Rachel wrote:
> 
> 
>> -----Original Message-----
>> From: Ben Greear <greearb@candelatech.com>
>> Sent: Monday, March 2, 2026 9:00 PM
>> To: linux-wireless <linux-wireless@vger.kernel.org>; Korenblit, Miriam Rachel
>> <miriam.rachel.korenblit@intel.com>
>> Subject: Use-after-free in iwl-mld after hardware fails to restart.
>>
>> Hello,
>>
>> Here's another failure case from my torture test system.
>>
>> This is from a patched 6.18.14+ kernel, but from a look at upstream Linux
>> kernel, the problems are there as well.
>>
>> I believe the problem is something like this:
>>
>> firmware crashes several times and cannot recover.  Maybe
>> Intel folks can tell why it is crashing?  I'd love to know if that
>> is something that can be fixed in the driver.
>>
>>   From mac80211/util.c:
>>
>> int ieee80211_reconfig(struct ieee80211_local *local)
>> is called, and gets to the failure case in this code (I see that second WARN in the
>> crash logs)
>> .....
>> 	/*
>> 	 * Upon resume hardware can sometimes be goofy due to
>> 	 * various platform / driver / bus issues, so restarting
>> 	 * the device may at times not work immediately. Propagate
>> 	 * the error.
>> 	 */
>> 	res = drv_start(local);
>> 	if (res) {
>> 		if (suspended)
>> 			WARN(1, "Hardware became unavailable upon resume.
>> This could be a software issue prior to suspend or a hardware issue.\n");
>> 		else
>> 			WARN(1, "Hardware became unavailable during
>> restart.\n");
>> 		ieee80211_wake_queues_by_reason(hw,
>> IEEE80211_MAX_QUEUE_MAP,
>>
>> 	IEEE80211_QUEUE_STOP_REASON_SUSPEND,
>> 						false);
>> 		ieee80211_handle_reconfig_failure(local);
>> 		return res;
>>
>>
>> This method has comments about cleaning things up, but I don't see where it
>> actually
>> cleans up the driver.  And it sets SDATA_IN_DRIVER to false, so a lot of the calls
>> in driver-ops.h that would otherwise tell the driver to clean up skip calls to
>> the driver.
>>
>> static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
>> {
>> 	struct ieee80211_sub_if_data *sdata;
>> 	struct ieee80211_chanctx *ctx;
>>
>> 	lockdep_assert_wiphy(local->hw.wiphy);
>>
>> 	/*
>> 	 * We get here if during resume the device can't be restarted properly.
>> 	 * We might also get here if this happens during HW reset, which is a
>> 	 * slightly different situation and we need to drop all connections in
>> 	 * the latter case.
>> 	 *
>> 	 * Ask cfg80211 to turn off all interfaces, this will result in more
>> 	 * warnings but at least we'll then get into a clean stopped state.
>> 	 */
>>
>> 	local->resuming = false;
>> 	local->suspended = false;
>> 	local->in_reconfig = false;
>> 	local->reconfig_failure = true;
>>
>> 	ieee80211_flush_completed_scan(local, true);
>>
>> 	/* scheduled scan clearly can't be running any more, but tell
>> 	 * cfg80211 and clear local state
>> 	 */
>> 	ieee80211_sched_scan_end(local);
>>
>> 	list_for_each_entry(sdata, &local->interfaces, list)
>> 		sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
>>
>> 	/* Mark channel contexts as not being in the driver any more to avoid
>> 	 * removing them from the driver during the shutdown process...
>> 	 */
>> 	list_for_each_entry(ctx, &local->chanctx_list, list)
>> 		ctx->driver_present = false;
>> }
>>
>>
>> So, how is the driver supposed to be cleaned up in this scenario?
> Driver was cleaned up in drv_start. See iwl_mld_restart_cleanup.
> Could you please share the iwlmld.ko and iwlwifi.ko files?

I have already made code changes and re-compiled to try to track it down.

If you can let me know what sort of information you'd like to see (like
gdb code listings?) I can gather it next time I can reproduce the problem.

Any idea why the firmware is crashing?

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



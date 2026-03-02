Return-Path: <linux-wireless+bounces-32355-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KsuFN/epWkvHgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32355-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 20:02:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560A1DE937
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 20:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEB283088ECC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061621C4A20;
	Mon,  2 Mar 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="iVXcNzl0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16D2E764D
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478028; cv=none; b=buLh1afCXIhotNHFUWkd0W4x3/ecgzvBZp43BxObkYvjiBbVKSaU5fh1Y7khglbv5hMzyTt8J2xxKB9hu3EbKOWOtKZyP2kK2mUrksqJKlIt94HubHPJdUr/BisZhYo0meqT4dxzOixuGfI8e7LR/hLV3ag++TLkb8p5NjElQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478028; c=relaxed/simple;
	bh=Nu2PILdZSviuF1Ju+NQajlA4FTK4Lggcb6RFeLt0R44=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=alEXOGbje16qdy2CO0jmXZcDKaHEkapnrXlQRbQ66ghuOYMl4e0+n/t8HL/xY7eQzTYYrWuIBff89iJJHGroG+MRflRNKmCe7IDYi/JnXe0nDxc1G1xblH+ffVvr45WvinUYmYYUMY7PpgV23lMC3oUz7CqZQu4vILlC06tB2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=iVXcNzl0; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C40639C00BA;
	Mon,  2 Mar 2026 19:00:15 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2013213C2B0;
	Mon,  2 Mar 2026 11:00:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2013213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772478013;
	bh=Nu2PILdZSviuF1Ju+NQajlA4FTK4Lggcb6RFeLt0R44=;
	h=Date:To:From:Subject:From;
	b=iVXcNzl0SN9fv0fkEIyp6YZejoNRxvuv3WDNEo8RMb4eaBcC5XJRJDx6O+mgV7euR
	 2u5zgpjfV1G0Ct9wL2G+T7AkivFUR3FgsCs++tmWl/tDbntKmoibUwj6I7grpqmjTE
	 YsjbWMa2C2OB7/UktC2Nxtv5a0y/3+IvyKcgBcFU=
Message-ID: <3b570a13-7570-52c7-faff-df32c3f9ef13@candelatech.com>
Date: Mon, 2 Mar 2026 11:00:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: Use-after-free in iwl-mld after hardware fails to restart.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772478016-w0SYDkJ34So2
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772478016;w0SYDkJ34So2;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 9560A1DE937
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32355-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,candelatech.com:dkim,candelatech.com:email,candelatech.com:url,candelatech.com:mid]
X-Rspamd-Action: no action

Hello,

Here's another failure case from my torture test system.

This is from a patched 6.18.14+ kernel, but from a look at upstream Linux
kernel, the problems are there as well.

I believe the problem is something like this:

firmware crashes several times and cannot recover.  Maybe
Intel folks can tell why it is crashing?  I'd love to know if that
is something that can be fixed in the driver.

 From mac80211/util.c:

int ieee80211_reconfig(struct ieee80211_local *local)
is called, and gets to the failure case in this code (I see that second WARN in the crash logs)
.....
	/*
	 * Upon resume hardware can sometimes be goofy due to
	 * various platform / driver / bus issues, so restarting
	 * the device may at times not work immediately. Propagate
	 * the error.
	 */
	res = drv_start(local);
	if (res) {
		if (suspended)
			WARN(1, "Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.\n");
		else
			WARN(1, "Hardware became unavailable during restart.\n");
		ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
						IEEE80211_QUEUE_STOP_REASON_SUSPEND,
						false);
		ieee80211_handle_reconfig_failure(local);
		return res;


This method has comments about cleaning things up, but I don't see where it actually
cleans up the driver.  And it sets SDATA_IN_DRIVER to false, so a lot of the calls
in driver-ops.h that would otherwise tell the driver to clean up skip calls to
the driver.

static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
{
	struct ieee80211_sub_if_data *sdata;
	struct ieee80211_chanctx *ctx;

	lockdep_assert_wiphy(local->hw.wiphy);

	/*
	 * We get here if during resume the device can't be restarted properly.
	 * We might also get here if this happens during HW reset, which is a
	 * slightly different situation and we need to drop all connections in
	 * the latter case.
	 *
	 * Ask cfg80211 to turn off all interfaces, this will result in more
	 * warnings but at least we'll then get into a clean stopped state.
	 */

	local->resuming = false;
	local->suspended = false;
	local->in_reconfig = false;
	local->reconfig_failure = true;

	ieee80211_flush_completed_scan(local, true);

	/* scheduled scan clearly can't be running any more, but tell
	 * cfg80211 and clear local state
	 */
	ieee80211_sched_scan_end(local);

	list_for_each_entry(sdata, &local->interfaces, list)
		sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;

	/* Mark channel contexts as not being in the driver any more to avoid
	 * removing them from the driver during the shutdown process...
	 */
	list_for_each_entry(ctx, &local->chanctx_list, list)
		ctx->driver_present = false;
}


So, how is the driver supposed to be cleaned up in this scenario?

A snippet of dmesg logs (from kdump crash logs) with KASAN use-after-free is below.  There were more
warnings and firmware crashes above, but I think this is probably the important
part.



[27428.778388] ---[ end trace 0000000000000000 ]---
[27428.781817] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[27430.502776] iwlwifi 0000:36:00.0: Device error - SW reset
[27430.502790] iwlwifi 0000:36:00.0: Couldn't send the SESSION_PROTECTION_CMD (-5)
[27430.507736] ieee80211 wiphy11: Hardware restart was requested
[27430.513028] wlan11: send auth to 70:58:a4:ff:75:59 (try 2/4)
[27431.669547] iwlwifi 0000:36:00.0: Microcode SW error detected. Restarting 0x0.
[27431.675717] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27431.683150] iwlwifi 0000:36:00.0: 0x00000000 | ADVANCED_SYSASSERT
[27431.688847] iwlwifi 0000:36:00.0: 0x00000000 | trm_hw_status0
[27431.693342] iwlwifi 0000:36:00.0: 0x00000000 | trm_hw_status1
[27431.697807] iwlwifi 0000:36:00.0: 0x00000000 | branchlink2
[27431.702023] iwlwifi 0000:36:00.0: 0x00000000 | interruptlink1
[27431.706501] iwlwifi 0000:36:00.0: 0x00000000 | interruptlink2
[27431.710979] iwlwifi 0000:36:00.0: 0x00000000 | data1
[27431.714680] iwlwifi 0000:36:00.0: 0x00000000 | data2
[27431.718389] iwlwifi 0000:36:00.0: 0x00000000 | data3
[27431.722089] iwlwifi 0000:36:00.0: 0x00000000 | beacon time
[27431.726304] iwlwifi 0000:36:00.0: 0x00000000 | tsf low
[27431.730157] iwlwifi 0000:36:00.0: 0x00000000 | tsf hi
[27431.733920] iwlwifi 0000:36:00.0: 0x00000000 | time gp1
[27431.737865] iwlwifi 0000:36:00.0: 0x00000000 | time gp2
[27431.741814] iwlwifi 0000:36:00.0: 0x00000000 | uCode revision type
[27431.746721] iwlwifi 0000:36:00.0: 0x00000000 | uCode version major
[27431.751607] iwlwifi 0000:36:00.0: 0x00000000 | uCode version minor
[27431.756500] iwlwifi 0000:36:00.0: 0x00000000 | hw version
[27431.760611] iwlwifi 0000:36:00.0: 0x00000000 | board version
[27431.764983] iwlwifi 0000:36:00.0: 0x00000000 | hcmd
[27431.768577] iwlwifi 0000:36:00.0: 0x00000000 | isr0
[27431.772165] iwlwifi 0000:36:00.0: 0x00000000 | isr1
[27431.775753] iwlwifi 0000:36:00.0: 0x00000000 | isr2
[27431.779371] iwlwifi 0000:36:00.0: 0x00000000 | isr3
[27431.782964] iwlwifi 0000:36:00.0: 0x00000000 | isr4
[27431.786556] iwlwifi 0000:36:00.0: 0x00000000 | last cmd Id
[27431.790796] iwlwifi 0000:36:00.0: 0x00000000 | wait_event
[27431.794929] iwlwifi 0000:36:00.0: 0x00000000 | l2p_control
[27431.799132] iwlwifi 0000:36:00.0: 0x00000000 | l2p_duration
[27431.803426] iwlwifi 0000:36:00.0: 0x00000000 | l2p_mhvalid
[27431.807630] iwlwifi 0000:36:00.0: 0x00000000 | l2p_addr_match
[27431.812119] iwlwifi 0000:36:00.0: 0x00000000 | lmpm_pmg_sel
[27431.816404] iwlwifi 0000:36:00.0: 0x00000000 | timestamp
[27431.820435] iwlwifi 0000:36:00.0: 0x00000000 | flow_handler
[27431.824895] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27431.829184] iwlwifi 0000:36:00.0: Transport status: 0x0000014A, valid: 6
[27431.834603] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27431.842034] iwlwifi 0000:36:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[27431.847707] iwlwifi 0000:36:00.0: 0x000002F0 | trm_hw_status0
[27431.852178] iwlwifi 0000:36:00.0: 0x00000000 | trm_hw_status1
[27431.856653] iwlwifi 0000:36:00.0: 0x002C438C | branchlink2
[27431.860891] iwlwifi 0000:36:00.0: 0x002B8AD0 | interruptlink1
[27431.865404] iwlwifi 0000:36:00.0: 0x002B8AD0 | interruptlink2
[27431.869859] iwlwifi 0000:36:00.0: 0x002A5822 | data1
[27431.873545] iwlwifi 0000:36:00.0: 0x00000010 | data2
[27431.877228] iwlwifi 0000:36:00.0: 0x00000000 | data3
[27431.880907] iwlwifi 0000:36:00.0: 0x00000000 | beacon time
[27431.885111] iwlwifi 0000:36:00.0: 0x000C06D2 | tsf low
[27431.888960] iwlwifi 0000:36:00.0: 0x00000000 | tsf hi
[27431.892741] iwlwifi 0000:36:00.0: 0x00000000 | time gp1
[27431.896699] iwlwifi 0000:36:00.0: 0x000EA826 | time gp2
[27431.900653] iwlwifi 0000:36:00.0: 0x00000001 | uCode revision type
[27431.905558] iwlwifi 0000:36:00.0: 0x00000065 | uCode version major
[27431.910464] iwlwifi 0000:36:00.0: 0x6EF20B19 | uCode version minor
[27431.915360] iwlwifi 0000:36:00.0: 0x00000472 | hw version
[27431.919468] iwlwifi 0000:36:00.0: 0x18C80002 | board version
[27431.923851] iwlwifi 0000:36:00.0: 0x8008FF05 | hcmd
[27431.927457] iwlwifi 0000:36:00.0: 0x00020000 | isr0
[27431.931064] iwlwifi 0000:36:00.0: 0x00000000 | isr1
[27431.934668] iwlwifi 0000:36:00.0: 0x48700002 | isr2
[27431.938275] iwlwifi 0000:36:00.0: 0x00C0001C | isr3
[27431.941873] iwlwifi 0000:36:00.0: 0x00000000 | isr4
[27431.945485] iwlwifi 0000:36:00.0: 0x00000000 | last cmd Id
[27431.949698] iwlwifi 0000:36:00.0: 0x002A5822 | wait_event
[27431.953823] iwlwifi 0000:36:00.0: 0x10000014 | l2p_control
[27431.958035] iwlwifi 0000:36:00.0: 0x00000000 | l2p_duration
[27431.962345] iwlwifi 0000:36:00.0: 0x00000000 | l2p_mhvalid
[27431.966545] iwlwifi 0000:36:00.0: 0x00000000 | l2p_addr_match
[27431.971021] iwlwifi 0000:36:00.0: 0x0000000B | lmpm_pmg_sel
[27431.975336] iwlwifi 0000:36:00.0: 0x00000000 | timestamp
[27431.979378] iwlwifi 0000:36:00.0: 0x00000024 | flow_handler
[27431.983800] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27431.988108] iwlwifi 0000:36:00.0: Transport status: 0x0000014A, valid: 7
[27431.993563] iwlwifi 0000:36:00.0: 0x20000034 | NMI_INTERRUPT_WDG
[27431.998303] iwlwifi 0000:36:00.0: 0x00000000 | umac branchlink1
[27432.002966] iwlwifi 0000:36:00.0: 0xC00808AA | umac branchlink2
[27432.007629] iwlwifi 0000:36:00.0: 0xC0081780 | umac interruptlink1
[27432.012526] iwlwifi 0000:36:00.0: 0x0101F1D8 | umac interruptlink2
[27432.017443] iwlwifi 0000:36:00.0: 0x00000020 | umac data1
[27432.021574] iwlwifi 0000:36:00.0: 0x0101F1D8 | umac data2
[27432.025706] iwlwifi 0000:36:00.0: 0x00000000 | umac data3
[27432.029842] iwlwifi 0000:36:00.0: 0x00000065 | umac major
[27432.033967] iwlwifi 0000:36:00.0: 0x6EF20B19 | umac minor
[27432.038091] iwlwifi 0000:36:00.0: 0x000EA81B | frame pointer
[27432.042478] iwlwifi 0000:36:00.0: 0xD00D6D44 | stack pointer
[27432.046864] iwlwifi 0000:36:00.0: 0x0001016A | last host cmd
[27432.051245] iwlwifi 0000:36:00.0: 0x00000000 | isr status reg
[27432.055892] iwlwifi 0000:36:00.0: TCM1 status:
[27432.059063] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[27432.062999] iwlwifi 0000:36:00.0: 0x00001D2E | tcm branchlink2
[27432.067561] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink1
[27432.072388] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink2
[27432.077211] iwlwifi 0000:36:00.0: 0x40000000 | tcm data1
[27432.081251] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data2
[27432.085290] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data3
[27432.089372] iwlwifi 0000:36:00.0: 0x00001DAC | tcm log PC
[27432.093499] iwlwifi 0000:36:00.0: 0x00803FF0 | tcm frame pointer
[27432.098249] iwlwifi 0000:36:00.0: 0x00803F5C | tcm stack pointer
[27432.102988] iwlwifi 0000:36:00.0: 0x00000000 | tcm msg ID
[27432.107113] iwlwifi 0000:36:00.0: 0x40080000 | tcm ISR status
[27432.111585] iwlwifi 0000:36:00.0: 0x000002F0 | tcm HW status[0]
[27432.116259] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[1]
[27432.120894] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[2]
[27432.125540] iwlwifi 0000:36:00.0: 0x00008100 | tcm HW status[3]
[27432.130247] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[4]
[27432.134883] iwlwifi 0000:36:00.0: 0x00000000 | tcm SW status[0]
[27432.139663] iwlwifi 0000:36:00.0: RCM1 status:
[27432.142819] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[27432.146828] iwlwifi 0000:36:00.0: 0x00001E2E | rcm branchlink2
[27432.151378] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink1
[27432.156200] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink2
[27432.161019] iwlwifi 0000:36:00.0: 0x20000000 | rcm data1
[27432.165058] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data2
[27432.169096] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data3
[27432.173135] iwlwifi 0000:36:00.0: 0x00001E98 | rcm log PC
[27432.177262] iwlwifi 0000:36:00.0: 0x00803FF0 | rcm frame pointer
[27432.181994] iwlwifi 0000:36:00.0: 0x00803F5C | rcm stack pointer
[27432.186731] iwlwifi 0000:36:00.0: 0x00000000 | rcm msg ID
[27432.190878] iwlwifi 0000:36:00.0: 0x20000000 | rcm ISR status
[27432.195361] iwlwifi 0000:36:00.0: 0x00420500 | frame HW status
[27432.199939] iwlwifi 0000:36:00.0: 0x00000000 | LMAC-to-RCM request mbox
[27432.205326] iwlwifi 0000:36:00.0: 0x00000000 | RCM-to-LMAC request mbox
[27432.210675] iwlwifi 0000:36:00.0: 0x00000000 | MAC header control
[27432.215482] iwlwifi 0000:36:00.0: 0x00000000 | MAC header addr1 low
[27432.220491] iwlwifi 0000:36:00.0: 0x003C0000 | MAC header info
[27432.225040] iwlwifi 0000:36:00.0: 0x00000000 | MAC header error
[27432.229831] iwlwifi 0000:36:00.0: TCM2 status:
[27432.232990] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[27432.236963] iwlwifi 0000:36:00.0: 0x00001D2E | tcm branchlink2
[27432.241526] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink1
[27432.246350] iwlwifi 0000:36:00.0: 0x0000211C | tcm interruptlink2
[27432.251173] iwlwifi 0000:36:00.0: 0x40000000 | tcm data1
[27432.255211] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data2
[27432.259249] iwlwifi 0000:36:00.0: 0xDEADBEEF | tcm data3
[27432.263292] iwlwifi 0000:36:00.0: 0x00001DAC | tcm log PC
[27432.267423] iwlwifi 0000:36:00.0: 0x00803FF0 | tcm frame pointer
[27432.272158] iwlwifi 0000:36:00.0: 0x00803F5C | tcm stack pointer
[27432.276882] iwlwifi 0000:36:00.0: 0x00000000 | tcm msg ID
[27432.281032] iwlwifi 0000:36:00.0: 0x40080000 | tcm ISR status
[27432.285494] iwlwifi 0000:36:00.0: 0x000002F0 | tcm HW status[0]
[27432.290136] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[1]
[27432.294784] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[2]
[27432.299456] iwlwifi 0000:36:00.0: 0x00008000 | tcm HW status[3]
[27432.304114] iwlwifi 0000:36:00.0: 0x00000000 | tcm HW status[4]
[27432.308750] iwlwifi 0000:36:00.0: 0x00000000 | tcm SW status[0]
[27432.313536] iwlwifi 0000:36:00.0: RCM2 status:
[27432.316694] iwlwifi 0000:36:00.0: 0x00000070 | error ID
[27432.320664] iwlwifi 0000:36:00.0: 0x00001E2E | rcm branchlink2
[27432.325214] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink1
[27432.330034] iwlwifi 0000:36:00.0: 0x000027A0 | rcm interruptlink2
[27432.334853] iwlwifi 0000:36:00.0: 0x20000000 | rcm data1
[27432.338912] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data2
[27432.342938] iwlwifi 0000:36:00.0: 0xDEADBEEF | rcm data3
[27432.346976] iwlwifi 0000:36:00.0: 0x00001E98 | rcm log PC
[27432.351109] iwlwifi 0000:36:00.0: 0x00803FF0 | rcm frame pointer
[27432.355864] iwlwifi 0000:36:00.0: 0x00803F5C | rcm stack pointer
[27432.360587] iwlwifi 0000:36:00.0: 0x00000000 | rcm msg ID
[27432.364718] iwlwifi 0000:36:00.0: 0x20000000 | rcm ISR status
[27432.369196] iwlwifi 0000:36:00.0: 0x00420500 | frame HW status
[27432.373781] iwlwifi 0000:36:00.0: 0x00000000 | LMAC-to-RCM request mbox
[27432.379122] iwlwifi 0000:36:00.0: 0x00000000 | RCM-to-LMAC request mbox
[27432.384487] iwlwifi 0000:36:00.0: 0x00000000 | MAC header control
[27432.389334] iwlwifi 0000:36:00.0: 0x00000000 | MAC header addr1 low
[27432.394353] iwlwifi 0000:36:00.0: 0x003C0000 | MAC header info
[27432.398900] iwlwifi 0000:36:00.0: 0x00000000 | MAC header error
[27432.403630] iwlwifi 0000:36:00.0: IML/ROM dump:
[27432.406892] iwlwifi 0000:36:00.0: 0x00000B03 | IML/ROM error/state
[27432.411841] iwlwifi 0000:36:00.0: 0x0000EED3 | IML/ROM data1
[27432.416273] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[27432.421562] iwlwifi 0000:36:00.0: Fseq Registers:
[27432.424999] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[27432.429571] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[27432.434666] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[27432.439923] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[27432.444577] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[27432.449927] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[27432.454572] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[27432.458884] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[27432.463196] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[27432.468023] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[27432.472851] iwlwifi 0000:36:00.0: 0x8F0F1BEF | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[27432.479415] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[27432.486314] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[27432.492012] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[27432.497184] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[27432.502187] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[27432.507324] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x8028b71c
[27432.511795] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0x15c8e
[27432.516107] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0xd0
[27432.520151] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x8028b71e
[27432.524790] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0xd0
[27432.528766] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0xd0
[27432.532728] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0xd0
[27432.536714] iwlwifi 0000:36:00.0: Function Scratch status:
[27432.540913] iwlwifi 0000:36:00.0: 0x01010101 | Func Scratch
[27433.026472] iwlwifi 0000:36:00.0: Failed to get INIT_COMPLETE -110
[27433.031380] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[27433.484021] workqueue: igb_watchdog_task [igb] hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
[27433.697463] iwlwifi 0000:36:00.0: timeout waiting for FW reset ACK (inta_hw=0x0, reset_done 0)
[27433.708870] iwlwifi 0000:36:00.0: HW error, resetting before reading
[27433.734508] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27433.738804] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -566635632
[27433.745035] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27433.752444] iwlwifi 0000:36:00.0: 0xCD04FE13 | ADVANCED_SYSASSERT
[27433.758156] iwlwifi 0000:36:00.0: 0xF846F31B | trm_hw_status0
[27433.762632] iwlwifi 0000:36:00.0: 0xB6AD1934 | trm_hw_status1
[27433.767106] iwlwifi 0000:36:00.0: 0x3F7FBC43 | branchlink2
[27433.771316] iwlwifi 0000:36:00.0: 0x3CB4435F | interruptlink1
[27433.775773] iwlwifi 0000:36:00.0: 0x0143963D | interruptlink2
[27433.780249] iwlwifi 0000:36:00.0: 0x1FD4C46C | data1
[27433.783944] iwlwifi 0000:36:00.0: 0xD7B8810A | data2
[27433.787652] iwlwifi 0000:36:00.0: 0x23DAA79F | data3
[27433.791333] iwlwifi 0000:36:00.0: 0xA6FBCFD6 | beacon time
[27433.795580] iwlwifi 0000:36:00.0: 0x17A7F7A8 | tsf low
[27433.799434] iwlwifi 0000:36:00.0: 0x2FDE7F52 | tsf hi
[27433.803202] iwlwifi 0000:36:00.0: 0x8291BEA1 | time gp1
[27433.807135] iwlwifi 0000:36:00.0: 0x431F5276 | time gp2
[27433.811106] iwlwifi 0000:36:00.0: 0xFD26C2E0 | uCode revision type
[27433.816006] iwlwifi 0000:36:00.0: 0xCA51FD4C | uCode version major
[27433.820917] iwlwifi 0000:36:00.0: 0x4E251D55 | uCode version minor
[27433.825823] iwlwifi 0000:36:00.0: 0x5DAD77E5 | hw version
[27433.829949] iwlwifi 0000:36:00.0: 0x87F0B58D | board version
[27433.834337] iwlwifi 0000:36:00.0: 0x70D0B729 | hcmd
[27433.837938] iwlwifi 0000:36:00.0: 0x932C4124 | isr0
[27433.841537] iwlwifi 0000:36:00.0: 0x113C7BD2 | isr1
[27433.845134] iwlwifi 0000:36:00.0: 0x926561B8 | isr2
[27433.848730] iwlwifi 0000:36:00.0: 0xEA001A8D | isr3
[27433.852346] iwlwifi 0000:36:00.0: 0x1E5E0C3C | isr4
[27433.855947] iwlwifi 0000:36:00.0: 0x9DC24A5E | last cmd Id
[27433.860163] iwlwifi 0000:36:00.0: 0x80C72210 | wait_event
[27433.864277] iwlwifi 0000:36:00.0: 0x49830C39 | l2p_control
[27433.868499] iwlwifi 0000:36:00.0: 0xBE0137F0 | l2p_duration
[27433.872787] iwlwifi 0000:36:00.0: 0xDC56ABC8 | l2p_mhvalid
[27433.877001] iwlwifi 0000:36:00.0: 0x01887468 | l2p_addr_match
[27433.881470] iwlwifi 0000:36:00.0: 0x89E06933 | lmpm_pmg_sel
[27433.885753] iwlwifi 0000:36:00.0: 0xBC593E6E | timestamp
[27433.889790] iwlwifi 0000:36:00.0: 0x081BC4A6 | flow_handler
[27433.894255] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27433.898577] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -134489909
[27433.904771] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27433.912219] iwlwifi 0000:36:00.0: 0xED21913C | ADVANCED_SYSASSERT
[27433.917921] iwlwifi 0000:36:00.0: 0x0C826210 | trm_hw_status0
[27433.922395] iwlwifi 0000:36:00.0: 0x8DCD76FF | trm_hw_status1
[27433.926869] iwlwifi 0000:36:00.0: 0x6BC6B6B5 | branchlink2
[27433.931083] iwlwifi 0000:36:00.0: 0xDA7C4E37 | interruptlink1
[27433.935553] iwlwifi 0000:36:00.0: 0x7B4289B7 | interruptlink2
[27433.940024] iwlwifi 0000:36:00.0: 0x34C0B73D | data1
[27433.943717] iwlwifi 0000:36:00.0: 0x68C4B32A | data2
[27433.947412] iwlwifi 0000:36:00.0: 0x85C87A41 | data3
[27433.951109] iwlwifi 0000:36:00.0: 0x0E6D3FFE | beacon time
[27433.955340] iwlwifi 0000:36:00.0: 0xD7F2F4A6 | tsf low
[27433.959195] iwlwifi 0000:36:00.0: 0xC92BCC40 | tsf hi
[27433.962975] iwlwifi 0000:36:00.0: 0xCF6C9AB2 | time gp1
[27433.966929] iwlwifi 0000:36:00.0: 0x8F928A68 | time gp2
[27433.970898] iwlwifi 0000:36:00.0: 0xAA79F6FB | uCode revision type
[27433.975792] iwlwifi 0000:36:00.0: 0x22B1757D | uCode version major
[27433.980703] iwlwifi 0000:36:00.0: 0x5C25F16F | uCode version minor
[27433.985613] iwlwifi 0000:36:00.0: 0x13816B3D | hw version
[27433.989720] iwlwifi 0000:36:00.0: 0xDDC6D3EF | board version
[27433.994108] iwlwifi 0000:36:00.0: 0x228E7953 | hcmd
[27433.997712] iwlwifi 0000:36:00.0: 0x228E4073 | isr0
[27434.001346] iwlwifi 0000:36:00.0: 0x011050CC | isr1
[27434.004941] iwlwifi 0000:36:00.0: 0xA8EA252F | isr2
[27434.008540] iwlwifi 0000:36:00.0: 0x422C99A6 | isr3
[27434.012133] iwlwifi 0000:36:00.0: 0x2A0FE89B | isr4
[27434.015732] iwlwifi 0000:36:00.0: 0x0D0D436E | last cmd Id
[27434.019937] iwlwifi 0000:36:00.0: 0xFA23D706 | wait_event
[27434.024048] iwlwifi 0000:36:00.0: 0xDE5662B4 | l2p_control
[27434.028243] iwlwifi 0000:36:00.0: 0x302B1411 | l2p_duration
[27434.032526] iwlwifi 0000:36:00.0: 0xF1ED9999 | l2p_mhvalid
[27434.036730] iwlwifi 0000:36:00.0: 0xD911283A | l2p_addr_match
[27434.041203] iwlwifi 0000:36:00.0: 0x4B50E379 | lmpm_pmg_sel
[27434.045503] iwlwifi 0000:36:00.0: 0x06F0B25E | timestamp
[27434.049549] iwlwifi 0000:36:00.0: 0xCCA6B9C4 | flow_handler
[27434.053904] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27434.058189] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: 1536606043
[27434.064404] iwlwifi 0000:36:00.0: 0xF5BB6DC3 | ADVANCED_SYSASSERT
[27434.069223] iwlwifi 0000:36:00.0: 0xA9C4AB03 | umac branchlink1
[27434.073879] iwlwifi 0000:36:00.0: 0xFBDED068 | umac branchlink2
[27434.078511] iwlwifi 0000:36:00.0: 0xF0EFCDC6 | umac interruptlink1
[27434.083400] iwlwifi 0000:36:00.0: 0x927DFA57 | umac interruptlink2
[27434.088304] iwlwifi 0000:36:00.0: 0xDF056A40 | umac data1
[27434.092431] iwlwifi 0000:36:00.0: 0x76CFCF9D | umac data2
[27434.096548] iwlwifi 0000:36:00.0: 0xDF3F7DAE | umac data3
[27434.100665] iwlwifi 0000:36:00.0: 0x2F9E655D | umac major
[27434.104781] iwlwifi 0000:36:00.0: 0x4EC3E237 | umac minor
[27434.108922] iwlwifi 0000:36:00.0: 0xF0D6BBEE | frame pointer
[27434.113293] iwlwifi 0000:36:00.0: 0xFF8AD538 | stack pointer
[27434.117679] iwlwifi 0000:36:00.0: 0x2BD3FED4 | last host cmd
[27434.122055] iwlwifi 0000:36:00.0: 0x9466AB8F | isr status reg
[27434.126606] iwlwifi 0000:36:00.0: TCM1 status:
[27434.129775] iwlwifi 0000:36:00.0: 0x311495AC | error ID
[27434.133721] iwlwifi 0000:36:00.0: 0xD7A7F20C | tcm branchlink2
[27434.138272] iwlwifi 0000:36:00.0: 0x6811D4EF | tcm interruptlink1
[27434.143080] iwlwifi 0000:36:00.0: 0x9FB5106B | tcm interruptlink2
[27434.147896] iwlwifi 0000:36:00.0: 0x6C240BD9 | tcm data1
[27434.151919] iwlwifi 0000:36:00.0: 0xB7BFA272 | tcm data2
[27434.155941] iwlwifi 0000:36:00.0: 0xF84FA90F | tcm data3
[27434.159964] iwlwifi 0000:36:00.0: 0x85DC37F5 | tcm log PC
[27434.164073] iwlwifi 0000:36:00.0: 0xA54305E0 | tcm frame pointer
[27434.168808] iwlwifi 0000:36:00.0: 0x5B7611C9 | tcm stack pointer
[27434.173533] iwlwifi 0000:36:00.0: 0x9683E832 | tcm msg ID
[27434.177650] iwlwifi 0000:36:00.0: 0x34057B3A | tcm ISR status
[27434.182107] iwlwifi 0000:36:00.0: 0xEDADE1E4 | tcm HW status[0]
[27434.186744] iwlwifi 0000:36:00.0: 0x0455D58F | tcm HW status[1]
[27434.191384] iwlwifi 0000:36:00.0: 0x347776EF | tcm HW status[2]
[27434.196018] iwlwifi 0000:36:00.0: 0x79C3887F | tcm HW status[3]
[27434.200645] iwlwifi 0000:36:00.0: 0xD13E8FE7 | tcm HW status[4]
[27434.205282] iwlwifi 0000:36:00.0: 0x77EE9B1C | tcm SW status[0]
[27434.210023] iwlwifi 0000:36:00.0: RCM1 status:
[27434.213188] iwlwifi 0000:36:00.0: 0xFDF7D0DB | error ID
[27434.217148] iwlwifi 0000:36:00.0: 0xEB23F6E4 | rcm branchlink2
[27434.221702] iwlwifi 0000:36:00.0: 0xA7F097C1 | rcm interruptlink1
[27434.226530] iwlwifi 0000:36:00.0: 0x03F23DE7 | rcm interruptlink2
[27434.231369] iwlwifi 0000:36:00.0: 0x59887C5A | rcm data1
[27434.235411] iwlwifi 0000:36:00.0: 0x8DDCAF7A | rcm data2
[27434.239459] iwlwifi 0000:36:00.0: 0x59B81B89 | rcm data3
[27434.243505] iwlwifi 0000:36:00.0: 0x87388B8C | rcm log PC
[27434.247630] iwlwifi 0000:36:00.0: 0x1DA9B7CD | rcm frame pointer
[27434.252382] iwlwifi 0000:36:00.0: 0xC327F637 | rcm stack pointer
[27434.257119] iwlwifi 0000:36:00.0: 0xDE7EDF46 | rcm msg ID
[27434.261249] iwlwifi 0000:36:00.0: 0xB1B7E577 | rcm ISR status
[27434.265725] iwlwifi 0000:36:00.0: 0x9C6BA502 | frame HW status
[27434.270285] iwlwifi 0000:36:00.0: 0x145C4A78 | LMAC-to-RCM request mbox
[27434.275614] iwlwifi 0000:36:00.0: 0x89AFB25B | RCM-to-LMAC request mbox
[27434.280952] iwlwifi 0000:36:00.0: 0xCF58B0AF | MAC header control
[27434.285775] iwlwifi 0000:36:00.0: 0x0DE3627B | MAC header addr1 low
[27434.290770] iwlwifi 0000:36:00.0: 0x3C05F23C | MAC header info
[27434.295347] iwlwifi 0000:36:00.0: 0x93D7E939 | MAC header error
[27434.300101] iwlwifi 0000:36:00.0: TCM2 status:
[27434.303259] iwlwifi 0000:36:00.0: 0x574771EE | error ID
[27434.307216] iwlwifi 0000:36:00.0: 0xD1774DB4 | tcm branchlink2
[27434.311798] iwlwifi 0000:36:00.0: 0xDCF3632F | tcm interruptlink1
[27434.316667] iwlwifi 0000:36:00.0: 0x3FDFED69 | tcm interruptlink2
[27434.321490] iwlwifi 0000:36:00.0: 0x3FA917F0 | tcm data1
[27434.325542] iwlwifi 0000:36:00.0: 0xC06718DC | tcm data2
[27434.329585] iwlwifi 0000:36:00.0: 0x4F228CE5 | tcm data3
[27434.333612] iwlwifi 0000:36:00.0: 0xDD39B0B2 | tcm log PC
[27434.337731] iwlwifi 0000:36:00.0: 0x1C7BB08A | tcm frame pointer
[27434.342457] iwlwifi 0000:36:00.0: 0xB28DBF54 | tcm stack pointer
[27434.347180] iwlwifi 0000:36:00.0: 0xE3E52A2E | tcm msg ID
[27434.351293] iwlwifi 0000:36:00.0: 0xB9736DEF | tcm ISR status
[27434.355772] iwlwifi 0000:36:00.0: 0xBA3B07D8 | tcm HW status[0]
[27434.360428] iwlwifi 0000:36:00.0: 0xC235BB61 | tcm HW status[1]
[27434.365066] iwlwifi 0000:36:00.0: 0x983479BF | tcm HW status[2]
[27434.369702] iwlwifi 0000:36:00.0: 0x8F372EC9 | tcm HW status[3]
[27434.374356] iwlwifi 0000:36:00.0: 0x2DFE58B2 | tcm HW status[4]
[27434.379004] iwlwifi 0000:36:00.0: 0xA6DEF528 | tcm SW status[0]
[27434.383825] iwlwifi 0000:36:00.0: RCM2 status:
[27434.386980] iwlwifi 0000:36:00.0: 0xFF61FB75 | error ID
[27434.390920] iwlwifi 0000:36:00.0: 0x67076D22 | rcm branchlink2
[27434.395471] iwlwifi 0000:36:00.0: 0x6F73050F | rcm interruptlink1
[27434.400279] iwlwifi 0000:36:00.0: 0x16E30B4F | rcm interruptlink2
[27434.405089] iwlwifi 0000:36:00.0: 0xF140A896 | rcm data1
[27434.409116] iwlwifi 0000:36:00.0: 0x7FA48784 | rcm data2
[27434.413140] iwlwifi 0000:36:00.0: 0xA8AA5283 | rcm data3
[27434.417168] iwlwifi 0000:36:00.0: 0xA5749F80 | rcm log PC
[27434.421296] iwlwifi 0000:36:00.0: 0x6B201787 | rcm frame pointer
[27434.426039] iwlwifi 0000:36:00.0: 0x1BF4C147 | rcm stack pointer
[27434.430761] iwlwifi 0000:36:00.0: 0xFD31318A | rcm msg ID
[27434.434891] iwlwifi 0000:36:00.0: 0x873460C1 | rcm ISR status
[27434.439388] iwlwifi 0000:36:00.0: 0x6F77F04A | frame HW status
[27434.443936] iwlwifi 0000:36:00.0: 0xC6DF4CBE | LMAC-to-RCM request mbox
[27434.449265] iwlwifi 0000:36:00.0: 0x1BD38A2E | RCM-to-LMAC request mbox
[27434.454593] iwlwifi 0000:36:00.0: 0x2FEEFFF5 | MAC header control
[27434.459405] iwlwifi 0000:36:00.0: 0xA19ADB4B | MAC header addr1 low
[27434.464389] iwlwifi 0000:36:00.0: 0xF09CEA1D | MAC header info
[27434.468937] iwlwifi 0000:36:00.0: 0xEAFAE2DE | MAC header error
[27434.473619] iwlwifi 0000:36:00.0: IML/ROM dump:
[27434.476867] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM error/state
[27434.481812] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM data1
[27434.486225] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[27434.491501] iwlwifi 0000:36:00.0: Fseq Registers:
[27434.494942] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[27434.499510] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[27434.504599] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[27434.509856] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[27434.514509] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[27434.519846] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[27434.524490] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[27434.528786] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[27434.533094] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[27434.537927] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[27434.542745] iwlwifi 0000:36:00.0: 0x8F0F1041 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[27434.549305] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[27434.556204] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[27434.561886] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[27434.567059] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[27434.572057] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[27434.577164] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x1110bad
[27434.581546] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0x0
[27434.585493] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0x0
[27434.589441] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x2220bad
[27434.593998] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0x0
[27434.597864] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0x0
[27434.601728] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0x0
[27434.605592] iwlwifi 0000:36:00.0: Function Scratch status:
[27434.609795] iwlwifi 0000:36:00.0: 0x01010000 | Func Scratch
[27434.614080] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[27434.825460] iwlwifi 0000:36:00.0: timeout waiting for FW reset ACK (inta_hw=0x0, reset_done 0)
[27434.832995] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27434.837286] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -566635632
[27434.843526] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27434.850961] iwlwifi 0000:36:00.0: 0xCD04FE13 | ADVANCED_SYSASSERT
[27434.856639] iwlwifi 0000:36:00.0: 0xF846F31B | trm_hw_status0
[27434.861134] iwlwifi 0000:36:00.0: 0xB6AD1934 | trm_hw_status1
[27434.865602] iwlwifi 0000:36:00.0: 0x3F7FBC43 | branchlink2
[27434.869845] iwlwifi 0000:36:00.0: 0x3CB4435F | interruptlink1
[27434.874345] iwlwifi 0000:36:00.0: 0x0143963D | interruptlink2
[27434.878837] iwlwifi 0000:36:00.0: 0x1FD4C46C | data1
[27434.882537] iwlwifi 0000:36:00.0: 0xD7B8810A | data2
[27434.886233] iwlwifi 0000:36:00.0: 0x23DAA79F | data3
[27434.889976] iwlwifi 0000:36:00.0: 0xA6FBCFD6 | beacon time
[27434.894190] iwlwifi 0000:36:00.0: 0x17A7F7A8 | tsf low
[27434.898043] iwlwifi 0000:36:00.0: 0x2FDE7F52 | tsf hi
[27434.901846] iwlwifi 0000:36:00.0: 0x8291BEA1 | time gp1
[27434.905836] iwlwifi 0000:36:00.0: 0x431F5276 | time gp2
[27434.909793] iwlwifi 0000:36:00.0: 0xFD26C2E0 | uCode revision type
[27434.914730] iwlwifi 0000:36:00.0: 0xCA51FD4C | uCode version major
[27434.919637] iwlwifi 0000:36:00.0: 0x4E251D55 | uCode version minor
[27434.924564] iwlwifi 0000:36:00.0: 0x5DAD77E5 | hw version
[27434.928694] iwlwifi 0000:36:00.0: 0x87F0B58D | board version
[27434.933079] iwlwifi 0000:36:00.0: 0x70D0B729 | hcmd
[27434.936683] iwlwifi 0000:36:00.0: 0x932C4124 | isr0
[27434.940292] iwlwifi 0000:36:00.0: 0x113C7BD2 | isr1
[27434.943920] iwlwifi 0000:36:00.0: 0x926561B8 | isr2
[27434.947528] iwlwifi 0000:36:00.0: 0xEA001A8D | isr3
[27434.951139] iwlwifi 0000:36:00.0: 0x1E5E0C3C | isr4
[27434.954747] iwlwifi 0000:36:00.0: 0x9DC24A5E | last cmd Id
[27434.958970] iwlwifi 0000:36:00.0: 0x80C72210 | wait_event
[27434.963142] iwlwifi 0000:36:00.0: 0x49830C39 | l2p_control
[27434.967363] iwlwifi 0000:36:00.0: 0xBE0137F0 | l2p_duration
[27434.971664] iwlwifi 0000:36:00.0: 0xDC56ABC8 | l2p_mhvalid
[27434.975894] iwlwifi 0000:36:00.0: 0x01887468 | l2p_addr_match
[27434.980383] iwlwifi 0000:36:00.0: 0x89E06933 | lmpm_pmg_sel
[27434.984681] iwlwifi 0000:36:00.0: 0xBC593E6E | timestamp
[27434.988724] iwlwifi 0000:36:00.0: 0x081BC4A6 | flow_handler
[27434.993281] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27434.997598] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -134489909
[27435.003811] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27435.011256] iwlwifi 0000:36:00.0: 0xED21913C | ADVANCED_SYSASSERT
[27435.016948] iwlwifi 0000:36:00.0: 0x0C826210 | trm_hw_status0
[27435.021423] iwlwifi 0000:36:00.0: 0x8DCD76FF | trm_hw_status1
[27435.025922] iwlwifi 0000:36:00.0: 0x6BC6B6B5 | branchlink2
[27435.030139] iwlwifi 0000:36:00.0: 0xDA7C4E37 | interruptlink1
[27435.034652] iwlwifi 0000:36:00.0: 0x7B4289B7 | interruptlink2
[27435.039109] iwlwifi 0000:36:00.0: 0x34C0B73D | data1
[27435.042819] iwlwifi 0000:36:00.0: 0x68C4B32A | data2
[27435.046523] iwlwifi 0000:36:00.0: 0x85C87A41 | data3
[27435.050218] iwlwifi 0000:36:00.0: 0x0E6D3FFE | beacon time
[27435.054434] iwlwifi 0000:36:00.0: 0xD7F2F4A6 | tsf low
[27435.058334] iwlwifi 0000:36:00.0: 0xC92BCC40 | tsf hi
[27435.062101] iwlwifi 0000:36:00.0: 0xCF6C9AB2 | time gp1
[27435.066078] iwlwifi 0000:36:00.0: 0x8F928A68 | time gp2
[27435.070061] iwlwifi 0000:36:00.0: 0xAA79F6FB | uCode revision type
[27435.074974] iwlwifi 0000:36:00.0: 0x22B1757D | uCode version major
[27435.079878] iwlwifi 0000:36:00.0: 0x5C25F16F | uCode version minor
[27435.084785] iwlwifi 0000:36:00.0: 0x13816B3D | hw version
[27435.088916] iwlwifi 0000:36:00.0: 0xDDC6D3EF | board version
[27435.093321] iwlwifi 0000:36:00.0: 0x228E7953 | hcmd
[27435.096936] iwlwifi 0000:36:00.0: 0x228E4073 | isr0
[27435.100543] iwlwifi 0000:36:00.0: 0x011050CC | isr1
[27435.104151] iwlwifi 0000:36:00.0: 0xA8EA252F | isr2
[27435.107774] iwlwifi 0000:36:00.0: 0x422C99A6 | isr3
[27435.111384] iwlwifi 0000:36:00.0: 0x2A0FE89B | isr4
[27435.114978] iwlwifi 0000:36:00.0: 0x0D0D436E | last cmd Id
[27435.119181] iwlwifi 0000:36:00.0: 0xFA23D706 | wait_event
[27435.123290] iwlwifi 0000:36:00.0: 0xDE5662B4 | l2p_control
[27435.127495] iwlwifi 0000:36:00.0: 0x302B1411 | l2p_duration
[27435.131861] iwlwifi 0000:36:00.0: 0xF1ED9999 | l2p_mhvalid
[27435.136069] iwlwifi 0000:36:00.0: 0xD911283A | l2p_addr_match
[27435.140528] iwlwifi 0000:36:00.0: 0x4B50E379 | lmpm_pmg_sel
[27435.144810] iwlwifi 0000:36:00.0: 0x06F0B25E | timestamp
[27435.148843] iwlwifi 0000:36:00.0: 0xCCA6B9C4 | flow_handler
[27435.153196] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27435.157481] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: 1536606043
[27435.163714] iwlwifi 0000:36:00.0: 0xF5BB6DC3 | ADVANCED_SYSASSERT
[27435.168523] iwlwifi 0000:36:00.0: 0xA9C4AB03 | umac branchlink1
[27435.173170] iwlwifi 0000:36:00.0: 0xFBDED068 | umac branchlink2
[27435.177807] iwlwifi 0000:36:00.0: 0xF0EFCDC6 | umac interruptlink1
[27435.182704] iwlwifi 0000:36:00.0: 0x927DFA57 | umac interruptlink2
[27435.187598] iwlwifi 0000:36:00.0: 0xDF056A40 | umac data1
[27435.191716] iwlwifi 0000:36:00.0: 0x76CFCF9D | umac data2
[27435.195848] iwlwifi 0000:36:00.0: 0xDF3F7DAE | umac data3
[27435.199956] iwlwifi 0000:36:00.0: 0x2F9E655D | umac major
[27435.204063] iwlwifi 0000:36:00.0: 0x4EC3E237 | umac minor
[27435.208175] iwlwifi 0000:36:00.0: 0xF0D6BBEE | frame pointer
[27435.212570] iwlwifi 0000:36:00.0: 0xFF8AD538 | stack pointer
[27435.216946] iwlwifi 0000:36:00.0: 0x2BD3FED4 | last host cmd
[27435.221323] iwlwifi 0000:36:00.0: 0x9466AB8F | isr status reg
[27435.225901] iwlwifi 0000:36:00.0: TCM1 status:
[27435.229061] iwlwifi 0000:36:00.0: 0x311495AC | error ID
[27435.233004] iwlwifi 0000:36:00.0: 0xD7A7F20C | tcm branchlink2
[27435.237554] iwlwifi 0000:36:00.0: 0x6811D4EF | tcm interruptlink1
[27435.242383] iwlwifi 0000:36:00.0: 0x9FB5106B | tcm interruptlink2
[27435.247200] iwlwifi 0000:36:00.0: 0x6C240BD9 | tcm data1
[27435.251238] iwlwifi 0000:36:00.0: 0xB7BFA272 | tcm data2
[27435.255279] iwlwifi 0000:36:00.0: 0xF84FA90F | tcm data3
[27435.259348] iwlwifi 0000:36:00.0: 0x85DC37F5 | tcm log PC
[27435.263495] iwlwifi 0000:36:00.0: 0xA54305E0 | tcm frame pointer
[27435.268220] iwlwifi 0000:36:00.0: 0x5B7611C9 | tcm stack pointer
[27435.272941] iwlwifi 0000:36:00.0: 0x9683E832 | tcm msg ID
[27435.277063] iwlwifi 0000:36:00.0: 0x34057B3A | tcm ISR status
[27435.281521] iwlwifi 0000:36:00.0: 0xEDADE1E4 | tcm HW status[0]
[27435.286159] iwlwifi 0000:36:00.0: 0x0455D58F | tcm HW status[1]
[27435.290794] iwlwifi 0000:36:00.0: 0x347776EF | tcm HW status[2]
[27435.295432] iwlwifi 0000:36:00.0: 0x79C3887F | tcm HW status[3]
[27435.300069] iwlwifi 0000:36:00.0: 0xD13E8FE7 | tcm HW status[4]
[27435.304708] iwlwifi 0000:36:00.0: 0x77EE9B1C | tcm SW status[0]
[27435.309491] iwlwifi 0000:36:00.0: RCM1 status:
[27435.312649] iwlwifi 0000:36:00.0: 0xFDF7D0DB | error ID
[27435.316618] iwlwifi 0000:36:00.0: 0xEB23F6E4 | rcm branchlink2
[27435.321180] iwlwifi 0000:36:00.0: 0xA7F097C1 | rcm interruptlink1
[27435.326009] iwlwifi 0000:36:00.0: 0x03F23DE7 | rcm interruptlink2
[27435.330820] iwlwifi 0000:36:00.0: 0x59887C5A | rcm data1
[27435.334846] iwlwifi 0000:36:00.0: 0x8DDCAF7A | rcm data2
[27435.338870] iwlwifi 0000:36:00.0: 0x59B81B89 | rcm data3
[27435.342900] iwlwifi 0000:36:00.0: 0x87388B8C | rcm log PC
[27435.347041] iwlwifi 0000:36:00.0: 0x1DA9B7CD | rcm frame pointer
[27435.351765] iwlwifi 0000:36:00.0: 0xC327F637 | rcm stack pointer
[27435.356501] iwlwifi 0000:36:00.0: 0xDE7EDF46 | rcm msg ID
[27435.360612] iwlwifi 0000:36:00.0: 0xB1B7E577 | rcm ISR status
[27435.365072] iwlwifi 0000:36:00.0: 0x9C6BA502 | frame HW status
[27435.369618] iwlwifi 0000:36:00.0: 0x145C4A78 | LMAC-to-RCM request mbox
[27435.374950] iwlwifi 0000:36:00.0: 0x89AFB25B | RCM-to-LMAC request mbox
[27435.380301] iwlwifi 0000:36:00.0: 0xCF58B0AF | MAC header control
[27435.385131] iwlwifi 0000:36:00.0: 0x0DE3627B | MAC header addr1 low
[27435.390115] iwlwifi 0000:36:00.0: 0x3C05F23C | MAC header info
[27435.394672] iwlwifi 0000:36:00.0: 0x93D7E939 | MAC header error
[27435.399481] iwlwifi 0000:36:00.0: TCM2 status:
[27435.402637] iwlwifi 0000:36:00.0: 0x574771EE | error ID
[27435.406592] iwlwifi 0000:36:00.0: 0xD1774DB4 | tcm branchlink2
[27435.411149] iwlwifi 0000:36:00.0: 0xDCF3632F | tcm interruptlink1
[27435.415970] iwlwifi 0000:36:00.0: 0x3FDFED69 | tcm interruptlink2
[27435.420830] iwlwifi 0000:36:00.0: 0x3FA917F0 | tcm data1
[27435.424870] iwlwifi 0000:36:00.0: 0xC06718DC | tcm data2
[27435.428927] iwlwifi 0000:36:00.0: 0x4F228CE5 | tcm data3
[27435.432975] iwlwifi 0000:36:00.0: 0xDD39B0B2 | tcm log PC
[27435.437099] iwlwifi 0000:36:00.0: 0x1C7BB08A | tcm frame pointer
[27435.441823] iwlwifi 0000:36:00.0: 0xB28DBF54 | tcm stack pointer
[27435.446536] iwlwifi 0000:36:00.0: 0xE3E52A2E | tcm msg ID
[27435.450684] iwlwifi 0000:36:00.0: 0xB9736DEF | tcm ISR status
[27435.455165] iwlwifi 0000:36:00.0: 0xBA3B07D8 | tcm HW status[0]
[27435.459808] iwlwifi 0000:36:00.0: 0xC235BB61 | tcm HW status[1]
[27435.464479] iwlwifi 0000:36:00.0: 0x983479BF | tcm HW status[2]
[27435.469118] iwlwifi 0000:36:00.0: 0x8F372EC9 | tcm HW status[3]
[27435.473775] iwlwifi 0000:36:00.0: 0x2DFE58B2 | tcm HW status[4]
[27435.478406] iwlwifi 0000:36:00.0: 0xA6DEF528 | tcm SW status[0]
[27435.483191] iwlwifi 0000:36:00.0: RCM2 status:
[27435.486365] iwlwifi 0000:36:00.0: 0xFF61FB75 | error ID
[27435.490340] iwlwifi 0000:36:00.0: 0x67076D22 | rcm branchlink2
[27435.494908] iwlwifi 0000:36:00.0: 0x6F73050F | rcm interruptlink1
[27435.499719] iwlwifi 0000:36:00.0: 0x16E30B4F | rcm interruptlink2
[27435.504555] iwlwifi 0000:36:00.0: 0xF140A896 | rcm data1
[27435.508601] iwlwifi 0000:36:00.0: 0x7FA48784 | rcm data2
[27435.512632] iwlwifi 0000:36:00.0: 0xA8AA5283 | rcm data3
[27435.516696] iwlwifi 0000:36:00.0: 0xA5749F80 | rcm log PC
[27435.520829] iwlwifi 0000:36:00.0: 0x6B201787 | rcm frame pointer
[27435.525591] iwlwifi 0000:36:00.0: 0x1BF4C147 | rcm stack pointer
[27435.530326] iwlwifi 0000:36:00.0: 0xFD31318A | rcm msg ID
[27435.534457] iwlwifi 0000:36:00.0: 0x873460C1 | rcm ISR status
[27435.538966] iwlwifi 0000:36:00.0: 0x6F77F04A | frame HW status
[27435.543527] iwlwifi 0000:36:00.0: 0xC6DF4CBE | LMAC-to-RCM request mbox
[27435.548872] iwlwifi 0000:36:00.0: 0x1BD38A2E | RCM-to-LMAC request mbox
[27435.554243] iwlwifi 0000:36:00.0: 0x2FEEFFF5 | MAC header control
[27435.559051] iwlwifi 0000:36:00.0: 0xA19ADB4B | MAC header addr1 low
[27435.564050] iwlwifi 0000:36:00.0: 0xF09CEA1D | MAC header info
[27435.568619] iwlwifi 0000:36:00.0: 0xEAFAE2DE | MAC header error
[27435.573299] iwlwifi 0000:36:00.0: IML/ROM dump:
[27435.576559] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM error/state
[27435.581547] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM data1
[27435.585961] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[27435.591234] iwlwifi 0000:36:00.0: Fseq Registers:
[27435.594675] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[27435.599243] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[27435.604316] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[27435.609590] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[27435.614244] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[27435.619591] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[27435.624229] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[27435.628535] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[27435.632841] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[27435.637672] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[27435.642501] iwlwifi 0000:36:00.0: 0x8F0F1041 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[27435.649060] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[27435.655954] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[27435.661640] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[27435.666815] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[27435.671816] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[27435.676958] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x1110bad
[27435.681360] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0x0
[27435.685343] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0x0
[27435.689293] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x2220bad
[27435.693846] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0x0
[27435.697709] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0x0
[27435.701565] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0x0
[27435.705463] iwlwifi 0000:36:00.0: Function Scratch status:
[27435.709664] iwlwifi 0000:36:00.0: 0x01010000 | Func Scratch
[27435.714057] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[27435.929438] iwlwifi 0000:36:00.0: timeout waiting for FW reset ACK (inta_hw=0x0, reset_done 0)
[27435.936969] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27435.941256] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -566635632
[27435.947490] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27435.954922] iwlwifi 0000:36:00.0: 0xCD04FE13 | ADVANCED_SYSASSERT
[27435.960595] iwlwifi 0000:36:00.0: 0xF846F31B | trm_hw_status0
[27435.965091] iwlwifi 0000:36:00.0: 0xB6AD1934 | trm_hw_status1
[27435.969575] iwlwifi 0000:36:00.0: 0x3F7FBC43 | branchlink2
[27435.973792] iwlwifi 0000:36:00.0: 0x3CB4435F | interruptlink1
[27435.978265] iwlwifi 0000:36:00.0: 0x0143963D | interruptlink2
[27435.982785] iwlwifi 0000:36:00.0: 0x1FD4C46C | data1
[27435.986527] iwlwifi 0000:36:00.0: 0xD7B8810A | data2
[27435.990205] iwlwifi 0000:36:00.0: 0x23DAA79F | data3
[27435.993899] iwlwifi 0000:36:00.0: 0xA6FBCFD6 | beacon time
[27435.998115] iwlwifi 0000:36:00.0: 0x17A7F7A8 | tsf low
[27436.002007] iwlwifi 0000:36:00.0: 0x2FDE7F52 | tsf hi
[27436.005775] iwlwifi 0000:36:00.0: 0x8291BEA1 | time gp1
[27436.009735] iwlwifi 0000:36:00.0: 0x431F5276 | time gp2
[27436.013687] iwlwifi 0000:36:00.0: 0xFD26C2E0 | uCode revision type
[27436.018603] iwlwifi 0000:36:00.0: 0xCA51FD4C | uCode version major
[27436.023516] iwlwifi 0000:36:00.0: 0x4E251D55 | uCode version minor
[27436.028429] iwlwifi 0000:36:00.0: 0x5DAD77E5 | hw version
[27436.032562] iwlwifi 0000:36:00.0: 0x87F0B58D | board version
[27436.037001] iwlwifi 0000:36:00.0: 0x70D0B729 | hcmd
[27436.040596] iwlwifi 0000:36:00.0: 0x932C4124 | isr0
[27436.044194] iwlwifi 0000:36:00.0: 0x113C7BD2 | isr1
[27436.047802] iwlwifi 0000:36:00.0: 0x926561B8 | isr2
[27436.051412] iwlwifi 0000:36:00.0: 0xEA001A8D | isr3
[27436.055013] iwlwifi 0000:36:00.0: 0x1E5E0C3C | isr4
[27436.058625] iwlwifi 0000:36:00.0: 0x9DC24A5E | last cmd Id
[27436.062864] iwlwifi 0000:36:00.0: 0x80C72210 | wait_event
[27436.066999] iwlwifi 0000:36:00.0: 0x49830C39 | l2p_control
[27436.071217] iwlwifi 0000:36:00.0: 0xBE0137F0 | l2p_duration
[27436.075512] iwlwifi 0000:36:00.0: 0xDC56ABC8 | l2p_mhvalid
[27436.079744] iwlwifi 0000:36:00.0: 0x01887468 | l2p_addr_match
[27436.084227] iwlwifi 0000:36:00.0: 0x89E06933 | lmpm_pmg_sel
[27436.088535] iwlwifi 0000:36:00.0: 0xBC593E6E | timestamp
[27436.092622] iwlwifi 0000:36:00.0: 0x081BC4A6 | flow_handler
[27436.097097] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27436.101405] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -134489909
[27436.107615] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27436.115044] iwlwifi 0000:36:00.0: 0xED21913C | ADVANCED_SYSASSERT
[27436.120834] iwlwifi 0000:36:00.0: 0x0C826210 | trm_hw_status0
[27436.125318] iwlwifi 0000:36:00.0: 0x8DCD76FF | trm_hw_status1
[27436.129779] iwlwifi 0000:36:00.0: 0x6BC6B6B5 | branchlink2
[27436.134006] iwlwifi 0000:36:00.0: 0xDA7C4E37 | interruptlink1
[27436.138482] iwlwifi 0000:36:00.0: 0x7B4289B7 | interruptlink2
[27436.142995] iwlwifi 0000:36:00.0: 0x34C0B73D | data1
[27436.146677] iwlwifi 0000:36:00.0: 0x68C4B32A | data2
[27436.150368] iwlwifi 0000:36:00.0: 0x85C87A41 | data3
[27436.154060] iwlwifi 0000:36:00.0: 0x0E6D3FFE | beacon time
[27436.158275] iwlwifi 0000:36:00.0: 0xD7F2F4A6 | tsf low
[27436.162158] iwlwifi 0000:36:00.0: 0xC92BCC40 | tsf hi
[27436.165927] iwlwifi 0000:36:00.0: 0xCF6C9AB2 | time gp1
[27436.169878] iwlwifi 0000:36:00.0: 0x8F928A68 | time gp2
[27436.173831] iwlwifi 0000:36:00.0: 0xAA79F6FB | uCode revision type
[27436.178754] iwlwifi 0000:36:00.0: 0x22B1757D | uCode version major
[27436.183668] iwlwifi 0000:36:00.0: 0x5C25F16F | uCode version minor
[27436.188575] iwlwifi 0000:36:00.0: 0x13816B3D | hw version
[27436.192705] iwlwifi 0000:36:00.0: 0xDDC6D3EF | board version
[27436.197108] iwlwifi 0000:36:00.0: 0x228E7953 | hcmd
[27436.200745] iwlwifi 0000:36:00.0: 0x228E4073 | isr0
[27436.204356] iwlwifi 0000:36:00.0: 0x011050CC | isr1
[27436.207951] iwlwifi 0000:36:00.0: 0xA8EA252F | isr2
[27436.211584] iwlwifi 0000:36:00.0: 0x422C99A6 | isr3
[27436.215181] iwlwifi 0000:36:00.0: 0x2A0FE89B | isr4
[27436.218789] iwlwifi 0000:36:00.0: 0x0D0D436E | last cmd Id
[27436.223029] iwlwifi 0000:36:00.0: 0xFA23D706 | wait_event
[27436.227224] iwlwifi 0000:36:00.0: 0xDE5662B4 | l2p_control
[27436.231452] iwlwifi 0000:36:00.0: 0x302B1411 | l2p_duration
[27436.235738] iwlwifi 0000:36:00.0: 0xF1ED9999 | l2p_mhvalid
[27436.239955] iwlwifi 0000:36:00.0: 0xD911283A | l2p_addr_match
[27436.244451] iwlwifi 0000:36:00.0: 0x4B50E379 | lmpm_pmg_sel
[27436.248742] iwlwifi 0000:36:00.0: 0x06F0B25E | timestamp
[27436.252785] iwlwifi 0000:36:00.0: 0xCCA6B9C4 | flow_handler
[27436.257187] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27436.261485] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: 1536606043
[27436.267719] iwlwifi 0000:36:00.0: 0xF5BB6DC3 | ADVANCED_SYSASSERT
[27436.272547] iwlwifi 0000:36:00.0: 0xA9C4AB03 | umac branchlink1
[27436.277203] iwlwifi 0000:36:00.0: 0xFBDED068 | umac branchlink2
[27436.281861] iwlwifi 0000:36:00.0: 0xF0EFCDC6 | umac interruptlink1
[27436.286775] iwlwifi 0000:36:00.0: 0x927DFA57 | umac interruptlink2
[27436.291696] iwlwifi 0000:36:00.0: 0xDF056A40 | umac data1
[27436.295827] iwlwifi 0000:36:00.0: 0x76CFCF9D | umac data2
[27436.299975] iwlwifi 0000:36:00.0: 0xDF3F7DAE | umac data3
[27436.304107] iwlwifi 0000:36:00.0: 0x2F9E655D | umac major
[27436.308242] iwlwifi 0000:36:00.0: 0x4EC3E237 | umac minor
[27436.312379] iwlwifi 0000:36:00.0: 0xF0D6BBEE | frame pointer
[27436.316770] iwlwifi 0000:36:00.0: 0xFF8AD538 | stack pointer
[27436.321147] iwlwifi 0000:36:00.0: 0x2BD3FED4 | last host cmd
[27436.325531] iwlwifi 0000:36:00.0: 0x9466AB8F | isr status reg
[27436.330084] iwlwifi 0000:36:00.0: TCM1 status:
[27436.333248] iwlwifi 0000:36:00.0: 0x311495AC | error ID
[27436.337196] iwlwifi 0000:36:00.0: 0xD7A7F20C | tcm branchlink2
[27436.341746] iwlwifi 0000:36:00.0: 0x6811D4EF | tcm interruptlink1
[27436.346557] iwlwifi 0000:36:00.0: 0x9FB5106B | tcm interruptlink2
[27436.351387] iwlwifi 0000:36:00.0: 0x6C240BD9 | tcm data1
[27436.355422] iwlwifi 0000:36:00.0: 0xB7BFA272 | tcm data2
[27436.359457] iwlwifi 0000:36:00.0: 0xF84FA90F | tcm data3
[27436.363490] iwlwifi 0000:36:00.0: 0x85DC37F5 | tcm log PC
[27436.367610] iwlwifi 0000:36:00.0: 0xA54305E0 | tcm frame pointer
[27436.372377] iwlwifi 0000:36:00.0: 0x5B7611C9 | tcm stack pointer
[27436.377121] iwlwifi 0000:36:00.0: 0x9683E832 | tcm msg ID
[27436.381235] iwlwifi 0000:36:00.0: 0x34057B3A | tcm ISR status
[27436.385725] iwlwifi 0000:36:00.0: 0xEDADE1E4 | tcm HW status[0]
[27436.390381] iwlwifi 0000:36:00.0: 0x0455D58F | tcm HW status[1]
[27436.395037] iwlwifi 0000:36:00.0: 0x347776EF | tcm HW status[2]
[27436.399679] iwlwifi 0000:36:00.0: 0x79C3887F | tcm HW status[3]
[27436.404374] iwlwifi 0000:36:00.0: 0xD13E8FE7 | tcm HW status[4]
[27436.409028] iwlwifi 0000:36:00.0: 0x77EE9B1C | tcm SW status[0]
[27436.413782] iwlwifi 0000:36:00.0: RCM1 status:
[27436.416951] iwlwifi 0000:36:00.0: 0xFDF7D0DB | error ID
[27436.420895] iwlwifi 0000:36:00.0: 0xEB23F6E4 | rcm branchlink2
[27436.425448] iwlwifi 0000:36:00.0: 0xA7F097C1 | rcm interruptlink1
[27436.430258] iwlwifi 0000:36:00.0: 0x03F23DE7 | rcm interruptlink2
[27436.435064] iwlwifi 0000:36:00.0: 0x59887C5A | rcm data1
[27436.439087] iwlwifi 0000:36:00.0: 0x8DDCAF7A | rcm data2
[27436.443128] iwlwifi 0000:36:00.0: 0x59B81B89 | rcm data3
[27436.447172] iwlwifi 0000:36:00.0: 0x87388B8C | rcm log PC
[27436.451284] iwlwifi 0000:36:00.0: 0x1DA9B7CD | rcm frame pointer
[27436.456006] iwlwifi 0000:36:00.0: 0xC327F637 | rcm stack pointer
[27436.460731] iwlwifi 0000:36:00.0: 0xDE7EDF46 | rcm msg ID
[27436.464851] iwlwifi 0000:36:00.0: 0xB1B7E577 | rcm ISR status
[27436.469345] iwlwifi 0000:36:00.0: 0x9C6BA502 | frame HW status
[27436.473890] iwlwifi 0000:36:00.0: 0x145C4A78 | LMAC-to-RCM request mbox
[27436.479232] iwlwifi 0000:36:00.0: 0x89AFB25B | RCM-to-LMAC request mbox
[27436.484572] iwlwifi 0000:36:00.0: 0xCF58B0AF | MAC header control
[27436.489424] iwlwifi 0000:36:00.0: 0x0DE3627B | MAC header addr1 low
[27436.494414] iwlwifi 0000:36:00.0: 0x3C05F23C | MAC header info
[27436.498974] iwlwifi 0000:36:00.0: 0x93D7E939 | MAC header error
[27436.503768] iwlwifi 0000:36:00.0: TCM2 status:
[27436.506963] iwlwifi 0000:36:00.0: 0x574771EE | error ID
[27436.510903] iwlwifi 0000:36:00.0: 0xD1774DB4 | tcm branchlink2
[27436.515491] iwlwifi 0000:36:00.0: 0xDCF3632F | tcm interruptlink1
[27436.520328] iwlwifi 0000:36:00.0: 0x3FDFED69 | tcm interruptlink2
[27436.525151] iwlwifi 0000:36:00.0: 0x3FA917F0 | tcm data1
[27436.529196] iwlwifi 0000:36:00.0: 0xC06718DC | tcm data2
[27436.533228] iwlwifi 0000:36:00.0: 0x4F228CE5 | tcm data3
[27436.537255] iwlwifi 0000:36:00.0: 0xDD39B0B2 | tcm log PC
[27436.541409] iwlwifi 0000:36:00.0: 0x1C7BB08A | tcm frame pointer
[27436.546149] iwlwifi 0000:36:00.0: 0xB28DBF54 | tcm stack pointer
[27436.550877] iwlwifi 0000:36:00.0: 0xE3E52A2E | tcm msg ID
[27436.554988] iwlwifi 0000:36:00.0: 0xB9736DEF | tcm ISR status
[27436.559446] iwlwifi 0000:36:00.0: 0xBA3B07D8 | tcm HW status[0]
[27436.564081] iwlwifi 0000:36:00.0: 0xC235BB61 | tcm HW status[1]
[27436.568738] iwlwifi 0000:36:00.0: 0x983479BF | tcm HW status[2]
[27436.573401] iwlwifi 0000:36:00.0: 0x8F372EC9 | tcm HW status[3]
[27436.578057] iwlwifi 0000:36:00.0: 0x2DFE58B2 | tcm HW status[4]
[27436.582693] iwlwifi 0000:36:00.0: 0xA6DEF528 | tcm SW status[0]
[27436.587473] iwlwifi 0000:36:00.0: RCM2 status:
[27436.590637] iwlwifi 0000:36:00.0: 0xFF61FB75 | error ID
[27436.594599] iwlwifi 0000:36:00.0: 0x67076D22 | rcm branchlink2
[27436.599166] iwlwifi 0000:36:00.0: 0x6F73050F | rcm interruptlink1
[27436.603976] iwlwifi 0000:36:00.0: 0x16E30B4F | rcm interruptlink2
[27436.608790] iwlwifi 0000:36:00.0: 0xF140A896 | rcm data1
[27436.612847] iwlwifi 0000:36:00.0: 0x7FA48784 | rcm data2
[27436.616893] iwlwifi 0000:36:00.0: 0xA8AA5283 | rcm data3
[27436.620919] iwlwifi 0000:36:00.0: 0xA5749F80 | rcm log PC
[27436.625071] iwlwifi 0000:36:00.0: 0x6B201787 | rcm frame pointer
[27436.629798] iwlwifi 0000:36:00.0: 0x1BF4C147 | rcm stack pointer
[27436.634527] iwlwifi 0000:36:00.0: 0xFD31318A | rcm msg ID
[27436.638644] iwlwifi 0000:36:00.0: 0x873460C1 | rcm ISR status
[27436.643105] iwlwifi 0000:36:00.0: 0x6F77F04A | frame HW status
[27436.647654] iwlwifi 0000:36:00.0: 0xC6DF4CBE | LMAC-to-RCM request mbox
[27436.652988] iwlwifi 0000:36:00.0: 0x1BD38A2E | RCM-to-LMAC request mbox
[27436.658317] iwlwifi 0000:36:00.0: 0x2FEEFFF5 | MAC header control
[27436.663142] iwlwifi 0000:36:00.0: 0xA19ADB4B | MAC header addr1 low
[27436.668115] iwlwifi 0000:36:00.0: 0xF09CEA1D | MAC header info
[27436.672675] iwlwifi 0000:36:00.0: 0xEAFAE2DE | MAC header error
[27436.677366] iwlwifi 0000:36:00.0: IML/ROM dump:
[27436.680622] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM error/state
[27436.685532] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM data1
[27436.689924] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[27436.695176] iwlwifi 0000:36:00.0: Fseq Registers:
[27436.698619] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[27436.703190] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[27436.708268] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[27436.713515] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[27436.718161] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[27436.723499] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[27436.728143] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[27436.732442] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[27436.736741] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[27436.741560] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[27436.746392] iwlwifi 0000:36:00.0: 0x8F0F1041 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[27436.752946] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[27436.759846] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[27436.765526] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[27436.770702] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[27436.775702] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[27436.780831] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x1110bad
[27436.785214] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0x0
[27436.789184] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0x0
[27436.793135] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x2220bad
[27436.797714] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0x0
[27436.801577] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0x0
[27436.805442] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0x0
[27436.809332] iwlwifi 0000:36:00.0: Function Scratch status:
[27436.813552] iwlwifi 0000:36:00.0: 0x01010000 | Func Scratch
[27436.817846] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[27437.033460] iwlwifi 0000:36:00.0: timeout waiting for FW reset ACK (inta_hw=0x0, reset_done 0)
[27437.040979] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27437.045262] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -566635632
[27437.051479] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27437.058917] iwlwifi 0000:36:00.0: 0xCD04FE13 | ADVANCED_SYSASSERT
[27437.064612] iwlwifi 0000:36:00.0: 0xF846F31B | trm_hw_status0
[27437.069072] iwlwifi 0000:36:00.0: 0xB6AD1934 | trm_hw_status1
[27437.073575] iwlwifi 0000:36:00.0: 0x3F7FBC43 | branchlink2
[27437.077794] iwlwifi 0000:36:00.0: 0x3CB4435F | interruptlink1
[27437.082274] iwlwifi 0000:36:00.0: 0x0143963D | interruptlink2
[27437.086754] iwlwifi 0000:36:00.0: 0x1FD4C46C | data1
[27437.090469] iwlwifi 0000:36:00.0: 0xD7B8810A | data2
[27437.094181] iwlwifi 0000:36:00.0: 0x23DAA79F | data3
[27437.097884] iwlwifi 0000:36:00.0: 0xA6FBCFD6 | beacon time
[27437.102103] iwlwifi 0000:36:00.0: 0x17A7F7A8 | tsf low
[27437.105982] iwlwifi 0000:36:00.0: 0x2FDE7F52 | tsf hi
[27437.109770] iwlwifi 0000:36:00.0: 0x8291BEA1 | time gp1
[27437.113738] iwlwifi 0000:36:00.0: 0x431F5276 | time gp2
[27437.117706] iwlwifi 0000:36:00.0: 0xFD26C2E0 | uCode revision type
[27437.122628] iwlwifi 0000:36:00.0: 0xCA51FD4C | uCode version major
[27437.127541] iwlwifi 0000:36:00.0: 0x4E251D55 | uCode version minor
[27437.132501] iwlwifi 0000:36:00.0: 0x5DAD77E5 | hw version
[27437.136634] iwlwifi 0000:36:00.0: 0x87F0B58D | board version
[27437.141028] iwlwifi 0000:36:00.0: 0x70D0B729 | hcmd
[27437.144641] iwlwifi 0000:36:00.0: 0x932C4124 | isr0
[27437.148232] iwlwifi 0000:36:00.0: 0x113C7BD2 | isr1
[27437.151841] iwlwifi 0000:36:00.0: 0x926561B8 | isr2
[27437.155485] iwlwifi 0000:36:00.0: 0xEA001A8D | isr3
[27437.159082] iwlwifi 0000:36:00.0: 0x1E5E0C3C | isr4
[27437.162712] iwlwifi 0000:36:00.0: 0x9DC24A5E | last cmd Id
[27437.166934] iwlwifi 0000:36:00.0: 0x80C72210 | wait_event
[27437.171066] iwlwifi 0000:36:00.0: 0x49830C39 | l2p_control
[27437.175283] iwlwifi 0000:36:00.0: 0xBE0137F0 | l2p_duration
[27437.179596] iwlwifi 0000:36:00.0: 0xDC56ABC8 | l2p_mhvalid
[27437.183815] iwlwifi 0000:36:00.0: 0x01887468 | l2p_addr_match
[27437.188297] iwlwifi 0000:36:00.0: 0x89E06933 | lmpm_pmg_sel
[27437.192602] iwlwifi 0000:36:00.0: 0xBC593E6E | timestamp
[27437.196662] iwlwifi 0000:36:00.0: 0x081BC4A6 | flow_handler
[27437.201131] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27437.205438] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -134489909
[27437.211654] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27437.219089] iwlwifi 0000:36:00.0: 0xED21913C | ADVANCED_SYSASSERT
[27437.224783] iwlwifi 0000:36:00.0: 0x0C826210 | trm_hw_status0
[27437.229259] iwlwifi 0000:36:00.0: 0x8DCD76FF | trm_hw_status1
[27437.233726] iwlwifi 0000:36:00.0: 0x6BC6B6B5 | branchlink2
[27437.237963] iwlwifi 0000:36:00.0: 0xDA7C4E37 | interruptlink1
[27437.242448] iwlwifi 0000:36:00.0: 0x7B4289B7 | interruptlink2
[27437.246928] iwlwifi 0000:36:00.0: 0x34C0B73D | data1
[27437.250618] iwlwifi 0000:36:00.0: 0x68C4B32A | data2
[27437.254337] iwlwifi 0000:36:00.0: 0x85C87A41 | data3
[27437.258014] iwlwifi 0000:36:00.0: 0x0E6D3FFE | beacon time
[27437.262279] iwlwifi 0000:36:00.0: 0xD7F2F4A6 | tsf low
[27437.266161] iwlwifi 0000:36:00.0: 0xC92BCC40 | tsf hi
[27437.269940] iwlwifi 0000:36:00.0: 0xCF6C9AB2 | time gp1
[27437.273911] iwlwifi 0000:36:00.0: 0x8F928A68 | time gp2
[27437.277875] iwlwifi 0000:36:00.0: 0xAA79F6FB | uCode revision type
[27437.282830] iwlwifi 0000:36:00.0: 0x22B1757D | uCode version major
[27437.287764] iwlwifi 0000:36:00.0: 0x5C25F16F | uCode version minor
[27437.292659] iwlwifi 0000:36:00.0: 0x13816B3D | hw version
[27437.296810] iwlwifi 0000:36:00.0: 0xDDC6D3EF | board version
[27437.301223] iwlwifi 0000:36:00.0: 0x228E7953 | hcmd
[27437.304822] iwlwifi 0000:36:00.0: 0x228E4073 | isr0
[27437.308448] iwlwifi 0000:36:00.0: 0x011050CC | isr1
[27437.312047] iwlwifi 0000:36:00.0: 0xA8EA252F | isr2
[27437.315662] iwlwifi 0000:36:00.0: 0x422C99A6 | isr3
[27437.319255] iwlwifi 0000:36:00.0: 0x2A0FE89B | isr4
[27437.322885] iwlwifi 0000:36:00.0: 0x0D0D436E | last cmd Id
[27437.327097] iwlwifi 0000:36:00.0: 0xFA23D706 | wait_event
[27437.331244] iwlwifi 0000:36:00.0: 0xDE5662B4 | l2p_control
[27437.335464] iwlwifi 0000:36:00.0: 0x302B1411 | l2p_duration
[27437.339770] iwlwifi 0000:36:00.0: 0xF1ED9999 | l2p_mhvalid
[27437.343994] iwlwifi 0000:36:00.0: 0xD911283A | l2p_addr_match
[27437.348477] iwlwifi 0000:36:00.0: 0x4B50E379 | lmpm_pmg_sel
[27437.352799] iwlwifi 0000:36:00.0: 0x06F0B25E | timestamp
[27437.356847] iwlwifi 0000:36:00.0: 0xCCA6B9C4 | flow_handler
[27437.361221] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27437.365527] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: 1536606043
[27437.371752] iwlwifi 0000:36:00.0: 0xF5BB6DC3 | ADVANCED_SYSASSERT
[27437.376580] iwlwifi 0000:36:00.0: 0xA9C4AB03 | umac branchlink1
[27437.381214] iwlwifi 0000:36:00.0: 0xFBDED068 | umac branchlink2
[27437.385884] iwlwifi 0000:36:00.0: 0xF0EFCDC6 | umac interruptlink1
[27437.390792] iwlwifi 0000:36:00.0: 0x927DFA57 | umac interruptlink2
[27437.395694] iwlwifi 0000:36:00.0: 0xDF056A40 | umac data1
[27437.399805] iwlwifi 0000:36:00.0: 0x76CFCF9D | umac data2
[27437.403953] iwlwifi 0000:36:00.0: 0xDF3F7DAE | umac data3
[27437.408069] iwlwifi 0000:36:00.0: 0x2F9E655D | umac major
[27437.412297] iwlwifi 0000:36:00.0: 0x4EC3E237 | umac minor
[27437.416439] iwlwifi 0000:36:00.0: 0xF0D6BBEE | frame pointer
[27437.420837] iwlwifi 0000:36:00.0: 0xFF8AD538 | stack pointer
[27437.425208] iwlwifi 0000:36:00.0: 0x2BD3FED4 | last host cmd
[27437.429591] iwlwifi 0000:36:00.0: 0x9466AB8F | isr status reg
[27437.434219] iwlwifi 0000:36:00.0: TCM1 status:
[27437.437390] iwlwifi 0000:36:00.0: 0x311495AC | error ID
[27437.441365] iwlwifi 0000:36:00.0: 0xD7A7F20C | tcm branchlink2
[27437.445932] iwlwifi 0000:36:00.0: 0x6811D4EF | tcm interruptlink1
[27437.450761] iwlwifi 0000:36:00.0: 0x9FB5106B | tcm interruptlink2
[27437.455588] iwlwifi 0000:36:00.0: 0x6C240BD9 | tcm data1
[27437.459633] iwlwifi 0000:36:00.0: 0xB7BFA272 | tcm data2
[27437.463672] iwlwifi 0000:36:00.0: 0xF84FA90F | tcm data3
[27437.467710] iwlwifi 0000:36:00.0: 0x85DC37F5 | tcm log PC
[27437.471839] iwlwifi 0000:36:00.0: 0xA54305E0 | tcm frame pointer
[27437.476579] iwlwifi 0000:36:00.0: 0x5B7611C9 | tcm stack pointer
[27437.481338] iwlwifi 0000:36:00.0: 0x9683E832 | tcm msg ID
[27437.485453] iwlwifi 0000:36:00.0: 0x34057B3A | tcm ISR status
[27437.489951] iwlwifi 0000:36:00.0: 0xEDADE1E4 | tcm HW status[0]
[27437.494605] iwlwifi 0000:36:00.0: 0x0455D58F | tcm HW status[1]
[27437.499257] iwlwifi 0000:36:00.0: 0x347776EF | tcm HW status[2]
[27437.503904] iwlwifi 0000:36:00.0: 0x79C3887F | tcm HW status[3]
[27437.508591] iwlwifi 0000:36:00.0: 0xD13E8FE7 | tcm HW status[4]
[27437.513229] iwlwifi 0000:36:00.0: 0x77EE9B1C | tcm SW status[0]
[27437.518020] iwlwifi 0000:36:00.0: RCM1 status:
[27437.521173] iwlwifi 0000:36:00.0: 0xFDF7D0DB | error ID
[27437.525128] iwlwifi 0000:36:00.0: 0xEB23F6E4 | rcm branchlink2
[27437.529687] iwlwifi 0000:36:00.0: 0xA7F097C1 | rcm interruptlink1
[27437.534509] iwlwifi 0000:36:00.0: 0x03F23DE7 | rcm interruptlink2
[27437.539353] iwlwifi 0000:36:00.0: 0x59887C5A | rcm data1
[27437.543378] iwlwifi 0000:36:00.0: 0x8DDCAF7A | rcm data2
[27437.547418] iwlwifi 0000:36:00.0: 0x59B81B89 | rcm data3
[27437.551460] iwlwifi 0000:36:00.0: 0x87388B8C | rcm log PC
[27437.555611] iwlwifi 0000:36:00.0: 0x1DA9B7CD | rcm frame pointer
[27437.560350] iwlwifi 0000:36:00.0: 0xC327F637 | rcm stack pointer
[27437.565102] iwlwifi 0000:36:00.0: 0xDE7EDF46 | rcm msg ID
[27437.569215] iwlwifi 0000:36:00.0: 0xB1B7E577 | rcm ISR status
[27437.573688] iwlwifi 0000:36:00.0: 0x9C6BA502 | frame HW status
[27437.578270] iwlwifi 0000:36:00.0: 0x145C4A78 | LMAC-to-RCM request mbox
[27437.583609] iwlwifi 0000:36:00.0: 0x89AFB25B | RCM-to-LMAC request mbox
[27437.588950] iwlwifi 0000:36:00.0: 0xCF58B0AF | MAC header control
[27437.593786] iwlwifi 0000:36:00.0: 0x0DE3627B | MAC header addr1 low
[27437.598768] iwlwifi 0000:36:00.0: 0x3C05F23C | MAC header info
[27437.603362] iwlwifi 0000:36:00.0: 0x93D7E939 | MAC header error
[27437.608136] iwlwifi 0000:36:00.0: TCM2 status:
[27437.611325] iwlwifi 0000:36:00.0: 0x574771EE | error ID
[27437.615280] iwlwifi 0000:36:00.0: 0xD1774DB4 | tcm branchlink2
[27437.619854] iwlwifi 0000:36:00.0: 0xDCF3632F | tcm interruptlink1
[27437.624657] iwlwifi 0000:36:00.0: 0x3FDFED69 | tcm interruptlink2
[27437.629481] iwlwifi 0000:36:00.0: 0x3FA917F0 | tcm data1
[27437.633524] iwlwifi 0000:36:00.0: 0xC06718DC | tcm data2
[27437.637551] iwlwifi 0000:36:00.0: 0x4F228CE5 | tcm data3
[27437.641596] iwlwifi 0000:36:00.0: 0xDD39B0B2 | tcm log PC
[27437.645747] iwlwifi 0000:36:00.0: 0x1C7BB08A | tcm frame pointer
[27437.650485] iwlwifi 0000:36:00.0: 0xB28DBF54 | tcm stack pointer
[27437.655209] iwlwifi 0000:36:00.0: 0xE3E52A2E | tcm msg ID
[27437.659364] iwlwifi 0000:36:00.0: 0xB9736DEF | tcm ISR status
[27437.663826] iwlwifi 0000:36:00.0: 0xBA3B07D8 | tcm HW status[0]
[27437.668460] iwlwifi 0000:36:00.0: 0xC235BB61 | tcm HW status[1]
[27437.673105] iwlwifi 0000:36:00.0: 0x983479BF | tcm HW status[2]
[27437.677754] iwlwifi 0000:36:00.0: 0x8F372EC9 | tcm HW status[3]
[27437.682429] iwlwifi 0000:36:00.0: 0x2DFE58B2 | tcm HW status[4]
[27437.687070] iwlwifi 0000:36:00.0: 0xA6DEF528 | tcm SW status[0]
[27437.691859] iwlwifi 0000:36:00.0: RCM2 status:
[27437.695022] iwlwifi 0000:36:00.0: 0xFF61FB75 | error ID
[27437.698976] iwlwifi 0000:36:00.0: 0x67076D22 | rcm branchlink2
[27437.703533] iwlwifi 0000:36:00.0: 0x6F73050F | rcm interruptlink1
[27437.708379] iwlwifi 0000:36:00.0: 0x16E30B4F | rcm interruptlink2
[27437.713199] iwlwifi 0000:36:00.0: 0xF140A896 | rcm data1
[27437.717289] iwlwifi 0000:36:00.0: 0x7FA48784 | rcm data2
[27437.721320] iwlwifi 0000:36:00.0: 0xA8AA5283 | rcm data3
[27437.725388] iwlwifi 0000:36:00.0: 0xA5749F80 | rcm log PC
[27437.729519] iwlwifi 0000:36:00.0: 0x6B201787 | rcm frame pointer
[27437.734257] iwlwifi 0000:36:00.0: 0x1BF4C147 | rcm stack pointer
[27437.738990] iwlwifi 0000:36:00.0: 0xFD31318A | rcm msg ID
[27437.743118] iwlwifi 0000:36:00.0: 0x873460C1 | rcm ISR status
[27437.747597] iwlwifi 0000:36:00.0: 0x6F77F04A | frame HW status
[27437.752169] iwlwifi 0000:36:00.0: 0xC6DF4CBE | LMAC-to-RCM request mbox
[27437.757511] iwlwifi 0000:36:00.0: 0x1BD38A2E | RCM-to-LMAC request mbox
[27437.762841] iwlwifi 0000:36:00.0: 0x2FEEFFF5 | MAC header control
[27437.767662] iwlwifi 0000:36:00.0: 0xA19ADB4B | MAC header addr1 low
[27437.772666] iwlwifi 0000:36:00.0: 0xF09CEA1D | MAC header info
[27437.777229] iwlwifi 0000:36:00.0: 0xEAFAE2DE | MAC header error
[27437.781909] iwlwifi 0000:36:00.0: IML/ROM dump:
[27437.785155] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM error/state
[27437.790115] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM data1
[27437.794529] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[27437.799800] iwlwifi 0000:36:00.0: Fseq Registers:
[27437.803238] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[27437.807809] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[27437.812895] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[27437.818156] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[27437.822812] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[27437.828160] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[27437.832813] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[27437.837118] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[27437.841412] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[27437.846257] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[27437.851086] iwlwifi 0000:36:00.0: 0x8F0F1041 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[27437.857657] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[27437.864569] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[27437.870264] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[27437.875435] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[27437.880437] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[27437.885596] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x1110bad
[27437.889989] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0x0
[27437.893948] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0x0
[27437.897908] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x2220bad
[27437.902480] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0x0
[27437.906402] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0x0
[27437.910263] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0x0
[27437.914126] iwlwifi 0000:36:00.0: Function Scratch status:
[27437.918348] iwlwifi 0000:36:00.0: 0x01010000 | Func Scratch
[27437.922633] iwlwifi 0000:36:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[27438.137484] iwlwifi 0000:36:00.0: timeout waiting for FW reset ACK (inta_hw=0x0, reset_done 0)
[27438.144999] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27438.149304] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -566635632
[27438.155500] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27438.163009] iwlwifi 0000:36:00.0: 0xCD04FE13 | ADVANCED_SYSASSERT
[27438.168703] iwlwifi 0000:36:00.0: 0xF846F31B | trm_hw_status0
[27438.173179] iwlwifi 0000:36:00.0: 0xB6AD1934 | trm_hw_status1
[27438.177664] iwlwifi 0000:36:00.0: 0x3F7FBC43 | branchlink2
[27438.181883] iwlwifi 0000:36:00.0: 0x3CB4435F | interruptlink1
[27438.186372] iwlwifi 0000:36:00.0: 0x0143963D | interruptlink2
[27438.190845] iwlwifi 0000:36:00.0: 0x1FD4C46C | data1
[27438.194536] iwlwifi 0000:36:00.0: 0xD7B8810A | data2
[27438.198226] iwlwifi 0000:36:00.0: 0x23DAA79F | data3
[27438.201953] iwlwifi 0000:36:00.0: 0xA6FBCFD6 | beacon time
[27438.206167] iwlwifi 0000:36:00.0: 0x17A7F7A8 | tsf low
[27438.210025] iwlwifi 0000:36:00.0: 0x2FDE7F52 | tsf hi
[27438.213811] iwlwifi 0000:36:00.0: 0x8291BEA1 | time gp1
[27438.217765] iwlwifi 0000:36:00.0: 0x431F5276 | time gp2
[27438.221725] iwlwifi 0000:36:00.0: 0xFD26C2E0 | uCode revision type
[27438.226653] iwlwifi 0000:36:00.0: 0xCA51FD4C | uCode version major
[27438.231545] iwlwifi 0000:36:00.0: 0x4E251D55 | uCode version minor
[27438.236460] iwlwifi 0000:36:00.0: 0x5DAD77E5 | hw version
[27438.240595] iwlwifi 0000:36:00.0: 0x87F0B58D | board version
[27438.244987] iwlwifi 0000:36:00.0: 0x70D0B729 | hcmd
[27438.248598] iwlwifi 0000:36:00.0: 0x932C4124 | isr0
[27438.252204] iwlwifi 0000:36:00.0: 0x113C7BD2 | isr1
[27438.255810] iwlwifi 0000:36:00.0: 0x926561B8 | isr2
[27438.259432] iwlwifi 0000:36:00.0: 0xEA001A8D | isr3
[27438.263036] iwlwifi 0000:36:00.0: 0x1E5E0C3C | isr4
[27438.266646] iwlwifi 0000:36:00.0: 0x9DC24A5E | last cmd Id
[27438.270865] iwlwifi 0000:36:00.0: 0x80C72210 | wait_event
[27438.275019] iwlwifi 0000:36:00.0: 0x49830C39 | l2p_control
[27438.279218] iwlwifi 0000:36:00.0: 0xBE0137F0 | l2p_duration
[27438.283518] iwlwifi 0000:36:00.0: 0xDC56ABC8 | l2p_mhvalid
[27438.287734] iwlwifi 0000:36:00.0: 0x01887468 | l2p_addr_match
[27438.292213] iwlwifi 0000:36:00.0: 0x89E06933 | lmpm_pmg_sel
[27438.296517] iwlwifi 0000:36:00.0: 0xBC593E6E | timestamp
[27438.300558] iwlwifi 0000:36:00.0: 0x081BC4A6 | flow_handler
[27438.305049] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27438.309372] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: -134489909
[27438.315589] iwlwifi 0000:36:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
[27438.323015] iwlwifi 0000:36:00.0: 0xED21913C | ADVANCED_SYSASSERT
[27438.328691] iwlwifi 0000:36:00.0: 0x0C826210 | trm_hw_status0
[27438.333156] iwlwifi 0000:36:00.0: 0x8DCD76FF | trm_hw_status1
[27438.337622] iwlwifi 0000:36:00.0: 0x6BC6B6B5 | branchlink2
[27438.341822] iwlwifi 0000:36:00.0: 0xDA7C4E37 | interruptlink1
[27438.346283] iwlwifi 0000:36:00.0: 0x7B4289B7 | interruptlink2
[27438.350756] iwlwifi 0000:36:00.0: 0x34C0B73D | data1
[27438.354441] iwlwifi 0000:36:00.0: 0x68C4B32A | data2
[27438.358137] iwlwifi 0000:36:00.0: 0x85C87A41 | data3
[27438.361812] iwlwifi 0000:36:00.0: 0x0E6D3FFE | beacon time
[27438.366009] iwlwifi 0000:36:00.0: 0xD7F2F4A6 | tsf low
[27438.369870] iwlwifi 0000:36:00.0: 0xC92BCC40 | tsf hi
[27438.373651] iwlwifi 0000:36:00.0: 0xCF6C9AB2 | time gp1
[27438.377603] iwlwifi 0000:36:00.0: 0x8F928A68 | time gp2
[27438.381554] iwlwifi 0000:36:00.0: 0xAA79F6FB | uCode revision type
[27438.386470] iwlwifi 0000:36:00.0: 0x22B1757D | uCode version major
[27438.391385] iwlwifi 0000:36:00.0: 0x5C25F16F | uCode version minor
[27438.396299] iwlwifi 0000:36:00.0: 0x13816B3D | hw version
[27438.400425] iwlwifi 0000:36:00.0: 0xDDC6D3EF | board version
[27438.404808] iwlwifi 0000:36:00.0: 0x228E7953 | hcmd
[27438.408398] iwlwifi 0000:36:00.0: 0x228E4073 | isr0
[27438.411992] iwlwifi 0000:36:00.0: 0x011050CC | isr1
[27438.415604] iwlwifi 0000:36:00.0: 0xA8EA252F | isr2
[27438.419254] iwlwifi 0000:36:00.0: 0x422C99A6 | isr3
[27438.422847] iwlwifi 0000:36:00.0: 0x2A0FE89B | isr4
[27438.426452] iwlwifi 0000:36:00.0: 0x0D0D436E | last cmd Id
[27438.430656] iwlwifi 0000:36:00.0: 0xFA23D706 | wait_event
[27438.434774] iwlwifi 0000:36:00.0: 0xDE5662B4 | l2p_control
[27438.439046] iwlwifi 0000:36:00.0: 0x302B1411 | l2p_duration
[27438.443382] iwlwifi 0000:36:00.0: 0xF1ED9999 | l2p_mhvalid
[27438.447586] iwlwifi 0000:36:00.0: 0xD911283A | l2p_addr_match
[27438.452044] iwlwifi 0000:36:00.0: 0x4B50E379 | lmpm_pmg_sel
[27438.456343] iwlwifi 0000:36:00.0: 0x06F0B25E | timestamp
[27438.460389] iwlwifi 0000:36:00.0: 0xCCA6B9C4 | flow_handler
[27438.464790] iwlwifi 0000:36:00.0: Start IWL Error Log Dump:
[27438.469100] iwlwifi 0000:36:00.0: Transport status: 0x0000054A, valid: 1536606043
[27438.475300] iwlwifi 0000:36:00.0: 0xF5BB6DC3 | ADVANCED_SYSASSERT
[27438.480144] iwlwifi 0000:36:00.0: 0xA9C4AB03 | umac branchlink1
[27438.484797] iwlwifi 0000:36:00.0: 0xFBDED068 | umac branchlink2
[27438.489442] iwlwifi 0000:36:00.0: 0xF0EFCDC6 | umac interruptlink1
[27438.494372] iwlwifi 0000:36:00.0: 0x927DFA57 | umac interruptlink2
[27438.499279] iwlwifi 0000:36:00.0: 0xDF056A40 | umac data1
[27438.503404] iwlwifi 0000:36:00.0: 0x76CFCF9D | umac data2
[27438.507529] iwlwifi 0000:36:00.0: 0xDF3F7DAE | umac data3
[27438.511657] iwlwifi 0000:36:00.0: 0x2F9E655D | umac major
[27438.515791] iwlwifi 0000:36:00.0: 0x4EC3E237 | umac minor
[27438.519914] iwlwifi 0000:36:00.0: 0xF0D6BBEE | frame pointer
[27438.524392] iwlwifi 0000:36:00.0: 0xFF8AD538 | stack pointer
[27438.528782] iwlwifi 0000:36:00.0: 0x2BD3FED4 | last host cmd
[27438.533177] iwlwifi 0000:36:00.0: 0x9466AB8F | isr status reg
[27438.537758] iwlwifi 0000:36:00.0: TCM1 status:
[27438.540918] iwlwifi 0000:36:00.0: 0x311495AC | error ID
[27438.544875] iwlwifi 0000:36:00.0: 0xD7A7F20C | tcm branchlink2
[27438.549451] iwlwifi 0000:36:00.0: 0x6811D4EF | tcm interruptlink1
[27438.554300] iwlwifi 0000:36:00.0: 0x9FB5106B | tcm interruptlink2
[27438.559124] iwlwifi 0000:36:00.0: 0x6C240BD9 | tcm data1
[27438.563179] iwlwifi 0000:36:00.0: 0xB7BFA272 | tcm data2
[27438.567233] iwlwifi 0000:36:00.0: 0xF84FA90F | tcm data3
[27438.571275] iwlwifi 0000:36:00.0: 0x85DC37F5 | tcm log PC
[27438.575401] iwlwifi 0000:36:00.0: 0xA54305E0 | tcm frame pointer
[27438.580151] iwlwifi 0000:36:00.0: 0x5B7611C9 | tcm stack pointer
[27438.584888] iwlwifi 0000:36:00.0: 0x9683E832 | tcm msg ID
[27438.589015] iwlwifi 0000:36:00.0: 0x34057B3A | tcm ISR status
[27438.593488] iwlwifi 0000:36:00.0: 0xEDADE1E4 | tcm HW status[0]
[27438.598140] iwlwifi 0000:36:00.0: 0x0455D58F | tcm HW status[1]
[27438.602777] iwlwifi 0000:36:00.0: 0x347776EF | tcm HW status[2]
[27438.607422] iwlwifi 0000:36:00.0: 0x79C3887F | tcm HW status[3]
[27438.612067] iwlwifi 0000:36:00.0: 0xD13E8FE7 | tcm HW status[4]
[27438.616717] iwlwifi 0000:36:00.0: 0x77EE9B1C | tcm SW status[0]
[27438.621492] iwlwifi 0000:36:00.0: RCM1 status:
[27438.624652] iwlwifi 0000:36:00.0: 0xFDF7D0DB | error ID
[27438.628649] iwlwifi 0000:36:00.0: 0xEB23F6E4 | rcm branchlink2
[27438.633200] iwlwifi 0000:36:00.0: 0xA7F097C1 | rcm interruptlink1
[27438.638027] iwlwifi 0000:36:00.0: 0x03F23DE7 | rcm interruptlink2
[27438.642861] iwlwifi 0000:36:00.0: 0x59887C5A | rcm data1
[27438.646900] iwlwifi 0000:36:00.0: 0x8DDCAF7A | rcm data2
[27438.650937] iwlwifi 0000:36:00.0: 0x59B81B89 | rcm data3
[27438.654980] iwlwifi 0000:36:00.0: 0x87388B8C | rcm log PC
[27438.659115] iwlwifi 0000:36:00.0: 0x1DA9B7CD | rcm frame pointer
[27438.663871] iwlwifi 0000:36:00.0: 0xC327F637 | rcm stack pointer
[27438.668603] iwlwifi 0000:36:00.0: 0xDE7EDF46 | rcm msg ID
[27438.672730] iwlwifi 0000:36:00.0: 0xB1B7E577 | rcm ISR status
[27438.677209] iwlwifi 0000:36:00.0: 0x9C6BA502 | frame HW status
[27438.681789] iwlwifi 0000:36:00.0: 0x145C4A78 | LMAC-to-RCM request mbox
[27438.687134] iwlwifi 0000:36:00.0: 0x89AFB25B | RCM-to-LMAC request mbox
[27438.692479] iwlwifi 0000:36:00.0: 0xCF58B0AF | MAC header control
[27438.697300] iwlwifi 0000:36:00.0: 0x0DE3627B | MAC header addr1 low
[27438.702283] iwlwifi 0000:36:00.0: 0x3C05F23C | MAC header info
[27438.706834] iwlwifi 0000:36:00.0: 0x93D7E939 | MAC header error
[27438.711559] iwlwifi 0000:36:00.0: TCM2 status:
[27438.714717] iwlwifi 0000:36:00.0: 0x574771EE | error ID
[27438.718657] iwlwifi 0000:36:00.0: 0xD1774DB4 | tcm branchlink2
[27438.723202] iwlwifi 0000:36:00.0: 0xDCF3632F | tcm interruptlink1
[27438.728006] iwlwifi 0000:36:00.0: 0x3FDFED69 | tcm interruptlink2
[27438.732843] iwlwifi 0000:36:00.0: 0x3FA917F0 | tcm data1
[27438.736874] iwlwifi 0000:36:00.0: 0xC06718DC | tcm data2
[27438.740901] iwlwifi 0000:36:00.0: 0x4F228CE5 | tcm data3
[27438.744930] iwlwifi 0000:36:00.0: 0xDD39B0B2 | tcm log PC
[27438.749039] iwlwifi 0000:36:00.0: 0x1C7BB08A | tcm frame pointer
[27438.753761] iwlwifi 0000:36:00.0: 0xB28DBF54 | tcm stack pointer
[27438.758479] iwlwifi 0000:36:00.0: 0xE3E52A2E | tcm msg ID
[27438.762594] iwlwifi 0000:36:00.0: 0xB9736DEF | tcm ISR status
[27438.767060] iwlwifi 0000:36:00.0: 0xBA3B07D8 | tcm HW status[0]
[27438.771694] iwlwifi 0000:36:00.0: 0xC235BB61 | tcm HW status[1]
[27438.776351] iwlwifi 0000:36:00.0: 0x983479BF | tcm HW status[2]
[27438.780987] iwlwifi 0000:36:00.0: 0x8F372EC9 | tcm HW status[3]
[27438.785627] iwlwifi 0000:36:00.0: 0x2DFE58B2 | tcm HW status[4]
[27438.790277] iwlwifi 0000:36:00.0: 0xA6DEF528 | tcm SW status[0]
[27438.795006] iwlwifi 0000:36:00.0: RCM2 status:
[27438.798163] iwlwifi 0000:36:00.0: 0xFF61FB75 | error ID
[27438.802099] iwlwifi 0000:36:00.0: 0x67076D22 | rcm branchlink2
[27438.806647] iwlwifi 0000:36:00.0: 0x6F73050F | rcm interruptlink1
[27438.811458] iwlwifi 0000:36:00.0: 0x16E30B4F | rcm interruptlink2
[27438.816271] iwlwifi 0000:36:00.0: 0xF140A896 | rcm data1
[27438.820300] iwlwifi 0000:36:00.0: 0x7FA48784 | rcm data2
[27438.824348] iwlwifi 0000:36:00.0: 0xA8AA5283 | rcm data3
[27438.828387] iwlwifi 0000:36:00.0: 0xA5749F80 | rcm log PC
[27438.832501] iwlwifi 0000:36:00.0: 0x6B201787 | rcm frame pointer
[27438.837270] iwlwifi 0000:36:00.0: 0x1BF4C147 | rcm stack pointer
[27438.841992] iwlwifi 0000:36:00.0: 0xFD31318A | rcm msg ID
[27438.846133] iwlwifi 0000:36:00.0: 0x873460C1 | rcm ISR status
[27438.850612] iwlwifi 0000:36:00.0: 0x6F77F04A | frame HW status
[27438.855165] iwlwifi 0000:36:00.0: 0xC6DF4CBE | LMAC-to-RCM request mbox
[27438.860495] iwlwifi 0000:36:00.0: 0x1BD38A2E | RCM-to-LMAC request mbox
[27438.865829] iwlwifi 0000:36:00.0: 0x2FEEFFF5 | MAC header control
[27438.870637] iwlwifi 0000:36:00.0: 0xA19ADB4B | MAC header addr1 low
[27438.875637] iwlwifi 0000:36:00.0: 0xF09CEA1D | MAC header info
[27438.880196] iwlwifi 0000:36:00.0: 0xEAFAE2DE | MAC header error
[27438.884894] iwlwifi 0000:36:00.0: IML/ROM dump:
[27438.888141] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM error/state
[27438.893085] iwlwifi 0000:36:00.0: 0x00000000 | IML/ROM data1
[27438.897502] iwlwifi 0000:36:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[27438.902779] iwlwifi 0000:36:00.0: Fseq Registers:
[27438.906226] iwlwifi 0000:36:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[27438.910795] iwlwifi 0000:36:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
[27438.915891] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[27438.921150] iwlwifi 0000:36:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[27438.925806] iwlwifi 0000:36:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[27438.931159] iwlwifi 0000:36:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[27438.935814] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVI_ID
[27438.940119] iwlwifi 0000:36:00.0: 0x02001910 | FSEQ_CNVR_ID
[27438.944432] iwlwifi 0000:36:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[27438.949267] iwlwifi 0000:36:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[27438.954095] iwlwifi 0000:36:00.0: 0x8F0F1041 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[27438.960666] iwlwifi 0000:36:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[27438.967581] iwlwifi 0000:36:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
[27438.973279] iwlwifi 0000:36:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
[27438.978454] iwlwifi 0000:36:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
[27438.983456] iwlwifi 0000:36:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[27438.988585] iwlwifi 0000:36:00.0: UMAC CURRENT PC: 0x1110bad
[27438.992982] iwlwifi 0000:36:00.0: LMAC1 CURRENT PC: 0x0
[27438.996941] iwlwifi 0000:36:00.0: LMAC2 CURRENT PC: 0x0
[27439.000885] iwlwifi 0000:36:00.0: UMAC CURRENT PC 1: 0x2220bad
[27439.005470] iwlwifi 0000:36:00.0: TCM1 CURRENT PC: 0x0
[27439.009330] iwlwifi 0000:36:00.0: RCM1 CURRENT PC: 0x0
[27439.013209] iwlwifi 0000:36:00.0: RCM2 CURRENT PC: 0x0
[27439.017089] iwlwifi 0000:36:00.0: Function Scratch status:
[27439.021291] iwlwifi 0000:36:00.0: 0x01010000 | Func Scratch
[27447.720718] ------------[ cut here ]------------
[27447.724078] Hardware became unavailable during restart.
[27447.728141] WARNING: CPU: 7 PID: 650226 at net/mac80211/util.c:1927 ieee80211_reconfig+0x1df/0x4790 [mac80211]
[27447.737069] Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc macvlan pktgen rfcomm 
rpcrdma rdma_cm iw_cm nfsv3 ib_cm ib_core nfs netfs qrtr bnep intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp intel_rapl_common 
intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc662 snd_hda_codec_realtek_lib 
snd_hda_codec_generic intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp mac80211 intel_wmi_thunderbolt pcspkr snd_hda_intel snd_intel_dspcfg btusb 
snd_hda_codec btbcm btmtk btrtl snd_hda_core btintel snd_hwdep iwlwifi bluetooth snd_seq snd_seq_device cfg80211 ftdi_sio snd_pcm i2c_i801 snd_timer snd 
i2c_smbus soundcore i2c_mux intel_pmc_core mei_hdcp mei_pxp pmt_telemetry pmt_discovery pmt_class intel_pch_thermal intel_pmc_ssram_telemetry intel_vsec 
acpi_pad bfq sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc zram raid1 dm_raid raid456
[27447.737231]  async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper 
drm_kms_helper cec rc_core igb ttm dca agpgart i2c_algo_bit hwmon intel_oc_wdt mei_wdt drm video wmi i2c_core scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath 
fuse [last unloaded: nfnetlink]
[27447.853718] CPU: 7 UID: 0 PID: 650226 Comm: kworker/7:0 Kdump: loaded Tainted: G        W           6.18.14+ #27 PREEMPT(full)
[27447.863923] Tainted: [W]=WARN
[27447.865608] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[27447.872165] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[27447.877817] RIP: 0010:ieee80211_reconfig+0x1df/0x4790 [mac80211]
[27447.882631] Code: 89 5c 24 08 e8 f2 ed ec ff 4c 8b 5c 24 08 85 c0 89 04 24 0f 84 a7 08 00 00 48 c7 c7 c0 0c ac a2 4c 89 5c 24 08 e8 61 26 d1 de <0f> 0b 48 b8 
00 00 00 00 00 fc ff df 4c 8b 5c 24 08 49 8d bb 44 44
[27447.900125] RSP: 0018:ffff88813d837a60 EFLAGS: 00010282
[27447.904064] RAX: 0000000000000000 RBX: ffff888146832080 RCX: ffffffff818fa835
[27447.909926] RDX: 1ffff11083bb5350 RSI: 0000000000000008 RDI: ffff88841dda9a80
[27447.915774] RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed1027b06f09
[27447.921631] R10: ffff88813d83784f R11: 0000000000dfdc68 R12: ffffed1028d061e5
[27447.927492] R13: ffff888146834d00 R14: ffff888146830f28 R15: ffff8881468352c8
[27447.933334] FS:  0000000000000000(0000) GS:ffff8884976c6000(0000) knlGS:0000000000000000
[27447.940154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27447.944624] CR2: 00007f92444e7d2c CR3: 000000000509a004 CR4: 00000000003706f0
[27447.950486] Call Trace:
[27447.951660]  <TASK>
[27447.952493]  ? lock_acquire+0x291/0x2e0
[27447.955062]  ? lock_release+0x1cc/0x290
[27447.957639]  ? ieee80211_stop_device+0x110/0x110 [mac80211]
[27447.962029]  ? synchronize_rcu_expedited+0x379/0x3e0
[27447.965730]  ? rcu_exp_wait_wake+0x13c0/0x13c0
[27447.968903]  ? do_raw_spin_lock+0x12c/0x270
[27447.971820]  ? swake_up_locked+0x1b0/0x1b0
[27447.974647]  ? timer_shutdown+0x110/0x110
[27447.977413]  ? cond_synchronize_rcu_expedited_full+0x90/0x90
[27447.981788]  ? lock_release+0x1cc/0x290
[27447.984374]  ieee80211_restart_work+0x261/0x3c0 [mac80211]
[27447.988669]  process_one_work+0x83f/0x17b0
[27447.991492]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[27447.994736]  ? lock_release+0x1cc/0x290
[27447.997286]  ? ieee80211_ifcomb_check+0x180/0x180 [mac80211]
[27448.001803]  worker_thread+0x58c/0xfb0
[27448.004291]  ? __kthread_parkme+0xc6/0x1f0
[27448.007109]  ? rescuer_thread+0x1340/0x1340
[27448.010024]  kthread+0x3b7/0x770
[27448.011982]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.014895]  ? finish_task_switch.isra.0+0x1ac/0x900
[27448.018586]  ? lock_release+0x1cc/0x290
[27448.021153]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.024063]  ret_from_fork+0x28b/0x3a0
[27448.026542]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.029457]  ret_from_fork_asm+0x11/0x20
[27448.032103]  </TASK>
[27448.033015] irq event stamp: 0
[27448.034805] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[27448.039805] hardirqs last disabled at (0): [<ffffffff814500f7>] copy_process+0x1c07/0x67e0
[27448.046798] softirqs last  enabled at (0): [<ffffffff81450144>] copy_process+0x1c54/0x67e0
[27448.053806] softirqs last disabled at (0): [<0000000000000000>] 0x0
[27448.058787] ---[ end trace 0000000000000000 ]---
[27448.062176] wlan11: send auth to 70:58:a4:ff:75:59 (try 3/4)
[27448.071528] iwlwifi 0000:36:00.0: Failed to trigger RX queues sync (-5)
[27448.076998] wlan11: drv-sta-state, sdata-not-in-driver, old_state: 1  new_state: 0
[27448.084018] ------------[ cut here ]------------
[27448.087370] WARNING: CPU: 7 PID: 650226 at net/mac80211/driver-ops.h:1055 ieee80211_del_chanctx+0x336/0x3d0 [mac80211]
[27448.096902] Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc macvlan pktgen rfcomm 
rpcrdma rdma_cm iw_cm nfsv3 ib_cm ib_core nfs netfs qrtr bnep intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp intel_rapl_common 
intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc662 snd_hda_codec_realtek_lib 
snd_hda_codec_generic intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp mac80211 intel_wmi_thunderbolt pcspkr snd_hda_intel snd_intel_dspcfg btusb 
snd_hda_codec btbcm btmtk btrtl snd_hda_core btintel snd_hwdep iwlwifi bluetooth snd_seq snd_seq_device cfg80211 ftdi_sio snd_pcm i2c_i801 snd_timer snd 
i2c_smbus soundcore i2c_mux intel_pmc_core mei_hdcp mei_pxp pmt_telemetry pmt_discovery pmt_class intel_pch_thermal intel_pmc_ssram_telemetry intel_vsec 
acpi_pad bfq sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc zram raid1 dm_raid raid456
[27448.097050]  async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper 
drm_kms_helper cec rc_core igb ttm dca agpgart i2c_algo_bit hwmon intel_oc_wdt mei_wdt drm video wmi i2c_core scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath 
fuse [last unloaded: nfnetlink]
[27448.213530] CPU: 7 UID: 0 PID: 650226 Comm: kworker/7:0 Kdump: loaded Tainted: G        W           6.18.14+ #27 PREEMPT(full)
[27448.223734] Tainted: [W]=WARN
[27448.225422] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[27448.231975] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[27448.237576] RIP: 0010:ieee80211_del_chanctx+0x336/0x3d0 [mac80211]
[27448.242585] Code: fe ff ff 80 3d 38 70 2f 00 00 0f 85 fe fd ff ff 48 c7 c7 20 28 ac a2 c6 05 24 70 2f 00 01 e8 51 49 cf de 0f 0b e9 e4 fd ff ff <0f> 0b 48 c7 
c7 40 29 ac a2 e8 bc f3 ea de e9 65 fe ff ff 48 89 ef
[27448.260079] RSP: 0018:ffff88813d837638 EFLAGS: 00010246
[27448.264027] RAX: 0000000000000000 RBX: ffff888146830ee0 RCX: 1ffffffff0b57d64
[27448.269886] RDX: 0000000000000004 RSI: 000000000000041c RDI: ffff8882141cb630
[27448.275752] RBP: ffff888140219454 R08: 0000000000000000 R09: 0000000000000000
[27448.281611] R10: ffff88816ef0a00f R11: ffffffff81d5e490 R12: ffff888140219400
[27448.287459] R13: 0000000000000000 R14: ffff888146834f00 R15: ffff8881402194b0
[27448.293343] FS:  0000000000000000(0000) GS:ffff8884976c6000(0000) knlGS:0000000000000000
[27448.300156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27448.304612] CR2: 00007f92444e7d2c CR3: 000000000509a004 CR4: 00000000003706f0
[27448.310461] Call Trace:
[27448.311622]  <TASK>
[27448.312438]  ieee80211_free_chanctx+0x144/0x210 [mac80211]
[27448.316720]  __ieee80211_link_release_channel+0x394/0x4a0 [mac80211]
[27448.321896]  ieee80211_destroy_auth_data+0x1b4/0x2b0 [mac80211]
[27448.326628]  ? trace_irq_enable.constprop.0+0xbe/0x100
[27448.330485]  ieee80211_mgd_stop+0x1d0/0x400 [mac80211]
[27448.334428]  ieee80211_do_stop+0x1d8/0x26a0 [mac80211]
[27448.338381]  ? lock_acquire+0x291/0x2e0
[27448.340952]  ? lock_acquire+0x291/0x2e0
[27448.343511]  ? trace_contention_end+0xc4/0x100
[27448.346672]  ? ieee80211_del_virtual_monitor+0x2d0/0x2d0 [mac80211]
[27448.351724]  ? rcu_exp_wait_wake+0x13c0/0x13c0
[27448.354888]  ? ieee80211_stop+0xac/0x2c0 [mac80211]
[27448.358557]  ? do_raw_spin_lock+0x12c/0x270
[27448.361475]  ? ww_mutex_lock+0x160/0x160
[27448.364133]  ? do_raw_spin_lock+0x12c/0x270
[27448.367047]  ? spin_bug+0x1d0/0x1d0
[27448.369266]  ? lock_acquire+0x291/0x2e0
[27448.371830]  ? trace_irq_enable.constprop.0+0xbe/0x100
[27448.375699]  ? dev_deactivate_many+0x5be/0x9f0
[27448.378885]  ? __local_bh_enable_ip+0xae/0x120
[27448.382049]  ? lock_release+0x1cc/0x290
[27448.384607]  ? _raw_spin_lock_irqsave+0x4c/0x60
[27448.387855]  ieee80211_stop+0x13b/0x2c0 [mac80211]
[27448.391440]  __dev_close_many+0x243/0x670
[27448.394167]  ? netdev_notify_peers+0x20/0x20
[27448.397154]  ? try_to_wake_up+0xa09/0x1450
[27448.399975]  netif_close_many+0x1e6/0x5c0
[27448.402705]  ? spin_bug+0x1d0/0x1d0
[27448.404912]  ? __dev_close_many+0x670/0x670
[27448.407808]  ? wake_up_q+0xaf/0x130
[27448.410018]  netif_close+0x141/0x1d0
[27448.412312]  ? netif_close_many+0x5c0/0x5c0
[27448.415208]  ? timer_shutdown+0x110/0x110
[27448.417937]  dev_close+0x89/0x1f0
[27448.419983]  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
[27448.425109]  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
[27448.429413]  process_one_work+0x83f/0x17b0
[27448.432233]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[27448.435480]  ? lock_release+0x1cc/0x290
[27448.438041]  ? ieee80211_ifcomb_check+0x180/0x180 [mac80211]
[27448.442483]  worker_thread+0x58c/0xfb0
[27448.444957]  ? __kthread_parkme+0xc6/0x1f0
[27448.447770]  ? rescuer_thread+0x1340/0x1340
[27448.450679]  kthread+0x3b7/0x770
[27448.452623]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.455525]  ? finish_task_switch.isra.0+0x1ac/0x900
[27448.459208]  ? lock_release+0x1cc/0x290
[27448.461759]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.464661]  ret_from_fork+0x28b/0x3a0
[27448.467145]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.470046]  ret_from_fork_asm+0x11/0x20
[27448.472690]  </TASK>
[27448.473596] irq event stamp: 0
[27448.475378] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[27448.480383] hardirqs last disabled at (0): [<ffffffff814500f7>] copy_process+0x1c07/0x67e0
[27448.487395] softirqs last  enabled at (0): [<ffffffff81450144>] copy_process+0x1c54/0x67e0
[27448.494396] softirqs last disabled at (0): [<0000000000000000>] 0x0
[27448.499389] ---[ end trace 0000000000000000 ]---
[27448.502758] drv-remove-chanctx, NOT driver_present, not sending request to driver.
[27448.502762] ==================================================================
[27448.514973] BUG: KASAN: slab-use-after-free in iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[27448.521963] Read of size 8 at addr ffff8882210e10a8 by task kworker/7:0/650226
[27448.527893]
[27448.528098] CPU: 7 UID: 0 PID: 650226 Comm: kworker/7:0 Kdump: loaded Tainted: G        W           6.18.14+ #27 PREEMPT(full)
[27448.528103] Tainted: [W]=WARN
[27448.528104] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[27448.528106] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[27448.528181] Call Trace:
[27448.528182]  <TASK>
[27448.528184]  dump_stack_lvl+0x73/0xa0
[27448.528189]  print_report+0xce/0x620
[27448.528195]  ? __virt_addr_valid+0x205/0x3f0
[27448.528199]  ? iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[27448.528216]  kasan_report+0xc6/0xf0
[27448.528220]  ? iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[27448.528238]  iwl_mld_mac80211_flush+0x2c6/0x330 [iwlmld]
[27448.528254]  ? trace_irq_enable.constprop.0+0xbe/0x100
[27448.528259]  __ieee80211_flush_queues+0x4e4/0x950 [mac80211]
[27448.528365]  ? ieee80211_get_vif_queues+0x270/0x270 [mac80211]
[27448.528473]  ? printk_get_console_flush_type+0x2d0/0x2d0
[27448.528478]  __ieee80211_recalc_idle+0x375/0x4a0 [mac80211]
[27448.528555]  ieee80211_recalc_idle+0x10/0x30 [mac80211]
[27448.528632]  ieee80211_del_chanctx+0x27d/0x3d0 [mac80211]
[27448.528714]  ieee80211_free_chanctx+0x144/0x210 [mac80211]
[27448.528796]  __ieee80211_link_release_channel+0x394/0x4a0 [mac80211]
[27448.528879]  ieee80211_destroy_auth_data+0x1b4/0x2b0 [mac80211]
[27448.528963]  ? trace_irq_enable.constprop.0+0xbe/0x100
[27448.528967]  ieee80211_mgd_stop+0x1d0/0x400 [mac80211]
[27448.529052]  ieee80211_do_stop+0x1d8/0x26a0 [mac80211]
[27448.529129]  ? lock_acquire+0x291/0x2e0
[27448.529133]  ? lock_acquire+0x291/0x2e0
[27448.529137]  ? trace_contention_end+0xc4/0x100
[27448.529141]  ? ieee80211_del_virtual_monitor+0x2d0/0x2d0 [mac80211]
[27448.529217]  ? rcu_exp_wait_wake+0x13c0/0x13c0
[27448.529220]  ? ieee80211_stop+0xac/0x2c0 [mac80211]
[27448.529297]  ? do_raw_spin_lock+0x12c/0x270
[27448.529301]  ? ww_mutex_lock+0x160/0x160
[27448.529304]  ? do_raw_spin_lock+0x12c/0x270
[27448.529308]  ? spin_bug+0x1d0/0x1d0
[27448.529311]  ? lock_acquire+0x291/0x2e0
[27448.529314]  ? trace_irq_enable.constprop.0+0xbe/0x100
[27448.529317]  ? dev_deactivate_many+0x5be/0x9f0
[27448.529321]  ? __local_bh_enable_ip+0xae/0x120
[27448.529326]  ? lock_release+0x1cc/0x290
[27448.529331]  ? _raw_spin_lock_irqsave+0x4c/0x60
[27448.529335]  ieee80211_stop+0x13b/0x2c0 [mac80211]
[27448.529460]  __dev_close_many+0x243/0x670
[27448.529464]  ? netdev_notify_peers+0x20/0x20
[27448.529468]  ? try_to_wake_up+0xa09/0x1450
[27448.529472]  netif_close_many+0x1e6/0x5c0
[27448.529475]  ? spin_bug+0x1d0/0x1d0
[27448.529480]  ? __dev_close_many+0x670/0x670
[27448.529483]  ? wake_up_q+0xaf/0x130
[27448.529488]  netif_close+0x141/0x1d0
[27448.529491]  ? netif_close_many+0x5c0/0x5c0
[27448.529494]  ? timer_shutdown+0x110/0x110
[27448.529499]  dev_close+0x89/0x1f0
[27448.529502]  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
[27448.529592]  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
[27448.529667]  process_one_work+0x83f/0x17b0
[27448.529672]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[27448.529676]  ? lock_release+0x1cc/0x290
[27448.529680]  ? ieee80211_ifcomb_check+0x180/0x180 [mac80211]
[27448.529754]  worker_thread+0x58c/0xfb0
[27448.529759]  ? __kthread_parkme+0xc6/0x1f0
[27448.529763]  ? rescuer_thread+0x1340/0x1340
[27448.529766]  kthread+0x3b7/0x770
[27448.529769]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.529771]  ? finish_task_switch.isra.0+0x1ac/0x900
[27448.529774]  ? lock_release+0x1cc/0x290
[27448.529778]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.529781]  ret_from_fork+0x28b/0x3a0
[27448.529784]  ? kthread_is_per_cpu+0xb0/0xb0
[27448.529786]  ret_from_fork_asm+0x11/0x20
[27448.529793]  </TASK>
[27448.529794]
[27448.766738] Allocated by task 657153:
[27448.769117]  kasan_save_stack+0x1c/0x40
[27448.771671]  kasan_save_track+0x10/0x30
[27448.774218]  __kasan_kmalloc+0x83/0x90
[27448.776678]  __kmalloc_noprof+0x24e/0x7d0
[27448.779408]  __sta_info_alloc+0x9c/0x1980 [mac80211]
[27448.783154]  ieee80211_prep_connection+0xb1e/0x1550 [mac80211]
[27448.787784]  ieee80211_mgd_auth+0xeba/0x1960 [mac80211]
[27448.791813]  cfg80211_mlme_auth+0x458/0x7f0 [cfg80211]
[27448.795758]  nl80211_authenticate+0xa90/0x1180 [cfg80211]
[27448.799943]  genl_family_rcv_msg_doit+0x1cb/0x2a0
[27448.803374]  genl_rcv_msg+0x3f7/0x6b0
[27448.805748]  netlink_rcv_skb+0x125/0x380
[27448.808393]  genl_rcv+0x24/0x40
[27448.810244]  netlink_unicast+0x5dd/0x9d0
[27448.812883]  netlink_sendmsg+0x749/0xc00
[27448.815515]  __sock_sendmsg+0xc1/0x150
[27448.817978]  ____sys_sendmsg+0x5f4/0x8f0
[27448.820611]  ___sys_sendmsg+0xed/0x170
[27448.823074]  __sys_sendmsg+0x107/0x1a0
[27448.825533]  do_syscall_64+0x69/0x1210
[27448.827998]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[27448.831758]
[27448.831964] Freed by task 650226:
[27448.833994]  kasan_save_stack+0x1c/0x40
[27448.836542]  kasan_save_track+0x10/0x30
[27448.839092]  __kasan_save_free_info+0x37/0x50
[27448.842156]  __kasan_slab_free+0x3b/0x60
[27448.844791]  kfree+0x164/0x580
[27448.846560]  sta_info_destroy_addr+0x75/0x100 [mac80211]
[27448.850653]  ieee80211_destroy_auth_data+0x14e/0x2b0 [mac80211]
[27448.855373]  ieee80211_mgd_stop+0x1d0/0x400 [mac80211]
[27448.859328]  ieee80211_do_stop+0x1d8/0x26a0 [mac80211]
[27448.863296]  ieee80211_stop+0x13b/0x2c0 [mac80211]
[27448.866920]  __dev_close_many+0x243/0x670
[27448.869639]  netif_close_many+0x1e6/0x5c0
[27448.872374]  netif_close+0x141/0x1d0
[27448.874665]  dev_close+0x89/0x1f0
[27448.876692]  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
[27448.881747]  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
[27448.886014]  process_one_work+0x83f/0x17b0
[27448.888820]  worker_thread+0x58c/0xfb0
[27448.891281]  kthread+0x3b7/0x770
[27448.893223]  ret_from_fork+0x28b/0x3a0
[27448.895684]  ret_from_fork_asm+0x11/0x20
[27448.898319]
[27448.898527] The buggy address belongs to the object at ffff8882210e0000
  which belongs to the cache kmalloc-8k of size 8192
[27448.908448] The buggy address is located 4264 bytes inside of
  freed 8192-byte region [ffff8882210e0000, ffff8882210e2000)
[27448.918282]
[27448.918484] The buggy address belongs to the physical page:
[27448.922768] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2210e0
[27448.929478] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[27448.935838] flags: 0x5fff8000000040(head|node=0|zone=2|lastcpupid=0x3fff)
[27448.941336] page_type: f5(slab)
[27448.943214] raw: 005fff8000000040 ffff888120043180 dead000000000122 0000000000000000
[27448.949663] raw: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
[27448.956119] head: 005fff8000000040 ffff888120043180 dead000000000122 0000000000000000
[27448.962656] head: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
[27448.969192] head: 005fff8000000003 ffffea0008843801 00000000ffffffff 00000000ffffffff
[27448.975726] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000000
[27448.982261] page dumped because: kasan: bad access detected
[27448.986540]
[27448.986746] Memory state around the buggy address:
[27448.990246]  ffff8882210e0f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[27448.996177]  ffff8882210e1000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[27449.002104] >ffff8882210e1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[27449.008034]                                   ^
[27449.011274]  ffff8882210e1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[27449.017205]  ffff8882210e1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[27449.023131] ==================================================================
[27449.029128] wlan11: ieee80211_vif_set_links: new_links=0x0; dormant_links=0x0

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



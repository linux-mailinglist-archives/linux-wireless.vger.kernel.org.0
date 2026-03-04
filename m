Return-Path: <linux-wireless+bounces-32479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MpjJcaOqGmzvgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:57:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C52074D1
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F5323029465
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A263DFC87;
	Wed,  4 Mar 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="U7f0t5pT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B963D6CCB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654271; cv=none; b=J3q5KkFIAXR0J0VV7W3mH65n80faAy5VnRUXeSBMvHlrMSpldLos5pb89xXFJjz4yzoJSL+GKW/xWHGTIFjYchdXgZR/mfEDtJ/nhs4aZ3EFi/z8rXwxUhhDmUEvS/a8mT+CYPZSVUYPrCUpgr1/2Z7zI80FYr87dfHb4M6G6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654271; c=relaxed/simple;
	bh=BiMmxjkD41/0Cr/ybV0cnDRo2yOKJ3ahWVah/uZrlAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ux5h6CiOM8ZdfFvxqe3tBA0qbJnLgCKVcCApEO3QbBFiWx8lx3dQTqCZ3t5IWPQqjPklNosO3Cu4f6aS6bS7fl356KadNJUqnknF06plSBIqI716hrsl1y6h/KzZfVHTCumRcFTrCUDzEuN3tfN5G9cUa7x657aufoJCuNZySoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=U7f0t5pT; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1C20FB00073;
	Wed,  4 Mar 2026 19:57:42 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id AB0D913C2B0;
	Wed,  4 Mar 2026 11:57:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AB0D913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772654259;
	bh=BiMmxjkD41/0Cr/ybV0cnDRo2yOKJ3ahWVah/uZrlAM=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=U7f0t5pTGCVimr0N+UNYc/ec88USfMaWyguKzLt8Jvx+8PNcytpjlfd2c42r4PSDG
	 F2nPdaOKOn+yCz9WnVenMXUn7Kd1iwockREkVmQ6yMxgs64Ak9Yq9lSriN9FFCLBuf
	 W+juowbJrFzrCLRVj7SdYJ2PnBDcmBSTueyq+gBs=
Message-ID: <354277a2-5e53-2cf0-d000-61f38d4d09cc@candelatech.com>
Date: Wed, 4 Mar 2026 11:57:39 -0800
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
 <57f29f81-9a05-ffef-342f-818a25842c6e@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <57f29f81-9a05-ffef-342f-818a25842c6e@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1772654262-2ybQRF7rRmn1
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772654262;2ybQRF7rRmn1;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 9C9C52074D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32479-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Action: no action

On 3/4/26 11:26, Ben Greear wrote:
> On 3/3/26 06:27, Ben Greear wrote:
>> On 3/2/26 23:19, Korenblit, Miriam Rachel wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Ben Greear <greearb@candelatech.com>
>>>> Sent: Monday, March 2, 2026 9:00 PM
>>>> To: linux-wireless <linux-wireless@vger.kernel.org>; Korenblit, Miriam Rachel
>>>> <miriam.rachel.korenblit@intel.com>
>>>> Subject: Use-after-free in iwl-mld after hardware fails to restart.
>>>>
>>>> Hello,
>>>>
>>>> Here's another failure case from my torture test system.
>>>>
>>>> This is from a patched 6.18.14+ kernel, but from a look at upstream Linux
>>>> kernel, the problems are there as well.
>>>>
>>>> I believe the problem is something like this:
>>>>
>>>> firmware crashes several times and cannot recover.  Maybe
>>>> Intel folks can tell why it is crashing?  I'd love to know if that
>>>> is something that can be fixed in the driver.
>>>>
>>>>   From mac80211/util.c:
>>>>
>>>> int ieee80211_reconfig(struct ieee80211_local *local)
>>>> is called, and gets to the failure case in this code (I see that second WARN in the
>>>> crash logs)
>>>> .....
>>>>     /*
>>>>      * Upon resume hardware can sometimes be goofy due to
>>>>      * various platform / driver / bus issues, so restarting
>>>>      * the device may at times not work immediately. Propagate
>>>>      * the error.
>>>>      */
>>>>     res = drv_start(local);
>>>>     if (res) {
>>>>         if (suspended)
>>>>             WARN(1, "Hardware became unavailable upon resume.
>>>> This could be a software issue prior to suspend or a hardware issue.\n");
>>>>         else
>>>>             WARN(1, "Hardware became unavailable during
>>>> restart.\n");
>>>>         ieee80211_wake_queues_by_reason(hw,
>>>> IEEE80211_MAX_QUEUE_MAP,
>>>>
>>>>     IEEE80211_QUEUE_STOP_REASON_SUSPEND,
>>>>                         false);
>>>>         ieee80211_handle_reconfig_failure(local);
>>>>         return res;
>>>>
>>>>
>>>> This method has comments about cleaning things up, but I don't see where it
>>>> actually
>>>> cleans up the driver.  And it sets SDATA_IN_DRIVER to false, so a lot of the calls
>>>> in driver-ops.h that would otherwise tell the driver to clean up skip calls to
>>>> the driver.
>>>>
>>>> static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
>>>> {
>>>>     struct ieee80211_sub_if_data *sdata;
>>>>     struct ieee80211_chanctx *ctx;
>>>>
>>>>     lockdep_assert_wiphy(local->hw.wiphy);
>>>>
>>>>     /*
>>>>      * We get here if during resume the device can't be restarted properly.
>>>>      * We might also get here if this happens during HW reset, which is a
>>>>      * slightly different situation and we need to drop all connections in
>>>>      * the latter case.
>>>>      *
>>>>      * Ask cfg80211 to turn off all interfaces, this will result in more
>>>>      * warnings but at least we'll then get into a clean stopped state.
>>>>      */
>>>>
>>>>     local->resuming = false;
>>>>     local->suspended = false;
>>>>     local->in_reconfig = false;
>>>>     local->reconfig_failure = true;
>>>>
>>>>     ieee80211_flush_completed_scan(local, true);
>>>>
>>>>     /* scheduled scan clearly can't be running any more, but tell
>>>>      * cfg80211 and clear local state
>>>>      */
>>>>     ieee80211_sched_scan_end(local);
>>>>
>>>>     list_for_each_entry(sdata, &local->interfaces, list)
>>>>         sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
>>>>
>>>>     /* Mark channel contexts as not being in the driver any more to avoid
>>>>      * removing them from the driver during the shutdown process...
>>>>      */
>>>>     list_for_each_entry(ctx, &local->chanctx_list, list)
>>>>         ctx->driver_present = false;
>>>> }
>>>>
>>>>
>>>> So, how is the driver supposed to be cleaned up in this scenario?
>>> Driver was cleaned up in drv_start. See iwl_mld_restart_cleanup.
>>> Could you please share the iwlmld.ko and iwlwifi.ko files?

Hello Miriam,

Should we call 'iwl_mld_restart_cleanup()' in the failure path before the goto error?

I do not see the log "mld-mac80211-start, already in-hw-restart, stopping fw cleanup"
in my dump, so it seems it did not actually do cleanup in this particular crash.

	if (mld->fw_status.in_hw_restart) {
		IWL_ERR(mld, "mld-mac80211-start, already in-hw-restart, stopping fw cleanup\n");
		iwl_mld_stop_fw(mld);
		iwl_mld_restart_cleanup(mld);
	}

	if (!in_d3 || ret) {
		ret = iwl_mld_start_fw(mld);
		if (ret) {
			IWL_ERR(mld, "Failed start-fw. ret=%d\n", ret);
			goto error;
		}
	}

...

And note this in the error path in same method:

error:
	/* If we failed to restart the hw, there is nothing useful
	 * we can do but indicate we are no longer in restart.
	 */
	mld->fw_status.in_hw_restart = false;

Maybe that keeps that cleanup code above from hitting in double failure
states?

[snipped rest of the logs to keep the email from being huge]

Thanks,
Ben



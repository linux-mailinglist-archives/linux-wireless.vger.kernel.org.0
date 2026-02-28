Return-Path: <linux-wireless+bounces-32310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGhtIHbmomkW8AQAu9opvQ
	(envelope-from <linux-wireless+bounces-32310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 13:58:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E85F1C3149
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7993028536
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FC40F8C8;
	Sat, 28 Feb 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="TcDyBpes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E17395DA0
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283505; cv=none; b=tsowMrALDKCS9rRhQrUAFtcQ7vMBVJg5dGwzu7rLNyio3mEx71PuPQ4x0Ym4IsPl4UiUSHkov44m+SYhJjmQZr0kLcu6ympPg+john+rfdLba1pptiGB1ddmqTD07n6S+kpsBCWqZsRA28rrnOURlzSS1HYsEa/a4uHvvYD7UDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283505; c=relaxed/simple;
	bh=quacLDU3IYuNL9TYKCXlWK/6IX3vM2DcLLO/Sf+ZnY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BZGEQIFjLYKi4BvEMqzbuPM/bwBYjAfiU6ChmqLuHl0Kc+UOQX5hhlwa4uiOeanXiOzb/zQZMGNKiSaN3XoiY6lwsSpkmG43bEg8KBaaA6Co6NTgH7/iBcn+bYPgojtJB6svTPIOfYRED+/cCR1oLtMRyJmrQUH3ZwLG/2CgiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=TcDyBpes; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 48BF6B00061;
	Sat, 28 Feb 2026 12:58:15 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E4E3B13C2B0;
	Sat, 28 Feb 2026 04:58:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E4E3B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772283493;
	bh=quacLDU3IYuNL9TYKCXlWK/6IX3vM2DcLLO/Sf+ZnY8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TcDyBpeszEbYhNTAf/E1VCG80ajWoDAd9wZ9aakY2NleyYNcQimWJVVj8nWM0Gl34
	 Ja9YSUDH3+VUBowWfzjvLmWgyUwxxQ4HOqCp1P+uqb8AHtuVSYVlWCFvjviieTqGXp
	 tVX4HgWmhYP+JuIf+JyjK2BpJlkS5WfAl0Btmc/M=
Message-ID: <3e65da3c-af75-4ced-9580-4ad89d7d5493@candelatech.com>
Date: Sat, 28 Feb 2026 04:58:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maybe problem with ieee80211_tear_down_links return value.
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <40a9eca2-17fb-b839-e31f-eb4aecb2ca41@candelatech.com>
 <0e276fba-7a1a-4d2f-a3da-1f3ad53a8a56@oss.qualcomm.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <0e276fba-7a1a-4d2f-a3da-1f3ad53a8a56@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1772283496-3LU8G47H-mz6
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772283496;3LU8G47H-mz6;<greearb@candelatech.com>;27be10da4449211123c88bf532733e0b
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-32310-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0E85F1C3149
X-Rspamd-Action: no action

On 2/27/26 22:45, Rameshkumar Sundaram wrote:
> 
> 
> On 2/28/2026 6:28 AM, Ben Greear wrote:
>> While checking on some other problems, I ended up adding logging to the code path
>> below from net/mac80211/link.c.  This path is hit very often on my system, and if I understand
>> the code correctly, it should only hit in error cases where MLO links have duplicated
>> MAC addresses.
>>
>>      ret = ieee80211_check_dup_link_addrs(sdata);
>>      if (!ret) {
>>          /* for keys we will not be able to undo this */
>>          ieee80211_tear_down_links(sdata, to_free, rem);
>>
>> The ieee80211_check_dup_link_addrs method appears to return 0 when there are no duplicates,
>> and -EALREADY when there are duplicates.  So maybe the check above should be reversed to be:
>>
>> if (ret) {
>> ??
>>
> 
> 
> The ieee80211_check_dup_link_addrs() helper returns 0 when no duplicates are found and -EALREADY on duplicates, as you described.
> 
> However, in the caller the pattern:
> 
>          if (!ret) {
>                  /* for keys we will not be able to undo this */
>                  ieee80211_tear_down_links(sdata, to_free, rem);
> 
>                  ieee80211_set_vif_links_bitmaps(sdata, new_links, dormant_links);
> 
>                  /* tell the driver */
>                  if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
>                          ret = drv_change_vif_links(sdata->local, sdata,
>                                                     old_links & old_active,
>                                                     new_links & sdata->vif.active_links,
>                                                     old);
>                  if (!new_links)
>                          ieee80211_debugfs_recreate_netdev(sdata, false);
> 
>                  if (sdata->vif.type == NL80211_IFTYPE_AP)
>                          ieee80211_update_apvlan_links(sdata);
>          }
> 
> treats ret == 0 as the success/commit path (i.e., only proceed with tearing down removed links, updating link bitmaps, and notifying the driver after validating 
> the new link configuration)
> 
> 
> So I don’t think the condition should be reversed. If it were changed to if (ret), we’d end up committing the update only when duplicates are detected 
> (-EALREADY), which seems backwards given the current flow (and the later rollback handling when ret is non-zero).

Hello Ramesh,

Thanks for the response.  Yes, I was confused...I thought that branch of code was the error case,
but it is actually expected case.

I'm seeing some rare debugfs corruption/crash in that code branch and started thinking it was
error handling.

Thanks,
Ben


--Ben

> 
> -- 
> Ramesh
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



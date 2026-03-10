Return-Path: <linux-wireless+bounces-32928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLDhCkRvsGmNjAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 20:21:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE4256FE8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 20:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC103300D302
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 19:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6D349AF3;
	Tue, 10 Mar 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="r3z3745n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC783491C8;
	Tue, 10 Mar 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170342; cv=none; b=p3h1VIpqc4hiQbgxNsTtwBYaLGO5L1bHgKbnJyQY0OhCqhjiaXq/4RHyd1I8ROgxv24UJjpulfZbP+5fanUuR7zjwSl1vYduWdBkqiBGUPkygNRr4hTFKlrN5a40Mx/mCyu11ww+zzozhhpjs5Ev3O2r348haadIuTNWql/2Yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170342; c=relaxed/simple;
	bh=SHQ8lO4VCs9n2oeVcb8+8rYSkeJ/w60bsT/WDV4zuJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mE9ih6zupAq7JvO/o6NPBKpoaPXqLYVYM8FoPF3UzNl656e1/CezuE1GTdyQz+AX+ECti7AKTeg6au99J8wwdMukPujjKqtry0qegSh3NsT4/VbtGi7RswFkIiZN3KNmUTn32o4HzhlDGi4DSH380FqmH4hrq41u2jF29/5eKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=r3z3745n; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 060D5280072;
	Tue, 10 Mar 2026 19:18:51 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0B65113C2B0;
	Tue, 10 Mar 2026 12:18:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0B65113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773170330;
	bh=SHQ8lO4VCs9n2oeVcb8+8rYSkeJ/w60bsT/WDV4zuJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r3z3745nKZVE7c2PZ8ynMQKvuykwgppEWZ0n3htjsDaXEePLMXoiEbIJqp9XkYTpV
	 3N/bB12d8KT3NwDyst2nZwmxNNi1Vr04PPxR89OTNHkdq3EoQm85T/XMgly/aWJfLw
	 94f4WRnlkAyp4Xzvh3me4Q79FmhQFpHRN3S1aiSQ=
Message-ID: <729164a1-9dd4-c9a4-f092-d93d775257e0@candelatech.com>
Date: Tue, 10 Mar 2026 12:18:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Miriam Rachel <miriam.rachel.korenblit@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
 <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
 <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
 <aadYoaA_JYduCx_S@slm.duckdns.org>
 <de003dc3-3e37-f238-4250-2df16eeb77d6@candelatech.com>
 <68c1ca1381d1871fff72b211890a64eb@kernel.org>
 <bba74cab-7305-a052-7e1c-7a7736ba4531@candelatech.com>
 <5b9b93df8774810a43fceb359906604b@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <5b9b93df8774810a43fceb359906604b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1773170333-4JhH_YF9W8Im
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773170333;4JhH_YF9W8Im;<greearb@candelatech.com>;e39a4ef213bcaa75c219f509376588df
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 91DE4256FE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32928-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,candelatech.com:dkim,candelatech.com:email,candelatech.com:url,candelatech.com:mid]
X-Rspamd-Action: no action

On 3/10/26 11:06, Tejun Heo wrote:
> Hello,
> 
> Thanks for the detailed dump. One thing that doesn't look right is the
> number of pending work items on pool 22 (CPU 5). The pool reports 2 idle
> workers, yet there are 7+ work items sitting in the pending list across
> multiple workqueues. If the pool were making forward progress, those items
> would have been picked up by the idle workers. So, the pool itself seems to
> be stuck for some reason, and the cfg80211 mutex stall may be a consequence
> rather than the cause.
> 
> Let's try using drgn on the crash dump. I'm attaching a prompt that you can
> feed to Claude (or any LLM with tool access to drgn). It contains workqueue
> internals documentation, drgn code snippets, and a systematic investigation
> procedure. The idea is:
> 
> 1. Generate the crash dump when the deadlock is happening:
> 
>       echo c > /proc/sysrq-trigger
> 
> 2. After the crash kernel boots, create the dump file:
> 
>       makedumpfile -c -d 31 /proc/vmcore /tmp/vmcore.dmp
> 
> 3. Feed the attached prompt to Claude with drgn access to the dump. It
>     should produce a Markdown report with its findings that you can post
>     back here.
> 
> This is a bit experimental, so let's see whether it works. Either way, the
> report should at least give us concrete data points to work with.
> 
> Thanks.

Thanks for that.  It will probably be a few days before I flip back to debugging
that lockup as I'm trying to get something ready for our internal release (using
kthread work-around).

While working on another bug, I found evidence (but not proof yet), that this code below
can be called multiple times for the same object.  The bug I'm tracking is that this
may be the cause of list corruption (my debugging logs and work-arounds are in the method below).

But could this work-item (re)initialization also explain work-queue system going
weird?  Just using kthreads, which 'fixes' the problem for me,
really shouldn't make a difference to the code below, so probably
it is not related?


void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
			 int link_id,
			 struct ieee80211_link_data *link,
			 struct ieee80211_bss_conf *link_conf)
{
	struct ieee80211_local *local = sdata->local;
	bool deflink = link_id < 0;

	lockdep_assert_wiphy(local->hw.wiphy);

	if (link_id < 0)
		link_id = 0;

	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
		struct ieee80211_sub_if_data *ap_bss;
		struct ieee80211_bss_conf *ap_bss_conf;

		ap_bss = container_of(sdata->bss,
				      struct ieee80211_sub_if_data, u.ap);
		ap_bss_conf = sdata_dereference(ap_bss->vif.link_conf[link_id],
						ap_bss);
		memcpy(link_conf, ap_bss_conf, sizeof(*link_conf));
	}

	link->sdata = sdata;
	link->link_id = link_id;
	link->conf = link_conf;
	link_conf->link_id = link_id;
	link_conf->vif = &sdata->vif;
	link->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
	link->user_power_level = sdata->local->user_power_level;
	link_conf->txpower = INT_MIN;

	wiphy_work_init(&link->csa.finalize_work,
			ieee80211_csa_finalize_work);
	wiphy_work_init(&link->color_change_finalize_work,
			ieee80211_color_change_finalize_work);
	wiphy_delayed_work_init(&link->color_collision_detect_work,
				ieee80211_color_collision_detection_work);
	/* I see some sort of list corruption where links don't get removed from chanctx
	 * lists.  I think if we are in a list while here, that could cause it.  deflink
	 * appears to have chance of doing that.  So, remove from list first if
	 * it is indeed in one.
	 */
	if (WARN_ON_ONCE((link->assigned_chanctx_list.next != LIST_POISON1)
			 && (link->assigned_chanctx_list.next != link->assigned_chanctx_list.prev)
			 && (link->assigned_chanctx_list.next))) {
		sdata_err(sdata, "link-init: %d called while already in an assigned-chan-ctx list, clearing.\n",
			  link_id);
		list_del(&link->assigned_chanctx_list);
	}
	if (WARN_ON_ONCE((link->reserved_chanctx_list.next != LIST_POISON1)
			 && (link->reserved_chanctx_list.next != link->reserved_chanctx_list.prev)
			 && (link->reserved_chanctx_list.next))) {
		sdata_err(sdata, "link-init: %d called while already in a reserved-chan-ctx list, clearing.\n",
			  link_id);
		list_del(&link->reserved_chanctx_list);
	}

	INIT_LIST_HEAD(&link->assigned_chanctx_list);
	INIT_LIST_HEAD(&link->reserved_chanctx_list);
	wiphy_delayed_work_init(&link->dfs_cac_timer_work,
				ieee80211_dfs_cac_timer_work);

	if (!deflink) {
		switch (sdata->vif.type) {
		case NL80211_IFTYPE_AP:
		case NL80211_IFTYPE_AP_VLAN:
			ether_addr_copy(link_conf->addr,
					sdata->wdev.links[link_id].addr);
			link_conf->bssid = link_conf->addr;
			WARN_ON(!(sdata->wdev.valid_links & BIT(link_id)));
			break;
		case NL80211_IFTYPE_STATION:
			/* station sets the bssid in ieee80211_mgd_setup_link */
			break;
		default:
			WARN_ON(1);
		}

		ieee80211_link_debugfs_add(link);
	}

	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
	rcu_assign_pointer(sdata->link[link_id], link);
}


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




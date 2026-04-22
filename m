Return-Path: <linux-wireless+bounces-35207-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCHmIdSH6Gk6LgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35207-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:33:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071834437F1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 718E130154A9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7BF377575;
	Wed, 22 Apr 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fwWuJoPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FB3BF673
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846788; cv=none; b=hEJ7mMJqpeY70njuQE2TymyUOtrVdNzo4g4C17pzBT/+PXEsfslceg+vg4MWKn25xZo1URwGuojxqA7C9FfkhOxf6mQz8zvtGtoGNhZ7/mnef+T7TcpQOI3w39IPHZ2/bVDksF2uk6N5zongFNjwHcnqqQg9D/Y4ZoFUpd2Rh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846788; c=relaxed/simple;
	bh=41xW4ejv7T1CSV+3/l1A9VAHjhkxCJbB9E6clsG2pBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtOwZiE4FwNt09GDhoZ7q/VyNKSF26rg/FVq+7NtuZvewcvLoULqYNTfLQkVh4Z3tqpOm2P0AEKKcGZyAEK9V9RrzpEfQe+pMrsn08AVwkY3kpRafoSKrQHY2XMTNsX+491IDrRxLairXVqGHhPr2ht6Wls3iPNp9SPPU70URV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fwWuJoPD; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2dee127b3c5so6639749eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 01:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846786; x=1777451586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwojWsoB4+OylC4P6G4YO5Qsy6kg6KFoVsUdEXs9maM=;
        b=F5A9990zXu5w49yBU2kLR0W51/v90OCm608GH1VSNs3iUYR5w5t2JkXS6QKzcBZ7Sr
         t7LYhseYSR85NJ4uA9JdnMg0oCQLfW6osFbtBU+htCPqQc33CCU7pWfVgirBTjMYPL5H
         sr1oATe86KE6lYxFGANvQ1ANhv8U128cnsd6Asewlev5qYXZVMCLwkKOBYqIx3JLu5X3
         eQkNdRHppsp6axvyTfz51OUFW+68D8dOGYWKsXNtRrCNYQP3o+8YmAkssg+fdBsczk7+
         fPZs+jr4HHSZ3QoREfWDFY0Y+KoGti8KcOQhJrMpLU2t/Yb35DBqtnL1P6b/8fYbSiky
         9RHA==
X-Forwarded-Encrypted: i=1; AFNElJ/OyNIigZh7CGMVFfqn/dMa7r3XUzhyLrd+9QdnsfxUjALTVY0nBCeSOyj2PHJ9ugI79oc0pWjG4ezexbyeZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygkxHRFVNxImAdwNqd0dA7Ar5HqS8Q5zVpuur43SEVMLavLoCH
	y3byX9myChwkJX9dUo8AimBwg/BXm6wV+CeJMC3FmasFusDw+Duxvr8nKHjJB7YklDbSqM0S4Z8
	1OKv9rqEjQEg7FiF1GZ0so0k8T97R20Wx2jrTTu0VqDEMxsxysQHOnZfJmu5nGsP2PrbHLtX1Yy
	FCekJQ+1LlSCbA6kq9yrdE1oRauKYz2b29cy8IVRQtghMSEqGSgjwxrYehrhtxWWayxrijNsLy7
	TLLf3yXGkjLdUCOmomHin5Zd4pZ
X-Gm-Gg: AeBDiesY27VCob+QP0fwaVdjFDr/oto4XoN5ImsQjF/d/tcyjyY3JW+/H+hmlJq8JHp
	4OGSBRkO63015fO0NLGNgcnLdEshp3PClMRTSiTkxAtMxlNOe5Xw1jAaj5g2yYh1X3W/XBVOS/g
	higgR6jeriYy60DYVbDLKZwEnDc06bAJ0Zq86WQ8//jsTmO5ZZqMnmdbm/d3DWlH2u/KXQMu145
	vqHtnzThhdoGhxVafCf4sVJjjLKd7qb+pv0r54Fd34jfna96rqmUAa/0cg+vrtZp71F8ief75YV
	JtraV01/P+Vm79Lewg62egFn4CkSoagWXfKX+Cj6kPVgSVzH+SbqAZRrR8FUD6VMEw9Me1JmKik
	dExLI73Ksu2AFkS1T3j/UMzlzl/mlHq1/2VzHWvFXBfbHsSCmlIZntzlzCsfHvyF4wzy5NjOmC1
	QSMuC/MMtsJ+Gkzop9WEUJV0PIljBCzgYS8flVi/8u/28iyNMOsytS/JNu+/7EWjoQQ9c4jnw=
X-Received: by 2002:a05:7301:1291:b0:2ea:5057:a333 with SMTP id 5a478bee46e88-2ea5057b8dfmr4157215eec.15.1776846785603;
        Wed, 22 Apr 2026 01:33:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-90.dlp.protect.broadcom.com. [144.49.247.90])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2e53cccd9ccsm1085657eec.27.2026.04.22.01.33.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:33:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2e60238adb1so7895743eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776846783; x=1777451583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwojWsoB4+OylC4P6G4YO5Qsy6kg6KFoVsUdEXs9maM=;
        b=fwWuJoPDn9PIi15yGYKowRuXQkYMcaGR3/T2HJWZo1iQBUL3ZnASDgZorzr57sHI2p
         zEZHrFHLdhV0EJPQV+Idi7XwNxXHBn+veZzP/EojpSQB3Cw10NTbeFlVb2XMQJwWjmTo
         h5eAzvWqh2zmkkPSTrhCu+zUs0pMoOrg2wGYI=
X-Forwarded-Encrypted: i=1; AFNElJ8h0A4zRwx8inawzUn0XI3oOrp9ZZcgkBjeSWts8MG0gN/hkG2J6R2W+OzUk+z1bOuUVhkV63yNUlQ6Dudh5w==@vger.kernel.org
X-Received: by 2002:a05:693c:3007:b0:2df:5715:82ca with SMTP id 5a478bee46e88-2e46557d3b3mr11251560eec.11.1776846783458;
        Wed, 22 Apr 2026 01:33:03 -0700 (PDT)
X-Received: by 2002:a05:693c:3007:b0:2df:5715:82ca with SMTP id 5a478bee46e88-2e46557d3b3mr11251553eec.11.1776846782869;
        Wed, 22 Apr 2026 01:33:02 -0700 (PDT)
Received: from [10.176.2.190] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm22570177eec.28.2026.04.22.01.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:33:02 -0700 (PDT)
Message-ID: <bb2efbdf-5e46-4e56-b785-dda27759b70f@broadcom.com>
Date: Wed, 22 Apr 2026 10:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: require admin perm on SET_PMK / DEL_PMK
To: Michael Bommarito <michael.bommarito@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Avraham Stern <avraham.stern@intel.com>, linux-kernel@vger.kernel.org
References: <20260421224552.4044147-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260421224552.4044147-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35207-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 071834437F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/04/2026 00:45, Michael Bommarito wrote:
> NL80211_CMD_SET_PMK and NL80211_CMD_DEL_PMK manage the offloaded
> 4-way-handshake PMK state used by drivers advertising
> NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X.  The only in-tree
> driver that wires up both ->set_pmk / ->del_pmk and advertises
> the feature today is brcmfmac, so the practical reach of this
> patch is narrow.
> 
> Both ops were introduced without a .flags gate, so the generic
> netlink layer dispatches them to an unprivileged caller instead
> of rejecting with -EPERM at the permission check.  Every other
> connection-state op in the adjacent block (CONNECT, ASSOCIATE,
> AUTHENTICATE, SET_KEY, ...) carries GENL_UNS_ADMIN_PERM; SET_PMK
> / DEL_PMK were introduced without the flag in 2017 and left
> unchanged by later refactors.  Johannes checked the original
> Intel submission history and confirmed there is no admin check
> in any prior revision either, so this seems likely to be a
> simple oversight rather than an intentional carve-out.
> 
> Require GENL_UNS_ADMIN_PERM so the genl layer performs the same
> capable(CAP_NET_ADMIN) check as its siblings.  wpa_supplicant
> already needs CAP_NET_ADMIN for every other nl80211 op it issues,
> so supplicant operation is unaffected.  The worst case the missing
> gate enables today is an unprivileged local process on a
> multi-user system invalidating the offloaded PMK state of another
> user's 4-way-handshake session, forcing a full EAP re-auth on the
> next reconnect.
> 
> Verified in UML: an unprivileged probe (uid=1000) sees
> SET_MULTICAST_TO_UNICAST (sibling op with GENL_UNS_ADMIN_PERM)
> return -EPERM on both pre- and post-fix kernels, while SET_PMK /
> DEL_PMK return -ENODEV from nl80211_pre_doit()'s wdev lookup pre-
> fix (proving dispatch crossed the genl permission check) and
> -EPERM post-fix (rejected at the genl layer as intended).
> 
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Fixes: 3a00df5707b6 ("cfg80211: support 4-way handshake offloading for 802.1X")

Good catch. Seems like good thing to do.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom>

> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>   net/wireless/nl80211.c | 2 ++
>   1 file changed, 2 insertions(+)


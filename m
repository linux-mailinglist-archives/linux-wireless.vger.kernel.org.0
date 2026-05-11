Return-Path: <linux-wireless+bounces-36221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHEECHCsAWoMhwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:16:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5F50BBCF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5849302011E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706C03C871D;
	Mon, 11 May 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBPdIqL5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4913C5529
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494420; cv=none; b=C4BmtTknJexaNCyvKofyHnaIygcE/32aSFhJUFBRjZ1qoszzg1nwhZo5/4FUi1oL+3RImXzRA+Xies8TuhEYJmvcMURF87bZ7mWFKGB4qZNppzvZKjTisk+NVvcNGPqOEA4n7eblRrBArv+8U/YjXvP9TZGmTpsgcBlAIgN+DFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494420; c=relaxed/simple;
	bh=ZSe1WM9GkxfcU2XH2njJDoyE4Vs9MxV6+egA23NmwZA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABuEhUCQeMvLP/3FxrrRdz9KHVM6iD7g+uq/PUQpcVUFKPRcNXvNNiOulcQd6Ufm3H5CeUVm31nYioA42kHQuS9ZeuS2tWdvcREjsCOXOnFplJI2TiySf5yDvwNkVTCs9mSw2egqOOXEd/4m44Gw9WKYHbJR+Ex0gUApMQIrvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBPdIqL5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80291e6237so2801071a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494418; x=1779099218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hVYHbC707lJbCSq9uPq5+h8+br2adm20wgf0NGFSTss=;
        b=HBPdIqL5+oc6lQpQG16iEevyAQkUsPqmtixvyZ8iwaF7tOqk7MWGPjnouIyHldG1Mh
         32+GPYvNfDCykEWN46OsTlkuVkqjaf1nqzZR8nXqaXhkFp4U7ennpUtN/rbvqkZ1nTFi
         ztCzIgzQV8eKe4IyYN4CMP9NHBESPkdWBsRBtTQst7zK+GLNsHR7zI7Syxcg0oulbrmY
         fRLewao9vab6eDcnTS5CrTmCmSFaY4wNOdRUAQ+FABJhjs2rhKmlm5bfac2jA7zW6+V0
         9VZMgYWwYPO/sqm4uZx20t2+w8m0AOiIx+t2JSr6qXV7WrWk0roODCttjjYoIn80X3nQ
         +6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494418; x=1779099218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVYHbC707lJbCSq9uPq5+h8+br2adm20wgf0NGFSTss=;
        b=IIfpY0/dq/YVqfYW4w9mln5nnORAdNF5r8QzP4a4lABO9wWs50G5fiE2AjOp6lJZUX
         1+gpbMzNEAMOryIqlO2fk3kEaXY1RBl+fUgCLyhm/6G8T8uaq/8W3f2VYEhVk9e9RCdR
         gp+6jBm+f8elRvQAhTAEX8NQAh6iI5yVxNVgSLQ48pYgrKBzW2bPH3KEyHCubcaYv1ks
         TBIthNdui1Khkr2DqQ7DKkGhnSXoybPJiAl47IY7gUowBiHhOuQa3Vb77eN9PPRnD+RO
         nTX6tKomnZiScuLw5BRHMdleLZ7ImfllPre3Br1VvgNjyJA3oz7WP4t8F15naDz3uKiN
         IHTA==
X-Gm-Message-State: AOJu0YzPxUS6gP3Cr4lWwU3/noHruyXjOAqt2kDPihnDXtkLOswy/uZw
	5v6FA8zkRGOHxnYSfPZFL/D/SPBXPEmjAEtE4DBeSsPR4JTjBMwmHcs7tMM54igDi04=
X-Gm-Gg: Acq92OHh5oy8/jV2aHsybh3A6sXxIY50355P8XUgw9IwfiwhA5xUL+aEDVqR0f3WpNy
	UHCke5LPvFCvtb0YnYqZho2Lb3WpwduV5WvBsfUOnJYxFsiWigxroLyiHJB5E7QEBdYevXzq5qQ
	2U0a4XL4Gv/iNNopQEDjbz1thIm6bCmR412sa7MjKZ7DC1i+Tx5enNMR0nv5scYzz+ziHUM0dXR
	3mN5LJYB2YO+lIvLUTO1SQ3cdu50bLscHRlwMv6nPcoB8nMKou/WouVCSQ8IHSsrEpWGJEVtIJS
	cEQdWh4f7c0e54ZYk4ZupnHvrrOPCikuHUjCMXCUlY0k96cEwGqPPVVqw7wyyGRHTtPIzpspDEk
	rYTBhn0nopnC2h5uoLX6oYe8YpGCfAqfRIzeixDBHGZrfJthSwFSywu0qvW9Hjf2kyjqQNiX+N+
	608YLDgSkhfMQl3Q==
X-Received: by 2002:a05:6300:8b0f:b0:3a2:7ef4:81e7 with SMTP id adf61e73a8af0-3aa5abc82b1mr26403276637.45.1778494418175;
        Mon, 11 May 2026 03:13:38 -0700 (PDT)
Received: from localhost ([2a09:bac5:4302:dc::16:19b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267723637sm8924018a12.27.2026.05.11.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:13:37 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 11 May 2026 18:13:10 +0800
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Subject: Re: iwlwifi: network not back after resuming from suspend since
 v6.15-rc2
Message-ID: <agGo8Hu-8Jw9lg9n@Rk>
References: <agFzc-Ngf_ZFXJ3o@Rk>
 <5d143832c8fdb8c39ee7daa5002cda9e5a26921e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d143832c8fdb8c39ee7daa5002cda9e5a26921e.camel@intel.com>
X-Rspamd-Queue-Id: 91D5F50BBCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36221-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coibyxu@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.com:url,opensuse.org:url,fedoraproject.org:url,archlinux.org:url]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:17:31AM +0000, Grumbach, Emmanuel wrote:
>Hi,

Your quick reply is much appreciated:)

>
>
>On Mon, 2026-05-11 at 14:49 +0800, Coiby Xu wrote:
>> Hi Emmanuel,
>>
>> I notice since v6.15-rc2, most of the times the network won't be back
>> again after resuming from suspend. And sometimes I need to run
>> "systemctl suspend" for 8 or 9 consecutive times to make WIFI
>> available
>> again. bisect and manual reverting show 15220a257319 ("wifi: iwlwifi:
>> don't warn if the NIC is gone in resume") is the 1st bad commit.
>>
>
>This is ... strange.
>Can you try to use our backport tree?
>https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/log/
>
>I am pretty sure it won't solve anything, but at least, it'll make it
>easier for us to work together on this issue.
>
>Also, may I suggest you open a bugzilla ticket on the drivers /
>wireless-intel component?
>As a starting point, I'll absolutely need the kernel log.

Thanks for the suggestion! I've filed 
https://bugzilla.kernel.org/show_bug.cgi?id=221501
with kernel logs after reproducing the issue using the backport tree
version.

>
>
>> Here are some other clues that may help resolve this issue,
>>
>>      1. An iwlwifi setting [1] can make this issue disappear,
>>         options iwlwifi swcrypto=0
>>         options iwlwifi bt_coex_active=0
>>         options iwlwifi power_save=0
>>         options iwlwifi uapsd_disable=1
>>         options iwlmvm power_scheme=1
>
>This is even more strange.
>
>>
>>      2. Before v6.15-rc2, the issue rarely happens. And if it
>> happens,
>>         simply suspending once can bring the network online again.
>> Other
>>         users seem to have experienced the same issue e.g. [2][3][4].
>>
>>      3. Suspending by "rtcwake -m mem -s 5" instead of by "systemcl
>> suspend"
>>         can make it much easier to reproduce this issue for kernels
>> older
>>         than v6.15-rc2.
>>
>> If you need more details from me, feel free to let me know! And I'll
>> very happy to test any possible solutions. Thanks!
>
>My problem here is that we seem to be talking about "the issue" but we
>don't know exactly which one... Let's start with a bugzilla ticket with
>logs.

Sorry I can only describe the issue as "network unavailable after
resuming from suspend". I've opened the ticket. Please let me know if
you need further info to narrow down the issue and find the root cause.
Meanwhile I'll also do some experiments like reverting the 1st bad
commit in the backport tree.

>
><snip>
>
>> I can't bisect against upstream kernel directly because v6.15-rc2
>> won't
>> be able to mount my root partition. So I manually reverted upstream
>> 15220a257319 ("wifi: iwlwifi: don't warn if the NIC is gone in
>> resume")
>> in v6.15 to confirm it's indeed the bad commit.
>>
>> [1] https://bbs.archlinux.org/viewtopic.php?pid=2227202#p2227202
>> [2] https://bbs.archlinux.org/viewtopic.php?id=301971
>> [3]
>> https://discussion.fedoraproject.org/t/random-wi-fi-adapter-loss-on-fedora-42-intel-alder-lake-p-cnvi/152878
>> [4]
>> https://forums.opensuse.org/t/wifi-suddenly-no-more-available/184399
>> [5]
>> https://github.com/coiby/kernel-auto-bisect/tree/random_issue_bisect
>> [6] https://github.com/rhkdump/kernel-auto-bisect
>> [7]
>> https://gitlab.com/cki-project/kernel-ark/-/commit/6453e892cf86c900d51f5884e9013e0dbeeea4ad
>>
>
>Those tickets are all over the place and unfortunately, nothing very
>conclusive comes up from those links.

-- 
Best regards,
Coiby


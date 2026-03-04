Return-Path: <linux-wireless+bounces-32474-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFG4FXFpqGl3uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32474-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 18:18:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B328F2050DA
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9F63073F42
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB48361646;
	Wed,  4 Mar 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjbnSbMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAF84039;
	Wed,  4 Mar 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644485; cv=none; b=HzEmZB1xYIdCdDxsJ45zoKLADkx7ONE4w+tS/KJZwLmAr2i2lvnxXhwcSNDixQLQyu+3vuN0w3fc3il/KE+m+sFyqQgmvAGCZYPTVAzXWZgNPY46DpK3Wt4yKEf+lTImTxbKIwQMVcjStZfQtOYPgZNMs9sWlAdM6YANU9N9pOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644485; c=relaxed/simple;
	bh=+oJjHKhWCbPsGXjJkJeOe7mOGQ8z0UHZlgUk21mKa4Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCT20oLRyHyIcPr5fLJbvtC8l2XG4ImsSx1x6tirdvw+4f53iUeRS2pOqnOXLneu1KT62M0uVHMpyrP8ux/+1xwUgJRAxe449iiHPmnNSRYbqP6psdYvPjBnSQXjbXcMsnijBgE1CTQZx+RN891Kt7DKMmNEbUf0spFjWvC81fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjbnSbMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FF5C4CEF7;
	Wed,  4 Mar 2026 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772644485;
	bh=+oJjHKhWCbPsGXjJkJeOe7mOGQ8z0UHZlgUk21mKa4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pjbnSbMAKSq7Q17bm6gxIzZUe7SLk8mJOqp24lZqrxoZOWP8muu+D8pvHgKzO/Hso
	 zNHz2YA6A/DENMS7RuxzRXMgnfwDqDyUpfQezziy0Ap//qNMbmCNSV+2AFTBx2b/bF
	 lZk3tFRWsnnoD/Y6DPYhMawbyVEPhTQDOytuTLcSbPSdOT0wrluWQScYcD3GTtRMQI
	 beJeqHGOcMDADjjNiJd3unhPCIi9qsX3oV8mYULON20/Lt77KvXsRpnmESYUxw7w+f
	 5qlnayHrNGao6tUV8YGfVEJkmy9Yy7AssjsivktmQADAJIEnUrM70R1Cr5hZccSwEI
	 Lb6PfUTLYABZQ==
Date: Wed, 04 Mar 2026 07:14:43 -1000
Message-ID: <68c1ca1381d1871fff72b211890a64eb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Korenblit@web.codeaurora.org,
	Miriam Rachel <miriam.rachel.korenblit@intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item
 is active.
In-Reply-To: <de003dc3-3e37-f238-4250-2df16eeb77d6@candelatech.com>
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
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Queue-Id: B328F2050DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_SPAM(0.00)[0.942];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-32474-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

(Partially drafted with the help of Claude)

On Tue, Mar 03, 2026 at 04:02:14PM -0800, Ben Greear wrote:
> Could the logic that detects blocked work-queues instead be instrumented
> to print out more useful information so that just reproducing the problem
> and providing dmesg output will be sufficient?  Or does dmesg already provide
> enough that would give you a clue as to what is going on?

It may not be exactly the same issue, but Breno just posted a patch that
might help. The current watchdog only prints backtraces for workers that
are actively running on CPU, so sleeping culprits are invisible. His
patch removes that filter so all in-flight workers get printed:

  http://lkml.kernel.org/r/aag4tTyeiZyw0jID@gmail.com

Might be worth trying.

> If I were to attempt to use AI on the coredump, would echoing 'c' to
> /proc/sysrq-trigger with kdump enabled (when deadlock is happening) be
> the appropriate action to grab the core file?

Yes, that's right, but you need to set up kdump first. The quickest way
depends on your distro:

 - Fedora/RHEL: dnf install kexec-tools, then kdumpctl reset-crashkernel,
   systemctl enable --now kdump
 - Ubuntu/Debian: apt install kdump-tools (say Yes to enable), reboot
 - Arch: Install kexec-tools, add crashkernel=512M to your kernel
   cmdline, create a kdump.service that runs
   kexec -p /boot/vmlinuz-linux --initrd=/boot/initramfs-linux.img \
     --append="root=<your-root> irqpoll nr_cpus=1 reset_devices"

After reboot, verify with: cat /sys/kernel/kexec_crash_size (should be
non-zero). Then when the deadlock happens:

  echo c > /proc/sysrq-trigger

The system will panic and boot into the kdump kernel. Note that the
kdump kernel runs with very limited memory, so you can't do much there
directly. Use makedumpfile to save a compressed dump to disk:

  makedumpfile -l -d 31 /proc/vmcore /var/crash/vmcore

Most distros' kdump setups do this automatically. Once the dump is saved,
the system reboots back to normal and you can analyze it at your leisure
with drgn:

  drgn -c /var/crash/vmcore

Thanks.

--
tejun


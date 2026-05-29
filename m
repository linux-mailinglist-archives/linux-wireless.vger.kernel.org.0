Return-Path: <linux-wireless+bounces-37123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAwBNCuAGWrVxAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 14:01:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F6601F41
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 901313048C2F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E273DEFF5;
	Fri, 29 May 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="n7d4JQcH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCE3DCDBB
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056096; cv=none; b=JNQdm91KCAh85FIkDUCLwa3LdFCQJ363l8+mBji02c0iz+siWSt25q/uSaxk51OblbzPW14Fnoh0kQEsB7fP/L1+fNpR+oQV+XZCR1kDMthzP3Rt4ttw8LxztR7OoNexcsLhnapVQLJr3BdneZlwPY9HnNlxduUJ4d0vu+mIkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056096; c=relaxed/simple;
	bh=AxY9oUjwJf+NaYORmqqPFF9Ol1uZACxBmLhHdv35SrU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JlmhYvoSaGFasMryi7lXxJvo64sb5alQv7zV3iMPGWEWv9Hi9pYBLKlgjXX88QCdOp2jmjFY+C6D1xtmURy2oXLkFpEoLYgOBuOIy3w6B0zz8fSSzUY4rb74tWvTGi9Aw9bRXGFaXtpK3LQYzpM4R4qfnPz45gS3BACegiCGW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=n7d4JQcH; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1780056087;
 bh=e2SkCPNZ6JzNXUa5syAvbrprqabqIg5XAoAZSpduDp4=;
 b=n7d4JQcHUUOHt0EOkYOb/GTlWBxN2uoZPimUAeqY5B0OLcvazvoUVwFRFRM1faywc8HEEmmTj
 bhKxGip1wtfURzUnnx+2Q3ZOL9wJE8xtYEZA30kq+VZXKG8egzdCZWem1PJrnuGBitmeUPYJYxH
 9fNzI0A4F1ur+gMg+4SLoG3on8qJXrZ/g49WIPhmhbzW1/UiHsqfzqDHBxhkyWnpsT+YYaTcocF
 ufCYO7KuPajC/YnI8C4O5FMtZztIs6ZK3Yu59NnkJCRdg0i5jXxbU57W7E9yRT9AO8XQ2clfALq
 dcX7qBSUPocM1Ww245kaf7ut1QJeAX37Aph+1EZPoW3A==
X-Forward-Email-ID: 6a1980155cd4cf91a6546360
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 29 May 2026 08:01:24 -0400
Message-Id: <DIV57VXLLBHC.1GLCJC1209Z31@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Alessio Ferri" <alessio.ferri@mythread.it>,
 <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Cc: "b43-dev" <b43-dev-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
X-Mailer: aerc 0.21.0
References: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
In-Reply-To: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:email,ubuntu.com:dkim];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37123-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[ubuntu.com:s=fe-953a8a3ca9];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	DMARC_POLICY_ALLOW(0.00)[ubuntu.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ubuntu.com:email,ubuntu.com:mid,ubuntu.com:dkim]
X-Rspamd-Queue-Id: 895F6601F41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu May 28, 2026 at 1:31 PM EDT, Alessio Ferri wrote:
> This series completes b43 support for the Broadcom N-PHY revision 8
> paired with radio 2057 revision 8. b43 already supports the surrounding
> PHY family - N-PHY rev 8 with radio 2057 rev 5 and rev 7 are handled,
> and rev 16 with radio 2057 rev 9 is handled - but the rev 8 + rev 8
> combination falls through four dispatcher gaps:
>
>   - radio_2057.c, r2057_upload_inittabs(), case 8 lists radio_rev 5
>     and 7 only;
>   - radio_2057.c, r2057_get_chantabent_rev7(), case 8 lists radio_rev
>     5 only;
>   - tables_nphy.c, b43_nphy_get_ipa_gain_table(), case 8 lists
>     radio_rev 5 only;
>   - radio_2057.c carries r2057_rev8_init[] as a 54-entry stub commented
>     out with "TODO: Which devices should use it?".
>
> Two further pieces of plumbing are needed to reach those dispatchers
> in the first place: d11 core revision 0x16 is missing from the b43
> bcma id table, firmware name, and the corerev 22 / radio 2057 combination
> needs the 24-bit indirect radio access path that brcmsmac uses for
> the same silicon generation (see brcmsmac/phy/phy_cmn.c
> read_radio_reg() / write_radio_reg()).
>
> The series:
>
>   1/7  b43: add firmware and initvals names for rev22
>   2/7  b43: add d11 core revision 0x16 to id table
>   3/7  b43: route d11 corerev 22 to 24-bit indirect radio access
>   4/7  b43: support radio 2057 rev 8
>   5/7  b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
>   6/7  b43: add channel info table for N-PHY r8 + radio 2057 r8
>   7/7  b43: add RF power offset for N-PHY r8 + radio 2057 r8
>
> Patches almost reveal the bringup, the first two are swapped, as
> applying 2/7 without 1/7 generate an immediate kernel panic caused
> by a null deref.
> From the third, each one fixes the next visible failure
> in bring-up: 3/7 lets phy versioning read coherent radio identifiers,
> 4/7 unblocks the boot-time radio calibration that otherwise stalls,
> and 5/7-7/7 fill the remaining 2.4 GHz dispatcher entries so
> b43_nphy_set_channel completes to the default channel and core_init
> proceeds past PHY init.
>
> Tested on a D-Link DSL-3580L (Broadcom BCM6362 SoC, single-die 2.4 GHz
> N-PHY rev 8 + radio 2057 rev 8 in 2.4 GHz IPA mode).
>
> b43 is currently Orphan in MAINTAINERS. These patches do not add a
> new chip family or PHY infrastructure; they fill four explicit
> dispatcher gaps for a combination of an already-supported PHY and
> an already-supported radio.
>
> CHANGELOG:
> v4: reword patch 1/7 commit
> v3: no changes, fighting with b4
> v2:
>   - Recovered the first patch of the series, so numbering is now /7
>   - Added Assisted-By header
> v1: https://lore.kernel.org/linux-wireless/8c0a07d2-9ec9-43d6-bdf7-f625bb=
b4a38a@mythread.it/
>
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
> ---
> ---
> Alessio Ferri (7):
>       b43: add firmware mappings for rev22
>       b43: add d11 core revision 0x16 to id table
>       b43: route d11 corerev 22 to 24-bit indirect radio access
>       b43: support radio 2057 rev 8
>       b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
>       b43: add channel info table for N-PHY r8 + radio 2057 r8
>       b43: add RF power offset for N-PHY r8 + radio 2057 r8
>
>  drivers/net/wireless/broadcom/b43/main.c        |  22 ++-
>  drivers/net/wireless/broadcom/b43/radio_2057.c  | 230 ++++++++++++++++++=
++++--
>  drivers/net/wireless/broadcom/b43/tables_nphy.c |  58 ++++++
>  3 files changed, 290 insertions(+), 20 deletions(-)
> ---
> base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
> change-id: 20260521-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-a31=
25f06e21e
>
> Best regards,

I'm assuming the extracted tables are correct (it would take me a while
to check) - and as mentioned this only is an addition, not a change, so

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>


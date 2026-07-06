Return-Path: <linux-wireless+bounces-38690-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xtGJITnWS2qRbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38690-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 18:22:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE367132D1
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 18:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IHOQOImP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38690-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38690-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66DEC302B754
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8E37882A;
	Mon,  6 Jul 2026 14:08:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E442BEC5F;
	Mon,  6 Jul 2026 14:08:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346913; cv=none; b=Yir4cy1M+h3zRKbPqwCFCaoczy6NfkIYi/8phn73jtvTVH/MgIL6uTXA4qjiKDUkXMu9kE4W02HuTkJNG4VL1T9R6jgw14gsB4Rf/wrVie/k/lkifCJMmRFe0KWpZWfSZVjBTmNY/zIktefsZglFTOGcSipiID9fl86IMz1urA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346913; c=relaxed/simple;
	bh=omFLfqHUMtKGYUCSITPWHFqJ+Ge4dFOsW3TBIjU3gVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyPY5TcLtlr3LtMIeFW0mvXOfsJCUrP6wsFgDYoeUb1VpAYKmvDEd/yfxZ4xZszKB+ZbdRNQ2dMj6PL6dneOGkNAZYmzuJ/UwalIP+GUEA0U+XQwGG8R9nBjRR1Zr8LuBUFEFVQKt1RVueigmJBlprIJvIICwe1zt0RbMx419Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHOQOImP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E831B1F00A3D;
	Mon,  6 Jul 2026 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346911;
	bh=q8+MGqf6q/NjxeYoH9XtM00SPb6CU+uTf/7HC064t/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHOQOImPKLRO/2IJTruEda7JV+JW5MVwANnHnnu3CJwAat6r//4ICi+MHJ/iCOM7h
	 R3uw70Y6fVOpmJG6bS3J0yJiped6pg+2BMmi4wruVsWZT0/KczzabLwn1wonJ9bF3c
	 rx355/27cmiFEV1e4YXsp1CwaGNFGWjKyYO/gG3EJym4E92BxadFQ+ozNyNbdi/EDd
	 G2XhWs5c2FnyRN1gWSzpuh/iDmoIWfzuTW42o8zBtNQTWxWbGZmChhRUhvpwdJ7m2b
	 i2ECLse1VPUCTDAkamN/6LKKwQxgL3/MMccPKplzDjrlfoLnl2CltVvKcfAH66wpT8
	 +s5eISYqi0TiQ==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 5.15.y] wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Mon,  6 Jul 2026 10:08:22 -0400
Message-ID: <20260706135124.draft-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706102512.1429947-1-arend.vanspriel@broadcom.com>
References: <20260706102512.1429947-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38690-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rob_garcia@163.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:duoming@zju.edu.cn,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:arend.vanspriel@broadcom.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDE367132D1

> The upstream fix uses timer_shutdown_sync() which prevents the timer from
> being re-armed after it returns. del_timer_sync() does not have this
> guarantee.
>
> brcmf_btcoex_handler() has three mod_timer() calls - two in
> BRCMF_BT_DHCP_START and one in BRCMF_BT_DHCP_OPPR_WIN - none of which are
> guarded by timer_on. A work item running between del_timer_sync() and
> cancel_work_sync() can re-arm the timer, leaving it pending when kfree() is
> called.

Agreed on the analysis. One thing to note: this backport already
shipped in v5.15.210, and 6.1.y shipped the same weakened
del_timer_sync() variant in v6.1.167, so this needs follow-up patches
rather than a v2 of the original.

> If the mod_timer() calls were made conditional on timer_on, setting
> timer_on = false before del_timer_sync() would be sufficient. That would be
> my preferred fix. Alternatively a second del_timer_sync() after
> cancel_work_sync() would also work.
>
> Also the commit message still mentions timer_shutdown_sync() rather than
> del_timer_sync().

There's a simpler option: timer_shutdown_sync() is actually available
in both 5.15.y and 6.1.y, so the del_timer_sync() substitution was
never necessary in the first place. A one-line follow-up converting
del_timer_sync() to timer_shutdown_sync() makes brcmf_btcoex_detach()
match the upstream post-image exactly, closes the re-arm window you
describe, and avoids a stable-only divergence guarding the mod_timer()
calls.

Robert, could you send follow-up patches for 5.15.y and 6.1.y doing
that conversion?

-- 
Thanks,
Sasha


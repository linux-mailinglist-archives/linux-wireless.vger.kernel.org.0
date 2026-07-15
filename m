Return-Path: <linux-wireless+bounces-39117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XDQsDJbQVmoBBgEAu9opvQ
	(envelope-from <linux-wireless+bounces-39117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 02:13:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A155E7599D0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 02:13:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aU3asLrJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39117-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39117-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C10330DC8CA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711915A864;
	Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04F7082D;
	Wed, 15 Jul 2026 00:12:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074369; cv=none; b=auhmBU3FnbK1stAQI2kywuSFyllJMbHkKuU4YYNzHX3Fi5uIqrs9l3eODJ2OWr6LRRZx1VZV8ULE0hZQbP7FReliWIOmPehC3CW6Z+l9z3fHvPPvVP/T6nVVIIKjwswrwziE3k/Br+0aQ9L1Gyw5pzx0ElQlSJOSi3IP12sum2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074369; c=relaxed/simple;
	bh=vGOWa1lG7tlQZu5N2J6/lJmsJbJlDZzFE4q67DuTfK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXVjwL9QeuhePnuFFLdwgMiZDILTlXkzxm3aA9X7wlBHOlfboq+pjLd6ZK9kMlFPLK9ElUjX8RiNSk4NnGbbJvD7iGdSydXhOdSkMDadhDjxYcUs8oTnBL1OAXLYtnt8fb28GvB2WcUykHhCt1TrBE4BCrwd4LZBVkbyQDR3pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU3asLrJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43501F00A3A;
	Wed, 15 Jul 2026 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074367;
	bh=n7m/GGbqac2Mb0792REfaI6YRuOV/e795EdrpgrNV6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aU3asLrJgyQAlwAnJv4HHEqGY8JOFwYW2Ui5dD2aWaMuAFI4zmBaSCjTl4B0Hiafp
	 l+jqIZ98AThbMijEsycmIx8CDR4Y8tInluRXmofoLq8pNXBItUfN6OH0aMREOzCMMP
	 COhQwwC9VX8qpDn8VvKQE2EEqbTW8e3mqmjVFeQIX3RSGgDetssWVx4jsI60bagguu
	 ulCCrDRc7P5cUu1wiZ610skD4IICtJF7LMxdbTwvCLn8QTYD47EKmusS5CfvSBS3vy
	 mZrWaIc6MT64Ts6jStP3W8wI5ZXPTQEMrZgGlkUMzuQkCUYj1Vc0rb2ljtG0Mr2gT6
	 /7sEDuc1F6BRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: Re: [stable backport request] wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon
Date: Tue, 14 Jul 2026 20:12:31 -0400
Message-ID: <20260714200600.stable0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713180433.52394-1-ismailtarim7@gmail.com>
References: <20260713180433.52394-1-ismailtarim7@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-39117-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:ismailtarim7@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A155E7599D0

> Please consider backporting the following mainline commit to the stable
> trees:
>
>   commit 351dd7d2c80d ("wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon")

Queued for 7.1, thanks.

-- 
Thanks,
Sasha


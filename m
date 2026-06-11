Return-Path: <linux-wireless+bounces-37643-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vf7oFEcFKmpchQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37643-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:45:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EA66D885
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:45:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=crLZqNOv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37643-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37643-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CC1A300D4FB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE01519B4;
	Thu, 11 Jun 2026 00:45:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67A1E7660;
	Thu, 11 Jun 2026 00:45:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138757; cv=none; b=e4LwkCGMV5YZqIulOl3Usy7WSf/LqM1rCTeajwRfkVb6bynGz1Wii05mnfheTDoNV2/ozI2Yswrjg9jRRUZrGBZ1DN0YpjOhtArj1UAzZWUZTBa8//4DXC7FXN+GOaS5XXtToOw1LECiFe9iZqcN/YbOVh8lXNZQrnsClyr27zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138757; c=relaxed/simple;
	bh=gScZvmFNCIbsaB8hGl7ro2smwAQIdPTmDjW80PbH9fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL78JxHkt5ZoXk10aDTFEOTBvwkrh5etG7eGQjMT1pdHiXndxBPVBFv/z8k63N0UuK3Lu6njXc1JhNdi/9ATtG9UuxgcVwuq4LsFzDp7eLpOVqCE7Y3IHHPxYbfF2+qjNSn2scUCEwBBse5OGXoKxPRNohfnIZ8hHvZkn400nkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crLZqNOv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C991F0089C;
	Thu, 11 Jun 2026 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138746;
	bh=Rz7r393CVmwuTcN3F9sCaR4ab1crKIHvHMF5mdpAUTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crLZqNOvmyJv3eoUlKUEUP18KLvhdS0jCyGR4YdF1vmp+YRTTC+kwJOSHK0kUhQyn
	 za35zlMKACIojmV769SaNBV/Yj+Nd5BdwWQ53Z5Wi3jGQSArOpI8kV+Ju6YmSwjpjo
	 gkAZ7khknpF8mlCJbufeWKaAIcuyv6PgSCLiig+HiInNSbnXLnWXDIOwmEcF5iRA60
	 ymSQvMEM0e9/IK43L+p0HqKke8HpI6ogiNgvZ5Y/kbHEh54GiI/QhaocaZZkWql1dJ
	 jlFcaqJ3xXkFWOEvO1+isajJXSzmDVAiAmv2uHTWVGHlIoTq+nbeZl8m1JUyncR2s0
	 sHP+YknEOxlcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: Re: [stable request] mt7921e: backport two mt76 fixes to 6.12.y
Date: Wed, 10 Jun 2026 20:45:27 -0400
Message-ID: <20260610-stable-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610080943.17734-1-rauty@altlinux.org>
References: <20260610080943.17734-1-rauty@altlinux.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37643-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:rauty@altlinux.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E92EA66D885

On Tue, Jun 10, 2026 at 11:09:43AM +0300, Ajrat Makhmutov wrote:
> Please backport to 6.12.y:
>   2425dc7beaad wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain
>   5ed54896b6bd wifi: mt76: mt7921: fix a potential scan no APs

I'm going to hold off on this one. The second commit, 5ed54896b6bd,
introduces a reachable dev->mutex self-deadlock on STA-remove-while-ROC;
the follow-up that cures it (d5059e52) isn't in any stable tree and was
never marked for stable (it's only in linux-next so far).

So taking these two alone would queue a deadlock. If d5059e52 lands
upstream (or you can confirm it's headed to stable), please resend the
request as all three together and I'll take them for 6.12.y.

--
Thanks,
Sasha


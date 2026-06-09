Return-Path: <linux-wireless+bounces-37547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sFpVHBpkJ2o2vwIAu9opvQ
	(envelope-from <linux-wireless+bounces-37547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:53:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94B65B755
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bAIgxeiN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37547-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37547-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F1F5303BA3C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 00:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259B2DA765;
	Tue,  9 Jun 2026 00:52:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C389265620;
	Tue,  9 Jun 2026 00:52:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966341; cv=none; b=GFuCPxnXzVWX8DLBFHtURkta0mPH/COzLuAHDMXObWSe+vZ/dAUBrty32giBdb/6ObV4RiVUWNW+t94CNG/E6Me/6BOacBBT/EOJgy91Zl6PcR5QVgxHAx+IRUBiGDFmcubt3uCWl7EX7UiblKZ0YA2r3IuZuRaURqFxHafuNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966341; c=relaxed/simple;
	bh=h7sRxlF8QUT/ED56jne3FRSt+5m6QitoR/LjFdcTuzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwcarbcp8cCF95xdwViszDWetLlSA5Qqf6UU9iTUmfT5QrTZOjyDNfCrJGR4cH6fu7k4PNAXSnooB8rPfKQq40tsWlO2BCEwoRTfp+ylpQtVy7ME4aG1UkNtKQ4vmf1FebUM4bjWM9jY7UsRfXPoNac6zaeDTxKsVDgaz9XUQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAIgxeiN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E71F00893;
	Tue,  9 Jun 2026 00:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966340;
	bh=h7sRxlF8QUT/ED56jne3FRSt+5m6QitoR/LjFdcTuzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bAIgxeiNnB1w7+V1aCZro6NkhnVrf4Kb/f6+3HsmIyG7IcgRV5g5ILY7bR6ID/QHp
	 GmypvjgwqLtoJ9R636603hUcPY+Y21ABxACr16aQlNPGvWdffj03fc5XClyllDPg32
	 CGdSSz5pLoCqmmBDO5Vnbw9USyUlR7a807wS7Rnhxz2gQ/JsDfFCpEgZJt3wP3GXlM
	 Tl5wS71qwKM3EiwlzL+YMXuiZMKWqJwNLDK+cPiKqjCyhTpWdv7kOKoMrF1nkzi4Mk
	 o5SfOytd1xbIGqxyOMJJYqVQcgC6hq2E5+Fm0O9tZKZz0gUW/pInqBESxxKn+MUgTF
	 y/FNAnVEUo2KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	yichenyu@google.com,
	kernel-team@android.com,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,
	Carlos Llamas <cmllamas@google.com>,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	"open list:802.11 (including CFG80211/NL80211)" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] wifi: remove zero-length arrays
Date: Mon,  8 Jun 2026 20:51:57 -0400
Message-ID: <20260608-stable-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608133216.1396790-1-cmllamas@google.com>
References: <20260608133216.1396790-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37547-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:yichenyu@google.com,m:kernel-team@android.com,m:johannes.berg@intel.com,m:syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,m:cmllamas@google.com,m:lachlan.hodges@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,fd222bb38e916df26fa4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E94B65B755

> [PATCH 6.12.y] wifi: remove zero-length arrays

Queued for 6.12, thanks. I dropped the leftover "Change-Id:" trailer from
the commit message while applying.

--
Thanks,
Sasha


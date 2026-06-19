Return-Path: <linux-wireless+bounces-37913-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iDc0GeXANGrygAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37913-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 06:09:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2936A3BF2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 06:09:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i6YaYO2S;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37913-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37913-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC323029AC4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 04:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747D328635;
	Fri, 19 Jun 2026 04:07:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508D3264DA;
	Fri, 19 Jun 2026 04:07:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842033; cv=none; b=iJdvqE+ty28FiO3oAd8T8y95xYD2wpxUe7HMFOrCEkd3Knffx2w7P72oWnt5yuAComDRvV9mihl8p0rG2o41bquPnxUfuZQISql3zWn8STejTOwqZxs8GXk1fMuiJq4AtCXUhiwkwkOv4OHYD1yqYezqKJbmz2G9IyT9qnkk9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842033; c=relaxed/simple;
	bh=BNPsSlcWM5VwVn650MixKKW+g0DRFmT2V9H+eER7ZkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNQdN6CBRuB0BED1i+QjgfUZWP/kIsJIYqMMvfRFgcB+T/4b6QxTjM0bEveXgO8N4t4o5hFS7X3kRy6nUMXz9Q1Ygi4r9PJyNPI0H4lVC2w6+tTz31Vucs2BtRIFbhRxFjcdheLwQeTEp9+yfAc/qm4VVN0JEWAhHwcPBaczUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6YaYO2S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE8D1F000E9;
	Fri, 19 Jun 2026 04:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842032;
	bh=STZMxVNasNP111QrobD1YWuR6RIGnTRQqos5R6ylo3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6YaYO2S3katfP2zO18DYNdfejLoB8qDWcm7qPcev4uAu38JiAmyScbuE7xCgX+R0
	 L6P/A/I7BKcaIkqH3s+IYamgba6Is7YEN/c4WFRoZL/3LxlzLg9KVJix1jClxha+52
	 t+WCREldmYVZaGcxiVdvIq/6zsLBIev7YUFurDRjZXmWMlD4VRjjwjd0gxstofkdqd
	 QIJy2Wvf0JcSTyyZMjaNEGMGpyRronMz6OzoJ7iEZpa8MR4vIWTwm1RCjIXxMFF1n2
	 xywuIYdMbnnBIfVcVATuzKhQJzdPpMQWUkC3PEIOlO/niuCdthT2F6nWXGDrF8d31O
	 pFmMYnyoc72QQ==
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: Re: [stable request] mt7921e: backport two mt76 fixes to 6.12.y
Date: Fri, 19 Jun 2026 00:06:56 -0400
Message-ID: <20260618-reply-item001-mt7921e@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <66552f9d-f5cc-4070-bde5-6417a41eed96@altlinux.org>
References: <66552f9d-f5cc-4070-bde5-6417a41eed96@altlinux.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37913-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:rauty@altlinux.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB2936A3BF2

> Please backport the following mt76/mt7921 fixes to 6.12.y:
>   - avoid undesired changes of the preset regulatory domain
>   - fix a potential scan no APs
>   - fix potential deadlock in mt7921_roc_abort_sync

All three are now queued for 6.12, thanks. The roc_abort_sync fix was
adapted to keep del_timer_sync(), since the timer rename is absent in
6.12.

--
Thanks,
Sasha


Return-Path: <linux-wireless+bounces-36826-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFRQDGWoEWqDogYAu9opvQ
	(envelope-from <linux-wireless+bounces-36826-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 15:15:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D915BF011
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 15:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2573013A5C
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDA39768D;
	Sat, 23 May 2026 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="N44wmmFd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8621B192
	for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779542114; cv=none; b=fAr8p5m3R9A4djgFOTAH+/hLLqUwO9v4k835gtllWEkOBihX7rLpuBZ0LshengXjA6dVrcDcPFzr4pfE7kr5H7s8bDRcEAaoxP5mLn9NUlAO05e7DO5RaHoP+kNcUVIu8hIlM67SUX72zsVfdC5vHOIrpTIXNZuypg3HPUxmAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779542114; c=relaxed/simple;
	bh=Eu5eLLAHHTEGA+jKGeKWDtMKrGO7f7F9TrucMPp2eFw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oq4tkuRPKJwJwL4p/C5F30CY3sp+VEAIn9nqnzwPdLqmsp+ygQFes6Al8/xmqwz8SgHLUyFCT+pxFjK/8zEitAde7S8OsRL+xJ+NWWG1BDEQ4O35o+Ow/dbX1wVWTmE9bztTorTZiM3Rb6hlnZZ1zFkmRluvGxl/YZXmWDNqQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=N44wmmFd; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:25b4:0:640:a124:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 12A2081181;
	Sat, 23 May 2026 16:09:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp) with ESMTPSA id c9Vn5vMfiSw0-QryM3SAI;
	Sat, 23 May 2026 16:09:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1779541781; bh=ulSpyMaOuPtUjE/kaMsyodJ8z51dXOLCMvbX66Q6rnE=;
	h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
	b=N44wmmFdnqkjkKXZAqBOogamNYjJ2FWlu12hCeniPiEE3AssJyddJla+YF1s/OiQ2
	 eVwWrbFoQbjJ7bBJV41fKqZJjYlU+7R2ZeCYB2q1aBKI6gan4m4igJ2aKmL2vTjwiD
	 mGk7wXWqgVY78znzxL+tIFHHw/a1clsrBJXl5Z88=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <17ef89cc-32b6-43f4-831a-ab756c6b5e3a@0upti.me>
Date: Sat, 23 May 2026 16:09:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: shayne.chen@mediatek.com
Cc: evelyn.tsai@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name,
 ryder.lee@mediatek.com
References: <20251215063728.3013365-7-shayne.chen@mediatek.com>
Subject: Re: [PATCH mt76 v2 7/7] wifi: mt76: mt7996: fix iface combination for
 different chipsets
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <20251215063728.3013365-7-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0upti.me,quarantine];
	R_DKIM_ALLOW(-0.20)[0upti.me:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-36826-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[0upti.me:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@0upti.me,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0upti.me:mid,0upti.me:dkim]
X-Rspamd-Queue-Id: 76D915BF011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey folks, this looks like it broke mt7996 init entirely with stable kernel 7.0.10.

Specifically it trips this check in net/wireless/core.c:681:

	if (WARN_ON(types & BIT(NL80211_IFTYPE_ADHOC) &&
		    c->beacon_int_min_gcd)) {
		return -EINVAL;
	}

I'm not sure what the correct fix here is, but unsetting beacon_int_min_gcd at least makes AP mode work again...


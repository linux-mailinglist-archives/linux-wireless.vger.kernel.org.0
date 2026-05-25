Return-Path: <linux-wireless+bounces-36883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP42CdlbFGpxMwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 16:25:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C15CBB21
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C56F301EC5C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20403909A6;
	Mon, 25 May 2026 14:25:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D33ED127
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719106; cv=none; b=iWCVwd9lh1LDtAssID/Kk0PxkJG5KGUCZ5CcL1vkjwY4DQMPdyhw1roEeEM9p1hrJd22h36g7VBF7s2hGWABR3YKpaRQjWgFZLKOJZp6QFDq15vk9ExQVNTp2IcBJWQ5MHt44MFXC7OI6v18Ord+xVMW5vbkmqTh/JnKBJ3kmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719106; c=relaxed/simple;
	bh=tIaLFX6wDvz8omqyixFH0407VovWexTGXfAx6MM8XwE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F8hmhUleBkT425xCqsEy8rvUG7s2ZHNmy1Wcm74n8eY9YOTvZSO666NKT9NAfTo77WemVRPHwPVOouC8275raqt/VuqLavo+bWohmw1eMWH9jAqMxjv0/kZaett1FvJVwaKK8uZrt5DRdvdYnPwW+wLjTzv0GcFcJmNtXRcNcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.128.234] (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: petrykinpa)
	by air.basealt.ru (Postfix) with ESMTPSA id 6EB1B23388;
	Mon, 25 May 2026 17:15:24 +0300 (MSK)
Message-ID: <93addbb5-7097-4f6c-a21b-920fa44e7cff@altlinux.org>
Date: Mon, 25 May 2026 17:15:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] mt7921e: Intermittent connection failure
From: silverducks <silverducks@altlinux.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
Reply-To: silverducks@altlinux.org
References: <59f58f03-6dee-4380-80d6-7e2778b5f14b@altlinux.org>
 <f264b392-37bc-4b31-ac0e-768466f2b962@altlinux.org>
 <CAGp9LzrfD+a84ZVGjUnrv7KYCpgfe88NyrXos8wW8U7aKM8BZw@mail.gmail.com>
 <651b9626-0c2c-4993-829a-3259141109dc@altlinux.org>
 <ddb70af0-b3b1-42c3-9459-ce41914c4d20@altlinux.org>
 <CAGp9LzoEaNuQf7+2i5QZi8f44zQfxpWGJiW0WgYrAZhT2a9D+Q@mail.gmail.com>
 <4d4f7e6a-b887-4541-9928-0f255bc61ee7@altlinux.org>
Content-Language: en-US
In-Reply-To: <4d4f7e6a-b887-4541-9928-0f255bc61ee7@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-36883-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[altlinux.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[silverducks@altlinux.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[silverducks@altlinux.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,altlinux.org:mid,altlinux.org:replyto]
X-Rspamd-Queue-Id: C08C15CBB21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings!

Update:
As of kernel version 7.1-rc4 the error is no longer reproduced.


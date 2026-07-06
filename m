Return-Path: <linux-wireless+bounces-38661-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3UY3CpZ1S2o1RwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38661-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:29:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7170E9BC
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=w16OV5Is;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38661-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38661-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2C631EE198
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785241737C;
	Mon,  6 Jul 2026 08:44:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A52400E09;
	Mon,  6 Jul 2026 08:44:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327469; cv=none; b=oPtxBTNh9sJMyf6Mxbl0h4HgxVf/8zjuAzah/rud1Mt/4XjNvl5VKJV9XbhhZyZ52YDwBvMkOTSSLPDEhQ3smIS0JKyQOrZt32Ns/8NWBrMEwZuU7Muk4f0vjAKtIsd6lzUreOZrfdsRFSMCacMD/N5EpvvDWF4sQxjiL5dTKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327469; c=relaxed/simple;
	bh=1n/RyvXa/XOQGkNV/CMCDrtaZ6yiUuhtqlEng7BfU3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqeFHlqBKVyvpfe5cxs5yK0anF0vxGLiktNftLBXrRYtgy1SO91Wwx8Fh4AG7+2aadQcmynMFw0QYri1ipbVkGK+TVFaGsbnYxzhhCjUaLFV2sdw4iwtgubU6b7vJcW7OforcAiCuO8VHXnrYnamiy/CGSig1l3Rj9O39L0u06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w16OV5Is; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1n/RyvXa/XOQGkNV/CMCDrtaZ6yiUuhtqlEng7BfU3k=;
	t=1783327464; x=1784537064; b=w16OV5IsnRsjjbgyEc27kdzt6lZ6q8nNJ8NOYDGFWUH+mQk
	hMNhUCy0WtZ7lX7aozWUPEvryFLqxNbfxwrKYJk7GI5KiauGIY8GZS8zJz8q//i+PfCKRKW37AYXu
	WuDYfd5xA60Sa303ycY4uAS9JBkg5Gk+/9zRBf0Ji9cssbkMcr1AXTL8Ndbukc7POxbzuXcrltVqy
	7Oucg6talmR1cbIncAcdhKXsozjEN00zHZ0U21WeAEh57pnu/QTrepZ4CXcYJ3Djf8wVCn8kCk2dd
	dd6bZTnvfJnq2s/AZ4VIbrtvOuCZD3gk/z/5K2jws634ssjPc4nZWxyJ//N3xmPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgevy-0000000CfyZ-3L4C;
	Mon, 06 Jul 2026 10:44:11 +0200
Message-ID: <fa2f4ef633510a157534c401e15b3ddacbacd4db.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 06/31] wifi: mm81x: add core.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge
	 <arien.judge@morsemicro.com>, ayman.grais@morsemicro.com, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 10:44:09 +0200
In-Reply-To: <o5cnnv4t7je6l4d3re6cifwb6v5ox3znje7hqmy7ebkktt5iak@4vtrqqfxx3iq> (sfid-20260622_081024_838436_4A85067B)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-7-lachlan.hodges@morsemicro.com>
	 <f6dbd068437564e18695b1ef263ebba27ad7fab0.camel@sipsolutions.net>
	 <o5cnnv4t7je6l4d3re6cifwb6v5ox3znje7hqmy7ebkktt5iak@4vtrqqfxx3iq>
	 (sfid-20260622_081024_838436_4A85067B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38661-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67F7170E9BC

Hi,

Sorry for the delay. You probably already decided, but FWIW

> since the kernel (AFAICT) only has a single host endian structure.
> However I am a bit cautious about redefining elf sections here since
> I cannot find much precedent in the tree. it does mean we don't need
> to use __force. Of course we could also do what you wrote above and
> convert in-place using __force to the host endian struct. Do you have
> any preferences here?

I don't really, though I'd probably try to capture this in as little
code as possible, perhaps a single conversion function.

> Seems most wireless drivers have much simpler
> TLV followed by blob firmware loaders.

Indeed, why bother with anything more complex if you get to define it,
but maybe you don't get to define it.

johannes


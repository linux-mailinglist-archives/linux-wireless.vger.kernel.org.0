Return-Path: <linux-wireless+bounces-36697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHZdKR2ZDWoMzwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:21:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B558C490
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EDE0300735B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FDD233956;
	Wed, 20 May 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZwigJI36"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5962D46CE
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275754; cv=none; b=JduUE2G3oTXfIMCS2WGKS9c6MJ6vHFTSBMxalEGTb2G380gObzi4eWwjmxptLm4AwbQBYa5dPXnmQ5wXJlnC/rxfMeHzBtw/7yoBbuxJEyk3w1KaTpdSFQFBSomQOK1z7T2L06T1zrLVaszP1JBqMbUuoi5arLd0tApbxvYLXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275754; c=relaxed/simple;
	bh=UMNK9671wVTQ6GjoX+Bd53MFTJl5e1HgB+bIQnKZSPA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpXDkWxWkgIy+HPhIRpUYudiuASJflMRlJy60ybexQhIFAV7E6qbAbDBmNmtzMU6tyEoxFyZ6rd5V7sfeW5ANLxOZqKuaAoAugOuY38MhIlzQdT7g7EO8yqDyPlwdqTGrGg8Q+nAP6DpAzQ0KD728ywoyNEKvjg1JRi+zu685wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZwigJI36; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f9ziqvnYU5rPtCU4lQo3l8adrKouhFrnCvv4b9MBDSU=;
	t=1779275752; x=1780485352; b=ZwigJI3684g6z0ZM9wHsMlN+NEr+Gl0xrNf2/AImGUkCPld
	cCB9BXaI9CJzmMihCHqTXm+D9eIHgQi69mhCnmxWmBnfCfxNrQOmawC4VJL8d4k8BqJ8WijgN5uFe
	VMrFOQE3X1dCKi+MsVlCMgBQS2YWql6lN6r+G20wZHcSUK6uYchcy+njv5zVN32mJ4IqQ6Y2f24DO
	4TPQz0nTVIczgwpuIQBWSbDouyyV2/sJFhBX3Z1pXPCG8Hpr2FDMkWKZInplFa6QApuvYq3zwsnBD
	IBEfj7NNRdlBsywidzNjjLBxYjZcvYOW7Rz7OnlCtNioFf+zTSW4lovBiEhDVvlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPetx-0000000AKYi-43z0;
	Wed, 20 May 2026 13:15:50 +0200
Message-ID: <530aec47e907fce393bcb789516becf3a2102a97.camel@sipsolutions.net>
Subject: Re: [PATCH v6 4/6] wifi: mac80211: Fix overread in PREQ frame
 processing
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Wed, 20 May 2026 13:15:48 +0200
In-Reply-To: <20260515233839.86829-4-masashi.honma@gmail.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
	 <20260515233839.86829-4-masashi.honma@gmail.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36697-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E5B558C490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-05-16 at 08:38 +0900, Masashi Honma wrote:
>=20
> +		/* Right now we only supports 1 target */

nit: "support"

johannes


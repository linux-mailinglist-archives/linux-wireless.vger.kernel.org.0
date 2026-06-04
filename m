Return-Path: <linux-wireless+bounces-37383-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3hyyJcpkIWq9FgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37383-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:43:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D698663F84E
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=pm6HBY05;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37383-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37383-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8045F307B4E6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2840DFD1;
	Thu,  4 Jun 2026 11:39:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B735C19F;
	Thu,  4 Jun 2026 11:39:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573160; cv=none; b=bD0Y2VFHX6xjo0LcsrR0rph7C9yIhYnuNqpSOMdOYpd3zcxexzBwC1ekQm9EPbqRDxKpg4rT5/QmWNdjrk1p0Ga5mjAb8IWwSsot1//kH3WUncVJOTrEy9BuLp+K7XmRZTII7gB3nKW7dwgv1lkO+Y25Wnbs1zA6yK2ye+OinWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573160; c=relaxed/simple;
	bh=trI7uYWPPxmf+GMBglIRRrzDivs6fV5ob1+4SdOFffo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWjGV48pq/HVoA+gyXjShfFy8V897PEOREttGZZkGh6Lnn8/uoapAyggU+RQ7mCEURERiDnEBdpgbhQGg+B91PZdc6biLHj6pJv2EPyeCBqN+QU4yJVc2KWM0ahuWnmRf7fSI1zVznbdvBXGs/iky4jNPds9uBIRbjbWJMJfjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pm6HBY05; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=czqTrRYMLbu3vlKRZtuPqF48PPZnnh5OJnZIZ3j/uq8=;
	t=1780573159; x=1781782759; b=pm6HBY05wSOYwzZO6zw9b4PvQXJQfwBCop5amThEX2owYyG
	putfT76/EtUWhp7aIVtA4S8I6HBZ4xhGfu2r3yku0o223EffbA3qUb/+smUsrmpcc9N+INzazSFjP
	nW00W53bvbbeM+8LSkprSGEq3WtxFHIIjkLsI02nKF/1LRSJlRFBL3fpehZ9FdujjJnslLdbFYnsL
	hgH0ScpAC7SbsQHuOQQ64wWJZs4DwL26wGiDjQ66kpwfokjCPyJSj8wCGcarv6ES4DBsW7FgoVtge
	bOc7DbukLJL6M3G20kV4plXLrLp/oRi+wbli3wOV8/wGuIZ0ffG4ZU1/tQLHC7+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV6Pt-00000000Sgf-1Imb;
	Thu, 04 Jun 2026 13:39:17 +0200
Message-ID: <a6bbcb3bc6258c657c42445b5df364c3152d30b7.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 06/31] wifi: mm81x: add core.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:39:16 +0200
In-Reply-To: <20260430045615.334669-7-lachlan.hodges@morsemicro.com> (sfid-20260430_065711_057965_1F72265E)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-7-lachlan.hodges@morsemicro.com>
	 (sfid-20260430_065711_057965_1F72265E)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-37383-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D698663F84E

On Thu, 2026-04-30 at 14:55 +1000, Lachlan Hodges wrote:
>=20
> +#define KHZ_TO_HZ(x) ((x) * 1000)
> +#define KHZ100_TO_MHZ(x) ((x) / 10)
> +#define KHZ100_TO_KHZ(freq) ((freq) * 100)
> +#define KHZ100_TO_HZ(freq) ((freq) * 100000)

Maybe not right now, but at least the first one seems fairly generic and
could be elsewhere.

> +static inline u32 mm81x_fle32_to_cpu(u32 v)
> +{
> +	return le32_to_cpu((__force __le32)v);
> +}
> +
> +static inline u16 mm81x_fle16_to_cpu(u16 v)
> +{
> +	return le16_to_cpu((__force __le16)v);
> +}

The whole __force thing here seems odd, why isn't the input 'v' just
__le16?

This goes with all the FW loader thing - but that also has all __force.
I'd argue it'd be better to just have separate FW-endian (little endian)
and host-endian structures, even if that duplicates the structure
definitions, but it'll have sparse actually checking the fields were all
converted correctly rather than=20

johannes


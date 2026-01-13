Return-Path: <linux-wireless+bounces-30738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6DD17617
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 09:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70FD630057D9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E475326D70;
	Tue, 13 Jan 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uR69myad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F92E7F3A
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294250; cv=none; b=KwyB7oW2M1ioocYugl9X96eMPCHuysWsI78KSVrTtQ49xTpdgdTx4Ef0Lz30TxpRzlhu3sT0a0mhtW9iEWroeO6CEwTigK9Lq6TVLZciUK7+KnDZUbd6XyNX5jSikY2RHHx+ke919z/4sWXAeEYl2/U9nondR3CrOYbgQXNTDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294250; c=relaxed/simple;
	bh=SRG4Yo0Ip2MBv9ibNlS9v+HNd6SowGzPl0LQESo7NF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJ5pwDbnv7mE7X8mf1JlXfzO9767OvnJ9p7eikGTEKGSurajAO+RzN7hWQo6KZhjYFBbxg1q6p9AkYijNUJR6cGkQJq/78fIGISzsSNhe2EiUmUL53PaxYOboc2n+Y1JeQzMDg3sRZwsMZs/IypvOSBtf6hUMs+iW2be3eFu/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uR69myad; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SRG4Yo0Ip2MBv9ibNlS9v+HNd6SowGzPl0LQESo7NF8=;
	t=1768294249; x=1769503849; b=uR69myad9d9mJ0im8Uu9DFZa7xggB1wcwSLyTpnBlNKT1nB
	RTTbDvoGYbyq/Tlj4TM1eR4seZ16yb0xN+oPxUbkhpmCPHVP/VtR0AO/4J3L8WLm16hcnkwiiiqPc
	j8AkBO45GO6REDr3awM4UPjuZYlX3O8QGy2r5UXXtsceO+TvjQD4DFPDgHaR4PGeMhcWsNUQ7ZQOw
	fFa+iirynG9cNZBzptPoJ7zsk4f5iysNAWF2ptKdUDMqdyskEZUpPJzbwcpNRtpvellSd7Um1X9VC
	vkwuF9kUGZ2wCi3wb7tzzRlABbTNBdtllX0acM7XsurQ7WKYHFueStSknjRGbgig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfa6w-0000000AgLV-05gj;
	Tue, 13 Jan 2026 09:50:46 +0100
Message-ID: <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for
 S1G Response Indication Configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: Ria Thomas <ria.thomas@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com, 
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
 simon@morsemicro.com
Date: Tue, 13 Jan 2026 09:50:44 +0100
In-Reply-To: <20260109040041.tnk7e6uewo24u3tr@1207> (sfid-20260109_050048_012596_BDA1E561)
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
	 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
	 <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
	 <20260109040041.tnk7e6uewo24u3tr@1207>
	 (sfid-20260109_050048_012596_BDA1E561)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-01-09 at 09:30 +0530, Ria Thomas wrote:
> The WFA HaLow test plan includes explicit test cases that require
> configuring the Response Indication on both the AP and the STA.
> In these scenarios, the Response Indication is not negotiated as
> part of association, but is instead set dynamically after the
> association has been established.

Fair.

> As a result, the Response Indication needs to be configurable at
> runtime from userspace and applied to the driver/firmware
> independently of association or AP setup. This requirement
> motivated the introduction of a userspace=E2=80=91configurable selector
> that updates the Response Indication state on an already active
> interface.

Actually, reading the spec, are you sure it's even on an *interface*
scope? A lot of this seems to me like it should be per intended
receiver, and you need to know its capabilities for generating the
intended response?

If it were per-STA then I think that'd have a much more natural lifetime
(since it cannot exceed that of the STA) which seems far better to me.

But you're going to have to help me understand it :)

johannes


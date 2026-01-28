Return-Path: <linux-wireless+bounces-31264-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id clfOHSfLeWlwzgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31264-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 09:39:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B088B9E490
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 09:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1263008775
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E232D0D3;
	Wed, 28 Jan 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aqy7PLlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824232AAAD
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589539; cv=none; b=R8Ry3+YBhwSqbtjN46X9Mz6YlUxVKjc1WpXYsNR708VsDxye2MMeQ07mAB7o7xOjnoylrCoA6H3AcAQ/bHJtVDVsICOra0u4m9VfukzWx1z46dC+NuZ5VSgB1+TxMI6RjjH4eOEhyuCTILrjGIWUEw/XsqI/GVZ6zAPFd7KJ02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589539; c=relaxed/simple;
	bh=LFtJi3MxITm+ZDY1sTZHkVNEVXlluEZ31xHyk3okVx8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6dGAORLG9CPf3YSVOl0mRgCUd+vyrKBu7uVRculmhc+p/i4/kHFpPdkOrBJjTB0R99hmuHEN0vLI3OxFPpLqUbrq7x34Ahp0fSdK2YUsSHiZhp/rXdqH2eQldUJcyFoJDot0rOBKfC28NcqxKp15LNak7dPaSWrcD4EoBnosuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aqy7PLlh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LFtJi3MxITm+ZDY1sTZHkVNEVXlluEZ31xHyk3okVx8=;
	t=1769589538; x=1770799138; b=aqy7PLlh+1h+xVfIVqn0TKdFOit18s44c+gXJIeAgox06n0
	7KaIEF7WAK9XFhMfZxmQQwF0w3zT4VV24Su+eDmUqeuDpp9ETBDgyvp91QcpH+ltZtcc/Z4DNmiXe
	AbGyxCWF7vqMXBE4bgHwDSdH8Fw1C87/c8lgFaWZKSbTxMy+yesPTCgJzN3IFG7ajz33BLko+zGk3
	1UQEUJli4bR2lPiObSnRNAg0k7/TvcMy5gFnu5nsM2ZBSB0+Pql/7DbIT8Bfl3vf37kdnbyVl1gM7
	1EPKMyoG7ktYQj4woNOBPuXoFAQO9tnHyrTt3HrX4/YtAZc5Hc1SHzqZHhvDw6mA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vl14g-00000005jMb-3nA1;
	Wed, 28 Jan 2026 09:38:55 +0100
Message-ID: <a4afd8690916a518e3919c52770fb423339b321d.camel@sipsolutions.net>
Subject: Re: Clarification on the usage of NL80211_SCAN_FLAG_FLUSH
From: Johannes Berg <johannes@sipsolutions.net>
To: Matthew Schwartz <matthew.schwartz@linux.dev>, 
	linux-wireless@vger.kernel.org
Date: Wed, 28 Jan 2026 09:38:53 +0100
In-Reply-To: <3b3bdd35-b831-4274-8b91-7ab90f6d4eec@linux.dev> (sfid-20260127_204113_457302_74040562)
References: <3b3bdd35-b831-4274-8b91-7ab90f6d4eec@linux.dev>
	 (sfid-20260127_204113_457302_74040562)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31264-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: B088B9E490
X-Rspamd-Action: no action

Hi,

> Is this intended behavior of NL80211_SCAN_FLAG_FLUSH where it clears all =
BSS entries regardless of which channels were scanned, or should NL80211_SC=
AN_FLAG_FLUSH be limited to channels that were scanned in the request which=
 triggered them? The uAPI definition for it is simply "flush cache before s=
canning", but this seems open to interpretation as to whether it means the =
entire cache or just the cache on scanned channels.

Well, AFAICT it has always done that, and so I think regardless of what
might have been the original intent, it simply is that behaviour now.
Changing it in the kernel would just end up having to fix two places,
unless you somehow don't care about running on older kernels without
fixes.

I also tend to think it makes sense since the scan could, at least in
theory, do e.g. colocated scanning, so networks on channels other than
the ones explicitly listed could be discovered. Trying to do anything
other than "flush all" would be far more complex.

johannes


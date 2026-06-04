Return-Path: <linux-wireless+bounces-37376-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pRUeGFlUIWrjDgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37376-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:32:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C463F0FB
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:32:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=s6MQDBKW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37376-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37376-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E74FB303EB86
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F81391E72;
	Thu,  4 Jun 2026 10:24:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C738C2D0
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 10:23:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568642; cv=none; b=ay9i6IEWlWf3vYu3d9UAYz93Dig5OMuaI3o6WaXTb6OBYOL2wOSzPewdIyzkMmEYPsMDg+NPqUnkNutqNTqTySEsWlhR69Wv1PK1SJiIHLVsztwOtOBcf7gZ6ztBhvrl+jHHDMaNrSdSXk/vAFIiwuCWaYJZcY9CaWpBDW6gFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568642; c=relaxed/simple;
	bh=j0808ANJvkkmYYD5vt+pNQEia55dsUDAo0mE3Ft3ujo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVbApnQY5Ua58on4UOPj7XQRFixC017uOlhsKxtX+V1EgUJNVhY8824DrmDpI2ZuxCzM7yAO1+q1bPtewsyZId+bCIZWk4kbxc45g2T08S9DgpqXHscqIr+I+EUABnsihqyhPqSxezAY5uqSMsFmj/LB1taqE/Ao+zu3jy+pju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s6MQDBKW; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j0808ANJvkkmYYD5vt+pNQEia55dsUDAo0mE3Ft3ujo=;
	t=1780568639; x=1781778239; b=s6MQDBKWNe2vsoSDOlH9KsTpuzETYMiFpGmbgQjdoKwCHRd
	lfYQaXLYyVzGB9/kQEvfoCq730a3u1zop0ntk3I362r3n2hDdQFDMigBLCU5b05R0UPM+QW/zBLP/
	sbYfUD/KOiC7KGG2xDF0W0fVUQpvCdfnP5Eh2lYcgHpNbEU8nTAI2B5DfIC17fPvRYTEOGaSKllt2
	1InCAHAImmysp5TmF6/OWcv+uDB/zwhxAma68C2nx7r6n8bd3Vo/4/Jdq2dd1jhhDzu4ppXn8FM3w
	ed1O9pgcypMo4tIZk0mBX1t0lWstolltikCOupQ38+kzXejp3XiZCLXN72EEqDbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV5Es-00000000Qs6-3hZ3;
	Thu, 04 Jun 2026 12:23:51 +0200
Message-ID: <ba6e767a75b02c11d4bec542c971c1affda77df9.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wlcore: Add support for IGTK key
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Kemnade <andreas@kemnade.info>, Peter =?ISO-8859-1?Q?=C5strand?=
	 <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 04 Jun 2026 12:23:50 +0200
In-Reply-To: <20260604120834.508f606f@kemnade.info>
References: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
		<20260508102403.4e2fb1bc@kemnade.info>
		<a2040dcc-af47-1de0-b731-defffe3ce4cd@lysator.liu.se>
	 <20260604120834.508f606f@kemnade.info>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37376-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andreas@kemnade.info,m:astrand@lysator.liu.se,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB2C463F0FB

> >=20
> btw: if the firmware is started for a second time, it will also decrement=
 again.
> So after some reboots we end up without any cipher.
> And afaik the firmware ups at any ifup.

Maybe just send a revert for now?

johannes


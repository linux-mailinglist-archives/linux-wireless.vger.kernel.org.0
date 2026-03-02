Return-Path: <linux-wireless+bounces-32341-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF79NNE5pWnt5wUAu9opvQ
	(envelope-from <linux-wireless+bounces-32341-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 08:18:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD61D3C8E
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 08:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 922E2301136E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A2284669;
	Mon,  2 Mar 2026 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FjufcnXD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5A1E8320
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435919; cv=none; b=hpE3/QUJ39cWWLZtZoRnG1v6C3Ybf5MJDJmkvr025bcZy1NhiBMWju7HDrI1biq8Aj89Y0qNipQ4mBO2YvDIKIvat6P6VzUtPA/qlqUxVyPu8RmlCcMxPwNCG70kdwTbDirXN9D3z5eOmlDKBswK4tIqdNJGY+BKeuGa7LPfYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435919; c=relaxed/simple;
	bh=rLYITeNwCfM6XxY2KBB/T1mQ2q7c4JVtguL2W389whs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0QUvtCLd/KcbPkvsPR7fG6rG50+MqWgtsDHooWOHjyszGfpUVq4UvjFnf7F25Jm0E6sKTZJSCDsjjrEnMYwIklt68PQ9Hwg24lP284cenLlB0oeJLSixhUV1f0H4PGWh09AiJfzcZOlboxFKJHkI2u40nF324uBnaJQES9ZKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FjufcnXD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rLYITeNwCfM6XxY2KBB/T1mQ2q7c4JVtguL2W389whs=;
	t=1772435918; x=1773645518; b=FjufcnXDh2Bn9mhKTeL4uYGE9X4axR+2CePJ3w94O0Oolcm
	l7b5qvbotNJ/jw70IoR7yH7suhVzSW/YE4re480Qo0sF6y0a7uAHz3Nkw2bqy76q2zqd177qcKOrq
	xhE4lE8BNzHAt27OMiJVP+0ck4Be6OaoTyZojFBnn/1Xa+BHlKrFz5tc5QoeBlSLfNMAX9T3eyAtb
	aVqhWwm8d7pr+jerOo5Z8UQIUS3xi5frJMD0tRuOPqIaSKoAOh9VknKB3+6IERizT2oyFjLBDb9ak
	l6hsakyl72C6mFfeLTDy6iu4cihAjm0V6e0HBbKyWJoft3eod8Hn45LLs7i+EcCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vwxXx-00000005zMr-0x2g;
	Mon, 02 Mar 2026 08:18:29 +0100
Message-ID: <49b8b784373eb57ea89d83e9a9a3893f0312744a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: give the AP more time for
 EPPKE as well
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 08:18:28 +0100
In-Reply-To: <20260128132414.881741-2-johannes@sipsolutions.net> (sfid-20260128_142629_316508_217699E6)
References: <20260128132414.881741-2-johannes@sipsolutions.net>
	 (sfid-20260128_142629_316508_217699E6)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32341-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65AD61D3C8E
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 14:24 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> EPPKE authentication can use SAE (via PASN), so give the
> AP more time to respond to EPPKE case just like for SAE.

Any comments on this from AP folks?

Are we expecting APs that supported EPPKE to be much faster? It seems
unlikely to me?

johannes


Return-Path: <linux-wireless+bounces-34466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIKRAAoN1WlQzwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 15:56:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6023AF8F6
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A70430BF024
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA33B636E;
	Tue,  7 Apr 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Vg9iAQXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DF1B4156;
	Tue,  7 Apr 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569591; cv=none; b=pzL0V+QqUlG5EsFmtieIQVHzk3lnamzM8zYJ0m35GYr29RPhVvab3SdCGI8SLy82T8OCF7VcKiwoC1h0Nc8jCP0Lhfu7Dif+0ct/oZpR/Y1ChfDFuSBgmno7o6LZCaDv4rEhoMdRR7TE54KVEH3FTwGwnn2KdRQSfeytP/JK3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569591; c=relaxed/simple;
	bh=o3htiO3qHQvQfmiV/xhRiW2LYmYImqM4+fArsf7ocBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VidMhXxrlHG57GdVmqxHgS6c0cDnO9Vahr6xcfKC4k1gbIpajVasOW5VtDty4TIh90VGnQunjKMcCdc7COUE1ehBfqYauzk10a4gL6xKFv3uTdnV0ELh1pzMgkBkz1K7wB0Z0BX5QGRzDzyodVLuTli1kl4vZwnTu0G58gGlz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Vg9iAQXL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o3htiO3qHQvQfmiV/xhRiW2LYmYImqM4+fArsf7ocBA=;
	t=1775569590; x=1776779190; b=Vg9iAQXL8N88gUgV9pF4s1CBI6gI7+/oYU8un2Ik3bXBLDt
	s6zY7SRp3CHyTY6Lpt78TiIqMU0/ieSkCPfPnr1dx6O+ZvQYaZAjsagK3Cyz3OTGHTGJ9wBqekEOr
	exyN91xdrkYSY4aeiHgbx98eAMx3lqmtJZXvew8DvMEby2AEtz2vrZB8jCBIpb5LyClroTEnU9V20
	fthXfhR1dVMMyIgrREK4M+DgC5rmBCJedpAXMQlL0GYXzAlk27KcDvdSHFNfvGO6wudywlD8tUqB4
	ozIACDxRsng+EaF54r+dTKolAAzCZ0k0r27C4sAShqCwL+LitcEQFRmVqo74Y6oQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA6lA-0000000CVsq-1PqN;
	Tue, 07 Apr 2026 15:46:28 +0200
Message-ID: <538186550596da7b862eb7340047695267f8b71e.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: change hwsim_class to a const struct
From: Johannes Berg <johannes@sipsolutions.net>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:MAC80211"
	 <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Tue, 07 Apr 2026 15:46:27 +0200
In-Reply-To: <20260401165938.3843784-1-jkoolstra@xs4all.nl>
References: <20260401165938.3843784-1-jkoolstra@xs4all.nl>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-34466-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 4C6023AF8F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The subject should have a "wifi: " prefix. Maybe we need a MAINTAINERS
thing for that ...

Also, this patch doesn't apply on wireless-next, please respin.

johannes


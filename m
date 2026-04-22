Return-Path: <linux-wireless+bounces-35202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O9jLNtr6GlZKAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:34:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1750A442741
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75AFE309F3FE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 06:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24F2EBBB7;
	Wed, 22 Apr 2026 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UBX1pFPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38192E62C4;
	Wed, 22 Apr 2026 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839283; cv=none; b=byZSQeoiWeyNSq2MRgDQgnS3+wf7ZB2tnHGWABPU5sT9gMk43JUscLonRyui268wWMmkk/DyGsi/A4vLzoPQuDdo0T1VK9YavBbWMvnZHSIm/R/sltC3v2O4W6y8FX9E/vNpof+60p5Rnc1m2V77zJ9p6qVlKD6r3Vq5gY51F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839283; c=relaxed/simple;
	bh=Y+C1s17f28OQihBIdZ1+zjA8624HESOUEFMCcDVLACw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbJQ2hMLJ4DT4H4yaD4SkhuFY66AzC/P+LZ16rUWz0Ww0ibuHb0JcnO5PNiBs/kN1QtCfKokeawDliQECW3rKiL0qIC2Duu2xaGYEEcViAIv5mfOgb+jQzD3cWJdpHYysBVLYk0Ubfo7EowROIoipgeGwtYhChH+soUHd/m/400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UBX1pFPH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y+C1s17f28OQihBIdZ1+zjA8624HESOUEFMCcDVLACw=;
	t=1776839282; x=1778048882; b=UBX1pFPH5iFLX0dGR37Dodf7AWuKwPb/DDei7B0iiWFlBQe
	HseC5GimsKKfVL8G6JtWkluXO/s8Z0qDLSAcMGJ2POhx1ddtLj9PAK0EWtU9hDpVM3IaN0TzGq5DR
	ChPQuf9bYTUGjL7RDdwZKGSVLJuYsuMp9KzDLUp0fbh16f1AgCIggZ3xsZwafbX1dkt213kCJlksZ
	/rLcJXHHUsPqI51hQw2soTTYhtK7kKV05pQnPoEY0Zv+yxonXxucrwyZyps+MSA9TEuvj7cCj/SU6
	oVamL+MQmZKiC92khjZNfJ5Mzb8UQFR+sMGZlepZTxrQLFQxsAtVcwHJU186m7Fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFR40-000000066Pj-25HP;
	Wed, 22 Apr 2026 08:27:56 +0200
Message-ID: <434407f50d6b7ee85ad14dd6db757f7d9f695a96.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: check ieee80211_rx_data_set_link return
 in pubsta MLO path
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Benjamin Berg <benjamin@sipsolutions.net>,
 	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Apr 2026 08:27:55 +0200
In-Reply-To: <20260422000651.4184602-1-michael.bommarito@gmail.com> (sfid-20260422_020705_790305_99EA1A92)
References: <20260422000651.4184602-1-michael.bommarito@gmail.com>
	 (sfid-20260422_020705_790305_99EA1A92)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35202-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1750A442741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 20:06 -0400, Michael Bommarito wrote:

> Benjamin Berg's 2026-02 RFC v2 "wifi: mac80211: refactor RX
> link_id and station handling"
> (20260223133818.9f5550ab445f.I...@changeid) touches the same
> code and may supersede or subsume this patch; happy to fold /
> rebase / drop.

Yeah, Benjamin, what's up with that :)

OTOH we perhaps wants this patch in wireless, and then yours in
wireless-next.

johannes


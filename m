Return-Path: <linux-wireless+bounces-36702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PGcEA6gDWqC0AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:50:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63458CF1C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93902316A912
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE63DBD63;
	Wed, 20 May 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QVJGO0cx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B003A9D83
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276665; cv=none; b=GHinzPjRjih5NjMImaCxFMqPJUekf8G/bP6XlBWRskGX1Rpzi8MOkrCLQzn/5AfR7UKDlaoyn3V1kkkQRG/mTh9OJYVEfEwuZ35gtEQ0F+JBkPTw6oOmwKHUn2Tuef+d5MY98dNVSV8XY6R7jqtlGQvduVnOW0Yn1wA0ebPvkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276665; c=relaxed/simple;
	bh=CXhhWj7h1y8behNNsG+ssGmEijZ2RHubR5Xk9ZX3FbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpkI0X/DLAkfneMvEgIOGA+VElGw8JOuQL2Nn6o2uCLp5iKLoLVY1iVMrsHc5keV4Ks/NC6tZsNTMGxbqI5DHGa+MTOG2W24tXxjKC9WbTYkNaMcmxncE5NY7JDcNLMlGHTFU0tx8zztBR6qGtt4//+66BMnqleS0hvBxkx73MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QVJGO0cx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CXhhWj7h1y8behNNsG+ssGmEijZ2RHubR5Xk9ZX3FbY=;
	t=1779276664; x=1780486264; b=QVJGO0cxFjrun+AV4vOifNOHBzg1bpCxr6MJXgxr82B0ZS1
	xbkVFMuONpn5uDaaSYfUjYlZziQWCVLTixCKuBjcIqjzTZdJ/zH+H2jju5QHclCbzYN9GxlmbMx2d
	A2GT7GYUZRXpxRJuwZmLvWzUogeyNcd2jjvmx++zipHezqrbfiSF43xpnlNJzxhr8f1MGAoNbS7To
	LKcKYNaG4SkEoZuZooAutIP0mdJVKHTszAWs2oqTRl4BhY95SEEu7NfzrBSYKyaBMl30MnOndmOlA
	cpmKrqajqOatYxSmt4Y28lJKKNI6mlvs+4Uuv8MKXx+xo1M2IZOi8IGS+D13Xw6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPf8e-0000000ANBM-41UW;
	Wed, 20 May 2026 13:31:01 +0200
Message-ID: <a5d3682c1da08d308991dd6f22602487c3ad0805.camel@sipsolutions.net>
Subject: Re: Question: nl80211 testmode_dump and prepare_vendor_dump 
 continuation missing netns recheck
From: Johannes Berg <johannes@sipsolutions.net>
To: Xie Maoyi <maoyi.xie@ntu.edu.sg>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Wed, 20 May 2026 13:30:59 +0200
In-Reply-To: <TYZPR01MB67585C3E22F1E7EE1A801741DC042@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
References: 
	<TYZPR01MB67585C3E22F1E7EE1A801741DC042@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36702-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: DB63458CF1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, 2026-05-15 at 15:40 +0000, Xie Maoyi wrote:
> Hi Johannes,
>=20
> After your acceptance of 79240f3f6d76 ("wifi: nl80211: re-check
> wiphy netns in nl80211_prepare_wdev_dump() continuation"), I
> looked at the other dumpit callbacks in net/wireless/nl80211.c.
> Two sites read state from cb->args[] across continuations without
> a comparable net_eq() recheck.
>=20
> Site 1: nl80211_testmode_dump().
>=20
> The continuation branch resolves rdev via
> cfg80211_rdev_by_wiphy_idx() on cb->args[0]. It does not verify
> that wiphy_net matches sock_net(cb->skb->sk).
>=20
> Site 2: nl80211_prepare_vendor_dump().
>=20
> The continuation branch resolves wiphy via wiphy_idx_to_wiphy()
> on cb->args[0] and proceeds. Same gap. This helper is called by
> nl80211_vendor_cmd_dump, so a fix here covers that path too.
>=20
> I notice one practical limit. No in-tree mainline driver currently
> registers .testmode_dump or wiphy_vendor_command.dumpit, so the
> paths are latent today. Out-of-tree drivers may register either.
>=20
> I wanted to check with you before sending anything. If you read
> these as the same class of bug as 79240f3f6d76 and a short series
> mirroring that fix would be useful, I would be glad to put one
> together when it fits your queue, or to drop the thread if you
> prefer.

I'm really not worried about this class of bug in the first place since
hardly anyone ever uses network namespaces at least as far as I'm aware,
and vendor command implementations are indeed mostly out-of-tree, but
seems we might as well fix it.

johannes


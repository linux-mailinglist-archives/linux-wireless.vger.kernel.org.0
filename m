Return-Path: <linux-wireless+bounces-32156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMaFBF0OnmkxTQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 21:47:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A394018C7B1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 21:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F963039CB5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C8334695;
	Tue, 24 Feb 2026 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lVfAKoJR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FD330646
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966038; cv=none; b=Vd8KVamzUYSWeMRqG7Dmx0qFGaaPjUqfkj0oEpcwGFAefLSnFZDNLIA1Qt0DxBzrLA2Y5ZI/3ZSSdorB54wKrTlE6y9a3JfNwMRLmf9Mn/VC6WDD/0ggYelj/FKo8eq3dN9WRnDtvqIFKFkc1OuQBxintokhMKUT6Pp/TP9Ci3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966038; c=relaxed/simple;
	bh=zRBP75nJECOs8RCo93T991YkqzNLZf5hz/+5e8Oazoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdpBu1hisdFNqnMJjR5ghn+d36jO4/pVar1eiCWYqXIy35efen6Q6tPvBoCMQSkI6t4bXkB+IyUsoXMkAUdkKd9lR8KWKOe91HDJtkZUKFO3F3X0MkkZu9StyBFVHUjfMMjTXKnVSp0oYItpHuZfyySqIrHvOP6c6tdTmpoe+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lVfAKoJR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SK2m0+BCqZK3Z0MefFDAaeio2GM2wmtU79nlwdyGEuo=;
	t=1771966037; x=1773175637; b=lVfAKoJRzidvvV40Nzbk6xV63X7I1WGN5m/H11pkCL5/atf
	FdSYZwN4kNB64V6u84Nxm8WL32dPJXMtxblYxlej7DAxRTb3wQrXoq7++f+YVjduBTzxqjjqPMbvq
	k6Sum3SBTW56J6fBe2fa6UQfiJb6KV1gfBAoH9r42Wx51IHCamLKazPbB2L9Oimq/uYYDJGxRrY6Z
	xxITU2R/H4DWtYbrUviVwdkXDJheuQTV+eWcW7l9SoKEjeRXTeD1uCtnf2cS5A8+TQGo/eRTsr2pd
	RNnq9Hmw/1s54ROELS9DziiUDUCQjD4XlB6AwH1vvYWqohvuylRHNaPH0c+JTwpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuzJJ-00000000fr0-2SY0;
	Tue, 24 Feb 2026 21:47:13 +0100
Message-ID: <0877db64cce68a9c206796da7261065d5785fca6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 1/2] wifi: UHR: define DPS/DBE/P-EDCA
 elements and fix size parsing
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 24 Feb 2026 21:47:12 +0100
In-Reply-To: <20260217054731.3667600-2-karthikeyan.kathirvel@oss.qualcomm.com>
References: 
	<20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20260217054731.3667600-2-karthikeyan.kathirvel@oss.qualcomm.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32156-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: A394018C7B1
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 11:17 +0530, Karthikeyan Kathirvel wrote:
>=20
> +/**
> + * struct ieee80211_uhr_dps_info - DPS operation information
> + *
> + * This structure is the "DPS Operation Parameter field" of "UHR
> + * Operation Element" fields as described in P802.11bn_D1.3
> + * subclause 9.4.1.87. See Figure 9-207u.
> + *
> + * Refer to IEEE80211_UHR_DPS*
> + * @dps_params:

I think it being in a DPS specific struct, we can drop the dps_ prefix
here?

> +/**
> + * struct ieee80211_uhr_dbe_info - DBE operation information
> + *
> + * This structure is the "DBE Operation Parameters field" of
> + * "UHR Operation Element" fields as described in P802.11bn_D1.3
> + * subclause 9.4.2.353. See Figure 9-aa6.
> + *
> + * Refer to IEEE80211_UHR_DBE_OPER*
> + * @dbe_params:

same here

> +/**
> + * struct ieee80211_uhr_p_edca_info - P-EDCA operation information
> + *
> + * This structure is the "P-EDCA Operation Parameters field" of
> + * "UHR Operation Element" fields as described in P802.11bn_D1.3
> + * subclause 9.4.2.353. See Figure 9-aa5.
> + *
> + * Refer to IEEE80211_UHR_P_EDCA*
> + * @p_edca_ec: The P-EDCA ECWmin, P-EDCA and ECWmax
> + *	fields indicate the CWmin and CWmax
> + *	value that are used by a P-EDCA STA during P-EDCA contention.
> + * @p_edca_params: The AIFSN field indicate the AIFSN value that are

and here

johannes


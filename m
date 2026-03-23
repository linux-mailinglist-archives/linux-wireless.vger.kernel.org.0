Return-Path: <linux-wireless+bounces-33707-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC5KOhkYwWn5QQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33707-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:38:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F122F0507
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8BFB300AB37
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA642192FA;
	Mon, 23 Mar 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZdZ7tpqO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965742D9ECB
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262294; cv=none; b=EmQtDMeeElGUbJ/7zdGA2S6dWf9UBRyYJSAnwIhkyZczXDcQXjjmaod25yjxIIe9AVstdqH5xL0J8XblbyViR6Uqt1O3iFD4nAoGGaqBBhbSa4w3SUe9+voAgUa1bXPPf9WIodM2yEZp4RCNJ+3N+ifwNMcHFEbEEi9c6bgaQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262294; c=relaxed/simple;
	bh=SPCPbHGRLUAkClLJ7ucTE+egGvu4tDbIqbr9/qvmQNc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAZaCTZBMCd32AZ8oHxN+b1XMiLfQIXYgspkJRL/DXBBGFffXWXeah7GZzqAJxvg2o/Fnq41foGYZBLwO8gLxTQmRxzbcve41+CaDp6qQYxdheYQXVbTMjGkbnk+k3HOXEcso/lBeg99WknlIBov3jefw5s9+SqTaaBP46m36io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZdZ7tpqO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bgraizMT1zw/VGGUxrMjWEbmfZExuHBp11gKX835dyw=;
	t=1774262293; x=1775471893; b=ZdZ7tpqOnFDyC8P6keyol256/hNv4Vi/OwVYgmukQH14Hmc
	L+O0gfweaV4rnc09aAOJm8W4bdy4zyybXuqpi1C17AF1zUYsTpVnWOqnWvgTroA8jcNgp0Ama55ks
	AeR1xGAjFqD1g+jiXevAWzImXs9WSk5IACFpS90oKccJC5xRVYRjWms+osd2BtGMqBy8lomjzbq48
	85gTkoKuoV9OHElK1vbymj9bXqDAbY1cyqn4uJd3/ApEuHDkljtdpURhjCOcPQJQ5GEdPJc8n7gp9
	HwFpeqjaDxVIt6hNPw5QS87AkFCSUQ9akqGRxw2WzQgSnKXNd/yQjYbAjLlHGaCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4cfj-00000009i3S-1zBL;
	Mon, 23 Mar 2026 11:38:11 +0100
Message-ID: <bdc089f84fbbc794276b365ad0c6b51c65752d84.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] wifi: mac80211: add AQL support for broadcast
 packets
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Mon, 23 Mar 2026 11:38:10 +0100
In-Reply-To: <20260323101954.874299-3-nbd@nbd.name>
References: <20260323101954.874299-1-nbd@nbd.name>
	 <20260323101954.874299-3-nbd@nbd.name>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33707-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90F122F0507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 10:19 +0000, Felix Fietkau wrote:
>=20
> +++ b/include/net/mac80211.h
> @@ -1252,8 +1252,8 @@ struct ieee80211_tx_info {
>  	    status_data_idr:1,
>  	    status_data:13,
>  	    hw_queue:4,
> +	    tx_time_mc:1,
>  	    tx_time_est:10;


> +			"BC/MC  %u us\n"

> +			atomic_read(&local->aql_bc_pending_airtime),

> +			local->aql_txq_limit_bc);
>  	return simple_read_from_buffer(user_buf, count, ppos,
>  				       buf, len);
>  }
> @@ -273,6 +277,11 @@ static ssize_t aql_txq_limit_write(struct file *file=
,
>  	else
>  		buf[count] =3D '\0';
> =20
> +	if (sscanf(buf, "mcast %u", &q_limit_low) =3D=3D 1) {

> +	u32 aql_txq_limit_bc;

...

I think you should be consistent with multicast/broadcast. It really
isn't handling purely broadcast anyway.

johannes


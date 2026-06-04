Return-Path: <linux-wireless+bounces-37378-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xchuAN5YIWp+EgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37378-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:52:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E40CD63F368
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=M8DMLoJx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37378-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37378-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEA6030380D7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26C298CAB;
	Thu,  4 Jun 2026 10:40:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C337EFF9
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 10:40:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569631; cv=none; b=IUJ5rSMmntZP2Bmb+ES+65/9cQZc8vBM5mJTUnrDGl4V9gmWhwnAsLcHl+Uqzl+aKKImYerE5TISdLoBIMM1f9XeOE+kqD/OgOx+hM0mjmRdPgvuWZa1eeh8Amk1xLFycQSI33oNFNRpLQImK8XHOcMbMkhSXZxqGoUg6LFpf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569631; c=relaxed/simple;
	bh=XFO/bVOeRxJ743o3rUy2PSGAH0dk8y63+3ZDbj+5j4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxP4+knrXy0/80H2msZRtKb4mrKdjdkKrJ8QBEWXjytmyza5Y7OEyFrowknS2Y9jdZxhQtVqT46/RR5zXHCyCs43TVB9NtSSqHEGE3GGMYmUCl/MzLdZbXnmbdxCxbzFQ4Fy47iK/0mb/F02VXnLPo6Eff02LhWIbaUvJUiUZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M8DMLoJx; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KxpqIH9O7EiQnbxVo9+XNKu4inEAbKaPR+qdL95F8Qk=;
	t=1780569629; x=1781779229; b=M8DMLoJxPWeIpbQcuf88f0Cd3f7E7/mgaOae9yd+uwnIhow
	fkOFT68Yb30p2lAM7m5PJRHMyRsmz9S8bpiKtrEGwzGjP7Sxw7Hnmy7NZIajynNZCl5TO2+yTGDR4
	nfBbLEYD9jc/qlCVrSsXlJM1ScbWsQddkDgJAqFrr4EByuZ9Zt0/yvFOD8qJC8DB3ZibRoSFMh1a9
	5rpypWvApnevDK+XzRCXKp3s4PN+16CVmXPj9Ya9gAPKUHyQmM2NZbZ8CkxkAsMkMN5QJ6ouOHi/9
	fA8qPX9UDN150UQ4ajhzM0NGLHOKbyP/vI8AqHsOpBYvygV9d+Rr7XrPXVCFn5Cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV5Uw-00000000RDr-00lH;
	Thu, 04 Jun 2026 12:40:26 +0200
Message-ID: <8234e425e99515f75a038126a21c17221270af6d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 2/4] wifi: cfg80211/nl80211: add
 STA-mode peer probing
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Thu, 04 Jun 2026 12:40:24 +0200
In-Reply-To: <20260507171603.1007812-3-pritiwa@qti.qualcomm.com>
References: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
	 <20260507171603.1007812-3-pritiwa@qti.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37378-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:priyansha.tiwari@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: E40CD63F368

Hi,

I'd already fixed these, but there are other issues in the later
patch(es?), so I'm sending this anyway:

> + * @peer: The peer MAC address (or MLD address for MLO) or %NULL if not
> + * applicable (e.g. for STA/P2P-client)

That should have some indentation.

> @@ -16146,7 +16162,6 @@ static int nl80211_probe_peer(struct sk_buff *skb=
, struct genl_info *info)
>  		goto free_msg;
>  	}
> =20
> -	addr =3D nla_data(info->attrs[NL80211_ATTR_MAC]);
> =20
>  	err =3D rdev_probe_peer(rdev, dev, addr, &cookie);

that leaves a spurious blank line.

johannes


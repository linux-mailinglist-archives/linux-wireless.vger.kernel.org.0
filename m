Return-Path: <linux-wireless+bounces-32100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMF4ARAvnGkKAgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:42:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067117509F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF4830071F5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16335B654;
	Mon, 23 Feb 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hyh35YRY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6434D4C4;
	Mon, 23 Feb 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843332; cv=none; b=K8jB8fE95hQONpgSFX1h397neWyxcUaP0I6S3hwttkmVySWNOYtS8IjNVorD9yVTxYxI59yL13AoI3SYe2JcHKi1nbbQl4yU92yowktL/8YsXwfRTqE1acQPEwZYmj3w/5D0OS03fsX1toWi7jx6ll8BiDH+8hdpRZJjnOqQMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843332; c=relaxed/simple;
	bh=tLvhxy7k/L9TPu+/29x81TIMMTrre7Y4MuZo0TkeVBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p8qlImmiELhSeBXYitOuvJpzTbD+4ZEnlpDWmquODWq7T6/JLOPdyRk3sJW5/+HQGg1Y2jrfYbWGLYBSMPcXJCetSDCDXdYaW72qh3snF88K6oVdjhTqxpFx/9ZqwwPgciHd4bpDngOJUoEpTbWD5XBJfpj62vqORsdiGeKJfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hyh35YRY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WWup+sQmd2pQ8sEJn9nreOCq8GsA129aTXSLc2cdveQ=;
	t=1771843331; x=1773052931; b=Hyh35YRYZMjR68P7gsirpYbqWdsBHrVACYMq+NSXEWCgIKY
	GNjA/b9Gad7GDbQjPbBEzmmSYIKqVRv2pOZQ8/8p80cVWeUUeLPbwXXP0WKt0mkhHU84BnCoGAbH1
	tNM7dpGNnbtoXfGYZYjwCDDlUBouVBs1rGbiP8zTIc5E3tqNWfv0baZPKqcP7HR0KKD9a+OUpG7ye
	mrdFuYuz4sJACayyYir8xOvS3TB0X/AmorCELHUWmjaP07PObr9xK5MDEukZQ2meaU/E6UBHWWk2+
	J0oiPYRrajtFQBlvQ5cdYnJaK27WKNHexWtTREZlYVT3mbDxl6Ws4lgfVXrrAqcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuTOB-0000000Gz5C-0CkX;
	Mon, 23 Feb 2026 11:42:07 +0100
Message-ID: <b70e193173ed4f32ac6df58c55032b327a16cc14.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: rsi: Don't default to -EOPNOTSUPP in
 rsi_mac80211_config
From: Johannes Berg <johannes@sipsolutions.net>
To: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: kernel@puri.sm, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 23 Feb 2026 11:42:05 +0100
In-Reply-To: <20260221-rsi-config-ret-v1-1-9a8f805e2f31@puri.sm>
References: <20260221-rsi-config-ret-v1-1-9a8f805e2f31@puri.sm>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32100-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 3067117509F
X-Rspamd-Action: no action

Should have "wifi: rsi: ..." prefix

On Sat, 2026-02-21 at 17:28 +0100, Sebastian Krzyszkowiak wrote:
> This triggers a WARN_ON in ieee80211_hw_conf_init and isn't the expected
> behavior from the driver - other drivers default to 0 too.

This makes sense, but

> Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")

not sure this makes much sense? I guess it added the warning though.

> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/net/wireless/rsi/rsi_91x_mac80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wi=
reless/rsi/rsi_91x_mac80211.c
> index 8c8e074a3a70..c7ae8031436a 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
> @@ -668,7 +668,7 @@ static int rsi_mac80211_config(struct ieee80211_hw *h=
w,
>  	struct rsi_hw *adapter =3D hw->priv;
>  	struct rsi_common *common =3D adapter->priv;
>  	struct ieee80211_conf *conf =3D &hw->conf;
> -	int status =3D -EOPNOTSUPP;
> +	int status =3D 0;

I'll note that this just fixes a minor thing in this driver, if you want
to actually use it you probably also want to fix

 - status is overwritten if multiple changes happen

 - WIPHY_PARAM_RTS_THRESHOLD there max absolutely no sense at all

johannes


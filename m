Return-Path: <linux-wireless+bounces-31447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLH4H29pgGlA7wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 10:07:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EEBC9EA9
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 10:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D9B630039A4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B129BD89;
	Mon,  2 Feb 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mTCmEPt+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB0258CD9
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023275; cv=none; b=C1h4Br0GwYLjM/eI5Hao5bnu9wNsP5rw8rFvstlH6EeWzyQPO2l+iYnukbewUk8hGs1aO2Zms/pqAl1OPi5FdQuvLuub6L5FkDW2druL+90vFu4SoEXj1E0EVYnotlasvFUUwmLIDdGVcSVJBRV3fH6i5WC94qG0OH0tpk4A2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023275; c=relaxed/simple;
	bh=Ra3mu6Hl2h071kBZ7f12uTEDiHgqcpQD/xQtRmQV0j8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1mvoWSF9MSlTpbePuKL6JPObrfuNv5tQh1lZeG7hsvPrrxrarz1p/3UhmY9PYtC/LiYzYe/PbsZm94/eyxqnwB9J8dQuaXKAv6Xi1moGzJcqG6IZcgQAEO0QI0TadBObWAuhSMy3CRJsYHbRwzM9sefJgCoNsuvW4tRRZkhVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mTCmEPt+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yJ1PomvNgr+Xgaa3SDSMo5BjZTbi6Dyjlf1uiX7+vXQ=;
	t=1770023274; x=1771232874; b=mTCmEPt+ODUya1UtK5mCvQeWRxYjzlpJhXQRbfespuVnnHR
	FkyS0YGLYBa2lf17EXlwidjf3OmZx7qYy+iUJnPx2gXL1gAfht5cDFD5DKARKxQ/6X2kqZrAQilPD
	4h3+Ijo8DE1M3JCQh3vgCjcyHaFJMZNGwmChZAGb8MMlWWK+2KUaIxLqgiqkwRQvmEcx9vhOey2av
	FfvOAKYSm0B7aXHB2mDOAYj96tRd/fa2znBJyl36Qb9hR/G73OVE0AgsNnJjX1LypS70xB9dqCWAX
	miwTEk/7eHdFU1h+egscm9OkB8dUwoEnGL3QZhn88iqq9Ahr0TiL/1QVcmiUi7Fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vmpuR-0000000BOk3-1PGT;
	Mon, 02 Feb 2026 10:07:51 +0100
Message-ID: <ce0fc7ade5da7639aa6fe6e7d6bd4bcb0629bf3c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: use wiphy_hrtimer_work
 for CAC timeout
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <amith.a@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 02 Feb 2026 10:07:50 +0100
In-Reply-To: <20260130035511.2328713-1-amith.a@oss.qualcomm.com> (sfid-20260130_045519_750372_09502D8D)
References: <20260130035511.2328713-1-amith.a@oss.qualcomm.com>
	 (sfid-20260130_045519_750372_09502D8D)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31447-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 22EEBC9EA9
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 09:25 +0530, Amith A wrote:
>=20
>  	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);
> +	ktime_t ktime =3D ktime_set(0, ms_to_ktime(cac_time_ms));
>  	struct ieee80211_chan_req chanreq =3D { .oper =3D *chandef };
>  	struct ieee80211_local *local =3D sdata->local;
>  	struct ieee80211_link_data *link_data;
> @@ -3874,8 +3875,7 @@ static int ieee80211_start_radar_detection(struct w=
iphy *wiphy,
>  	if (err)
>  		return err;
> =20
> -	wiphy_delayed_work_queue(wiphy, &link_data->dfs_cac_timer_work,
> -				 msecs_to_jiffies(cac_time_ms));
> +	wiphy_hrtimer_work_queue(wiphy, &link_data->dfs_cac_timer_work, ktime);

This is really questionable on multiple counts (at least the variable
name, the ktime_set call arguments), I've fixed it to just do
ms_to_ktime(cac_time_ms) in the argument ...

johannes


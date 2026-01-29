Return-Path: <linux-wireless+bounces-31314-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE3BMmw8e2kRCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31314-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:54:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 278CEAF31F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3849305E9E6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A02340295;
	Thu, 29 Jan 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XLLWLcTA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D02D9797
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683266; cv=none; b=eW7WefhCeybyHJDbPnJTYzg/wbCZcYFnwd0p/27Exs/L5/Dr49vU8BFZZmHJxbJUGB4GVskAuUs/Gf/pjRyTkuclT7WwqBQm9LYdq37XFJqAYRxYtYubI4BG3UffmtKy0KMqh9MjNUBc3bl6SBLQb5Genmn0JjJ7Yj2FPbWu1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683266; c=relaxed/simple;
	bh=5gS+mk6H5qA35ox1CI6N5NRIMShZMymiRsgLtTzp4Pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IL91J1iHFN2zBiFupH5aHmdXxyK2pINwHEpgXm2qqMjRUwiCn176kFah7+0lCQJ4+3NSXZLN/KAyv8fjQdLGN7HQhMg72CxqGdCYKRCrTrjA4E/nP17RFfjrOhHtg+bznbOZ0smCwNzwpXiVGY9bAfutadQjW+fIARy8hPmFN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XLLWLcTA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DHzIka3ZUXPiAJVGhescLz0uxJDSQy65Ksgz41NgL8s=;
	t=1769683265; x=1770892865; b=XLLWLcTA+Q0FLYSRDeSv+OVONFF4lb8QM2PBOrwuYcWcedI
	cEf381Cn7KwmJscS82ti+ntBkZmDfz3Ybn6FSay1z1HV9dG5HO4tg9nZGl0rqHrOGyqswxXvJe4iw
	Jv9aVw079LvQufapSwn87JJLkLhzQsWs7YWBafrTgJVkNcaOkTVVBQLt1bkjfwnnaT6jDKAiLGSzO
	2BHSJKWZVlJZ4AyuZa2n/ZQbQZIMk1M1D8sjQesfzVA60NmPQEwFx36KmqRSY54dHeH3C7cKEeCUw
	P5kybYP9A+G6OE03T4DvDT8bDgeUB759o0J96LqeMKeWeFcEaVpNz2KfB9FbU9aA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlPSP-00000006n8k-2CgK;
	Thu, 29 Jan 2026 11:41:01 +0100
Message-ID: <57afadb2cbd7e9ef2d15a50ec688e62bf8b0e11d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: use wiphy_hrtimer_work
 for CAC timeout
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <amith.a@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 11:41:00 +0100
In-Reply-To: <20260128064856.3667270-1-amith.a@oss.qualcomm.com> (sfid-20260128_074905_226433_BD0D407B)
References: <20260128064856.3667270-1-amith.a@oss.qualcomm.com>
	 (sfid-20260128_074905_226433_BD0D407B)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31314-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 278CEAF31F
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 12:18 +0530, Amith A wrote:
>=20
> @@ -3851,6 +3851,7 @@ static int ieee80211_start_radar_detection(struct w=
iphy *wiphy,
>  					   u32 cac_time_ms, int link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);
> +	ktime_t ktime =3D ktime_set(0, cac_time_ms * NSEC_PER_MSEC);

ms_to_ktime()

johannes


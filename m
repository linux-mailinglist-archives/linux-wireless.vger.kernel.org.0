Return-Path: <linux-wireless+bounces-32147-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIAeDhvinWnpSQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32147-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:38:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D164818AA0D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B6803016730
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6B3A785B;
	Tue, 24 Feb 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U8K4cYje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB860E555
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954712; cv=none; b=HAyV0dxjK547H6U2NEY+D1wweFDV5GwQqOzbx8lCh4RAhjDipRX5VYF1Jsa7G4kVUdjHPIUdQbSvYX8a1ub1qxFeEnf2gJHfiWqPu/vKXaQjsi/RS3wXxTQPNixUWp+TSem4NoNPq74gCgT+mItnqOWLUgyXHzgOUOdiY4zd1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954712; c=relaxed/simple;
	bh=VB6ybLnwZgfVYt5rTSexjH/NGjtvc8IA0qcNcfaryzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwIAs8WIKyq2TpKI34aJgc885bk04yXnEjSNayeTr+H4miYOtYhDE6DjPQQBCnp5yepu4LPgtDNf1cU3/BDp81xbASSrqkbTqQo9EyUtk145pii9+wx9GN5naQudPwGWBfIlkgGJynMpCdsg/2n1HYTrUAC/WMs7lN+X34Dzc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U8K4cYje; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DUaBES1pgfd4UXRN5nydP5AQXLOnuADF+hwkvdTkdYs=;
	t=1771954711; x=1773164311; b=U8K4cYjeqiW3yyEnvz4Cb5gCGkgTIfQPSA01GxSxIEgWWD6
	Lau2UtMaI5IxpGJ8VQMKujeMoXqCqZ9lW7U09pQnyWZCGNkHGXxT/6iXAkCZoB5j4x3xE4rxLF7NB
	UPMFz7FWqqjLR6firOt2ClEa6qdtv6wc+8gXscnfY4kmjbjdP4cCn9OTbfwKLvV5rCC14LL791Onu
	HuBu36Jbzj+QHDfA2b20fiBR6vgFLkdLtaPegIEVKRqSKsTUyRYvsTc5JO0nddLtWoccMwUsBbEDO
	V/0XLBhRk57pJsStdweIClIvIPPQIaCltFCQg7TuAEPwVXnXXf3yxchJ+Pd/JZxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuwMc-00000000bne-2t1G;
	Tue, 24 Feb 2026 18:38:26 +0100
Message-ID: <b2b284785c462961f4801e783e1421c0c9bba398.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 1/2] wifi: UHR: define DPS/DBE/P-EDCA
 elements and fix size parsing
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 24 Feb 2026 18:38:26 +0100
In-Reply-To: <c71a84fe19a632ccd748d0f1fded1a8b1277e0b1.camel@sipsolutions.net>
References: 
	<20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
		 <20260217054731.3667600-2-karthikeyan.kathirvel@oss.qualcomm.com>
	 <c71a84fe19a632ccd748d0f1fded1a8b1277e0b1.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32147-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D164818AA0D
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 17:42 +0100, Johannes Berg wrote:
> Oh, another thing
>=20
> > + * @dbe_params:
> > + *	B0-B2 - DBE Bandwidth field is set to indicate
> > + *	expanded bandwidth for DBE mode
> > + *	Value 0 is reserved.
> > + *	Set to 1 to indicate 40 MHz DBE bandwidth.
> > + *	Set to 2 to indicate 80 MHz DBE bandwidth.
> > + *	Set to 3 to indicate 160 MHz DBE bandwidth.
> > + *	Set to 4 to indicate 320-1 MHz DBE bandwidth.
> > + *	Set to 5 to indicate 320-2 MHz DBE bandwidth.
> > + *	Values 6 to 7 are reserved.
> > + *	B3 - DBE Disabled Subchannel Bitmap Present.
>=20
> Seems we should have an enum for the possible bandwidth values?

How about this?

enum ieee80211_uhr_dbe_oper_bw {
        IEEE80211_UHR_DBE_OPER_BW_40    =3D 1,
        IEEE80211_UHR_DBE_OPER_BW_80    =3D 2,
        IEEE80211_UHR_DBE_OPER_BW_160   =3D 3,
        IEEE80211_UHR_DBE_OPER_BW_320_1 =3D 4,
        IEEE80211_UHR_DBE_OPER_BW_32_2  =3D 5,
};


johannes


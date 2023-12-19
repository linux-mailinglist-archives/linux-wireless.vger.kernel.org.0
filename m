Return-Path: <linux-wireless+bounces-1048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52288193C0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70331C23914
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB6249F4;
	Tue, 19 Dec 2023 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t595r6SO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4E37D22
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OCLP58LC3SYnoOpFsgZEfkKEyiKUxB1isuDXWv30WjE=;
	t=1703025786; x=1704235386; b=t595r6SO3xFrStARmh+w9Ahg0YHcJQSENUfcTfSqP4NPS3H
	1BEijo7VNbUXdUACEjUlnJIlrXdKoHC2viSY45zTSSPsj8i43iIQTsNBEYrNhrts5RDqOxk/3X7BD
	ovvYnbuA1PjwNhbbKSUGwX6oTdNtPBdkCLMvsctp1eTNWvefnrMLuh3P43qs2BqM82RW/NoizZ+Vp
	qOV2HWKeLBQqQv1LBzQZtCQB14zVvZLEzVJDHgcNHuaiCiqQ3plC4oLnov/Z7WEc4VoEB9Os8FjsY
	1dL20Tc72kmo21mXMgZ5f5HpvUEw0eZBb7uCOlVwTF2jNh3+nlHD85eb0aGi92bQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFinm-00000000NTW-3RUC;
	Tue, 19 Dec 2023 23:43:03 +0100
Message-ID: <a817504ee11fd9bca316312b40218f82c56ec7b7.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/13] wifi: mac80211: rework RX timestamp flags
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Gregory Greenman
	 <gregory.greenman@intel.com>, Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 19 Dec 2023 23:43:01 +0100
In-Reply-To: <69e18f8e-0157-43db-bd11-78ee945d9912@quicinc.com>
References: 
	<20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	 <20231220133549.d0e664832d14.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
	 <69e18f8e-0157-43db-bd11-78ee945d9912@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-19 at 14:41 -0800, Jeff Johnson wrote:
>=20
> >  static inline bool
> >  ieee80211_have_rx_timestamp(struct ieee80211_rx_status *status)
> >  {
> > -	WARN_ON_ONCE(status->flag & RX_FLAG_MACTIME_START &&
> > -		     status->flag & RX_FLAG_MACTIME_END);
> > -	return !!(status->flag & (RX_FLAG_MACTIME_START | RX_FLAG_MACTIME_END=
 |
> > -				  RX_FLAG_MACTIME_PLCP_START));
> > +	return status->flag & RX_FLAG_MACTIME;
>=20
> curious why you dropped the !!

Just a general cleanup I guess.

> now the code can return a value that doesn't map to the true/false bool
> enums

No, it cannot, at least not if 'bool' is implemented in a C99-compliant
way :) It's not actually an enum, it will return 0/1 in the machine
register even with this code.

johannes


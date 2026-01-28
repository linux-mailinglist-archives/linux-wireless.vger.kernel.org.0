Return-Path: <linux-wireless+bounces-31275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLsVLRsIemn11wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 13:59:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8BA1B0A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE1830071CF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247052868B0;
	Wed, 28 Jan 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cjQMMpgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1E1F19A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605052; cv=none; b=igaJ93d/2TcT2hMOHMqGgJ+fH7TYIZzl5zZmpGROlJXWI56qii6ropR3Ix9JTzK1RIU1Ije5On1DMG4VgKNd0/jzWg0Yvc7c2m09mJscqaqRT3YFIuiFj/gswEEVZ1aIF0/p5g+4KDVnm6yD9JRl72mxLNT+p6njFsedeGzpby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605052; c=relaxed/simple;
	bh=3c2T7rQHHrLQTPLdb4mIUUE9E9GXjbm/yXiqHDQJt7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLuPBM2BDX+NozE9+lLrgQQFKZhrPagab89s8Ass3fqj7szKJ3SJvXNcf6fkVug72PoXmHoN3rj7PHBluqqbtZefEtYOkBKMqoD9hD2pZQ/Kv6GguXdSSJAWZR+tQennegDcX568gVMmCnYUFGXrnJZiNUEqWnlnQQ3WanU+IBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cjQMMpgK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ihjH1iI5eRT7Oc/TIUd6sfBTrJzhVAf8tuRS24kh/Ac=;
	t=1769605050; x=1770814650; b=cjQMMpgKcu5kI+MV4HsTcTzqn2yVvnTAqXgTguO3HLpPrYP
	aP51DvEneUOs4CHzKB7NphG34G1RPAiA11N3I22D1c8Ycgs0e6hkRJ/qyzf1MGT04OBWCLXT51hk4
	jmVcFrrR/5BPddAp5q5cgLIaRa1DowFOWbEjpzV9We9lQCa5RNCN01xkn3mHfuMZ2S/3GiAFqkv5K
	Gvj+sE+5EzZOyzQo++x6OJvM8VLs+ElUKtxNqCkaEbVrmfA4iSQ4WqrHKQxW8HHhFlTSw/uFS+0jb
	8xk9o0vgzx81ok40qGCueGkVw5ca2WX9vm/V1GGUic3cXa+AwYyX9q3R5lwCuFSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vl56q-00000005qTn-2hpz;
	Wed, 28 Jan 2026 13:57:24 +0100
Message-ID: <a2013bbb6988d53be3f6722cd8ff838dbd4d7f1c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: Add eMLSR/eMLMR action
 frame parsing support
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, 	linux-wireless@vger.kernel.org,
 Felix Fietkau <nbd@nbd.name>, Shayne Chen	 <shayne.chen@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 28 Jan 2026 13:57:23 +0100
In-Reply-To: <aXoHdmjLKB-g54ie@lore-desk> (sfid-20260128_135628_166382_5E70C1A1)
References: <20260128-mac80211-emlsr-v3-1-473b0c1d9cc4@kernel.org>
	 <69d939aae0abecfdd011219e00076542c6e1abb1.camel@sipsolutions.net>
	 <aXoHdmjLKB-g54ie@lore-desk> (sfid-20260128_135628_166382_5E70C1A1)
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,nbd.name,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31275-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: E6F8BA1B0A
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 13:56 +0100, Lorenzo Bianconi wrote:
> >=20
> > > +	if (drv_set_eml_op_mode(sdata, &sta->sta, &eml_params))
> > > +		return;
> > > +
> > > +	ieee80211_send_eml_op_mode_notif(sdata, mgmt, opt_len);
> >=20
> > IMHO it would make more sense to pass "ptr, opt_len" rather than "mgmt,
> > opt_len", since that's just what gets copied and then the callee doesn'=
t
> > need to dig it out.
>=20
> But I guess we need mgmt pointer to set even other fields (e.g. dst-addr,
> dialog_token, ecc.).

Yeah, good point, passing them all individually isn't great either.

johannes


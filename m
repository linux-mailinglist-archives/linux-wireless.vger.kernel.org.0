Return-Path: <linux-wireless+bounces-31270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAfXCcD4eWkE1QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 12:53:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC52AA0E1E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 12:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE22F301A417
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C746E338599;
	Wed, 28 Jan 2026 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ucn4nX3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB00D531
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601009; cv=none; b=QJfIhhLC2mghycfUvbg8JcofJvLZhliFdU5kgPliuSdmwqr9+sq1+Fy52CoxR5WL/GXdkztLcnjZCJhkhY6FUl/XOMqWlqtJZAgD525Vjt7413SdK+ANN48grfbeco2iCezsQO+3gR4jHxOQE02P1CU0Ev8xUZ9zx4CYCfWzkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601009; c=relaxed/simple;
	bh=Vudfb/ma6j0ISlgyMyQlUg45zCUlHkrD1SVOJxCYIJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgCjTnY7l7BzxcEPlhSkgG30Ya6k75lAe4m6PaK5RImWeK0HVOGGRCS2Ctt65UDNHDPxWmGlnPEXtGgMgNiX5OymE4fMRL1uA+D4ciPYP9xLzhMO9PACmuy4EnH8bbBVBB7QAk8rh07MF/XqG+l4PyN9JoXSsd0vAQsFxboDujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ucn4nX3A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iRJzba95YNbQZtqj//pbDPHC/663xqJuFvXEYYPTvLA=;
	t=1769601008; x=1770810608; b=Ucn4nX3Aq8m2ppRsCs//O+NDaWITLRGOyNczq3l8+BHzJ6P
	975+34Z2Esz0CYgLMqUTNIt7smniD6f4c5guJ/QSRYFf/cQfkMmlkh+6L+aiU6HINWbVH1kmwuwZ5
	zx6u4C53cDGH4RWBlWtyNkylThMpWAom3G0jn575TTzUjDvxu3tntGq6tG6it+bjzlj3FYWaREGsN
	d6v2Slen8nDzFXkT+eHMIzWPxU/OwZDA0Ce1O6gNQmfV3tLB2pjgCgeiqvk65P8oLbtK+ijTtedNR
	KL1Ozg2d8NJGJcBHwiED3p0H3yQZsFnY05Ny7CqQpyGfm5NgZryDmdvq6wY5UpvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vl43e-00000005oNF-3cT0;
	Wed, 28 Jan 2026 12:50:03 +0100
Message-ID: <69d939aae0abecfdd011219e00076542c6e1abb1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: Add eMLSR/eMLMR action
 frame parsing support
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Shayne
 Chen	 <shayne.chen@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 28 Jan 2026 12:50:01 +0100
In-Reply-To: <20260128-mac80211-emlsr-v3-1-473b0c1d9cc4@kernel.org> (sfid-20260128_121810_555043_35237ACC)
References: <20260128-mac80211-emlsr-v3-1-473b0c1d9cc4@kernel.org>
	 (sfid-20260128_121810_555043_35237ACC)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31270-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,mediatek.com,gmail.com,collabora.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: BC52AA0E1E
X-Rspamd-Action: no action

I probably missed this the last time already:

> +	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
> +	    (control & IEEE80211_EML_CTRL_EMLMR_MODE)) {
> +		eml_params.link_bitmap =3D get_unaligned_le16(ptr);
> +		if (eml_params.link_bitmap &&

Surely 0 is an invalid bitmap? To disable it, you send a frame without
IEEE80211_EML_CTRL_EMLSR_MODE or IEEE80211_EML_CTRL_EMLMR_MODE set, so I
don't see how an empty bitmap would be valid?

> +		    !(eml_params.link_bitmap & sdata->vif.active_links))

That's the wrong check, I think? It only checks that you have any
overlap, but we need all bits to be valid, i.e. only

		(link_bitmap & active_links) =3D=3D link_bitmap

is valid, no?

> +			return;
> +	}
> +
> +	if (drv_set_eml_op_mode(sdata, &sta->sta, &eml_params))
> +		return;
> +
> +	ieee80211_send_eml_op_mode_notif(sdata, mgmt, opt_len);

IMHO it would make more sense to pass "ptr, opt_len" rather than "mgmt,
opt_len", since that's just what gets copied and then the callee doesn't
need to dig it out.

johannes


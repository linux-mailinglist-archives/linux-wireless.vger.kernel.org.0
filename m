Return-Path: <linux-wireless+bounces-34801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLJsC46n32nQXQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 16:58:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264E40596F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CEE300C915
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB29D3A5E81;
	Wed, 15 Apr 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jc5K2hX+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46D3D6694
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264904; cv=none; b=k/rY6it0YxnCG23oCOuDelfjkizRmHDv4pLlCcMj40EePc7ArDMwXXbnFkkXeyKtNKaFEZOv4ydeewCc7IYaR7YnKM4UE6u8slWXvQeqmDM6XkCfNc27u+1aNZPrU1GTbb6EtGH44QUlJgNNSFxK+gelLTN5/bAXR8HwmTj+JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264904; c=relaxed/simple;
	bh=YrKjMoujVC9SymhRIrxIG2yW0AN5rIdRmq8Wd+7xErY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdL6gvEeh/HUAsA+fzGYfcCh8SwmdbxDjdEeN5YZnSV0N0SRlNtTlU4IyLkuzN9crzrFnKUQcZEqaBjmOseTZJvD2nzOdCEuCcdUcjM7Ks35+kheg5Y2S0JUtPpA2AEzFIjq2OxJkJKzQzmGxzZ+/646GNYJp+NbUJuSjQ8OI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jc5K2hX+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3ErIE7kBRudbPNmm1UqkcS1TQ31jBaPdk6sXjDatHZI=;
	t=1776264903; x=1777474503; b=jc5K2hX+UlCABCTVhX3w84cKGnmmOZ6Azwy7OC0eS4hvAYo
	vWsBRJV1qyoh1yCFfAzCDxUslLk9qk+73tumvtIlLPHEXoL3p6IS3nkb48D4F7cmu0Ev8rdAFwUOB
	J3ptFmvWUp7GTbZNwEuHvww8cbWaGKXWR+rkSmG/afc/2xwrbG42MhuVz3XIbG4tyCYVR7JABVaZL
	rgQtuSSlj2fn8Gl/7DOjEplrXl4jvwLYvsNakoIvovOu5/1pL+mnUtV6eJsrFGH6KYBVvLdPSP+lD
	rpwLdZTmiNofp/8146KUJBTvtsqjn81Iwg6JYRgyMU0a8qyeuP5M0RJIaLdnp47w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wD1dq-00000006Ssf-3YPt;
	Wed, 15 Apr 2026 16:54:59 +0200
Message-ID: <60e2d9cdb781ad0bed35ef664f7d63dfc49fb9eb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: radiotap: add definitions for the
 new UHR TLVs
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org
Date: Wed, 15 Apr 2026 16:54:58 +0200
In-Reply-To: <e3af2190-3941-4ec8-9c59-91eafc6eb156@freebox.fr>
References: 
	<20260412152605.73e682d0c8c3.I5a0c858467c852b7a2a00f580bd073af29c37705@changeid>
	 <e3af2190-3941-4ec8-9c59-91eafc6eb156@freebox.fr>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34801-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,radiotap.org:url,jmberg.github.io:url]
X-Rspamd-Queue-Id: 7264E40596F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 15:27 +0200, Pablo MARTIN-GOMEZ wrote:
>=20
> > +	IEEE80211_RADIOTAP_UHR_ELR =3D 37,
> > +	IEEE80211_RADIOTAP_UHR =3D 38,
> Why are the values 37 and 38 but below in the doc 35 and 38?

The doc doesn't even exist yet as you say? Other things are being
assigned to 35/36.

> > +/*
> > + * ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)
> > + * see https://www.radiotap.org/fields/UHR-ELR for details
> The URL gives a error 404

Yeah it's not merged yet. For now you can see the (draft) at
https://jmberg.github.io/radiotap.github.io/fields/UHR-ELR (etc)

> > +enum ieee80211_radiotap_uhr_known {
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_SPATIAL_REUSE		=3D 0x00000001,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_GI_LTF_SIZE		=3D 0x00000002,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_NUMBER_OF_UHR_LTF_SYMBOLS	=3D 0x00000004=
,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_LDPC_EXTRA_SYMBOL_SEGMENT	=3D 0x00000008=
,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_PRE_FEC_PADDING_FACTOR	=3D 0x00000010,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_PE_DISAMBIGUITY		=3D 0x00000020,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_DISREGARD_OFDMA		=3D 0x00000040,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_CRC1			=3D 0x00000080,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_TAIL1			=3D 0x00000100,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_CRC2			=3D 0x00000200,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_TAIL2			=3D 0x00000400,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_INTERFERENCE_MITIGATION	=3D 0x00000800,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_DISREGARD_NON_OFDMA	=3D 0x00001000,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_NUMBER_OF_NON_OFDMA_USERS	=3D 0x00002000=
,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_COMMON_ENCODING_BLOCK_CRC	=3D 0x00004000=
,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_COMMON_ENCODING_BLOCK_TAIL	=3D 0x0000800=
0,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_RU_MRU_DRU_SIZE		=3D 0x00010000,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_RU_MRU_INDEX		=3D 0x00020000,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_DRU_RRU_ALLOC_TB_FMT	=3D 0x00040000,
> > +	IEEE80211_RADIOTAP_UHR_KNOWN_PRI80_CHAN_POS		=3D 0x00080000,
> > +};
> In the other radiotap fields, the `known` fields are (as far as I
> checked) have the same order than the data, but here, for example,
> `PRI80_CHAN_POS` is before `INTERFERENCE_MITIGATION  ` in `known` but
> after in `data`. Any reason for that?

Any reason you care? ;-) I think I just assigned them in the order I
needed them, and in this case you really should look at the radiotap
spec for it too. Some of it may also be due to having copied some things
from EHT and then filling gaps with new bits, perhaps. Since other
people are already working on wireshark support etc. I don't think we'll
be changing this without a good reason.

johannes


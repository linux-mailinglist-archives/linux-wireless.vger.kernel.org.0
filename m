Return-Path: <linux-wireless+bounces-32181-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKPrNPUsn2lzZQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32181-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:10:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFDA19B4AC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2272930138A6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7233DA7EB;
	Wed, 25 Feb 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XEMzFxRN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF463AE6F6
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039311; cv=none; b=rzEoSOKCnoTC9l/LUxPYNdHPKuvqgIB5EuULtw/cn7ZmURybNWNVJa5Ea0Y0SNLVMXfAM7+YD38vxO5cwF6YQFF/1G1xLoMh5wi08EJPiYX8lQIsOnXw0GM8gWEOFeKicESEnH6bLZgP63q55v+MnfGAx/E4NzAlCuDCw67bFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039311; c=relaxed/simple;
	bh=G7mi3zHEdD7T5dX1w7volzfsj6yXpijJOqdHV8CKkaM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBReu1/J+sOyQbo0cEmUoybb2eXbdqS0KQPpsClOxNJtXOC3uL3HCxMo4PpZ/QOv2XBkrg/E9yFmbmLPl9XOExSLGRuVZljGaX3muAdxfQI7vK4zFcKgQkUtV2g2rurF4qYvI+1ng75qALZhiW4XY1XrU5d/FXS/HqbDg1vLajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XEMzFxRN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JG7vFBtAx6h1tgt+Sjcwx789AmhpBWpZHr8/GP+X8sE=;
	t=1772039310; x=1773248910; b=XEMzFxRN4Oh3TGbKj5TLre+Rj/+M13VE3uYIxaf/TkYwypH
	VeI7P8T0q56C/q4OkgLEcWLCyw3tUkXC+Thu7HtdTYyuItc1lAp+a5iItvyRr37/NLZLX1wLtt25/
	MKbllmXFODaryX8k2JCHDlt1qszht9/qFEIjirn9xb066fPf7C6M6/sZByGTGklfVVTSLHlHqmoUs
	pBeo+bO1CPeOK/oMqusApkCNPWomMo077B9Wwucf1g2iQg91P2Fs2AKoa8sG6U92DiIDxzkHeUffM
	9tIOUvYhqgiWJgTLtY75v0F0goKraYk1Oa+zejv06OdQmyH1wKkUpq9M9uazyTbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvIN9-00000001Xq1-323n
	for linux-wireless@vger.kernel.org;
	Wed, 25 Feb 2026 18:08:27 +0100
Message-ID: <d4e7f2ec4a7def5820eb41e84ed0815e159cf39b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: move action code from per-type frame structs
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Wed, 25 Feb 2026 18:08:27 +0100
In-Reply-To: <20260225175252.03c5c338a7b2.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
References: 
	<20260225175252.03c5c338a7b2.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32181-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 7DFDA19B4AC
X-Rspamd-Action: no action

Hi all,

Couple of things I noticed while doing this, for driver maintainers:


> --- a/drivers/net/wireless/marvell/mwl8k.c
> +++ b/drivers/net/wireless/marvell/mwl8k.c
> @@ -1985,9 +1985,9 @@ mwl8k_txq_xmit(struct ieee80211_hw *hw,
>  	 */
>  	if (unlikely(ieee80211_is_action(wh->frame_control) &&
>  	    mgmt->u.action.category =3D=3D WLAN_CATEGORY_BACK &&
> -	    mgmt->u.action.u.addba_req.action_code =3D=3D WLAN_ACTION_ADDBA_REQ=
 &&
> +	    mgmt->u.action.action_code =3D=3D WLAN_ACTION_ADDBA_REQ &&
>  	    priv->ap_fw)) {
> -		u16 capab =3D le16_to_cpu(mgmt->u.action.u.addba_req.capab);
> +		u16 capab =3D le16_to_cpu(mgmt->u.action.addba_req.capab);
>  		tid =3D (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
>  		index =3D mwl8k_tid_queue_mapping(tid);


I'm not convinced this isn't broken because there's no length check for
the frame, and monitor mode injection could happen?

> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -414,8 +414,8 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *de=
v, __le32 *txwi,
> =20
>  	if (ieee80211_is_action(fc) &&
>  	    mgmt->u.action.category =3D=3D WLAN_CATEGORY_BACK &&
> -	    mgmt->u.action.u.addba_req.action_code =3D=3D WLAN_ACTION_ADDBA_REQ=
) {
> -		u16 capab =3D le16_to_cpu(mgmt->u.action.u.addba_req.capab);
> +	    mgmt->u.action.action_code =3D=3D WLAN_ACTION_ADDBA_REQ) {
> +		u16 capab =3D le16_to_cpu(mgmt->u.action.addba_req.capab);

Same here and in the other mt76 drivers, but

>  		txwi[5] |=3D cpu_to_le32(MT_TXD5_ADD_BA);
>  		tid =3D (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;

maybe this kind of thing shouldn't happen for injected frames anyway
(there's a flag you can check)

> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -5146,10 +5146,10 @@ static void rtl8xxxu_dump_action(struct device *d=
ev,
>  	if (!(rtl8xxxu_debug & RTL8XXXU_DEBUG_ACTION))
>  		return;
> =20
> -	switch (mgmt->u.action.u.addba_resp.action_code) {
> +	switch (mgmt->u.action.action_code) {

This seems broken the same way.


> +++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> @@ -1409,7 +1409,7 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struc=
t sk_buff *skb, u8 is_tx)
>  				sta_entry =3D
>  					(struct rtl_sta_info *)sta->drv_priv;
>  				capab =3D
> -				  le16_to_cpu(mgmt->u.action.u.addba_req.capab);
> +				  le16_to_cpu(mgmt->u.action.addba_req.capab);
>  				tid =3D (capab &
>  				       IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
>  				if (tid >=3D MAX_TID_COUNT) {

This one is worse because it's not even just local, it's over-the-air
(invoked on RX frames)

> @@ -2519,25 +2519,25 @@ struct sk_buff *rtl_make_del_ba(struct ieee80211_=
hw *hw,
>  	struct ieee80211_mgmt *action_frame;
>  	u16 params;
> =20
> -	/* 27 =3D header + category + action + smps mode */
> -	skb =3D dev_alloc_skb(34 + hw->extra_tx_headroom);
> +	skb =3D dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(delba) +
> +			    hw->extra_tx_headroom);

This one's weird ... it got the comment copy/pasted from SMPS, so that's
completely wrong anyway, but if I'm counting correctly then
IEEE80211_MIN_ACTION_SIZE(delba) is actually 30 not 34, so was it
sending frames that are too long?

>  	if (!skb)
>  		return NULL;
> =20
>  	skb_reserve(skb, hw->extra_tx_headroom);
> -	action_frame =3D skb_put_zero(skb, 34);
> +	action_frame =3D skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(delba));
>  	memcpy(action_frame->sa, sa, ETH_ALEN);
>  	memcpy(action_frame->da, rtlefuse->dev_addr, ETH_ALEN);
>  	memcpy(action_frame->bssid, bssid, ETH_ALEN);
>  	action_frame->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_MGMT |
>  						  IEEE80211_STYPE_ACTION);
>  	action_frame->u.action.category =3D WLAN_CATEGORY_BACK;
> -	action_frame->u.action.u.delba.action_code =3D WLAN_ACTION_DELBA;
> +	action_frame->u.action.action_code =3D WLAN_ACTION_DELBA;
>  	params =3D (u16)(1 << 11);	/* bit 11 initiator */
>  	params |=3D (u16)(tid << 12);	/* bit 15:12 TID number */
> =20
> -	action_frame->u.action.u.delba.params =3D cpu_to_le16(params);
> -	action_frame->u.action.u.delba.reason_code =3D
> +	action_frame->u.action.delba.params =3D cpu_to_le16(params);
> +	action_frame->u.action.delba.reason_code =3D
>  		cpu_to_le16(WLAN_REASON_QSTA_TIMEOUT);

It's not putting anything beyond the normal DelBA frame ...

> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -507,7 +507,7 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, =
int prio)
>  		if (ieee80211_is_action(fc)) {
>  			struct ieee80211_mgmt *action_frame =3D
>  				(struct ieee80211_mgmt *)skb->data;
> -			if (action_frame->u.action.u.ht_smps.action =3D=3D
> +			if (action_frame->u.action.action_code =3D=3D
>  			    WLAN_HT_ACTION_SMPS) {

Same issue with frame length I think.

johannes


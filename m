Return-Path: <linux-wireless+bounces-793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C739B81301F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 13:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D801D1C21556
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2148CED;
	Thu, 14 Dec 2023 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fRdOkDDJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F6A3
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 04:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zK16PLC7YyQ800P7XqS/d4WVwRulehjggbN68Vyp2H4=;
	t=1702556987; x=1703766587; b=fRdOkDDJ83MWvkARGaoni2Wosu+EICwWSWlX0C1szoN6iCa
	SJ75FZtvUebObHaqGVXTFcNs0J7jSYS8IasQEKG1gkswHfklCbHKnzjgkNca+wGYZMziQqWxjigZJ
	y8kyFT49U7D3/T10rr3n0U3cfg79Ssieo7wyvZOoZKm3XAlRH9Jvp2ASzwl8TvNy/w/4AtmeNpYhT
	SChN79YqZmLstxWopc7e+QcTTrNuY7r+AGIJ3qhaa+M6vGAHqy7PSmCSNhNVvPpthPCkIF1oj10W1
	AMaSvI/uPeGbtVEPGz9Vf/xm7UT3E7apLpn+7GtKMauAUgDCy9XK0Ntb1MkF+rrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rDkqV-0000000Ap4b-1qtm;
	Thu, 14 Dec 2023 13:29:43 +0100
Message-ID: <65d21336e8f7e180352403a3e894aeaf27a22cab.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Update bssid indicator with real BSS
 numbers
From: Johannes Berg <johannes@sipsolutions.net>
To: Allen Ye <allen.ye@mediatek.com>, linux-wireless@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>,  Evelyn Tsai <evelyn.tsai@mediatek.com>,
 Money Wang <money.wang@mediatek.com>,  linux-mediatek@lists.infradead.org
Date: Thu, 14 Dec 2023 13:29:42 +0100
In-Reply-To: <20231208063820.25983-1-allen.ye@mediatek.com>
References: <20231208063820.25983-1-allen.ye@mediatek.com>
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

Hi,

We should have Lorenzo here, he wrote the original code.

On Fri, 2023-12-08 at 14:38 +0800, Allen Ye wrote:
> The cnt member in mbssid is the count of total number of MBSSID elements
> instead of BSSID. Therefore, we fix this by reading the MaxBSSID Indicato=
r
> field directly.

I'll say I don't understand this much ...

Are you trying to have BSSIDs that are hidden from the kernel? Or not
contiguous in the MBSSID set? Not sure how the two can be not
equivalent?

> Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Co-developed-by: Money Wang <money.wang@mediatek.com>
> Signed-off-by: Money Wang <money.wang@mediatek.com>
> Signed-off-by: Allen Ye <allen.ye@mediatek.com>

I have to admit that I chuckled a bit about this for a 5 line patch :-)

> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 606b1b2e4123..f90bcd59f85a 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1164,9 +1164,11 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_da=
ta *sdata,
>  	/* copy in optional mbssid_ies */
>  	if (mbssid) {
>  		u8 *pos =3D new->tail + new->tail_len;
> +		const struct element *mbssid_elem;
> =20
>  		new->mbssid_ies =3D (void *)pos;
>  		pos +=3D struct_size(new->mbssid_ies, elem, mbssid->cnt);
> +		mbssid_elem =3D (const struct element *)pos;
>  		pos +=3D ieee80211_copy_mbssid_beacon(pos, new->mbssid_ies,
>  						    mbssid);
>  		if (rnr) {
> @@ -1175,8 +1177,7 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_dat=
a *sdata,
>  			ieee80211_copy_rnr_beacon(pos, new->rnr_ies, rnr);
>  		}
>  		/* update bssid_indicator */
> -		link_conf->bssid_indicator =3D
> -			ilog2(__roundup_pow_of_two(mbssid->cnt + 1));
> +		link_conf->bssid_indicator =3D mbssid_elem->data[0];

But this seems fishy to me, if you look into the element itself, you're
going to have to do some validation on it? And what about fragmentation?

johannes


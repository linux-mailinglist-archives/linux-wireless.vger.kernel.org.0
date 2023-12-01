Return-Path: <linux-wireless+bounces-307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD9A80134F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E61C20995
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634454C3BD;
	Fri,  1 Dec 2023 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gcC2lV92"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393BAD
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WgDIh/adQPejnn5S24A8QEMPbeBHKjlxVd2GYiT7ls8=;
	t=1701457575; x=1702667175; b=gcC2lV92X21rGectLn+P9IZlYuCT+PUhEc8Vf7CYyZPWQ0U
	fvOeYoGtgR/hANqJkrf4HQtBKI4+j7iPrjsdr1/y72MJEowpJqMK7qdNEaqrqr7UOoGL4ipP3XmCK
	8nO33qU+ZAr5i7wwqWM7cKdByYFCAp5lW4TvsV0GkWLI/7UjCW4cV0UYYMA9nsCXTLZDTMk9qZlVV
	Yqb5rTA2zIGGbm0BLpCx7VUO8M2ThqI4RQr22LDxAPIq/VKffVviWa4FomouHqTFzPz+QYx2nwjKw
	MKXRlQ2T7M5prpXWLpki4f0gThsuJG/aoWODlpKfDtVMLgcc/SoFsLfuOWXEJNwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r98q3-0000000BPwk-36Sn;
	Fri, 01 Dec 2023 20:06:11 +0100
Message-ID: <575322249ff9b9d062edfc3bd6aa234a085d6a94.camel@sipsolutions.net>
Subject: Re: [PATCH v3,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Date: Fri, 01 Dec 2023 20:06:10 +0100
In-Reply-To: <20231129054321.10199-2-michael-cy.lee@mediatek.com>
References: <20231129054321.10199-1-michael-cy.lee@mediatek.com>
	 <20231129054321.10199-2-michael-cy.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So looking at this ... I'm not sure I want the operating class parsing?

On Wed, 2023-11-29 at 13:43 +0800, Michael-CY Lee wrote:
> The new Wi-Fi Standard (IEEE P80211be D4.1) specifies that the Wide
> Bandwidth Channel Switch (WBCS) Element subfields have the same
> definitions as VHT operation information if the operating band is not
> S1G.

Actually that's already in REVme, no?

"If the New Operating Class field in the frame [...] does not indicate
an S1G band, the subfields New Channel Width, New Channel Center
Frequency Segment 0 and New Channel Center Frequency Segment 1 have the
same definition, respectively, as Channel Width, Channel Center
Frequency Segment 0, Channel Center Freqauency Segment 1 in the VHT
Operation Information field, described in Table 9-313 (VHT Operation
Information subfields)."

> The problem comes when the BSS is in 6 GHz band, the STA parses the WBCS
> Element by ieee80211_chandef_vht_oper(), which checks the capabilities fo=
r
> HT/VHT mode, not HE/EHT mode.

OK, but that's an implementation issue, we can make it look at HE
capabilities too, for 6 GHz?

> This patch refactors STA CSA parsing flow so that the corresponding
> capabilities can be checked.

That seems fine.


> Also, it adds the way to use op_class in ECSA
> Element to build a new chandef.

Not sure why that?

> In summary, the new steps for STA to handle CSA event are:
> 1. build the new chandef from the CSA-related Elements.
>    (CSA, ECSA, WBCS, etc.)

Actually that's not what you do? The logic is more like

 - if BWI present: use only that
 - if operating class/channel can be used: use only that
 - if WBCS is present: use only that
 - otherwise: use (ext) chanswitch element info from before


Given that I just got a report of an MTK AP that has a broken WCBS
element, I'm not sure I'm happy with that logic ;-)

Seems to me the operating class use should maybe be further down the
list, and perhaps (if it's there) validate the other elements against
it, to make sure the AP isn't confused?

So perhaps better:
 - use, in this order: BWI, WBCS, ECSA, CSA (according to the mode
   we parse as, and our own capabilities)
 - if present, check that operating class agrees

no?

> Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
> Signed-off-by: Money Wang <money.wang@mediatek.com>

Seems that might be in the wrong order and/or should have Co-developed-
by?

> +static inline void
> +wbcs_ie_to_chandef(const struct ieee80211_wide_bw_chansw_ie *wbcs_ie,
> +		   struct cfg80211_chan_def *chandef)

I'd prefer if we generally switched to "element" instead of "IE" since
the spec did that. Yeah we didn't go back and rename all existing code
(unlike the spec), but still?

Please also drop the 'inline', compiler will do it if it makes sense.

> +{
> +	u8 ccfs0 =3D wbcs_ie->new_center_freq_seg0;
> +	u8 ccfs1 =3D wbcs_ie->new_center_freq_seg1;
> +	u32 cf0 =3D ieee80211_channel_to_frequency(ccfs0, chandef->chan->band);
> +	u32 cf1 =3D ieee80211_channel_to_frequency(ccfs1, chandef->chan->band);
> +
> +	switch (wbcs_ie->new_channel_width) {
> +	case IEEE80211_VHT_CHANWIDTH_160MHZ:
> +		chandef->width =3D NL80211_CHAN_WIDTH_160;
> +		chandef->center_freq1 =3D cf0;

maybe add a note that this encoding is deprecated?

> +		break;
> +	case IEEE80211_VHT_CHANWIDTH_80P80MHZ:
> +		chandef->width =3D NL80211_CHAN_WIDTH_80P80;
> +		chandef->center_freq1 =3D cf0;
> +		chandef->center_freq2 =3D cf1;

and not sure I remember well, but this one too? at least going by this:

> +		break;
> +	case IEEE80211_VHT_CHANWIDTH_80MHZ:
> +		chandef->width =3D NL80211_CHAN_WIDTH_80;
> +		chandef->center_freq1 =3D cf0;
> +
> +		if (ccfs1) {
> +			u8 diff =3D abs(ccfs0 - ccfs1);
> +
> +			if (diff =3D=3D 8) {
> +				chandef->width =3D NL80211_CHAN_WIDTH_160;
> +				chandef->center_freq1 =3D cf1;
> +			} else if (diff > 8) {
> +				chandef->width =3D NL80211_CHAN_WIDTH_80P80;
> +				chandef->center_freq2 =3D cf1;
> +			}
> +		}
> +		break;


> +static inline int
> +validate_chandef_by_ht_vht_oper(struct ieee80211_sub_if_data *sdata,

same here about 'inline'

> +				ieee80211_conn_flags_t conn_flags,
> +				u32 vht_cap_info,
> +				struct cfg80211_chan_def *chandef)
> +{
> +	u32 control_freq, center_freq1, center_freq2;
> +	enum nl80211_chan_width chan_width;
> +	struct ieee80211_ht_operation *ht_oper =3D NULL;
> +	struct ieee80211_vht_operation *vht_oper =3D NULL;

No point initializing those to NULL?

> +	if (conn_flags & (IEEE80211_CONN_DISABLE_HT |
> +			  IEEE80211_CONN_DISABLE_40MHZ)) {
> +		chandef->chan =3D NULL;
> +		return 0;
> +	}
> +
> +	control_freq =3D chandef->chan->center_freq;
> +	center_freq1 =3D chandef->center_freq1;
> +	center_freq2 =3D chandef->center_freq2;
> +	chan_width =3D chandef->width;
> +
> +	ht_oper =3D kzalloc(sizeof(*ht_oper), GFP_KERNEL);
> +	if (!ht_oper)
> +		return -ENOMEM;

Not sure I see value in putting this on the heap, it's tiny?

> +	vht_oper =3D kzalloc(sizeof(*vht_oper), GFP_KERNEL);

same here

> +	if (!vht_oper) {
> +		kfree(ht_oper);
> +		return -ENOMEM;

and if you have these gone, you no longer need a return value either,
which is nice.

> +static inline int

same here

> +validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata=
,
> +				     ieee80211_conn_flags_t conn_flags,
> +				     struct cfg80211_chan_def *chandef)
> +{
> +	u32 size, control_freq, center_freq1, center_freq2;
> +	enum nl80211_chan_width chan_width;
> +	struct ieee80211_he_operation *he_oper =3D NULL;
> +	struct ieee80211_eht_operation *eht_oper =3D NULL;

same here about =3DNULL, and for the allocations too

> +	case NL80211_CHAN_WIDTH_80P80:
> +		he_6ghz_oper->control =3D
> +			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;

Is that right? Do HE/EHT even still do 80+80?

>  int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
>  				 struct ieee802_11_elems *elems,
>  				 enum nl80211_band current_band,
> @@ -27,13 +257,14 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_su=
b_if_data *sdata,
>  				 struct ieee80211_csa_ie *csa_ie)
>  {
>  	enum nl80211_band new_band =3D current_band;
> -	int new_freq;
> -	u8 new_chan_no;
> +	int new_freq, ret;
> +	u8 new_chan_no =3D 0, new_op_class =3D 0;
>  	struct ieee80211_channel *new_chan;
> -	struct cfg80211_chan_def new_vht_chandef =3D {};
> +	struct cfg80211_chan_def new_chandef =3D {};
>  	const struct ieee80211_sec_chan_offs_ie *sec_chan_offs;
>  	const struct ieee80211_wide_bw_chansw_ie *wide_bw_chansw_ie;
>  	const struct ieee80211_bandwidth_indication *bwi;
> +	const struct ieee80211_ext_chansw_ie *ext_chansw_ie;
>  	int secondary_channel_offset =3D -1;
> =20
>  	memset(csa_ie, 0, sizeof(*csa_ie));
> @@ -41,6 +272,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_=
if_data *sdata,
>  	sec_chan_offs =3D elems->sec_chan_offs;
>  	wide_bw_chansw_ie =3D elems->wide_bw_chansw_ie;
>  	bwi =3D elems->bandwidth_indication;
> +	ext_chansw_ie =3D elems->ext_chansw_ie;
> =20
>  	if (conn_flags & (IEEE80211_CONN_DISABLE_HT |
>  			  IEEE80211_CONN_DISABLE_40MHZ)) {
> @@ -51,26 +283,30 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_su=
b_if_data *sdata,
>  	if (conn_flags & IEEE80211_CONN_DISABLE_VHT)
>  		wide_bw_chansw_ie =3D NULL;
> =20
> -	if (elems->ext_chansw_ie) {
> -		if (!ieee80211_operating_class_to_band(
> -				elems->ext_chansw_ie->new_operating_class,
> -				&new_band)) {
> -			sdata_info(sdata,
> -				   "cannot understand ECSA IE operating class, %d, ignoring\n",
> -				   elems->ext_chansw_ie->new_operating_class);
> +	if (ext_chansw_ie) {
> +		new_op_class =3D ext_chansw_ie->new_operating_class;
> +		if (!ieee80211_operating_class_to_band(new_op_class, &new_band)) {
> +			new_op_class =3D 0;
> +			sdata_info(sdata, "cannot understand ECSA IE "
> +					  "operating class, %d, ignoring\n",

please don't break strings like that, the previous way this was done was
just fine

> +	/* parse one of the Elements to build a new chandef */

except you don't really, as discussed above

I'd actually kind of like to have these validated against each other,
but that's for another day, and we don't build the strictest
implementation.

Though I probably will make the implementation optionally stricter in
some places like this, and enable that for all testing/certification in
the future.

> +	} else if (!ieee80211_operating_class_to_chandef(new_op_class, new_chan=
,
> +							 &new_chandef)) {
> +		if (wide_bw_chansw_ie)
> +			wbcs_ie_to_chandef(wide_bw_chansw_ie, &new_chandef);
> +		else
> +			new_chandef =3D csa_ie->chandef;

So like I said above, this starts to ignore WBCS if you have things from
operating class, why? Is the only reason it doesn't work against your
broken AP now? ;-)

>  	if (elems->max_channel_switch_time)
>  		csa_ie->max_switch_time =3D
>  			(elems->max_channel_switch_time[0] << 0) |
> -			(elems->max_channel_switch_time[1] <<  8) |
> +			(elems->max_channel_switch_time[1] << 8) |
>=20

No need, I guess, but hey, doesn't matter much. How'd you find this
anyway? :)

johannes


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF96F562E21
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 10:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiGAI2X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiGAI1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 04:27:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038FD71BF6
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jwrZPBYB/F58sbefxHyAw+FhEHos5BLUMJX7x/mGbW4=;
        t=1656663907; x=1657873507; b=VEfwbE7HTmXeg5uXu+8TLomrfsoOd8FItgs69+6qZULjCn9
        Swq7Zfr5AHQgxDaPZSdHevAD/Ks2FDyMhm9KgY+H+RfAfUqgB77+oAYCFYCoLKek8q+zO9chWgwt1
        iRaQcobLz7bk3ShkOUW71No+nBMshcNbeGvyBsI9UPETpJ1/4xi8S9Px7IPGGG1OXWQ5tvWA/0P5P
        DwOSPHVDsXJM+ZG/m4Hbngqe2wXCHCMIMkfpZN8TW1FNEZ9V+l/EXb89wrsRg+BV6UXU7RMhzfVeZ
        VN1WW3uQfMcT5IBygWv/EMhf4mMvyaCk4FGE/zGhZXujeD5NkIYHFMAjn46LTcDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7BxY-003Ofr-BZ;
        Fri, 01 Jul 2022 10:25:04 +0200
Message-ID: <13d1ae9e406d7192e0b47dac5496f16eac7387d7.camel@sipsolutions.net>
Subject: Re: [PATCH v1] cfg80211: parse RNR IE about MLD params for MBSSID
 feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Paul Zhang <quic_paulz@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 01 Jul 2022 10:25:03 +0200
In-Reply-To: <1649335871-9173-1-git-send-email-quic_paulz@quicinc.com>
References: <1649335871-9173-1-git-send-email-quic_paulz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry it took me so long to get here - I'm buried in (other) MLO work.


On Thu, 2022-04-07 at 20:51 +0800, Paul Zhang wrote:
> In order to reconstruct frame for MBSSID feature, per the description of
> the Reduced Neighbor Report(RNR) element about MLD parameters subfield in
> section 9.4.2.170 of Draft P802.11be_D1.4, the RNR IE is modified:

You're a bit inconsistent here - "RNR element" vs. "RNR IE". I'd
generally prefer now to switch to the "element" naming in new code. And
then maybe the subject should be more like

  parse MLD params from RNR element

or so.

Also D2.0 is available - please check if anything changed.

> +/*
> + * TBTT Information field, based on Draft P802.11be_D1.4
> + * section 9.4.2.170.2
> + */
> +#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD		13
> +#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM	16
> +#define IEEE80211_TBTT_TYPE_MASK	0xC0
> +#define IEEE80211_TBTT_COUNT_MASK	0x0F
> +/* TBTT infomation header(2) + Operating class(1) + Channel number(1) */

typo: "information"

> +/**
> + * cfg80211_handle_rnr_ie_for_mbssid() - parse and modify RNR IE for MBS=
SID
> + *                                       feature
> + * @elem: The pointer to RNR IE
> + * @bssid_index: BSSID index from MBSSID index IE
> + * @pos: The buffer pointer to save the transformed RNR IE, caller is ex=
pected
> + *       to supply a buffer that is at least as big as @elem

I'd prefer IE -> element also here, I think.

> + * Per the description about Neighbor AP Information field about MLD
> + * parameters subfield in section 9.4.2.170.2 of Draft P802.11be_D1.4.
> + * If the reported AP is affiliated with the same MLD of the reporting A=
P,
> + * the TBTT information is skipped; If the reported AP is affiliated wit=
h
> + * the same MLD of the nontransmitted BSSID, the TBTT information is cop=
ied
> + * and the MLD ID is changed to 0.
> + *
> + * Return: Length of the element written to @pos
> + */
> +static size_t cfg80211_handle_rnr_ie_for_mbssid(const struct element *el=
em,
> +						u8 bssid_index, u8 *pos)
> +{
> +	size_t rnr_len;
> +	const u8 *rnr, *data, *rnr_end;
> +	u8 *rnr_new, *tbtt_info_field;
> +	u8 tbtt_type, tbtt_len, tbtt_count;
> +	u8 mld_pos, mld_id;
> +	u32 i, copy_len;
> +	/* The count of TBTT info field whose MLD ID equals to 0 in a neighbor
> +	 * AP information field.
> +	 */
> +	u32 tbtt_info_field_count;
> +	/* The total bytes of TBTT info fields whose MLD ID equals to 0 in
> +	 * current RNR IE.
> +	 */
> +	u32 tbtt_info_field_len =3D 0;
> +
> +	rnr_new =3D pos;
> +	rnr =3D (u8 *)elem;

That's a bit weird, why are you doing manipulations on u8 pointers now?

Shouldn't the elem struct be more useful?

> +	rnr_len =3D elem->datalen;
> +	rnr_end =3D rnr + rnr_len + 2;
> +
> +	memcpy(pos, rnr, 2);
> +	pos +=3D 2;

That really could be open-coded. And if you have "rnr_new =3D pos" maybe
use that?

> +	data =3D elem->data;
> +	while (data < rnr_end) {
> +		tbtt_type =3D u8_get_bits(data[0], IEEE80211_TBTT_TYPE_MASK);
> +		tbtt_count =3D u8_get_bits(data[0], IEEE80211_TBTT_COUNT_MASK);
> +		tbtt_len =3D data[1];

You're not checking that any data is present, i.e. that you actually
have a suitable length?

[snip]
it's kind of hard to follow this, to be honest ... maybe that's
intrinsic, but maybe we could do something like

#define copy(pos, data, len) do {
  memcpy(pos, data, len);
  pos +=3D len;
  data +=3D len;
} while (0)

or something to simplify? And maybe that should also have a bounds check
... which I feel are missing quite a bit, not just the one I pointed out
above.


> @@ -321,8 +448,13 @@ static size_t cfg80211_gen_new_ie(const u8 *ie, size=
_t ielen,
>  			const struct element *old_elem =3D (void *)tmp_old;
> =20
>  			/* ie in old ie but not in subelement */
> -			if (cfg80211_is_element_inherited(old_elem,
> -							  non_inherit_elem)) {
> +			if (tmp_old[0] =3D=3D WLAN_EID_REDUCED_NEIGHBOR_REPORT) {

That comment is now misplaced, it seems? It was probably kind of wrong
from the start though.

johannes

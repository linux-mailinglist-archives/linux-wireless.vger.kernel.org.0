Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B565F793E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJGNup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 09:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJGNuo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 09:50:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A528C822B
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MSqOsuBTlPigFAA/oRzEnJhM/dqlXWUPfN4/TDP6vC4=;
        t=1665150643; x=1666360243; b=MnaoIQJzwlvChDKJOJJf7rpteZUJH8dSnqdOAxDvVrNF7K3
        IQ4TToFIhqnCInOXKJkQjcc6oLuqW5kMYymKhzB8BTqrgIWBaYnnrN9aCucUhRb+cv6Sf16FZB68B
        +ZDtDf9dfSEPiEy8ZdwPYTnbtGL7VePVIbwEYYeEshmRoY48Lakf/pfejtFEcLGLI1/lvZhshbzKl
        JUJ2uFQnSy6W8ehfhcAhiH1AG9EbyzeTn1s05xXX+bS1gkTTZi4PCREneC7IATL3wAJd2UHzC9BWd
        3HWcGJzPNTBdHb+m/e5ILv1YYN26kLeMQhV2xekRF7hpPeujWPz076xsWYMdt5Fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ognkP-000OuD-0s;
        Fri, 07 Oct 2022 15:50:41 +0200
Message-ID: <e9943adb7c7cea0c2dc46039918e30d857b1ad53.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: modify MLD ID params about RNR element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Paul Zhang <quic_paulz@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 07 Oct 2022 15:50:40 +0200
In-Reply-To: <1656991169-25910-1-git-send-email-quic_paulz@quicinc.com>
References: <1656991169-25910-1-git-send-email-quic_paulz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-07-05 at 11:19 +0800, Paul Zhang wrote:
>=20
> Signed-off-by: Paul Zhang <quic_paulz@quicinc.com>
> ---
>  include/linux/ieee80211.h |   9 +++
>  net/wireless/scan.c       | 159 ++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 162 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 559b6c6..0e547b5 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -3996,6 +3996,15 @@ static inline bool for_each_element_completed(cons=
t struct element *element,
>  #define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
>  #define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
> =20
> +/*
> + * TBTT Information field, based on Draft P802.11be_D2.0
> + * section 9.4.2.170.2
> + */
> +#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD		13
> +#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM	16
> +/* TBTT information header(2) + Operating class(1) + Channel number(1) *=
/

might be easier to have a struct for this, and then

> +#define IEEE80211_NBR_AP_INFO_LEN	4

becomes a sizeof()?

This code all makes me nervous again because it's over-the-air parsing
code I don't understand immediately :-)

> +	memcpy(pos, rnr, 2);
> +	pos +=3D 2;
> +	data =3D elem->data;
> +	while (data + IEEE80211_NBR_AP_INFO_LEN <=3D rnr_end) {
> +		tbtt_type =3D u8_get_bits(data[0],
> +					IEEE80211_AP_INFO_TBTT_HDR_TYPE);
> +		tbtt_count =3D u8_get_bits(data[0],
> +					 IEEE80211_AP_INFO_TBTT_HDR_COUNT);
> +		tbtt_len =3D data[1];
> +
> +		copy_len =3D tbtt_len * (tbtt_count + 1) +
> +			   IEEE80211_NBR_AP_INFO_LEN;
> +		if (data + copy_len > rnr_end)
> +			break;
> +
> +		if (tbtt_len >=3D
> +		    IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM)
> +			mld_pos =3D
> +			    IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD;
> +		else
> +			mld_pos =3D 0;
> +		/* If MLD params do not exist, copy this neighbor AP
> +		 * information field.
> +		 * Draft P802.11be_D2.0, tbtt_type value 1, 2 and 3
> +		 * are reserved.
> +		 */
> +		if (mld_pos =3D=3D 0 || tbtt_type !=3D 0) {
> +			memcpy(pos, data, copy_len);
> +			pos +=3D copy_len;
> +			data +=3D copy_len;
> +			continue;
> +		}
> +		/* If MLD params exists, copy the 4 bytes fixed field.
> +		 * tbtt_info_field is used to modify the tbtt_count field later.
> +		 */
> +		memcpy(pos, data, IEEE80211_NBR_AP_INFO_LEN);
> +		tbtt_info_field =3D pos;
> +		pos +=3D IEEE80211_NBR_AP_INFO_LEN;
> +		data +=3D IEEE80211_NBR_AP_INFO_LEN;
> +
> +		tbtt_info_field_count =3D 0;
> +		for (i =3D 0; i < tbtt_count + 1; i++) {
> +			mld_id =3D data[mld_pos];
> +			/* Refer to Draft P802.11be_D2.0
> +			 * 9.4.2.170.2 Neighbor AP Information field about
> +			 * MLD parameters subfield
> +			 */
> +			if (mld_id =3D=3D 0) {
> +				/* Skip this TBTT information since this
> +				 * reported AP is affiliated with the same MLD
> +				 * of the reporting AP who sending the frame
> +				 * carrying this element.
> +				 */
> +				tbtt_info_field_len +=3D tbtt_len;
> +				data +=3D tbtt_len;
> +				tbtt_info_field_count++;
> +			} else if (mld_id =3D=3D bssid_index) {
> +				/* Copy this TBTT information and change MLD
> +				 * to 0 as this reported AP is affiliated with
> +				 * the same MLD of the nontransmitted BSSID.
> +				 */
> +				memcpy(pos, data, tbtt_len);
> +				pos[mld_pos] =3D 0;
> +				data +=3D tbtt_len;
> +				pos +=3D tbtt_len;
> +			} else {
> +				/* Just copy this TBTT information */
> +				memcpy(pos, data, tbtt_len);
> +				data +=3D tbtt_len;
> +				pos +=3D tbtt_len;
> +			}
> +		}
> +		if (tbtt_info_field_count =3D=3D (tbtt_count + 1)) {
> +			/* If all the TBTT informations are skipped, then also
> +			 * revert the 4 bytes fixed field which has been copied.
> +			 */
> +			pos -=3D IEEE80211_NBR_AP_INFO_LEN;
> +			tbtt_info_field_len +=3D IEEE80211_NBR_AP_INFO_LEN;
> +		} else {
> +			/* Modify the tbtt_count field if some TBTT informations
> +			 * are skipped.
> +			 */
> +			u8p_replace_bits(&tbtt_info_field[0],
> +					 tbtt_count - tbtt_info_field_count,
> +					 IEEE80211_AP_INFO_TBTT_HDR_COUNT);
> +		}
> +	}
> +
> +	/* Sanity check if any parsing issue happens */
> +	if (data !=3D rnr_end)
> +		return 0;

That can only happen in the case of the 'break' above, so maybe just
return 0 immediately there?

johannes

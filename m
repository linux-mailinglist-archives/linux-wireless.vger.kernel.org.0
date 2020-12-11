Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECC72D75A5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 13:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405936AbgLKM3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 07:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405957AbgLKM3F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 07:29:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF4C0613D3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Dec 2020 04:28:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1knhX4-006m0u-Vc; Fri, 11 Dec 2020 13:28:23 +0100
Message-ID: <2a24380874289c1a2bd6145f0ae54b1e0286755d.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: 160MHz support per IEEE802.11ax standard
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     linux-wireless@vger.kernel.org, Aviad.Brikman@celeno.com,
        eliav.farber@celeno.com
Date:   Fri, 11 Dec 2020 13:28:06 +0100
In-Reply-To: <20201019063921.4335-1-shay.bar@celeno.com>
References: <20201012141808.22284-1-shay.bar@celeno.com>
         <20201019063921.4335-1-shay.bar@celeno.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-10-19 at 09:39 +0300, Shay Bar wrote:
> According to the new IEEE802.11ax standard center frequency of the 160MHz
> should be published in segment2 field of HT operation IE when using EXT NSS
> (when supporting smaller number of NSS in VHT in 160MHz BW).
> This patch adds the required support to mac80211, cfg80211 to parse it properly
> according to the new style as appears in the new standard.
> 
> According to the new style, the AP should publish that its bw is 80MHz and not
> 160MHz.
> A STA should conclude that an AP is working in 160MHz if it publishes
> the center frequency of the 160MHz bandwidth in seg1 field of VHT operation IE
> or seg2 field of HT operation IE.
> 
> A little about the old/new style of the channel/bandwidth publish in beacons:
> 
> - In the old style bandwidth of 160MHz and center frequency segment 0 are
>   published in vht/he operation information element, while the center_freq_seg0
>   indicates the center frequency of 160MHz.
> - According to the new style, bandwidth of 80MHz is published and also the
>   following:
>     * If the supported number of VHT NSS in 160MHz is at least max VHT NSS
>       support, then center_freq_seg0 indicates the center frequency of 80MHz and
>       center_freq_seg1 indicates the center frequency of 160MHz.
>     * If the supported number of VHT NSS in 160MHz is less than max VHT NSS
>       support, then center_freq_seg0 indicates the center frequency of 80MHz and
>       center_freq_seg1 is 0. The center frequency of 160MHz is published in HT
>       operation information element instead.


All of that is nice, but basically we already covered it ...

Seems like perhaps you rebased this patch and dropped the bits that we
already had upstream now/later, but we don't have the CSA pieces, and
then you didn't update the commit message? :-)

> +/**
> + * enum ieee80211_center_freq_seg1_location - the location of center
> + * frequency segment1
> + * @IEEE80211_CENTER_FREQ_SEG1_NONE: center freq seg1 is located no where
> + * @IEEE80211_CENTER_FREQ_SEG1_VHT_OPER: center freq seg1 is located in VHT
> + * operation IE
> + * @IEEE80211_CENTER_FREQ_SEG1_HT_OPER: center freq seg1 is located in HT
> + * operation IE

please use tabs at the beginning of continued documentation lines

> +static enum ieee80211_vht_chanwidth
> +ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
> +				 u32 seg0,
> +				 u32 seg1)

the parameters all fit on one line

> +{
> +	enum ieee80211_vht_chanwidth ret = IEEE80211_VHT_CHANWIDTH_USE_HT;
> +
> +	if (vht_oper_bw != IEEE80211_VHT_CHANWIDTH_80MHZ)
> +		return vht_oper_bw;
> +
> +	if (!seg1) {
> +		return IEEE80211_VHT_CHANWIDTH_80MHZ;
> +	} else {
> +		int diff;
> +
> +		diff = abs((int) seg0 - (int) seg1);
> +
> +		if (diff == 8)
> +			return IEEE80211_VHT_CHANWIDTH_160MHZ;
> +
> +		if (diff > 16)
> +			return IEEE80211_VHT_CHANWIDTH_80P80MHZ;
> +	}
> +
> +	return ret;

You can remove the 'ret' variable, and having "else" after "return" is
also pointless.

Easier to just do a chain of ifs, and return
IEEE80211_VHT_CHANWIDTH_USE_HT at the end.

> +}
> +
> +static enum ieee80211_center_freq_seg1
> +ieee80211_get_center_freq_seg1_location(struct ieee80211_sub_if_data *sdata,
> +					u32 vht_cap_info,
> +					u8 actual_chanwidth)
> +{
> +	u8 ext_nss_bw = (vht_cap_info &
> +			      IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
> +			      IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT;
> +	u8 supp_chwidth = (vht_cap_info &
> +			   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) >>
> +			   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_SHIFT;


please use the include/bitfield.h helpers, specifically u32_get_bits().

> +	enum ieee80211_center_freq_seg1 res =
> +					IEEE80211_CENTER_FREQ_SEG1_NONE;
> +
> +	/* The bandwidth is less than 80+80/160MHz */
> +	if (actual_chanwidth < IEEE80211_VHT_CHANWIDTH_160MHZ)
> +		return IEEE80211_CENTER_FREQ_SEG1_NONE;
> +
> +	switch (supp_chwidth) {
> +	case 0:
> +		if ((ext_nss_bw > 1) ||
> +		    ((ext_nss_bw == 1) &&
> +		     (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ)))
> +			/* CCFS2 */
> +			res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER;

You can also just return here and get rid of the 'res' variable.

> +		break;
> +	case 1:
> +		if ((ext_nss_bw > 2) ||
> +		    (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ))
> +			/* CCFS1 */
> +			res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER;
> +		else if (ext_nss_bw > 0)
> +			/* CCFS2 */
> +			res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER;
> +		break;
> +	case 2:
> +		res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER;
> +		if ((ext_nss_bw > 0) && (ext_nss_bw < 3))
> +			sdata_info(sdata,
> +				   "Invalid ext_nss_bw %u\n", ext_nss_bw);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return res;
> +}

Maybe that could reuse some code from ieee80211_chandef_vht_oper()?
Seems very similar? Or refactor some of it?

> +++ b/net/wireless/nl80211.c
> @@ -2976,6 +2976,21 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
>  		chandef->edmg.channels = 0;
>  	}
>  
> +	if (chandef->width == NL80211_CHAN_WIDTH_80) {
> +		if (chandef->center_freq2) {
> +			int diff = abs(chandef->center_freq1 -
> +				       chandef->center_freq2);
> +
> +			if (diff == 40)
> +				chandef->width = NL80211_CHAN_WIDTH_160;
> +			else if (diff > 80)
> +				chandef->width = NL80211_CHAN_WIDTH_80P80;
> +
> +			chandef->center_freq1 = chandef->center_freq2;
> +			chandef->center_freq2 = 0;
> +		}
> +	}

This doesn't seem appropriate at all, why would we possibly want to do
such a backward compat workaround in the *nl80211* API??

_If_ there's a good reason for it, it needs to come in a separate patch,
but I really don't see it.

johannes


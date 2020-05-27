Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2868F1E4639
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbgE0Olx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgE0Olx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:41:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B0C05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:41:53 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdxFf-004ANJ-Dv; Wed, 27 May 2020 16:41:51 +0200
Message-ID: <74232fe9a140a15306c04f0509e6c615b8e329de.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 16:41:50 +0200
In-Reply-To: <1589399105-25472-10-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-10-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 12:45 -0700, Rajkumar Manoharan wrote:
> In 6 GHz band, determine chandef from 6 GHz operation information
> of HE operation element.

So here we get to real differences ...

> Reported-by: kernel test robot <rong.a.chen@intel.com>

Huh?

> +bool ieee80211_chandef_he_oper(struct ieee80211_sub_if_data *sdata,
> +			       const struct ieee80211_he_operation *heop,
> +			       struct cfg80211_chan_def *chandef)
> +{
> +	struct ieee80211_he_oper_6ghz_op_info info;
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	struct ieee80211_supported_band *sband;
> +	struct cfg80211_chan_def new = *chandef;
> +	int cf0, cf1;
> +	int ccf0, ccf1;
> +	bool support_80_80;
> +	bool support_160;
> +	u8 he_phy_cap;
> +	u8 pos = 0;
> +
> +	/* Below HE Operation check is required only for 6 GHz band */
> +	if (chandef->chan->band != NL80211_BAND_6GHZ)
> +		return true;
> +
> +	if (!heop)
> +		return false;
> +
> +	sband = sdata->local->hw.wiphy->bands[chandef->chan->band];
> +	if (!sband)
> +		return false;
> +
> +	he_cap = ieee80211_get_he_iftype_cap(sband, sdata->vif.type);
> +	if (!he_cap)
> +		return false;
> +
> +	if (!(le32_to_cpu(heop->he_oper_params) &
> +				IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
> +		return false;
> +
> +	he_phy_cap = he_cap->he_cap_elem.phy_cap_info[0];
> +	support_160 =
> +		!!(he_phy_cap &
> +		   IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
> +	support_80_80 =
> +		!!(he_phy_cap &
> +		   IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
> +
> +	if (le32_to_cpu(heop->he_oper_params) &
> +	    IEEE80211_HE_OPERATION_VHT_OPER_INFO)
> +		pos += 3;
> +	if (le32_to_cpu(heop->he_oper_params) &
> +	    IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
> +		pos += 1;

This really gets better with the ieee80211_he_6ghz_oper() inline I wrote
and posted in the other reply.

> +	case IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ:
> +		new.center_freq1 = cf0;
> +		new.width = NL80211_CHAN_WIDTH_80;
> +		if (ccf1) {
> +			unsigned int diff;
> +
> +			diff = abs(ccf1 - ccf0);
> +			if (diff == 8 && support_160) {
> +				new.width = NL80211_CHAN_WIDTH_160;
> +				new.center_freq1 = cf1;
> +			} else if ((diff > 8) && support_80_80) {
> +				new.width = NL80211_CHAN_WIDTH_80P80;
> +				new.center_freq2 = cf1;
> +			}
> +		}

Hmm. Yes, we just had

+       case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
+               if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8)
+                       he_chandef.width = NL80211_CHAN_WIDTH_160;
+               else
+                       he_chandef.width = NL80211_CHAN_WIDTH_80P80;
+               break;


but that breaks if you don't support 80+80 or 160.

OTOH, we check this later again, I think, and downgrade if we don't
support it, so no harm done?

I think I'd prefer the parsing to be exact, and then downgrade as
necessary. That makes things a bit simpler.

That may mean the place where you call this should be different though.

johannes


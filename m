Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243211E6093
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 14:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbgE1MUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbgE1MUa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 08:20:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855CC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 05:20:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeHWO-004qXv-3Y; Thu, 28 May 2020 14:20:28 +0200
Message-ID: <ce7d58fd1b504dfa8d4444d1fe8e62e2f475dab9.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/11] mac80211: add HE 6 GHz Band Capability IE in
 Assoc. Request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 28 May 2020 14:20:27 +0200
In-Reply-To: <1589399105-25472-7-git-send-email-rmanohar@codeaurora.org> (sfid-20200513_214546_498367_3B5A386B)
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-7-git-send-email-rmanohar@codeaurora.org>
         (sfid-20200513_214546_498367_3B5A386B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi again :)

So ...

> @@ -4803,7 +4809,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>  	if (!sband->ht_cap.ht_supported) {
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> -		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +		if (sband->band != NL80211_BAND_6GHZ)
> +			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>  	}
>  
>  	if (!sband->vht_cap.vht_supported)
> @@ -5493,7 +5500,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>  	if (req->flags & ASSOC_REQ_DISABLE_HT) {
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> -		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +		if (sband->band != NL80211_BAND_6GHZ)
> +			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;

I had dropped these bits from the patch earlier, because they didn't
really seem to belong here.

Now that I look at them in more detail, and compare to what I had done
before, it seems that this isn't really suitable...

For example for better or worse, IEEE80211_STA_DISABLE_HT and
IEEE80211_STA_DISABLE_VHT are checked in various places, for example in
the CSA code.

I had instead done here

bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;

[...]

-        if (!sband->ht_cap.ht_supported) {
+        if (!sband->ht_cap.ht_supported && !is_6ghz) {

and so on.


Technically, *of course* you're right in that HT/VHT are disabled on 6
GHz channels. In practice, we've clearly not disentangled that enough
yet, I think.

I'll post the patch as I had it, wrt. these flags, and then we can see
about cleaning it up?

johannes


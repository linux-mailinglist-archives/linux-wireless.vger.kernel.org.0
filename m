Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E95265C78
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKJaG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 05:30:06 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:39166
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgIKJaA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 05:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599816599;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=Zq8bJjYwHsQZJt6GKnKDYFqvWyWQdWAV4ouwbXypAhQ=;
        b=H5o2PE8Z5x8AM+PT3EYRLk9TsO1fiDWu4/uo5bVDommvOHZGJ/ZCrwlM4aQnnmub
        sy0jiNY+kWecyUgp72EhwoHH/4YVjhS5OSGAy2W/FLKSLRI64nkk7CkVT5GMbUvKe4b
        RdIKmY+ECDshKOFulL1lDFprUv9x9MwXPkW9SF4w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599816599;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=Zq8bJjYwHsQZJt6GKnKDYFqvWyWQdWAV4ouwbXypAhQ=;
        b=OA6V39Dei1Uo5v73cxXpXUcdPrF92KKhahnJWwfb1VXhHgfCQWbpFosybAyhzauk
        LILVxvCQM7dgSjq0UBf6tLq5N71W4CQm6APu9vwm2zyFZ98Cs6x0beOUJiQBoevdRqo
        LQ8ci//4SYs+ZrsG6U2l53MDSKHJks7F1i6TsfmI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 09:29:59 +0000
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2 13/24] mac80211: determine chandef from HE 6 GHz
 operation
In-Reply-To: <20200528213443.25687d2695bc.I3f9747c1147480f65445f13eda5c4a5ed4e86757@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
 <20200528213443.25687d2695bc.I3f9747c1147480f65445f13eda5c4a5ed4e86757@changeid>
Message-ID: <010101747c80077b-a00559ae-264a-4140-b662-625e0949a112-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 03:34, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Support connecting to HE 6 GHz APs and mesh networks on 6 GHz,
> where the HT/VHT information is missing but instead the HE 6 GHz
> band capability is present, and the 6 GHz Operation information
> field is used to encode the channel configuration instead of the
> HT/VHT operation elements.
> 
> Also add some other bits needed to connect to 6 GHz networks.
> 
> Link:
> https://lore.kernel.org/r/1589399105-25472-10-git-send-email-rmanohar@codeaurora.org
> Co-developed-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/ieee80211_i.h |   3 ++
>  net/mac80211/mesh.c        |   1 +
>  net/mac80211/mlme.c        |  69 +++++++++++++++++-------
>  net/mac80211/util.c        | 106 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+), 19 deletions(-)
> 
[...]
> @@ -4838,21 +4860,23 @@ static int ieee80211_prep_channel(struct
> ieee80211_sub_if_data *sdata,
>  			  IEEE80211_STA_DISABLE_160MHZ);
> 
>  	/* disable HT/VHT/HE if we don't support them */
> -	if (!sband->ht_cap.ht_supported) {
> +	if (!sband->ht_cap.ht_supported && !is_6ghz) {
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>  	}
> 
> -	if (!sband->vht_cap.vht_supported)
> +	if (!sband->vht_cap.vht_supported && !is_6ghz) {
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> +		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +	}
when connec to NL80211_BAND_2GHZ, it does not support vht, then it 
failed for HE and connected with HT mode.
I tesed with below change, it fix the issue, it connected with HE mode 
for NL80211_BAND_2GHZ with an HE mode 11AX AP.
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b2a9d47cf86d..c85186799d05 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4853,6 +4853,7 @@ static int ieee80211_prep_channel(struct 
ieee80211_sub_if_data *sdata,
         struct ieee80211_supported_band *sband;
         struct cfg80211_chan_def chandef;
         bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
+       bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
         struct ieee80211_bss *bss = (void *)cbss->priv;
         int ret;
         u32 i;
@@ -4871,7 +4872,7 @@ static int ieee80211_prep_channel(struct 
ieee80211_sub_if_data *sdata,
                 ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
         }

-       if (!sband->vht_cap.vht_supported && !is_6ghz) {
+       if (!sband->vht_cap.vht_supported && is_5ghz) {
                 ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
                 ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
         }
> 
>  	if (!ieee80211_get_he_sta_cap(sband))
>  		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> 
>  	rcu_read_lock();
> 
> -	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
> +	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
>  		const u8 *ht_oper_ie, *ht_cap_ie;
> 
>  		ht_oper_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_OPERATION);
[...]

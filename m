Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8C463A9A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 16:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbhK3P4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 10:56:25 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:49632 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240114AbhK3Pxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 10:53:39 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.171])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D28BB2A0076;
        Tue, 30 Nov 2021 15:50:10 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 595DF9C0072;
        Tue, 30 Nov 2021 15:50:10 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.71.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 589C413C2B0;
        Tue, 30 Nov 2021 07:50:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 589C413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1638287409;
        bh=qwAT3bJ7cuf0LLaB5IIYFUudlUnCmA0OATwf0/yh9R8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cGDOjOhV5f1T8YN9e+hu4m7ulTy4UV7ZyUVbx83YYqP8LSGZD2fIBdpfGlXqDfTW+
         bX10OIoMOOvdBBfvqi41yukNB6TaPx4jes39r2zokzxeENbQUpaoH7RiKtf8RMkIta
         7rUsMb5Si/J71duzdgqHmWPizle8lgcfUf5gwdDg=
Subject: Re: [PATCH v2] mac80211: add more HT/VHT/HE state logging
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <iwlwifi.20211129152938.9e81043f04f6.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
 <iwlwifi.20211130131608.ac51d574458c.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <30293d97-c0bb-1902-7bfd-9af543163caa@candelatech.com>
Date:   Tue, 30 Nov 2021 07:50:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20211130131608.ac51d574458c.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1638287411-MykMN4owVJen
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/30/21 3:16 AM, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add more logging in places that affect HT/VHT/HE state, so
> things get easier to debug.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
> 
> In v2:
>    * removed "if (vht_cap)" in one of the changes.  Merge mistake.
> 
> net/mac80211/mlme.c | 45 +++++++++++++++++++++++++++++++++------------
>   1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 54ab0e1ef6ca..666955ef300f 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -164,12 +164,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   	chandef->freq1_offset = channel->freq_offset;
>   
>   	if (channel->band == NL80211_BAND_6GHZ) {
> -		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef))
> +		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef)) {
> +			mlme_dbg(sdata,
> +				 "bad 6 GHz operation, disabling HT/VHT/HE\n");
>   			ret = IEEE80211_STA_DISABLE_HT |
>   			      IEEE80211_STA_DISABLE_VHT |
>   			      IEEE80211_STA_DISABLE_HE;
> -		else
> +		} else {
>   			ret = 0;
> +		}
>   		vht_chandef = *chandef;
>   		goto out;
>   	} else if (sband->band == NL80211_BAND_S1GHZ) {
> @@ -190,6 +193,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
>   
>   	if (!ht_oper || !sta_ht_cap.ht_supported) {
> +		mlme_dbg(sdata, "HT operation missing / HT not supported\n");

In case you re-spin this, I prefer that you not only have text like that above, but
then also explain what is happening, for instance, add:   Disabling HT/VHT/HE,
and maybe print out ht_oper and sta_ht_cap.ht_supported so you can see exactly why
it hit this code path.

Similar suggestions for changes below...

Thanks,
Ben

>   		ret = IEEE80211_STA_DISABLE_HT |
>   		      IEEE80211_STA_DISABLE_VHT |
>   		      IEEE80211_STA_DISABLE_HE;
> @@ -223,6 +227,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   	if (sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
>   		ieee80211_chandef_ht_oper(ht_oper, chandef);
>   	} else {
> +		mlme_dbg(sdata, "40 MHz not supported\n");
>   		/* 40 MHz (and 80 MHz) must be supported for VHT */
>   		ret = IEEE80211_STA_DISABLE_VHT;
>   		/* also mark 40 MHz disabled */
> @@ -231,6 +236,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   	}
>   
>   	if (!vht_oper || !sband->vht_cap.vht_supported) {
> +		mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
>   		ret = IEEE80211_STA_DISABLE_VHT;
>   		goto out;
>   	}
> @@ -253,7 +259,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   						&vht_chandef)) {
>   			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
>   				sdata_info(sdata,
> -					   "HE AP VHT information is invalid, disable HE\n");
> +					   "HE AP VHT information is invalid, disabling HE\n");
>   			ret = IEEE80211_STA_DISABLE_HE;
>   			goto out;
>   		}
> @@ -263,7 +269,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   					       &vht_chandef)) {
>   		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
>   			sdata_info(sdata,
> -				   "AP VHT information is invalid, disable VHT\n");
> +				   "AP VHT information is invalid, disabling VHT\n");
>   		ret = IEEE80211_STA_DISABLE_VHT;
>   		goto out;
>   	}
> @@ -271,7 +277,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   	if (!cfg80211_chandef_valid(&vht_chandef)) {
>   		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
>   			sdata_info(sdata,
> -				   "AP VHT information is invalid, disable VHT\n");
> +				   "AP VHT information is invalid, disabling VHT\n");
>   		ret = IEEE80211_STA_DISABLE_VHT;
>   		goto out;
>   	}
> @@ -284,7 +290,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
>   	if (!cfg80211_chandef_compatible(chandef, &vht_chandef)) {
>   		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
>   			sdata_info(sdata,
> -				   "AP VHT information doesn't match HT, disable VHT\n");
> +				   "AP VHT information doesn't match HT, disabling VHT\n");
>   		ret = IEEE80211_STA_DISABLE_VHT;
>   		goto out;
>   	}
> @@ -5036,19 +5042,23 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   
>   	/* disable HT/VHT/HE if we don't support them */
>   	if (!sband->ht_cap.ht_supported && !is_6ghz) {
> +		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>   	}
>   
>   	if (!sband->vht_cap.vht_supported && is_5ghz) {
> +		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>   	}
>   
>   	if (!ieee80211_get_he_iftype_cap(sband,
> -					 ieee80211_vif_type_p2p(&sdata->vif)))
> +					 ieee80211_vif_type_p2p(&sdata->vif))) {
> +		mlme_dbg(sdata, "HE not supported, disabling it\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +	}
>   
>   	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
>   		ht_oper = elems->ht_operation;
> @@ -5072,6 +5082,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   		}
>   
>   		if (!elems->vht_cap_elem) {
> +			sdata_info(sdata,
> +				   "bad VHT capabilities, disabling VHT\n");
>   			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>   			vht_oper = NULL;
>   		}
> @@ -5119,8 +5131,10 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>   		break;
>   	}
>   
> -	if (!have_80mhz)
> +	if (!have_80mhz) {
> +		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> +	}
>   
>   	if (sband->band == NL80211_BAND_S1GHZ) {
>   		s1g_oper = elems->s1g_oper;
> @@ -5684,12 +5698,14 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>   	else if (!is_6ghz)
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>   	vht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_VHT_CAPABILITY);
> -	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap))
> +	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
>   		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
>   		       sizeof(struct ieee80211_vht_cap));
> -	else if (is_5ghz)
> +	} else if (is_5ghz) {
> +		sdata_info(sdata, "VHT capa missing/short, disabling VHT/HE\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
>   				IEEE80211_STA_DISABLE_HE;
> +	}
>   	rcu_read_unlock();
>   
>   	if (WARN((sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_UAPSD) &&
> @@ -5763,16 +5779,21 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>   	}
>   
>   	if (req->flags & ASSOC_REQ_DISABLE_HT) {
> +		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>   	}
>   
> -	if (req->flags & ASSOC_REQ_DISABLE_VHT)
> +	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
> +		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> +	}
>   
> -	if (req->flags & ASSOC_REQ_DISABLE_HE)
> +	if (req->flags & ASSOC_REQ_DISABLE_HE) {
> +		mlme_dbg(sdata, "HE disabled by flag, disabling VHT\n");
>   		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +	}
>   
>   	err = ieee80211_prep_connection(sdata, req->bss, true, override);
>   	if (err)
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB62426FAD3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgIRKqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKqC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:46:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57758C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:46:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDtw-006CeO-Hs; Fri, 18 Sep 2020 12:46:00 +0200
Message-ID: <c0d5ddf778f4e8814195b6982275577a8803433f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 11/22] cfg80211: parse S1G Operation element for BSS
 channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:45:59 +0200
In-Reply-To: <20200831205600.21058-12-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-12-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> Extract the BSS primary channel from the S1G Operation
> element.

Out of curiosity, do you even need to?

I mean ... you know what channel you received it on, surely?

> @@ -1318,15 +1318,26 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
>  	tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
>  	if (tmp && tmp[1] == 1) {
>  		channel_number = tmp[2];
> -	} else {
> -		tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
> -		if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
> -			struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
> +		goto found_channel;
> +	}
>  
> -			channel_number = htop->primary_chan;
> -		}
> +	tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
> +	if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
> +		struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
> +
> +		channel_number = htop->primary_chan;
> +		goto found_channel;
> +	}
> +
> +	tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
> +	if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
> +		struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
> +
> +		channel_number = s1gop->primary_ch;
> +		goto found_channel;
>  	}

I *am* a bit worried about this though - do you really want to try to
parse DS elements on S1G, or S1G elements on other bands? Seems like
there ought to be a band check here?

johannes


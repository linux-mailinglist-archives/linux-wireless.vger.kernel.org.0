Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D16223327A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgG3M5y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3M5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:57:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2FC061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 05:57:52 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k1887-00DX54-8O; Thu, 30 Jul 2020 14:57:51 +0200
Message-ID: <5ccd3a30d9ede70148f1d02d397a8243c37b9c7b.camel@sipsolutions.net>
Subject: Re: [PATCH V2 02/10] nl80211: add attributes for multiple bssid
 related settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 14:57:50 +0200
In-Reply-To: <20200706115219.663650-2-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
         <20200706115219.663650-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-07-06 at 13:52 +0200, John Crispin wrote:
> 
> @@ -1126,6 +1137,7 @@ struct cfg80211_ap_settings {
>  	u32 flags;
>  	struct ieee80211_he_obss_pd he_obss_pd;
>  	struct cfg80211_he_bss_color he_bss_color;
> +	struct ieee80211_multi_bssid multi_bssid;

Missing docs?

>  };
>  
>  /**
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index b7a5d1de7aff..45b88f1221b0 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2511,6 +2511,11 @@ enum nl80211_commands {
>   * @NL80211_ATTR_MULTI_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
>   *	the parent interface.
>   *
> + * @NL80211_ATTR_MULTI_BSSID_INDEX: The index of this BSS inside the multi bssid
> + *	IE.

Element, not "IE", these days ... :)

johannes


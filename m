Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377DE59C74
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF1NEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 09:04:02 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50234 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1NEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 09:04:01 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgqXn-0001Ld-VO; Fri, 28 Jun 2019 15:04:00 +0200
Message-ID: <e293e8e7b38ba504eec40f396d21d3271c780a85.camel@sipsolutions.net>
Subject: Re: [RFC V2 5/8] cfg80211: add 6GHz in code handling array with
 NUM_NL80211_BANDS entries
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 28 Jun 2019 15:03:58 +0200
In-Reply-To: <1561461027-10793-6-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
         <1561461027-10793-6-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-25 at 13:10 +0200, Arend van Spriel wrote:
> 
> +++ b/net/wireless/trace.h
> @@ -2446,10 +2446,11 @@
>  		       sizeof(int) * NUM_NL80211_BANDS);
>  	),
>  	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", "
> -		  "mcast_rates [2.4GHz=0x%x, 5.2GHz=0x%x, 60GHz=0x%x]",
> +		  "mcast_rates [2.4GHz=0x%x, 5.2GHz=0x%x, 6GHz=0x%x, 60GHz=0x%x]",
>  		  WIPHY_PR_ARG, NETDEV_PR_ARG,
>  		  __entry->mcast_rate[NL80211_BAND_2GHZ],
>  		  __entry->mcast_rate[NL80211_BAND_5GHZ],
> +		  __entry->mcast_rate[NL80211_BAND_6GHZ],
>  		  __entry->mcast_rate[NL80211_BAND_60GHZ])
>  );

This doesn't really - you just pointed out that legacy rates aren't
permitted, and so this bitmap doesn't make sense for 6 GHz?

johannes


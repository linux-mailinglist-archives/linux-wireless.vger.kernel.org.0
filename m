Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3995926FAFB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRKwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:52:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686FC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:52:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJE0V-006Cri-Rs; Fri, 18 Sep 2020 12:52:47 +0200
Message-ID: <d922fa0215d8617c92948e1ddee5d23f77610723.camel@sipsolutions.net>
Subject: Re: [PATCH v2 15/22] mac80211: don't calculate duration for S1G
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:52:47 +0200
In-Reply-To: <20200831205600.21058-16-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-16-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> For now just skip the duration calculation for frames
> transmitted on the S1G band and avoid a warning.
> 
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
> ---
>  net/mac80211/tx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index d2136007e2eb..bef19616c5f0 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -82,6 +82,10 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
>  
>  	erp = txrate->flags & IEEE80211_RATE_ERP_G;
>  
> +	/* TODO */
> +	if (sband->band == NL80211_BAND_S1GHZ)
> +		return 0;


I'm not even sure I'd leave a TODO there ... just say

	/* device is expected to do this */

or so?

johannes


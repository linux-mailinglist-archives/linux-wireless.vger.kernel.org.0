Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7837D26FA9E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIRKbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRKbl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8039C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:31:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDg3-006CAp-9A; Fri, 18 Sep 2020 12:31:39 +0200
Message-ID: <6f43e5779e7ea7959e7614fc0a28e07c33f6f7ee.camel@sipsolutions.net>
Subject: Re: [PATCH v4 11/14] mac80211: support using
 ieee80211_tx_status_ext to free skbs without status info
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 12:31:38 +0200
In-Reply-To: <20200908123702.88454-12-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
         <20200908123702.88454-12-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-08 at 14:36 +0200, Felix Fietkau wrote:
> For encap-offloaded packets, ieee80211_free_txskb cannot be used, since it
> does not have the vif pointer.
> Using ieee80211_tx_status_ext for this purpose has the advantage of being able
> avoid an extra station lookup for AQL
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/mac80211/status.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index ac4d988556b0..a3543c3dbd3d 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -1087,6 +1087,24 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
>  	bool acked, noack_success;
>  	u16 tx_time_est;
>  
> +	if (pubsta)
> +		sta = container_of(pubsta, struct sta_info, sta);

There were some conflicts, e.g. this was already in place ...

Please check once I push it out.

johannes



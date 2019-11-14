Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556CFFC207
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 10:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNJCI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 04:02:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57972 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNJCH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 04:02:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 068A560B6E; Thu, 14 Nov 2019 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573722127;
        bh=M9b6tWWRlv/nIgD8aV0jdiAlB4CPupsLqn0ahdsi6T8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HZxlLjbdCnikXWixno/p9VEazlGEOZAkRIGrvkZGBhw1faDQOnAxwXPIu5gGpmFGM
         JrJkkBJ8u1ROYyNEViY0zQh0gi2TEBAiITm4xafmPd70eEQN8oNVBhX+jE6wOWSuqN
         oBpXNxVZp+uI1GymA0UV3DoUHeSg+KVT39p6VUEM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D55A60B14;
        Thu, 14 Nov 2019 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573722126;
        bh=M9b6tWWRlv/nIgD8aV0jdiAlB4CPupsLqn0ahdsi6T8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CzrhYIqDY0feJZ/svA4pv5LiHbCqgjky4ET2HIPi0vvnoTHIKdmBuSrDArFhCKgor
         4Gb4voVMY+3AyB4nPIy0bmxEOb+eVDTobKPJ5jX6s9ZX1B1v27A/26uRBZXKXzjcF5
         5GgvY2uXSdkGBUchCrHuyF5ER6Ght2EfFtrWk/E0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D55A60B14
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ming Chen <ming032217@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: Re: [PATCH] mac80211: Drop the packets whose source or destination mac address is empty
References: <20191114001230.71469-1-ming.chen@watchguard.com>
Date:   Thu, 14 Nov 2019 11:02:00 +0200
In-Reply-To: <20191114001230.71469-1-ming.chen@watchguard.com> (Ming Chen's
        message of "Wed, 13 Nov 2019 16:12:30 -0800")
Message-ID: <874kz6de5z.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ming Chen <ming032217@gmail.com> writes:

> We occasionally found ath9k could receive some packets from Linux IP stack
> with empty source and destination mac address,which will result in the
> driver cannot find the station node in TX complete. And thus, the driver
> will complete this buffer but without updating the block ack window.
>
> To fix this issue, we should drop this kind of error packet before it
> goes into the driver.

s-o-b missing, please read:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#signed-off-by_missing

> ---
>  net/mac80211/tx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index db38be1b75fa..0668123e8e85 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2481,6 +2481,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
>  	bool tdls_peer;
>  	bool multicast;
>  	u16 info_id = 0;
> +	const int empty_mac[ETH_ALEN] = {0};
>  	struct ieee80211_chanctx_conf *chanctx_conf;
>  	struct ieee80211_sub_if_data *ap_sdata;
>  	enum nl80211_band band;
> @@ -2489,6 +2490,13 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
>  	if (IS_ERR(sta))
>  		sta = NULL;
>  
> +	/* drop this skb when source mac or destination mac is empty */
> +	if (!memcmp(skb->data, empty_mac, ETH_ALEN) ||
> +	    !memcmp(skb->data + ETH_ALEN, empty_mac, ETH_ALEN)) {
> +		ret = -ENOTCONN;
> +		goto free;
> +	}

Can you use is_zero_ether_addr()?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

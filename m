Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2E41E79F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 08:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352148AbhJAGei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 02:34:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23243 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbhJAGeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 02:34:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633069973; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=yngI8d9kE9NDRbOqrv6sx2IfRNF26J+yF9N7nFydqCA=; b=g1KHl1dgCvS61/ru3+iNbYoEfJZqqWTqdbszcRy4VQ+OmXgIDLV72RYjavHYoeNy0WDTJblM
 5ffAVmGlUBAgszkSPpwLxJhNQYGx+uoRNHCDVKZ/vIQSrDIzO0XqSi0Wd/3EMhU798Ft4t24
 2GyAVJLJYluUAbqbQKC1GXT95VQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6156ab9363b1f186582a527d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 06:32:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7187EC4360C; Fri,  1 Oct 2021 06:32:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6926C4338F;
        Fri,  1 Oct 2021 06:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E6926C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mac80211: do intersection with he mcs and nss set of peer and own
References: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
        <1609816120-9411-3-git-send-email-wgong@codeaurora.org>
        <b6c96c4ecdf9ec175d7f89e8600fb53768287cc2.camel@sipsolutions.net>
        <facd18458a7ecfc0afbfd06c8a57d849@codeaurora.org>
Date:   Fri, 01 Oct 2021 09:32:45 +0300
In-Reply-To: <facd18458a7ecfc0afbfd06c8a57d849@codeaurora.org> (Wen Gong's
        message of "Wed, 29 Sep 2021 11:20:01 +0800")
Message-ID: <87bl49mf02.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2021-09-28 21:02, Johannes Berg wrote:
>> Hi,
>>
>>
>> I had done a bunch of fixups to this patch, but the zero-day build
>> robot
>> correctly reports that:
>>
>>> +	ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80,
>>> +				      &he_cap->he_mcs_nss_supp.rx_mcs_80,
>>> +				      &own_he_cap.he_mcs_nss_supp.tx_mcs_80,
>>> +				      &he_cap->he_mcs_nss_supp.tx_mcs_80);
>>
>> the &own_he_cap... parts here will take an __le16 pointer to a possibly
>> unaligned variable - any thoughts how we could fix that?
>>
> Hi Johannes,
>
> Add "__packed" before the "__le16 *" should solve this warning by my
> understand like this:
>
> diff --git a/net/mac80211/he.c b/net/mac80211/he.c
> index c05af7018f79..960fea9646b0 100644
> --- a/net/mac80211/he.c
> +++ b/net/mac80211/he.c
> @@ -52,7 +52,7 @@ ieee80211_update_from_he_6ghz_capa(const struct
> ieee80211_he_6ghz_capa *he_6ghz_
>         sta->sta.he_6ghz_capa = *he_6ghz_capa;
>  }
>
> -static void ieee80211_he_mcs_disable(__le16 *he_mcs)
> +static void ieee80211_he_mcs_disable(__packed __le16 *he_mcs)
>  {
>         u32 i;
>
> @@ -60,8 +60,8 @@ static void ieee80211_he_mcs_disable(__le16 *he_mcs)
>                 *he_mcs |= cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED
> << i * 2);
>  }
>
> -static void ieee80211_he_mcs_intersection(__le16 *he_own_rx, __le16
> *he_peer_rx,
> -                                         __le16 *he_own_tx, __le16
> *he_peer_tx)
> +static void ieee80211_he_mcs_intersection(__packed __le16 *he_own_rx,
> __packed __le16 *he_peer_rx,
> +                                         __packed __le16 *he_own_tx,
> __packed __le16 *he_peer_tx)
>  {
>         u32 i;
>         u16 own_rx, own_tx, peer_rx, peer_tx;
>
>
>
> net/mac80211/he.c:158:33: warning: taking address of packed member
> 'rx_mcs_80' of class or structure 'ieee80211_he_mcs_nss_supp' may
> result in an unaligned pointer value [-Waddress-of-packed-member]

I don't know what Johannes thinks, but to me that looks like an ugly
hack. Wouldn't use get_unaligned() or similar be cleaner?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

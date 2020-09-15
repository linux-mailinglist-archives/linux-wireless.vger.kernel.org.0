Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87026A554
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIOMep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 08:34:45 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:48306 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgIOMd2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 08:33:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600173202; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EROatjBP0EJsfyOd4pXy53/USKzLz3vEtCJA0R1bLig=;
 b=mWBSOaUgyc0bEhVZxRGOI6PY+K+4bHLoX3idsbEVKWpzYPGhrsCFPDMxNb83SFCNLbM/erd5
 OzXvuVcu+P6Qh179nypPoXheCJsVOjuW+h6lj3PYAIK0Un6fdDRvdUvlzZ4TxFhV3lGGmnEa
 +0l7PQsJTxHjKjzynAZu5Yl8CEE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f60b47754e87432bed54d18 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 12:32:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4F96C433F0; Tue, 15 Sep 2020 12:32:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 693B6C433C8;
        Tue, 15 Sep 2020 12:32:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 20:32:53 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v5 2/8] ath11k: add support for 6GHz radio in driver
In-Reply-To: <a5cac45b02396c98628738cef7f92ad1@codeaurora.org>
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
 <20200603001724.12161-3-pradeepc@codeaurora.org>
 <a5cac45b02396c98628738cef7f92ad1@codeaurora.org>
Message-ID: <e08a20b99363d68626bc38b6e3d2fcfd@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-15 19:16, Wen Gong wrote:
> On 2020-06-03 08:17, Pradeep Kumar Chitrapu wrote:
>> This patch adds 6GHz band support and mac80211 registration for
>> the 6G phy radio.
>> 
>> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
>> ---
>> v5:
>>  - do not add ht/vht caps in 6ghz band.
>> v3:
>>  - update 6GHz starting frequency as defined in IEEE P802.11ax/D6.1
>> 
>>  drivers/net/wireless/ath/ath11k/core.h |  6 +-
>>  drivers/net/wireless/ath/ath11k/mac.c  | 93 
>> +++++++++++++++++++++-----
>>  drivers/net/wireless/ath/ath11k/wmi.c  | 16 ++++-
>>  3 files changed, 94 insertions(+), 21 deletions(-)
>> 
> [...]
>> @@ -3482,7 +3494,7 @@ static void ath11k_mac_setup_ht_vht_cap(struct 
>> ath11k *ar,
>>  						    rate_cap_rx_chainmask);
>>  	}
>> 
>> -	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
>> +	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP && 
>> !ar->supports_6ghz) {
>>  		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
>>  		ht_cap = cap->band[NL80211_BAND_5GHZ].ht_cap_info;
>>  		if (ht_cap_info)
> After this change, when 6G is support, it removed HT/VHT of 5G band
> from "iw list", when connect to an 11AX AP of 5G, it used non-HT.
> caused together with this commit
> 75e296e9b22aef6fa467523ace87ef623dac1fad(mac80211: simplify and
> improve HT/VHT/HE disable code)
> +       /* disable HT/VHT/HE if we don't support them */
> +       if (!sband->ht_cap.ht_supported) {
> +               ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
> +               ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
> +               ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
> +       }
> 
> after remove this change in ath11k, it become correct to HE
> iw wls1 station dump:
> rx bitrate:     149.7 MBit/s HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
> 
Hi Pradeep Kumar Chitrapu,
For QCA6390, it is single_pdev, the pdev support all 2G/5G/6G,
Is it have 3 pdev/ath11k in your chip for 2G/5G/6G?
And the pdev/ath11k of 6G have WMI_HOST_WLAN_5G_CAP of 
cap->supported_bands?
> [...]

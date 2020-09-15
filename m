Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4A26B3B6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 01:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgIOXIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 19:08:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13231 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727413AbgIOXIJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 19:08:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600211283; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7nyXYw+qfF6wJrk28EGZNuPpSkSDFpWpRryxT77+ECc=;
 b=Hyah64co04i5O6zSFywO2gf7jjPVY5y8srM0Ey/AZcWhh3NFBtJ6lAy2FPIpMsve7y3q0/1E
 6enUTu2QRJL2fhsBveWdWGHaInWMrpFNuio2gzm0akfC6hKidV7s2tvVSt0k137DupeGH1HA
 9h7YbEBT14RtJ/vkYBUQBq+skZw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f614951d2819a1846c999be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 23:08:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A5C7C433F0; Tue, 15 Sep 2020 23:08:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C55CC433FE;
        Tue, 15 Sep 2020 23:07:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 16:07:59 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v5 2/8] ath11k: add support for 6GHz radio in driver
In-Reply-To: <e08a20b99363d68626bc38b6e3d2fcfd@codeaurora.org>
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
 <20200603001724.12161-3-pradeepc@codeaurora.org>
 <a5cac45b02396c98628738cef7f92ad1@codeaurora.org>
 <e08a20b99363d68626bc38b6e3d2fcfd@codeaurora.org>
Message-ID: <0b4f6d618388a97082009ba5380afbf5@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>>> 
>>> -	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
>>> +	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP && 
>>> !ar->supports_6ghz) {
>>>  		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
>>>  		ht_cap = cap->band[NL80211_BAND_5GHZ].ht_cap_info;
>>>  		if (ht_cap_info)
>> After this change, when 6G is support, it removed HT/VHT of 5G band
>> from "iw list", when connect to an 11AX AP of 5G, it used non-HT.
>> caused together with this commit
>> 75e296e9b22aef6fa467523ace87ef623dac1fad(mac80211: simplify and
>> improve HT/VHT/HE disable code)
>> +       /* disable HT/VHT/HE if we don't support them */
>> +       if (!sband->ht_cap.ht_supported) {
>> +               ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>> +               ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>> +               ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>> +       }
>> 
>> after remove this change in ath11k, it become correct to HE
>> iw wls1 station dump:
>> rx bitrate:     149.7 MBit/s HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
Hi Wen,

Do you have 
https://lore.kernel.org/linux-wireless/20200528213443.25687d2695bc.I3f9747c1147480f65445f13eda5c4a5ed4e86757@changeid/?

>> 
> Hi Pradeep Kumar Chitrapu,
> For QCA6390, it is single_pdev, the pdev support all 2G/5G/6G,
> Is it have 3 pdev/ath11k in your chip for 2G/5G/6G?
> And the pdev/ath11k of 6G have WMI_HOST_WLAN_5G_CAP of 
> cap->supported_bands?
>> [...]
Yes, ath11k receives WMI_HOST_WLAN_5G_CAP from firmware for 6G as well.


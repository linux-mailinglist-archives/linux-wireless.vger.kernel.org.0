Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E741BECE2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD3AL2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 20:11:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:40884 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgD3AL1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 20:11:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588205487; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2ZYd6vN3Z5HaXMPEGMliAHDQJA0b5a9bpA7SE5OwoJA=;
 b=N8SyjWe4vtT1wr1G2YzEBwTIshnosJE1cPNQnhTW3LldyFodcJAsw+TjWyGgi9I3wVnYxOuT
 4+Olas8lW6vaK/aBIr8J+A1kIGeSgAi1ur/rl+9JjFSk7giOTZ7Kioe/ZSx9j7Vv2aMg6uRT
 H9S4GpMssEyZ4gu3Uwk5GedZA7Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaa17ad.7f3ef7432260-smtp-out-n03;
 Thu, 30 Apr 2020 00:11:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D7E3C433D2; Thu, 30 Apr 2020 00:11:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41832C433CB;
        Thu, 30 Apr 2020 00:11:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 17:11:24 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/10] mac80211: handle HE 6 GHz Capability in HE STA
 processing
In-Reply-To: <8e55825d2c399dc926dacdc799fc64851d2fc4fb.camel@sipsolutions.net>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
 <1587768108-25248-6-git-send-email-rmanohar@codeaurora.org>
 <8e55825d2c399dc926dacdc799fc64851d2fc4fb.camel@sipsolutions.net>
Message-ID: <a555a6cd27c5b100d2d11804c5b387de@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 07:31, Johannes Berg wrote:
> On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
>> 
>>   * @has_he: true iff HE data is valid.
>> + * @has_he_6ghz: true iff HE 6 GHz data is valid.
>>   * @he_cap_elem: Fixed portion of the HE capabilities element.
>>   * @he_mcs_nss_supp: The supported NSS/MCS combinations.
>>   * @ppe_thres: Holds the PPE Thresholds data.
>> + * @ampdu_factor: Maximum A-MPDU length factor used in 6 GHz.
>> + * @ampdu_density: Minimum A-MPDU spacing used in 6 GHz.
>> + * @he_6gz_cap: HE 6 GHz Band capability.
> 
> typo
> 
>>   */
>>  struct ieee80211_sta_he_cap {
>>  	bool has_he;
>> +	bool has_he_6ghz;
>>  	struct ieee80211_he_cap_elem he_cap_elem;
>>  	struct ieee80211_he_mcs_nss_supp he_mcs_nss_supp;
>>  	u8 ppe_thres[IEEE80211_HE_PPE_THRES_MAX_LEN];
>> +	u8 ampdu_factor;
>> +	u8 ampdu_density;
>> +	u16 he_6ghz_cap;
> 
> Maybe these should be in some kind of sub-struct so it's clear what the
> "has_he_6ghz" applies to?
> 
Got it.

>>  };
>> 
>>  /**
>> @@ -1272,7 +1280,7 @@ struct station_parameters {
>>  	u8 he_capa_len;
>>  	u16 airtime_weight;
>>  	struct sta_txpwr txpwr;
>> -	const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;
>> +	const u8 *he_6ghz_capa;
> 
> hm?
> 

I realized later ;) that ieee80211_he_cap_ie_to_sta_he_cap accepting u8* 
for IEs.
To align with the existing pattern changed to u8 *. Let me correct it 
first.

-Rajkumar

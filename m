Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80623673C1D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjASOft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 09:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjASOfe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 09:35:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0C67974
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:35:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so6116371ejc.10
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/wCr+oyngzlRh+eWqadAOW0a1BZXf9k2NIv2t5yris=;
        b=cm8cYIGyYEcCjRHE8Y3hWnXqcfV3RaWQqqu1DW0SwarXmigQYYPOrSXRNG4pnCQvfJ
         M8tPUZSponY8NXAJyjyivZLc1xXiA6YDAYU5Js8H0xryoglPAa5Ev44NvoGLp+dSS8uz
         yrPsHvlnu6qK8QvPFk9LNXEcCq2O5gXd8FF96PomUMAM0VgCV2lOVobHISF6n6vjRay/
         3xXfZedzDDZnS+Ypvi6AXF9lLnNNgcU1bz8v/YLUAk68OU2FPPswlTSu/eex+gt3fD8k
         DzEuts1nuw24Drnr8qUv5t6QuHabsNUP05ZDtody0GdrAEDdWrk39TusVXtBqAv+YGjF
         SXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/wCr+oyngzlRh+eWqadAOW0a1BZXf9k2NIv2t5yris=;
        b=jGLcPvkhZSZp4PxPfsd+2w5MpClxll7/s3RJL2ePQhYvJLfA4VN1vi9CoGA61pNqn5
         GUi7KCZIE6IUu42JcTRhYMw/CfqhCBgyGI/DBq914DUpL21i/oKJxku+jiwX/OX8CBwS
         HiFZtlJuM2ZCE6+kXlYLvoS2KTy5c5U6J+3FyVs6w5bgxg70Kdz3dgZ9SX2eV+ifU6rf
         6H//Nh4nyGsBX0lILvIruOwxHDNWlXjfsZnYFEHPehMaEuHwcW67704/6KM5Jd/pnjaU
         k+q1PtlUSkXqHApijRVTuL/2+zanDuIiBdirAKrTopClNIzcUI5tMC8mJ+VZTuZsrjHo
         qzcQ==
X-Gm-Message-State: AFqh2kp9f1M8VqUrCSAkpdNIYOuxZPE/3gP4aAE7AY++cJqimQOHMG4n
        n2/DVkXTqRWblRt0qs+CzVM=
X-Google-Smtp-Source: AMrXdXswBj5005ZBT8Z9L1a4yMcqJqHKUSLzVyZU9d7LclGqY4KDqXUfJJlp1lD6RjDIUdn62rXSBw==
X-Received: by 2002:a17:907:d110:b0:7ae:8194:7e06 with SMTP id uy16-20020a170907d11000b007ae81947e06mr13024176ejc.56.1674138923865;
        Thu, 19 Jan 2023 06:35:23 -0800 (PST)
Received: from smtpclient.apple ([2001:9e8:f13d:5500:8810:952c:6d58:93ff])
        by smtp.gmail.com with ESMTPSA id lh2-20020a170906f8c200b00877696c015asm1564130ejb.134.2023.01.19.06.35.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:35:23 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [RFC v2 4/6] mac80211: add utility function for tx_rate -
 rate_info conversion
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <f364ace23f73e90f9cf62b5c8238e78599b6b7ab.camel@sipsolutions.net>
Date:   Thu, 19 Jan 2023 15:34:52 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: 7bit
Message-Id: <3AA54978-0B7D-4FFD-9A45-423CDC2D1658@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-5-jelonek.jonas@gmail.com>
 <64731257b957f50b0f66e4d2fcd8c24dea8d70ff.camel@sipsolutions.net>
 <9AE44A41-6357-4F3A-BF75-8E3B0A381E9B@gmail.com>
 <f364ace23f73e90f9cf62b5c8238e78599b6b7ab.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 19. Jan 2023, at 12:35, Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> On Thu, 2023-01-19 at 12:31 +0100, Jonas Jelonek wrote:
>>> On 12. Jan 2023, at 11:26, Johannes Berg <johannes@sipsolutions.net>
>>> wrote:
>>> 
>>>> +void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate *rate,
>>>> + 							struct wiphy *wiphy, u8 band,
>>>> +  							struct rate_info *rate_info)
>>>> +{
>>>> +  	memset(rate_info, 0, sizeof(struct rate_info));
>>>> +
>>>> +  	if (rate->flags & IEEE80211_TX_RC_MCS) { /* 802.11n */
>>>> +  		rate_info->flags |= RATE_INFO_FLAGS_MCS;
>>>> +  		rate_info->mcs = rate->idx;
>>>> +  	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) { /* 802.11ac */
>>>> +  		rate_info->flags |= RATE_INFO_FLAGS_VHT_MCS;
>>>> +  		rate_info->mcs = ieee80211_rate_get_vht_mcs(rate);
>>>> +  		rate_info->nss = ieee80211_rate_get_vht_nss(rate);
>>>> +  } else { /* 802.11a/b/g */
>>> 
>>> what about HE/EHT?
>> 
>> ieee80211_tx_rate uses an s8 for rate/MCS index, so only up to VHT
>> rates fit in there.
>> For rates above VHT, rate_info is needed, thus are are no HE/EHT rates
>> occuring in
>> ieee80211_tx_rate. Same applies to your comment on the hwsim
>> conversion.
> 
> I guess I should've read the commit message more closely ;-)
> 
> But please add kernel-doc to the function; both in general it'd be good
> to have, and in particular explaining that this is more for older
> drivers I guess?

I will add that in my next RFC version to make sure this is clear.

Jonas

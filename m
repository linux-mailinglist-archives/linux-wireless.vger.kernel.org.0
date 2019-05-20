Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F823B27
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfETOu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 10:50:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45874 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfETOu1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 10:50:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1013F61ACF; Mon, 20 May 2019 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558363826;
        bh=LnnYhUQIsVDx3eoOmf0xQEXvOjKavJ7vu2egjrVCWEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CoG6Tpt/gAExgrKXQ2+VviFzGxMYSvos4WkQ/sBOt8qltMeb84gjpkrB8Mi1RyaQW
         MDgRm84pNt/3wobMzGGHiRzzTQqXpUfdbm2aLzPtzK193AYUyMg01fcCCj5EIE/SyS
         hoo+tKUF9YThds5hJR7H1UGlXJj3RcBvQCTagmQI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.18.172.35] (unknown [185.23.60.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ailizaro@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DB9A615E8;
        Mon, 20 May 2019 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558363825;
        bh=LnnYhUQIsVDx3eoOmf0xQEXvOjKavJ7vu2egjrVCWEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VBFpLb/Q1A9yh5Hn3lXPsdE4xpDPTHt3PkrqBUWzrTfwCVI+1603Q4WVzN8DDIOV3
         CgoSoaxeNS2cdIxD46I7NXsb0mRBT2pw7C/5anEutXz0xbmaL+5AtvHKSV33qfdVkn
         hUSkbUyEqGwxLOXZEK2V2M0U6bWxNGaKD02Tj8Ek=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DB9A615E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ailizaro@codeaurora.org
Subject: Re: [PATCH v2 1/2] nl80211: Add support for EDMG channels
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1557758554-18907-1-git-send-email-ailizaro@codeaurora.org>
 <1557758554-18907-2-git-send-email-ailizaro@codeaurora.org>
 <87k1eluvlg.fsf@purkki.adurom.net>
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Message-ID: <ba9f1ac9-5658-a530-dbd8-a2c3ec6203df@codeaurora.org>
Date:   Mon, 20 May 2019 17:50:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87k1eluvlg.fsf@purkki.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/20/2019 4:03 PM, Kalle Valo wrote:
> Alexei Avshalom Lazar <ailizaro@codeaurora.org> writes:
> 
>> 802.11ay specification defines Enhanced Directional Multi-Gigabit
>> (EDMG) STA and AP which allow channel bonding of 2 channels and more.
>> Introduce NL80211_ATTR_WIPHY_EDMG_CHANNELS,
>> NL80211_ATTR_WIPHY_EDMG_BW_CONFIG, NL80211_BAND_ATTR_EDMG_CHANNELS,
>> NL80211_BAND_ATTR_EDMG_BW_CONFIG and RATE_INFO_FLAGS_EDMG
>> that needed for enabling and configuring EDMG support.
>> Driver is expected to report its EDMG capabilities: whether EDMG
>> is supported and the supported EDMG channels.
>> Bitrate calculation is enhanced to take into account EDMG support
>> according to the 802.11ay specification.
>> The kernel uses NL80211_BAND_ATTR_EDMG_CHANNELS and
>> NL80211_BAND_ATTR_EDMG_BW_CONFIG attributes in order to publish
>> the EDMG capabilities to the userspace.
>> NL80211_BAND_ATTR_EDMG_CHANNELS is a bitmap field that indicates
>> the 2.16 GHz channel(s) that are allowed to be used for transmissions
>> in the BSS.
>> If NL80211_BAND_ATTR_EDMG_CHANNELS is not set then EDMG not
>> supported. NL80211_BAND_ATTR_EDMG_BW_CONFIG represent the allowed
>> channel bandwidth configurations.
>> NL80211_ATTR_WIPHY_EDMG_CHANNELS and NL80211_ATTR_WIPHY_EDMG_BW_CONFIG
>> will be used by the userspace for AP configuration and connect command.
>>
>> Change-Id: I534f4a750354a4b0baad28c47dc29afb9cbc36ac
> 
> No Change-Id in upstream patches. And please read:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#signed-off-by_missing
> 

Hi Kalle,
Thanks for sharing the Wiki page, I will raise updated patches.

-- 
Alexei Lazar
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum a 
Linux Foundation Collaborative Project

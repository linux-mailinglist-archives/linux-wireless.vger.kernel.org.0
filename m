Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0474C88B69
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfHJMlP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 08:41:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMlP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 08:41:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 08D996063F; Sat, 10 Aug 2019 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565440875;
        bh=yJ1BlyP2N+MGDpUxAHU8VlyACH1I6LtPj6CRxZyqCX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f+OFtFpgwFDZ07ppEVkE+P0/Huiv5wzYVmVKwVCOtHD6QGTvGb8j66QG5ztbCML5w
         sWSjgNfQZ34zvldTFLAqCdiTI7mzApdRSBFSm9BMomKFu4nkAyZjC3Zb+PxPqentq5
         l8tSiQu37Wlnyot29/zJomDI7dUsimElDHP3sxHw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A3B56602ED;
        Sat, 10 Aug 2019 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565440874;
        bh=yJ1BlyP2N+MGDpUxAHU8VlyACH1I6LtPj6CRxZyqCX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TDowV+u6LOHcpW402dXkH7Nnj9bAKaX824lvHMaHyyevfnVn9Y6fyOFKEmeaiqiqn
         3PShPpe0Os4RVdOtTH0i8vdGxihb64Mh5zPORP1GQef/LE4IFfScA1bZmnlbGLAICQ
         63eJtLbUds1jnuLvTaPuDfmYWcc6Sgev3vuz/uJI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 10 Aug 2019 18:11:14 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv6 3/9] nl80211: Add netlink attribute for AMPDU
 aggregation enable/disable
In-Reply-To: <1077c62701b31cfcb4436e6b13be64ade6b1ae1b.camel@sipsolutions.net>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-4-git-send-email-tamizhr@codeaurora.org>
 <1077c62701b31cfcb4436e6b13be64ade6b1ae1b.camel@sipsolutions.net>
Message-ID: <e704b7dd39c86c2596b6c0861a376117@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-31 14:58, Johannes Berg wrote:
> On Tue, 2019-06-18 at 10:57 +0530, Tamizh chelvam wrote:
>> 
>> +		if (!wiphy_ext_feature_isset(&rdev->wiphy,
>> +				NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL)) {
>> +			NL_SET_ERR_MSG_ATTR(extack,
>> +					    attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
>> +					    "TID specific configuration not "
>> +					    "supported");
>> +			return -ENOTSUPP;
>> +		}
>> +
>> +		if (peer && !wiphy_ext_feature_isset(&rdev->wiphy,
>> +				NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL)) {
>> +			NL_SET_ERR_MSG_ATTR(extack,
>> +					    attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
>> +					    "peer specfic TID configuration not "
>> +					    "supported");
>> +			return -ENOTSUPP;
>> +		}
> 
> I think you should probably make this be a function to which you pass
> the attribute pointer and feature flags.
> 
> err = nl80211_check_tid_config_supported(extack,
> 					 attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
> 					 NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
> 					 NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL);
> 
> since you have this code a lot?
> 
Sure, I will make that change in the next version of patchset.

Thanks,
Tamizh.

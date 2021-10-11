Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC74285AB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 06:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhJKEIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 00:08:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51312 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhJKEIP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 00:08:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633925176; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+56MsHvQUgwvmdOWMayKmrkXDzcge09CMTNZDQdtpZ0=;
 b=fUGjixsmboVsL1bTtCDXb6j1Y/chBmLXuH8ii5PkC25pT9B/NQAFst8AqDmKgTEilWk93XQs
 nmlVouqLdb9gydFmZcuMBx1RrxynRfYMwKZ1PZbGVo27YU+ybJUrVQplAq84zWAQjQST5x9E
 0zHkfNOnjvd3FGrLQsJYMA7nadY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6163b8338ea00a941f751be0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 04:06:11
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 619F2C4360C; Mon, 11 Oct 2021 04:06:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEAD4C4338F;
        Mon, 11 Oct 2021 04:06:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Oct 2021 12:06:10 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
References: <20210928085211.26186-1-wgong@codeaurora.org>
 <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
 <cb20427eae96c4551084e4c899618b94@codeaurora.org>
 <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
 <2ed76cff292dcca18326de0407a93821@codeaurora.org>
 <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
Message-ID: <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-30 20:50, Johannes Berg wrote:
> On Thu, 2021-09-30 at 10:53 +0800, Wen Gong wrote:
>> > >
>> > > 		chan->max_reg_power =
>> > > 			min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
>> > > 			      MBM_TO_DBM(power_rule2->max_eirp));
>> > >
>> > > For AP + STA concurrency, it should to maintain 2 group of reg rules,
>> > > one is for AP, another is for STA.
>> >
>> > Can we maintain two power rules in the same channel one for AP and one
>> > for STA. In this way, we can update the power rules in the same
>> > channel for both AP and STA from the reg rules.
>> >
>> > Otherwise, we need to maintain multiple channel lists in sband for all
>> > supported power mode combinations to apply the respective power rules
>> > and build channel flags from the multiple reg rules.
>> > right?
>> 
>> If AP+STA is up in the same wiphy/ieee80211_hw, and AP's reg rules is
>> different
>> with STA, then it should maintain muti channel list for each band of 
>> the
>> wiphy/ieee80211_hw by my understand.
> 
> I don't think that's how it works. You can today have AP/STA 
> concurrency
> on a single wiphy with different netdevs, even with mesh or whatever.
> 
>> Currently there is only one "struct ieee80211_supported_band
>> *bands[NUM_NL80211_BANDS]"
>> in "struct wiphy".
>> 
>> I advise to discuss the AP + STA concurrency in another mail thread
>> since it is not relative with this patch.
> 
> I actually explicitly pointed to this thread, but I'm not sure it's so
> clear cut?
> 
> If we have completely separate rules here for AP and STA, we probably
> should have different "max_reg_power" values for AP and STA? Maybe mesh
> is treated like AP, maybe not?
> 
> But I don't know - does PSD really differ between AP and STA?
> 
> Maybe this discussion belongs rather to the power type patch? But that
> didn't add any state!
> 
> 
> So - does this PSD depend on mode? It kind of seems like it shouldn't
> and then this *isn't* the right place to be discussing this, but if PSD
> does in fact depend on the mode then we should be discussing it here?
> 
> Venkatesh seemed to be worried more about LPI/client power etc. as in
> commit 405fca8a9461 ("ieee80211: add power type definition for 6 GHz"),
> but that doesn't add state?
> 
> So what gives? From a regulatory POV it seems PSD should be 
> independent,
> but some other things might be dependent on mode?
> 

As I know, below values maybe all different for the AP and
STATION in the same wiphy/ieee80211_hw, not only PSD.

struct ieee80211_reg_rule {
	struct ieee80211_freq_range freq_range;
	struct ieee80211_power_rule power_rule;
	struct ieee80211_wmm_rule wmm_rule;
	u32 flags;
	u32 dfs_cac_ms;
	bool has_wmm;
	s8 psd;
};

@Venkateswara, please feel free to give more info to Johannes:)

> johannes

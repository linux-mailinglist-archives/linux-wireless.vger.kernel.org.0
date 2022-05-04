Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F06519EC0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbiEDMED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiEDMDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 08:03:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B33F4A
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mY2mgK4GXixkyAnRyVErr8pNbuciIp0UGA/C/xY3T48=;
        t=1651665617; x=1652875217; b=t0K7nPsnXXYHDhjknCBPLNI54RCWsjTxQM6wMI2qgKHTaZz
        /UB6RxtEqgO40s+GlJzIrL8hDlgqsSZCwwQlje+R5iRcrPPWBnLJvjgSHgmLx0t8lNnnX1oX5ImC5
        j/G2rZyXTwkrc5ty37gSfQOtzkL6GQPBLo2Wu19GRLiN/FL3P67YknSbI7uikx3Wq9xTZZ0Hqdyk4
        l7SBSlFCdW/Wu7n0gswZYmkoEgpWSXHO85I0nH1MRK/odAKsYKqiGbI1Ap4Lc4AbPr7gl6wO+jmvo
        63MXDOUVt/LRxi4SloaHno/h6BnMmWEaXfZQomgJ7PgUIHOHNQ4UoOl3jQbs1/mQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDfu-0021gf-Or;
        Wed, 04 May 2022 14:00:10 +0200
Message-ID: <a0a40e7f40dd173cc4a3688bd77c90cc8c479ab7.camel@sipsolutions.net>
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, Wen Gong <wgong@codeaurora.org>
Cc:     Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org, quic_adisi@quicinc.com,
        quic_vnaralas@quicinc.com
Date:   Wed, 04 May 2022 14:00:09 +0200
In-Reply-To: <aee8fc50-3ffb-f985-f0ad-9752bb51890d@quicinc.com>
References: <20210928085211.26186-1-wgong@codeaurora.org>
         <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
         <cb20427eae96c4551084e4c899618b94@codeaurora.org>
         <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
         <2ed76cff292dcca18326de0407a93821@codeaurora.org>
         <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
         <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
         <DM8PR02MB8154258563A4F7C805C84B4BE6B59@DM8PR02MB8154.namprd02.prod.outlook.com>
         <0b05f6e555bcb89c49f56279c077ce63@codeaurora.org>
         <18363bc18538ea9b7e8fe28f4c5595c54f3b93d3.camel@sipsolutions.net>
         <67936afa5545b9a5d6eb5ad6931026d7@codeaurora.org>
         <6053b0963612057267f00b89e14b9e15@codeaurora.org>
         <68b700b371399db0ed4174d20ddd0b8b@codeaurora.org>
         <7761dc6f736b04cce1137b68a7132ac7@codeaurora.org>
         <aee8fc50-3ffb-f985-f0ad-9752bb51890d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry. I've been shying away from this, it's completely confusing me,
and the code isn't really helping that much, so far.

> PSD is another type power value as well as the power_rule in 
> ieee80211_reg_rule
> and max_reg_power/max_power in ieee80211_channel. For 6G, it need the
> both the 2 values (psd and tx-power) for power control.

Sure, that makes sense. You have PSD limits as well as TX power limits.

> To support LPI/SP/VLP mode + concurrency, it is not only to process the
> TX power and psd, it need to process all fields in ieee80211_reg_rule.
> for example, for the same country US, it has some ieee80211_reg_rule for
> 6G:
> LPI mode for AP mode is:
> (5945 - 7125 @ 160) (0, 30) (FLAGS 512) (psd 5 dB/MHz)
> 
> LPI mode for client mode is:
> (5945 - 7125 @ 160) (0, 24) (FLAGS 512) (psd -1 dB/MHz)
> 
> SP mode is:
> (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd 17 dB/MHz)
> (6525 - 6875 @ 160) (0, 30) (FLAGS 0) (psd 17 dB/MHz)
> 
> you can see the frequency range/flags/tx power/psd are not same between
> the 3 mode.

Right. But here I already don't understand - does that mean your
hardware can only be in one mode today overall? 

It seems you'd need to have separate regulatory rules per mode, and
possibly per interface type, no?

Or do you try to adjust the regulatory rules when the mode is switched?
But we try to have regulatory rules capture the overall status, not a
temporary status, and then apply the rules that make sense at any given
time.

> So the psd value is a same kind field as well as the frequency
> range/flags/tx power in ieee80211_reg_rule and ieee80211_channel.
> If it has only one interface in the same ieee80211_hw, the interface
> must choose one the the above modes at any time, and the reg rules
> will be updated when the interface changed its mode, then the info
> of channels of ieee80211_supported_band for 6G also update, it has
> no problem.

Ah OK, so you answer that question - you're actually changing the
regulatory rules, which is totally unexpected to me, since I'd expect
those to only change when the regulatory changes, not when you mode
switch ...

> When it has 2 interface up simultaneously in the same ieee80211_hw,
> then it will have problem. because the 2 interface share the same
> ieee80211_reg_rule and the same channels and same ieee80211_supported_band
> for 6G, if interface #1 is LPI-AP, and interface #2 is SP mode, then
> even the channels count is not same for the 2 interface, channels count
> of SP mode is smaller than LPI-AP, also the info of channel is not same.
> 
> So adding/not adding psd value into ieee80211_reg_rule/ieee80211_channel
> will not effect the problem of muti-interface concurrency issue of 6G.

Oh but I disagree - adding it will mean that this is how we interpret
the reg_rule, that it only carries the current status according to "the"
current mode (which isn't even well-defined), rather than the entirety
of the regulatory information.

> When muti-interface concurrency run, all the fields of ieee80211_reg_rule/
> ieee80211_channel should be split.

Right.

> I think the easy way is to save the channels of ieee80211_supported_band
> of 6G in each interface instead of ieee80211_hw, then interface #1/#2
> have/use their own channels, they use their own frequency range/flags/
> tx power/psd... 
> 

I'm not sure that will work, because we often compare chan pointers with
==, and if you're doing something like remain-on-channel that's still
relevant. So having the same channel struct on the same hardware with
the same frequency is bound to be problematic.

> This is a high level change, and adding psd into
> ieee80211_reg_rule/ieee80211_channel is a low level change. So I think
> they have no dependency with each other.

I think I disagree, per the above disagreement.

johannes

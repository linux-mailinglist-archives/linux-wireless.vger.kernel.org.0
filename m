Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCBE7AF3C2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjIZTGC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjIZTGB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 15:06:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A77DE
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 12:05:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D3C433C7;
        Tue, 26 Sep 2023 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695755154;
        bh=7wY1yolZBWdNMw1lFtLTpWHClKu+sx6vQPHOLa38gm4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V4Q1hwIbrhlonESOxBBuVzhtJhEWhEVya23Pkw282wJdvw9c0V0tIO8wG8/xOVLXw
         LmDMeAxtt9IezHDssvwaBnc3sEFkkT1JOYY0EydOKddUTamp9PE3CQKV77NNy+r5jB
         P+eWS0vmTX3OqaTqizdawvmvb3CMdm81LIcHAsIrg4ruEiXRR0z+m5jiCOMgxw/7zA
         dAX0d0UtDFdr4VSQtQqhc/cZYe6ZG3xI4pME+RElTleWvlmRHtjOc4f5wbNFSw0myW
         md5d1V/NjHl8K9jO2PxJuvlUa6Dlqb2TON2ZT1bvlt8HjM4sXWDyuvIpZuOY+Zj/qI
         cVI5RdCQ6mQug==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath11k: mac: fix struct
 ieee80211_sband_iftype_data handling
References: <20230926163350.2641064-1-kvalo@kernel.org>
        <49b5de54ca00f5521ceaa8210f587f2af48d6835.camel@sipsolutions.net>
Date:   Tue, 26 Sep 2023 22:05:51 +0300
In-Reply-To: <49b5de54ca00f5521ceaa8210f587f2af48d6835.camel@sipsolutions.net>
        (Johannes Berg's message of "Tue, 26 Sep 2023 18:43:56 +0200")
Message-ID: <87fs3092ls.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2023-09-26 at 19:33 +0300, Kalle Valo wrote:
>> 
>> - he_mcs_map =
>> le16_to_cpu(ath11k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
>> +	he_cap = ieee80211_get_he_iftype_cap_vif(sband, arvif->vif);
>> +	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(he_cap));
>
> Technically, ieee80211_get_he_iftype_cap_vif() could return NULL if you
> didn't actually configure/enable HE for this iftype, the static checkers
> might complain here.

And this is even mentioned in the documentation which I failed to see:

 * Return: pointer to the struct ieee80211_sta_he_cap, or %NULL is none found

Thanks! I'll fix this in v3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

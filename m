Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD223519715
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 07:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbiEDGBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiEDGBx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 02:01:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128227CDE
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 22:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B43DB823E5
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 05:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A9C385A5;
        Wed,  4 May 2022 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651643895;
        bh=6rMrdFlxB2HYNIr+QgW4lkKZhphhdlcyYYgYahs6rb4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HNqIa9aTzg5/UfzkCn4SMjoPG6ZMqskucwV33Iz1m4dZvXfBxS3c9IMvtFN9V2adZ
         ZV2kHeFNQVdf6ftnj3Aen4W4aagphLhWzWuur9J3MweRA6TvB+tk54Qx6Ud6GlgEfB
         dqQ3y5jwzulDsBGgYjpAiAGPQSa2F6XMj7WPRhxvix3kR999/aTPRvV2dQ0UY2pPFH
         3pJLsqEI0h4UiCFfBiKARXhHlWlER3HRNA+X2OkClAtnv4wRVaLD8z4p6xlIVN+FbK
         GrumAxvhLXw5REw5WcRLfrFGWYfLY2oU55IebuTg1h9AfHd1QPZwo1kGVo62IxqeQo
         Cd62BjMwOJvow==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] ath11k: mac: fix too long line
References: <20220503060415.24499-1-kvalo@kernel.org>
        <f2f27831-03eb-3788-5855-649c0f33c785@quicinc.com>
Date:   Wed, 04 May 2022 08:58:09 +0300
In-Reply-To: <f2f27831-03eb-3788-5855-649c0f33c785@quicinc.com> (Jeff
        Johnson's message of "Tue, 3 May 2022 08:17:55 -0700")
Message-ID: <87y1zhalfy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/2/2022 11:04 PM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> checkpatch warns:
>>
>> drivers/net/wireless/ath/ath11k/mac.c:7760: line length of 91 exceeds 90 columns
>>
>> This was introduced by commit 046d2e7c50e3 ("mac80211: prepare sta handling for
>> MLO support").
>>
>> Compile tested only.
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
>> index c76cac5d6849..32fb0142124d 100644
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -7735,6 +7735,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
>>   	bool he_fixed_rate = false, vht_fixed_rate = false;
>>   	struct ath11k_peer *peer, *tmp;
>>   	const u16 *vht_mcs_mask, *he_mcs_mask;
>> +	struct ieee80211_link_sta *deflink;
>>   	u8 vht_nss, he_nss;
>>   	bool ret = true;
>>   @@ -7757,13 +7758,16 @@
>> ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar,
>> enum nl80211_b
>>   	spin_lock_bh(&ar->ab->base_lock);
>>   	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
>>   		if (peer->sta) {
>> -			if (vht_fixed_rate && (!peer->sta->deflink.vht_cap.vht_supported ||
>> -					       peer->sta->deflink.rx_nss < vht_nss)) {
>> +			deflink = &peer->sta->deflink;
>
>
> is there a reason to not declare deflink here?
> then its scope of definition would equal the scope of usage

In ath10k and ath11k I have tried to avoid that and instead declare all
variables in the beginning of the function, this is to keep the code
simple. Of course there are few cases where a variable is declared in
the middle of the function, but that's just sloppy review on my part. I
feel that it's better to refactor the function into smaller functions
than start declaring variables in the middle of functions. Does that
make sense?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

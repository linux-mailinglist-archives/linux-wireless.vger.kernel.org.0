Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008060758D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJUK6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJUK6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 06:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724FB36BC8
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 03:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E1B461E2D
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 10:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBDCC433C1;
        Fri, 21 Oct 2022 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666349925;
        bh=70Ces4Q+pevX+GMvRqDBvO9S7E+kRyMBl08I5+iVKcg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OEG5U28Ao+OVH2adFKQt/1SfbDYWWAde72NaUijlNBj9aaM5F8LBErpesKdQtwz1F
         1AQ/XHTmsyz8jJjjxgKDfT7nSS3sETMz47RkUwy342LAbdsJno2o14EGpvuXj4JV6e
         6ru6QwYSsUIDjGOlSN/08Bv9UOTkSZh+UP8orB6EYxu2Pc0bFSg5jyCS5CTgTm/AUP
         CGiuCO8YVvtAZgXWdSlfjs62+E+T+/M/B+KAM73HTY5YkQAwcMYUYfG9IvejI2Nkwh
         RcTwgLmnKWxSZCJipQZwdlUs7rev3LrcHvdVap5L8ca2j2zqLwnD1K0OdkCBHN5N3X
         Nnu0Q0RMr5+Eg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 06/50] wifi: ath12k: add core.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-7-kvalo@kernel.org>
        <f0c1dad2-cb69-cc7e-5cc8-892b4a3fa9d9@quicinc.com>
Date:   Fri, 21 Oct 2022 13:58:38 +0300
In-Reply-To: <f0c1dad2-cb69-cc7e-5cc8-892b4a3fa9d9@quicinc.com> (Jeff
        Johnson's message of "Fri, 12 Aug 2022 17:16:10 -0700")
Message-ID: <871qr1l9y9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>> +struct ath12k_skb_cb {
>> +	dma_addr_t paddr;
>> +	u8 flags;
>> +	u32 cipher;
>> +	struct ath12k *ar;
>> +	struct ieee80211_vif *vif;
>> +	dma_addr_t paddr_ext_desc;
>> +} __packed;
>
> Usage of __packed seems incorrect since this is not an ABI buffer, and
> packing will potentially result in some members being unaligned
> (ath11k has struct ath11k_skb_cb packed as well).
>
> Suggest removing __packed and using pahole to find the ideal layout
> since the only concern is that this does not exceed
> IEEE80211_TX_INFO_DRIVER_DATA_SIZE

Praneesh fixed this in ath12k-bringup:

1a458fd07d47 ath12k: remove __packed from the ath12k_skb_cb struct

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

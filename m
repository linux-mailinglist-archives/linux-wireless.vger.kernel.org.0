Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432107062B2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjEQIYe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjEQIYW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 04:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A395264
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 01:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB7F63815
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E77C433D2;
        Wed, 17 May 2023 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684311853;
        bh=CB5qEF8ReCaIt+XiAIqzmCU3UHsgYgsJP9IZuPQ4zEI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WUkKvsMBAPe6+kpVTcsMBpNiPv3U4eiyeUtW7twzej6xxRWXxSJuxaf0ekg0H2tQA
         E3Znb5k72xvJK7MsgjLDvGAEBWLWJj+Olx4MUUmYlGlH/CRR/tq50t4cMo7ClxNgzE
         7HNIDBCA0ZO+gTDU1lq7GXobxihJ1PefFtyGb80HyNY+mhlIElxvmyi0bFd4JAi5Wl
         qgjHrVVHOVmjOwVZ34ydQNPVeg5PfwM162i7uPKFdvRdF4d8xez/Jhmd3eqOrSUqyC
         XqKFbMNmoG8JEZCSe6G0JeJ+bgMTmsJjYxs3egMIH1Yq7rd9ZzIKNwDPfFnOWzpdxb
         02VviRXoAUHZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] ath11k: Relocate the func
 ath11k_mac_bitrate_mask_num_ht_rates() and change hweight16 to hweight8
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230510100242.1241752-2-quic_mkenna@quicinc.com>
References: <20230510100242.1241752-2-quic_mkenna@quicinc.com>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168431185022.6823.2193709812407218849.kvalo@kernel.org>
Date:   Wed, 17 May 2023 08:24:12 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <quic_mkenna@quicinc.com> wrote:

> Relocate the function ath11k_mac_bitrate_mask_num_ht_rates() definition
> to call this function from other functions which helps to avoid the
> compilation error (function not defined).
> 
> ht_mcs[] is 1 byte array and it is enough to use hweight8() instead
> of hweight16(). Hence, fixed the same.
> 
> Tested on: Compile tested only.
> 
> Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>

I took v1 instead:

https://patchwork.kernel.org/project/linux-wireless/list/?series=744909&state=*&order=date

2 patches set to Superseded.

13236705 [v2,1/2] ath11k: Relocate the func ath11k_mac_bitrate_mask_num_ht_rates() and change hweight16 to hweight8
13236704 [v2,2/2] ath11k: Send HT fixed rate in WMI peer fixed param

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230510100242.1241752-2-quic_mkenna@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


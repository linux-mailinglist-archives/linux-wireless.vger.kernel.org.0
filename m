Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72D5E9DBD
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiIZJe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiIZJe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 05:34:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7512AF5
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 02:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74667B80171
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 09:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AEFC433D6;
        Mon, 26 Sep 2022 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664184892;
        bh=keryL8x5WQ7BOAAsT9qNGImfmldpWW17GqsPeM7DcLY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=g/8UANutZ9YJFO4wALhZq+j0Hin6Xmq/vk4Ic7IPEpneSjWoSHHc2tcWaYXLYFbbn
         2sVVwDYZvW4i0yi6BKAGA+GHne800fM7qhQQKMxfUii4OmI7yX9mM4HW/cVgDc0+CL
         64N9TWiy4oR/i+JhTg5vWR9HKe8phy70RX9KG/V945sFwPZxSO7vKr2LfOMN1IuyCB
         pGeH2tk+W8o9aBmLWoUGo/uQsfcydiaqAxC0cCjQSTx1YrGLHdh7OQ/4QmfzguZfZ4
         FVABymthhL3kt9WDjy7zNt+5b1wGVre/wGgVk0wrGHyYTPzWzK8dMfwAdVpTtiNDik
         p9gwhtGb1v+Zg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support to get power save duration for each
 client
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220725054601.14719-1-quic_tamizhr@quicinc.com>
References: <20220725054601.14719-1-quic_tamizhr@quicinc.com>
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166418488625.13691.4613820697908403573.kvalo@kernel.org>
Date:   Mon, 26 Sep 2022 09:34:50 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> wrote:

> Add support to get the following power save information through debugfs interface,
> 
>  * Current ps state of the peer
>  * Time duration since the peer is in power save
>  * Total duration of the peer spent in power save
> 
> Above information is helpful in debugging the issues with power save clients.
> 
> This patch also add trace log support for PS timekeeper to track the PS state
> change of the peers alongs with the peer MAC address and timestamp.
> 
> Use the below commands to get the above power save information,
> 
> To know the time_since_station_in_power_save:
> cat /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/
> XX:XX:XX:XX:XX:XX/current_ps_duration
> 
> To know power_save_duration:
> cat /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/
> XX:XX:XX:XX:XX:XX/total_ps_duration
> 
> To reset the power_save_duration of all stations connected to AP:
> echo 1 > /sys/kernel/debug/ieee80211/phyX/ath11k/reset_ps_duration
> 
> To enable/disable the ps_timekeeper:
> echo Y > /sys/kernel/debug/ieee80211/phyX/ath11k/ps_timekeeper_enable
> Y = 1 to enable and Y = 0 to disable.
> 
> To record PS timekeeer logs after enabling ps_timekeeper:
> trace-cmd record -e ath11k_ps_timekeeper
> 
> Tested-on: Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

710a95f95586 wifi: ath11k: Add support to get power save duration for each client

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220725054601.14719-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


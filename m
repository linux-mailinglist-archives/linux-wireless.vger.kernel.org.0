Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A657FE44
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiGYLXO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiGYLXN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 07:23:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97314D08
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 04:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A58B9B80E4C
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 11:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B5C341C8;
        Mon, 25 Jul 2022 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658748190;
        bh=BVdjLwLxOOb/BTqcmnVSOT7tpDS8HiwfdQrWI1fdU4M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JCO18uHVn822/vHLs34I00heNZZKFBrNacEisIqzwqUg+UTTv00u0vzqJVffPkfH7
         HsqIH1lDSpIMMo/5Cq+kbbcwpsqfWpRkH4fTZV7iE5g82HN2UBFTVsiDaPLf/jXmpE
         7Od3y5OFs/L+FpY+JMW0i5vSgiZZEDpebzRz+EhWgcvM2s2uA3igqJ7VsXWsZuA+j4
         vamXT0EL9RUqxPZwJWK5jzf2xBD77CyaaI1KBlCAvJ/diEGn7lMItY1plHdlIVk5Km
         LEeZvD7MyOalF1UZYcT3YqQQkN1OjKUHtKcGLQ9OABsomu9QoWLjNho9zdjgufHU42
         u3eOVyzaKvvgQ==
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
Message-ID: <165874818328.809.14159736625387988844.kvalo@kernel.org>
Date:   Mon, 25 Jul 2022 11:23:09 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This failed to build:

drivers/net/wireless/ath/ath11k/wmi.c:6771:1: error: no previous prototype for 'ath11k_wmi_event_peer_sta_ps_state_chg' [-Werror=missing-prototypes]

I fixed it in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220725054601.14719-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


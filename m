Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC07A0547
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbjINNQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbjINNQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 09:16:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8381FD4
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 06:16:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CBBC433C8;
        Thu, 14 Sep 2023 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697384;
        bh=OMOntvKwCjbvcnXTdTiuIkhUzTCTCAxQoy6WTxNf3hw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kvdM9DfZhTCmOryBT5CbjAeQ13A5utXBwHqUz7wexBtGVMeEyKV2n9L6PeuUuenMK
         xZOFKxkKM3OyK1i93KGS/plNy49Ozoa3zF1JzcjYNzLQ1xksbv1ph+Qp5WDHDufBoa
         FLffKu520stgJLQlRAZUc9T6QD5Sxw8x6P5B635jvXPXdzuw9zSZUG2/4HO2N3nmm/
         nNRxXit0VJi3ObewjHGnwLixsrzEuUEDtRMkkbbkybJbX5EJHHye5ivvb9AQmoTaUa
         HgjQ5lxDAny/PbcFJ9ymNG/YFNxCbaaAyvIYFjvA8HDr2Qhd6N9tGhQaZnIJg/hAtY
         Epy41yavpitcg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath11k: fix CAC running state during virtual
 interface start
References: <20230607124647.27682-1-quic_adisi@quicinc.com>
        <20230607124647.27682-3-quic_adisi@quicinc.com>
        <a7ba84fe-4ac8-4842-8e46-093ebc4e7014@quicinc.com>
Date:   Thu, 14 Sep 2023 16:16:21 +0300
In-Reply-To: <a7ba84fe-4ac8-4842-8e46-093ebc4e7014@quicinc.com> (Aditya Kumar
        Singh's message of "Wed, 13 Sep 2023 18:55:02 +0530")
Message-ID: <87fs3gdhei.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> On 6/7/23 18:16, Aditya Kumar Singh wrote:
>> Currently channel definition's primary channel's DFS CAC time
>> as well as primary channel's state i.e usable are used to set
>> the CAC_RUNNING flag for the ath11k radio structure. However,
>> this is wrong since certain channel definition are possbile
>> where primary channel may not be a DFS channel but, secondary
>> channel is a DFS channel. For example - channel 36 with 160 MHz
>> bandwidth.
>> In such cases, the flag will not be set which is wrong.
>> Fix this issue by using cfg80211_chandef_dfs_usable() function
>> from cfg80211 which return trues if at least one channel is in
>> usable state.
>> While at it, modify the CAC running debug log message to print
>> the CAC time as well in milli-seconds.
>> Tested-on: QCN9074 hw1.0 PCI
>> WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Hi Kalle,
>
> The upstream dependency got merged today. I have sent [v2] of this
> series which was just rebased on latest ToT and the [PATCH v2 1/3] got
> merged. With this, [PATCH v2 2/3] and [PATCH v2 3/3] are unblocked
> now.

Thanks, this is helpful. I still need to merge wireless-next into
ath-next but hopefully that happens next week.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

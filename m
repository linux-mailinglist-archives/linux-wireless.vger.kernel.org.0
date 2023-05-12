Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E170034F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjELJF0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjELJFU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 05:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30879E702
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 02:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C01AE65408
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 09:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E27FC433D2;
        Fri, 12 May 2023 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683882310;
        bh=gZF+Xguz9RCrAkGQCEJKmm2Z525C7fjWB8wIIxVpGCA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FhRWeq3XRRWxjPA8ps/Vk2I5RRROK9fE7uoVdKKQkq7vGKs7baX0UkqEG3hwHTIWX
         D/HAy47x5SfVuneU+R9NXM9WQmi3HjlmpnLgzgUkVU9P+aMzr4lb38MYRewBDSKDdH
         1ZbPoe4ibzbbDGfeOU0VJL3ETTwWktL5zku+1IoKXj4u/dpe+w6kzRSZG3QoN2U7x4
         gSPmJ63Ix/hICW3RSj8FsjGTUIMXF0bEbVF1CGDknyCNFqCvSYjgGsBXSp5vLfVkO9
         2NSfFiRVmjbze1qZm5rnHdUoUaMm5BupwTgcVlAFH0XMHmfq84hJPg4pcq1+e2up7r
         EhOxNa8tgF6og==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/2] ath11k: factory test mode support
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
        <87edpson9o.fsf@kernel.org>
        <0289c7f1-e729-e924-5ae8-a6156266e675@quicinc.com>
Date:   Fri, 12 May 2023 12:05:05 +0300
In-Reply-To: <0289c7f1-e729-e924-5ae8-a6156266e675@quicinc.com> (Raj Kumar
        Bhagat's message of "Tue, 28 Mar 2023 10:16:58 +0530")
Message-ID: <87ttwhncn2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> On 3/13/2023 5:51 PM, Kalle Valo wrote:
>
>> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
>> 
>>> Device is booted in factory test mode to calibrate the board.
>>> The commands are sent from a userspace application, which is
>>> sent to firmware using wmi commands. Firmware will send the
>>> response back to the application which stores the calibration
>>> data in caldata.bin file. This file will be loaded when the
>>> device boots up normally next time.
>>>
>>> Govindaraj Saminathan (1):
>>>   wifi: ath11k: factory test mode support
>>>
>>> Sowmiya Sree Elavalagan (1):
>>>   wifi: ath11k: Allow ath11k to boot without caldata in ftm mode
>> 
>> While reviewing the patches I made quite a few style cleanup to patches
>> (too many to list):
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=4a5ca29c396ace5c46b208a8c15a3ba53eabaddd
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=ba74c7478f5d15ce38e609b9ad4810db7511a3dd
>> 
>> I only compile tested them. Please use these as the baseline for v2.
>> 
> Hi Kalle,
>
> Unable to get the baseline patch for v2 from the above link. Getting the
> below error with the link:
> Bad commit reference: 4a5ca29c396ace5c46b208a8c15a3ba53eabaddd

I now pushed them again:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=f3d1f7ae115e12108ba7d7fa0ea6374b9e28869c

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=229ea354bdd24bf3c33c9447674fab8d609e24a2

From now I'll tag every time I change the pending branch, this should
prevent old commits from disappearing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

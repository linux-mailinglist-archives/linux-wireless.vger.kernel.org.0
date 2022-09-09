Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2B5B32BE
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiIIJGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiIIJFf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 05:05:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0E9FA84
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 02:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63C81B82403
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 09:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBDBC433D7;
        Fri,  9 Sep 2022 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662714298;
        bh=x0+8r++HF6A1wPLEFxJcCLQRHIbcMl/u00vuBrLUSTs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XhsNmAgKg/oro78SWFyn0ig2b+K2ELW8bWCBbEIw1JDmwYrLmNeosblU3CpbgHPDa
         bs9gNvsMHL03hFc752YjVKAygCCcf08XTt/7TSKt3VFXPCslHS3AO4QJXci19h2suE
         PtqgE3WbzstaA7/5j/A0s7WqPLtqIZtfCv9nC9PlWPCuyPucYlAKK34fGhXIMmpZ1T
         9U0krSfCqgSXQ6mo3EADJOpJvGQDusCtnxaAlvFRhxoqA2vnd+MP03cwMlhVDZ0kB1
         dJM0MG8YORbGRXBKe5/RykjwZyn9QfeEdAxVDaK6oU+NcR+DHWUJOuCzCZRMTdh+ip
         cK0YjiqSwpN/A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: cfg80211: Fix MCS divisor value
References: <20220908181034.9936-1-quic_tamizhr@quicinc.com>
Date:   Fri, 09 Sep 2022 12:04:51 +0300
In-Reply-To: <20220908181034.9936-1-quic_tamizhr@quicinc.com> (Tamizh Chelvam
        Raja's message of "Thu, 8 Sep 2022 23:40:34 +0530")
Message-ID: <87fsh0c40c.fsf@kernel.org>
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

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> writes:

> Bitrate for HE/EHT MCS6 is calculated wrongly due to the incorrect
> MCS divisor value for mcs6. Fix it with the proper value.
>
> previous mcs_divisor value = (11769/6144) = 1.915527
>
> fixed mcs_divisor value = (11377/6144) = 1.851725
>
> Fixes 9c97c88d2 ("cfg80211: Add support to calculate and report 4096-QAM HE rates")

The format for Fixes tag should be:

Fixes: 9c97c88d2f4b ("cfg80211: Add support to calculate and report 4096-QAM HE rates")

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F505338C5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 10:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiEYIsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiEYIsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 04:48:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB95353B6C
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 01:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BFEAB81CEF
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 08:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05442C385B8;
        Wed, 25 May 2022 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653468491;
        bh=QiO97DWh+AvbYAR8PbGJUwnyKeZSRgCADGv+AmY9VAY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Nwj9AJPUSe1rDUwR9v0DhmtOOTuY4acr+QILK3TdD6gi4FMkvXaYabcIexDkqtlmX
         rBH1BM5VtbTswpQXCMNkyaXxV9ICCfqoUoTZnRZet4yl23vgUm0+2vZY7INA7qDRYw
         kjn7OMD1E+aNhBMyoYBRp0+yj+aZp11hVVJafyMKYi8dBFf+18HKY7io+q6co74JTZ
         AiMRVjX1s8OI7ih5sUVHu5UCm2wwwe98cFFa4ku99dJURwdLygiZM/YeAMdbDdhwMI
         mbWxBs3UIqTwMeq2H+eRnciBXIApxcMNIFn74dzb0oq4j+ZLG5LP7qwa/GwotomTKm
         Vo2WVdgphI0/A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: support avg signal in station dump
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1652965061-30457-1-git-send-email-quic_tmariyap@quicinc.com>
References: <1652965061-30457-1-git-send-email-quic_tmariyap@quicinc.com>
To:     Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165346846494.2716.14472646811781150760.kvalo@kernel.org>
Date:   Wed, 25 May 2022 08:48:09 +0000 (UTC)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thiraviyam Mariyappan <quic_tmariyap@quicinc.com> wrote:

> Currently mac80211 doesn't calculate average signal when RSS(Receive side
> scaling) is enabled from the driver, so average signal isn't printed in
> the station dump. To address this issue, calculate the average signal
> from RSSI within driver and display in the station dump.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

New warning:

drivers/net/wireless/ath/ath11k/mac.c:8166: line length of 94 exceeds 90 columns

I fixed it in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1652965061-30457-1-git-send-email-quic_tmariyap@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC384F290A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiDEIZH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiDEITR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 04:19:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0731AF1D
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 01:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE06BB81B18
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 08:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66635C385A0;
        Tue,  5 Apr 2022 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649146157;
        bh=VzMbINFNTvSENLG/I6ooncrp2ypoqck+oxssEZccqoM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RRvQs/ew/vr6siHZtExBHLT9lWLJNq8Hyy4R9/QXp7goNUlHhRv5ouiMwqvaym8nS
         KW4UrRfoLi8M+IRhl/WIajFgH0jx31qT3ibM9ZFQrAHYdqRlZ69JFr4akgquE80Yfd
         V1tnoHoTaYjq3BDO1Fj3lO8/3IjN7HLvqiRG0siMp5r/YC+cjF+birFgWxCppUzAxC
         VvDmsjqvYw/5WKT9MnoNdmnb4frQKfqNcCimdVDHvvNvs4bwF+DR0K3GPtAmb8/W5r
         Q4F/B1EBeYk/vuJWtsDH4Lgg2Pxzpu+KG1fLu3PrDFEWOVEvDt5o870PXs+mn7XCLm
         EJIcfYqJOZPFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Change max no of active probe SSID and BSSID to
 fw
 capability
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220329150221.21907-1-quic_kathirve@quicinc.com>
References: <20220329150221.21907-1-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164914615451.12306.2945099051936753478.kvalo@kernel.org>
Date:   Tue,  5 Apr 2022 08:09:16 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> The maximum number of SSIDs in a for active probe requests is currently
> reported as 16 (WLAN_SCAN_PARAMS_MAX_SSID) when registering the driver.
> The scan_req_params structure only has the capacity to hold 10 SSIDs.
> This leads to a buffer overflow which can be triggered from
> wpa_supplicant in userspace. When copying the SSIDs into the
> scan_req_params structure in the ath11k_mac_op_hw_scan route, it can
> overwrite the extraie pointer.
> 
> Firmware supports 16 ssid * 4 bssid, for each ssid 4 bssid combo probe
> request will be sent, so totally 64 probe requests supported. So
> set both max ssid and bssid to 16 and 4 respectively. Remove the
> redundant macros of ssid and bssid.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01300-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

50dc9ce9f805 ath11k: Change max no of active probe SSID and BSSID to fw capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220329150221.21907-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


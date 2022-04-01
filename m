Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B584EECA1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbiDAL5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiDAL47 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:56:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CDE1D67ED
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40730B824AE
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38647C340F2;
        Fri,  1 Apr 2022 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648814108;
        bh=y6XcPGh3sC2XlAg+TUUW/ULmKjUaOfKpUMeAfKPhDP0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XxBxNsdZN8wAmhmmR/ZZjd7i4wuLyHDUFYp0Pvex/dAnXVC9IsPgw4cHtAJG2I58D
         bKlbjmHqJWbmvx1iumWsO47QRI8OAy2w5tpBa5WfNE/0XEeVhpGze2faLjoY2RIesf
         enZiwCXWsMCV3ploLqF3P1ft9uJxJDazbjDeKwzriKVnYb0Qc8yb2+LAHsGEibCRyW
         5XTJNT+1zfeCw79Sce3JDwDUyd7djTLm3zIYcEbyFU8XrR9jHqAqVXSAJ8yGzqDC5a
         Z1J4KDT1Mr6kw7a8Kb+9dWLDYv9SMxiJXTFx0IIEfNDEihkm5mCtuSjoz3BvlVPVga
         JYT8yIoOBowCQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: Change max no of active probe SSID and BSSID to fw capability
References: <20220329150221.21907-1-quic_kathirve@quicinc.com>
Date:   Fri, 01 Apr 2022 14:55:01 +0300
In-Reply-To: <20220329150221.21907-1-quic_kathirve@quicinc.com> (Karthikeyan
        Kathirvel's message of "Tue, 29 Mar 2022 20:32:21 +0530")
Message-ID: <87wng9t3vu.fsf@kernel.org>
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

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

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
> Tested-on : WLAN.HK.2.7.0.1-01300-QCAHKSWPL_SILICONZ-1 v1

This is not correct format:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag

On what hardware did you test this? I can then fix the tag.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

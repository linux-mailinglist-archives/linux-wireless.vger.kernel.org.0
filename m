Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283C6A422C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjB0NDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 08:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjB0NDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 08:03:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E325F9EE2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 05:03:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38AC5CE0FC8
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 13:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7975C4339B;
        Mon, 27 Feb 2023 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677503014;
        bh=RYkNAgZgiYeaaXL9Pl+5+zD1OJ5nLgaPwvvpaJezxjU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QRzgGMkPB96l+sx9SJpOakHuUyn1iNX8ZNFhNtlfcQQhiPrpZKB56cgxjhqEWD+08
         woL9tv3eU3uCqL9+G9vK6bRFn4U4Oi1mIFNURv7VgZd+vvgaAlzVpG2K8QPifkb9eT
         3Dmk7HGqiORTUtta+DnNKE6SF/nrNj1lWZk8ElFEdS4pYdzoLk0210b1yycRsToe3q
         IxrNozltw8JteCkahr99xGATVJT5Gxey9SPsJzkeVZijr7rUThzBJfupLst7pUL8zW
         Gebc9qQtmNLe74oEQRhpm3n51LNT6JzxDGOodHQRUegC6loCeXQtYCc1VtKwaL4mSN
         shWKkJsr3pYyA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: factory test mode support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230213130854.2473-2-quic_rajkbhag@quicinc.com>
References: <20230213130854.2473-2-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167750301098.30655.1426219945777543435.kvalo@kernel.org>
Date:   Mon, 27 Feb 2023 13:03:32 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with NORMAL mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
> 
> When start command ATH11K_TM_CMD_TESTMODE_START is received, ar state
> is set to Test Mode. If the FTM command or event length is greater
> than 256 bytes, it will be broken down into multiple segments and
> encoded with TLV header if it is segmented commands, else it is sent
> to firmware as it is.
> 
> On receiving UTF event from firmware, if it is segmented event, the driver
> will wait until it receives all the segments and notify the complete
> data to user application. In case the segmented sequence are missed or
> lost from the firmware, driver will skip the already received partial data.
> 
> In case of unsegmented UTF event from firmware, driver notifies the
> data to the user application as it comes. Applications handles
> the data further.
> 
> Command to boot in ftm mode
> insmod ath11k ftm_mode=1
> 
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This had new warnings:

drivers/net/wireless/ath/ath11k/testmode.c:27:16: error: no previous prototype for 'ath11k_tm_get_ar' [-Werror=missing-prototypes]
drivers/net/wireless/ath/ath11k/testmode.h:26: void function return statements are not generally useful
drivers/net/wireless/ath/ath11k/core.c:1839: Blank lines aren't necessary before a close brace '}'

I fixed them in the pending branch, but please always use ath11k-check before submitting patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230213130854.2473-2-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


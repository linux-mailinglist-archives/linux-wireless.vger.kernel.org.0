Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227895379CE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiE3LZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiE3LZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 07:25:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D5C7CB70
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 04:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D897FB80B9B
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 11:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC276C385B8;
        Mon, 30 May 2022 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653909934;
        bh=Wi/Gy+edutQVhd4CS7HA9wNwuHjoIQ8DWfESxJSRyeA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eabv2gHvzXE/Vw20iHbRz/HZM5TBe99i+8yT4i3Lp6IU5LuFfHGQXjoFJF+7cYZ/R
         Gcm2zKmrQNPCT9navyPt1+KTub/G6JJJf9/V5hSNdvhJ4rnCxKV93UL4LPoKZh6REy
         UI5TcvA2fOfUVg+tx1uIZBMfKacO3cK+0UjESv3pzzC7AVIrbvC3uxRZQu4ZHXX3Rq
         3JzjeTjzzaP+35sHfryGO9+tgBPAVYd7TiVlrYqVT3c9TJf31HUlVGlsPrsD9/e7FF
         MCorDjIzc99OMRS1xpDDP2KdMtFHB1v9QwTzIGIdVemZxlLe1oSd+NVfPdsnnl2vbD
         mpm3Lunejb6yQ==
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
Message-ID: <165390993199.3436.1119696416291246316.kvalo@kernel.org>
Date:   Mon, 30 May 2022 11:25:33 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch applied to ath-next branch of ath.git, thanks.

b205ce4c266c ath11k: support avg signal in station dump

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1652965061-30457-1-git-send-email-quic_tmariyap@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111365E5D92
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIVIfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 04:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiIVIf3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 04:35:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9A4E853
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 01:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 62AA6CE1FCE
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 08:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A18C433D7;
        Thu, 22 Sep 2022 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663835722;
        bh=LzYixJB53o4lrYmnQpu6l9b3KeR5dskhXKC15wJwOW8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Myb5Zos/+R8NGrvzoedBHSVKxD+/DYQikKtB9TnWTKCPS61BNW7zSR0Y8kyJWSvkB
         vVZ7JZqwgwbAywZ7xgMQulnZK6Yd6xjC7DoZ4Dvel4bLoXES8K6d0HACdumBn4gKye
         dbVbQ6uWwwLVrqiNTvFdX5/D2JEMfoSD4mUpckVXD/5hCFiIB9anVgYfMAk3Kp+uyd
         ZxRStr6X0N8VBu1FJCGVgh0wHa5W+x/K7cz+zRpUbVXMcsumtZLCbIMmX7dHd9Bm5E
         oQ1sDPeujft/clAmVYPIttfrOS5Af5B3l1YcLdlxOazU958puRgSY4UrVNP9UpGXj2
         XMMTxNP+op/rA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix number of VHT beamformee spatial streams
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220616173947.21901-1-jesus.manzano@galgus.net>
References: <20220616173947.21901-1-jesus.manzano@galgus.net>
To:     Jesus Fernandez Manzano <jesus.manzano@galgus.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        jesus.manzano@galgus.net
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166383571956.27663.10307320275505026019.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 08:35:21 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jesus Fernandez Manzano <jesus.manzano@galgus.net> wrote:

> The number of spatial streams used when acting as a beamformee in VHT
> mode are reported by the firmware as 7 (8 sts - 1) both in IPQ6018 and
> IPQ8074 which respectively have 2 and 4 sts each. So the firmware should
> report 1 (2 - 1) and 3 (4 - 1).
> 
> Fix this by checking that the number of VHT beamformee sts reported by
> the firmware is not greater than the number of receiving antennas - 1.
> The fix is based on the same approach used in this same function for
> sanitizing the number of sounding dimensions reported by the firmware.
> 
> Without this change, acting as a beamformee in VHT mode is not working
> properly.
> 
> Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Jesus Fernandez Manzano <jesus.manzano@galgus.net>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

55b5ee3357d7 wifi: ath11k: fix number of VHT beamformee spatial streams

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220616173947.21901-1-jesus.manzano@galgus.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


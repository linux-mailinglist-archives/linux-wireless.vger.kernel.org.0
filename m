Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C54F5CCC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiDFLs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiDFLsB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 07:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C984B1945
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 01:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 075F160DDD
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 08:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CD1C385A1;
        Wed,  6 Apr 2022 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649234063;
        bh=yHI4cCsChblsBPcn58Gc84jVaku3lU6eMPwbk92lODQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PmHI2AXstj0TP/ZEFAhot17q52TFFM1hV8ocf24IJ+BWH8X99RkP3QrsDvJ4fugxt
         yBYxczrDgxV/UbmL8RWrU5ej506Vbb5FG8aSd1sqHS39cIqxBBcq5E7AYkQVm4UQV7
         sznx7sKwMfBeLSQPLsF0NpNs/N0hECsoHMjwXIFespt/KAsnPjsZ4vPLEHlz2cRsR/
         zAm8qRJK+sGiPeXqC5RbaG7BcXap6aRn8gl3rDRgcSqWXEuZK6EYjzvIKR9ofzfazf
         axrG/+0s/lp2Ypelx+35lFvkHku2EJ2MVoKrEKPhSGGhk3JM9eq/lgLeOGUndUupkr
         LuClG5wOBRgBg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: mhi: remove state machine
References: <20220401173042.17467-2-kvalo@kernel.org>
        <164923162903.31835.17335207502754178945.kvalo@kernel.org>
Date:   Wed, 06 Apr 2022 11:34:17 +0300
In-Reply-To: <164923162903.31835.17335207502754178945.kvalo@kernel.org> (Kalle
        Valo's message of "Wed, 6 Apr 2022 07:53:51 +0000 (UTC)")
Message-ID: <87wng2pq46.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> wrote:
>
>> State machines are difficult to understand and in this case it's just useless,
>> which is shown by the diffstat. So remove it entirely to make the code simpler.
>> 
>> No functional changes.
>> 
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> 3 patches applied to ath-next branch of ath.git, thanks.
>
> 5fe7847bb63b ath11k: mhi: remove state machine
> 4afe7c40380e ath11k: mhi: add error handling for suspend and resume
> 7dabaa64c04a ath11k: mhi: remove unnecessary goto from ath11k_mhi_start()

I accidentally had a wrong commit in ath-next so to remove that I had to
rebase these three commits. The new commit ids are:

121210ec935c ath11k: mhi: remove state machine
3e80fcbca372 ath11k: mhi: add error handling for suspend and resume
b9e34ba6b314 ath11k: mhi: remove unnecessary goto from ath11k_mhi_start()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

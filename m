Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7731621266
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 14:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiKHN1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 08:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiKHN1n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 08:27:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB2853EEA
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 05:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74C10CE1B6C
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 13:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA72C433D6;
        Tue,  8 Nov 2022 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667914059;
        bh=uDaE4OLVOMECMlR7iVxh8/EBgnAsH1SSuitfLpP/q4k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K2TxuRhu2zOV4fqONOj6ofTM2OuXyxqUirQZgG3ZyCE69UEPTDtcNMe4FeP2pzqri
         cx/fRf55vrA7KpPD/ULgQuAPr0LYrPv2msh9u2NNbZauTn49HsA0zgIaL97vTfr8DP
         At/7mD3yPcvflN5POnDvvTvRjp0J5+7seasJnbr3ZmysBgxpQ0dmFp6igRE3jTHjuD
         p2aIoZjGklwhAEvp/EKEcXg1SY5z8UVFFxBe0QesE84NOvRFL4kFGG/ad49SvNVLDk
         G4BnL/BTP4et2Ee2TNlOXoC0kJPFDvnJO243zkw/u8BSAy4Vdpkvvrpole6s6E27pP
         UMmTuG8vAVJLQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 30/50] wifi: ath12k: add hw.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-31-kvalo@kernel.org>
        <9038589b-f2e6-18e5-29f2-f88f19d34a68@quicinc.com>
Date:   Tue, 08 Nov 2022 15:27:34 +0200
In-Reply-To: <9038589b-f2e6-18e5-29f2-f88f19d34a68@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 15:30:13 -0700")
Message-ID: <87r0ydefuh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

>> +	struct mhi_controller_config *mhi_config;
>
> imo based upon mhi.c review this should be const

I added this to the todo list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

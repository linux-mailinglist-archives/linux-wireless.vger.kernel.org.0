Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F5862147A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiKHOBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 09:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiKHOBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 09:01:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A55682BD
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 06:01:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C30B81AF2
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 14:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32D6C433D6;
        Tue,  8 Nov 2022 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667916096;
        bh=9prAyGVeteAqqEgdah8x4O25W796zsM/hMuDhu14HI0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ByzqXn4+OWE99tlqZypSWAaHb4gsVGWoAiYFV/1LFrPGUGwREoJHjQ8r4MK5vBDA3
         8gOXFxczaw/xksGs6YM8sMqJcoC7l2GOrFmC86q+G4QD2jN3VtrnIp8vSz1Xr3AzkX
         1XO8dgWynzQxIcizCK2W2+7nX+pwW97UEk0ddD1CoXq0IB3TvjrBgyAaGuOrsuWAHD
         +gBbeHRZzITKUB7Er5BzDXp56RTgr/Jb3Ec6OIsXodYRXqMCu7QGEN4X0zKDCuMssj
         Ym2LZGhURee7TTJY91eWoxzjMcGjRHAP7A74F4XUc2IbOdw0SqLkIncRq8eC8QVBWc
         AVWa26JAZNQTQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 34/50] wifi: ath12k: add mhi.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-35-kvalo@kernel.org>
        <d4d4ab35-b38c-6369-e436-5eb37c502ca6@quicinc.com>
Date:   Tue, 08 Nov 2022 16:01:34 +0200
In-Reply-To: <d4d4ab35-b38c-6369-e436-5eb37c502ca6@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 15:30:53 -0700")
Message-ID: <87cz9xee9t.fsf@kernel.org>
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
>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

>> +extern struct mhi_controller_config ath12k_mhi_config_qcn9274;
>> +extern struct mhi_controller_config ath12k_mhi_config_wcn7850;
>
> imo both should be const

Fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

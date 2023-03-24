Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024356C78A2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 08:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCXHRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCXHRR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 03:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDE10248
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 00:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3133662976
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B671C4339B;
        Fri, 24 Mar 2023 07:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679642231;
        bh=aGztGcU7/fjAKFTZAFnUoTbI71Po/UtViDXqfGt4488=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KQGlvGpj6elZt0523wrFhTL92OMKKxsaOgo49VeIjmAkTHlD0n6d4ELMXy3mjt79S
         VWuBtihNt1UqBKdSGtFlQRgY1BG3L5tZQwwkvBmYjK1fVBt9/qHvJll2iyXaGetLLv
         TcVxRNoBvQBcPiRugkpXXCRXdAU8TZEjQLWHo6qcXldcP2E8MHSDiMiuoC3niAQY6H
         zhauftEKZL1BNT8jf7XRSBQAkGTxJuOL+Mhzytu0+sGNW4vXoCDWRjhWGsFUPLH0KB
         OKwG90BwSHY3CV/v/GiWL7XXRTf7//7kQ0C6SPEwp8WcmV3cPV1keky+mlktfaCoeq
         6FqXhqIycm7Cg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH v3] wireless: mt76: mt7921: Fix use-after-free in fw features query.
References: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
        <ff4c3a89-f3dc-2ae6-1b11-f2c46944e376@nbd.name>
Date:   Fri, 24 Mar 2023 09:17:08 +0200
In-Reply-To: <ff4c3a89-f3dc-2ae6-1b11-f2c46944e376@nbd.name> (Felix Fietkau's
        message of "Wed, 22 Mar 2023 21:58:36 +0100")
Message-ID: <87zg82ty8b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 22.03.23 17:37, Lorenzo Bianconi wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Stop referencing 'features' memory after release_firmware is called.
>>
>> Fixes this crash:
>>
>> RIP: 0010:mt7921_check_offload_capability+0x17d
>> mt7921_pci_probe+0xca/0x4b0
>> ...
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

The title should have "wifi:", not "wireless:".

> Acked-by: Felix Fietkau <nbd@nbd.name>

Felix, do you mean I should take this to wireless tree?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

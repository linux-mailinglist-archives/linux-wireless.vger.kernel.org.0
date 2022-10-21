Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761C160780B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJUNOs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJUNN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6724CCAD
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 06:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F02AB82B60
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 13:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42932C433D6;
        Fri, 21 Oct 2022 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666358010;
        bh=2Ck3h+6cyIC56TpNNxGsWM/DMQkNY2j7l2PmUhSU2Cw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NWDNQC+YC9BO6otVefhBh/7fWKrBtOEU4wvQmYeuWmHmzcp5kIgcwS6fFQ2NmOzNN
         MpeVzlbjoqG+jfjoBLZ/JydnZVZHkLcitFzdk3OUgYfdJ0cC6RoiPzlK+4z00PL2pb
         jGqX3+JrxdtxCnUokBYXTPVILlqe1hM0rs2wZvWLtFbKHN3JiWUUlhlWbsf2L1D1dS
         gRhqdy4Orlbo7HtcpYy0JlmF9wVWSLzlOuVgrnZc8BX5LiH3z7nFibc1QQHA8gmEp/
         VRVkw/WCytaIT/aTxboIepqkjMgLRQXsr9zA7vbrESs3nAWXqv2EdmK1lQhn90/LTb
         e/7FY599WbDww==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Sriram R \(QUIC\)" <quic_srirrama@quicinc.com>
Cc:     "Jeff Johnson \(QUIC\)" <quic_jjohnson@quicinc.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k\@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 15/50] wifi: ath12k: add dp_rx.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-16-kvalo@kernel.org>
        <576a0720-fe45-36bd-abd1-b772dbe380b0@quicinc.com>
        <SN6PR02MB43343C4EE7BBA09592CF8CDDF7249@SN6PR02MB4334.namprd02.prod.outlook.com>
Date:   Fri, 21 Oct 2022 16:13:27 +0300
In-Reply-To: <SN6PR02MB43343C4EE7BBA09592CF8CDDF7249@SN6PR02MB4334.namprd02.prod.outlook.com>
        (Sriram R.'s message of "Fri, 14 Oct 2022 03:01:16 +0000")
Message-ID: <87sfjhiako.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Sriram R (QUIC)" <quic_srirrama@quicinc.com> writes:

>>> +             paddr = dma_map_single(ab->dev, skb->data,
>>> +                                    skb->len + skb_tailroom(skb),
>>> +                                    DMA_FROM_DEVICE);
>>> +             if (dma_mapping_error(ab->dev, paddr))
>>> +                     goto fail_free_skb;
>>> +
>>> +             if (hw_cc) {
>>
>>hw_cc is a very cryptic name. is there a better name for this?
>>presumably this has something to do with hardware giving us unique
>>cookies so we don't have idr overhead?
>
> The hw_cc indicates Hw cookie conversion, which converts the cookie
>passed in the rxdma descriptor to a corresponding SW descriptor vaddr
>(which was allocated mapped during init time in ath12k_dp_cc_init())
>and passes back the addr directly during msdu rx rather than having the
>idr overhead. Since 'cc' was used across the driver to indicate this
>feature, we used it similarly here as well.

Having a comment explaining what hw_cc means would be really nice.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

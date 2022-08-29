Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2545A511E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiH2QLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 12:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiH2QLE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 12:11:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844871997
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 09:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F75AB81118
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 16:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECD2C433D7;
        Mon, 29 Aug 2022 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789459;
        bh=JrmSmvfDj2tcyi69FrlJddBAl36LjWNQ2wBjUnlClnY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eDfXNib0z4pzREhM1o7QwKHkOpAjHwebsTyWCxRdHPgcErzc00IwgphqigeAgmoKH
         gfoW6Gv/qxgGssc5nTSI+oCPaznEZhIxjLiiqttz99M9U+E73KXKNaEFLpjAS8g+dP
         7TsDXh9rf+qJE4JF0n/MteCqZcUEEQpsETikwSwU4vzqn0e+TnGKknNFm1VTiWkbQi
         WnAPNi7ZnT6je64zbzvrQc0wukVLLZrYL15V+d6PlubPfXR7wvDbF1zSXpaV442GZe
         n2tXhFGTE3m5XduOWweDB4MF62r/gwk3P6Xe1mGyBSFq0J75d4KTlBhlD2DT8tB8Lu
         wbpGmVjadZAmQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Deren Wu <Deren.Wu@mediatek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921e: fix crash in chip reset fail
References: <727eb5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com>
        <CAGp9LzoZkxONid2Kt-ykuQWiY1pTG6NGxho8FeLwMd9MdWd-rA@mail.gmail.com>
        <CAGp9Lzo+MxynP-Lwb8_eCX4w+EQ6FqZAU3w-OMpcj7x1N8xyyQ@mail.gmail.com>
Date:   Mon, 29 Aug 2022 19:10:52 +0300
In-Reply-To: <CAGp9Lzo+MxynP-Lwb8_eCX4w+EQ6FqZAU3w-OMpcj7x1N8xyyQ@mail.gmail.com>
        (Sean Wang's message of "Fri, 26 Aug 2022 03:50:26 -0700")
Message-ID: <87wnarc9o3.fsf@kernel.org>
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

Sean Wang <sean.wang@kernel.org> writes:

> Kalle seemed not available this week, so I would like to look for help from you.
> If the patch looks good to you, could you help apply the patch to
> wireless-drivers.git because there are getting more users reporting
> the issue with the stable kernel such as [1]. I would like to backport
> it sooner once it appears in the Linus tree to solve the indefinite
> hang issue. Sorry for the hurry request, I knew you just sent the pull
> request one moment ago :(
>
> [1]
> https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/

Johannes applied this now:

https://git.kernel.org/wireless/wireless/c/fa3fbe640378

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

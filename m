Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104717E5CE8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjKHSKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:10:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5461FEB
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:10:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E80CC433C8;
        Wed,  8 Nov 2023 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699467044;
        bh=ZhnQd77nx25O9I+BDvIQd9T1u9yJzJ6XIy/5XVehguQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Et+2HAdQU3jS9rMjfTkeKjQaD7b6J9q7DetE5oRAcAyFT2UNz0ns1cQXSmVbxALVZ
         z58u1lQWJ7/UCHgrnHf56HqCAD2TOywSSaQnfqVKsWocnSNz+yjtYhHViIBeC8dFyq
         ncTaKCcV+x0KPucliT37LFbnQMY0luJCpjPCWsH6y3KV1HKTJyQmSoDRzpDx1OYgTN
         0NvyfxuS94+8NKKNhOwnhomjfq7/iwAcEzM4DFTudqj5mdzWTowv4tbIFoT7vk0fnE
         H0lcuJen7/soDvJX/sUdhFmGMIy/6QpOBD85hdenD8s18eEXIm8ozff0S/BqoBfp1e
         bstOztDxCrSfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [next,v2] wifi: mt76: mt7921: fix 6GHz disabled by the missing
 default CLC config
References: <5a976ddf1f636b5cb809373501d3cfdc6d8de3e4.1698648737.git.deren.wu@mediatek.com>
        <169946628281.2754325.4918391356587950317.kvalo@kernel.org>
Date:   Wed, 08 Nov 2023 20:10:38 +0200
In-Reply-To: <169946628281.2754325.4918391356587950317.kvalo@kernel.org>
        (Kalle Valo's message of "Wed, 8 Nov 2023 17:58:04 +0000 (UTC)")
Message-ID: <87ttpw9kv5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Deren Wu <deren.wu@mediatek.com> wrote:
>
>> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>> 
>> No matter CLC is enabled or disabled, the driver should initialize
>> the default value 0xff for channel configuration of CLC. Otherwise,
>> the zero value would disable channels.
>> 
>> Reported-and-tested-by: Ben Greear <greearb@candelatech.com>
>> Closes: https://lore.kernel.org/all/2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com/
>> Fixes: 09382d8f8641 ("wifi: mt76: mt7921: update the channel usage when the regd domain changed")
>> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
>
> Patch applied to wireless.git, thanks.
>
> 7a934b5cc3f4 wifi: mt76: mt7921: fix 6GHz disabled by the missing default CLC config

BTW the fixes tag didn't use correct title and I fixed it during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

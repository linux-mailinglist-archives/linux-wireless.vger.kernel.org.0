Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A47E5CC9
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 18:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjKHR6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 12:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKHR6M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 12:58:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA81BF7
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 09:58:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0801DC433C7;
        Wed,  8 Nov 2023 17:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699466289;
        bh=pemo+h5iPUSArhokPwEEF/udpfGjRhboJyggEUsTSyI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=C6C67w4I9ce982zkp1+YNKj0bFyqb3oLU9cW39lBszA10nk+uZPZStOaHmG2s+PZQ
         08AgQEtlStSHqLJahE9PA0a6/e5f5SUGarZPFlEhnBTBgH/en0gVzleghztvxbe7uO
         pJ+8b2PXi4WfreoPBtA9HLLsYl1I61RxQb8sr7F3tcJfJCfVcfMFqKMbxvpQa2sUT6
         hf4dotoSaMWZEeqP65LhL0pBkxyyZmb1FeSqjgVOSKSv5xmXB/uXEBd8aZtquPRIUM
         NQLCNsLjGGVnO9ZGE3JfdwKYlItgq/KF2wib0iEBehrxk7RFyejSuOiIpm8YIpwUpQ
         /0nOT1ngBxz+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [next,v2] wifi: mt76: mt7921: fix 6GHz disabled by the missing
 default CLC config
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <5a976ddf1f636b5cb809373501d3cfdc6d8de3e4.1698648737.git.deren.wu@mediatek.com>
References: <5a976ddf1f636b5cb809373501d3cfdc6d8de3e4.1698648737.git.deren.wu@mediatek.com>
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
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946628281.2754325.4918391356587950317.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 17:58:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Deren Wu <deren.wu@mediatek.com> wrote:

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> 
> No matter CLC is enabled or disabled, the driver should initialize
> the default value 0xff for channel configuration of CLC. Otherwise,
> the zero value would disable channels.
> 
> Reported-and-tested-by: Ben Greear <greearb@candelatech.com>
> Closes: https://lore.kernel.org/all/2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com/
> Fixes: 09382d8f8641 ("wifi: mt76: mt7921: update the channel usage when the regd domain changed")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Patch applied to wireless.git, thanks.

7a934b5cc3f4 wifi: mt76: mt7921: fix 6GHz disabled by the missing default CLC config

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/5a976ddf1f636b5cb809373501d3cfdc6d8de3e4.1698648737.git.deren.wu@mediatek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


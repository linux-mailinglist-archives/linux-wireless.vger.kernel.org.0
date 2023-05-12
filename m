Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DF700266
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 10:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjELIUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjELIUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 04:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1EE70B
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 01:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181E4653C9
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 08:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43CCC433EF;
        Fri, 12 May 2023 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683879600;
        bh=sEyfgjN8qN8u+KDZ69Jq/FF4HD2Z+duw7+YR1G3/WB4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WikYIkBQfs5oyvYYwV9ici1s0labJXD3auz8K3GTD9DYBvFko2GUiLItLKbuzHl6K
         wk/FSZD7CkHqC6rCXPZvljaolDQHNo5UjqQwnSBy56Azt2Hsyd3+gktHvnoC4r6Hkt
         3JuekZ1y/Q23uVohKslY4NYHLkkvOT/Y5T6Qqu3RWUhjL2mu4/FFHiznAdoVQDjZ4y
         +j6ol54Xqgy86s9dezK59BgGAWrTXvvPmaLIlrv+ar8P5uQP3OGIoMbrDUoGssb6T6
         G+AVwTjiE8MMpTpVnMzybN7w2VOcHCRs9ru7A700ve83bJr1VsGOhhW2C9Oymw8CEK
         763H055bcFScw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wifi: mt76: connac: fix stats->tx_bytes calculation
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b3cd45596943cf5a06b2e08e2fe732ab0b51311b.1682285873.git.ryder.lee@mediatek.com>
References: <b3cd45596943cf5a06b2e08e2fe732ab0b51311b.1682285873.git.ryder.lee@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168387959659.10206.9301062404052420631.kvalo@kernel.org>
Date:   Fri, 12 May 2023 08:19:58 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> wrote:

> The stats->tx_bytes shall subtract retry byte from tx byte.
> 
> Fixes: 43eaa3689507 (wifi: mt76: add PPDU based TxS support for WED device)
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

The fixes tag is wrong, should be:

Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for WED device")

I can fix that.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b3cd45596943cf5a06b2e08e2fe732ab0b51311b.1682285873.git.ryder.lee@mediatek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


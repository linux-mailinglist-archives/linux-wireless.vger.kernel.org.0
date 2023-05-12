Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAC700268
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjELIVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjELIVg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 04:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218911FC8
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 01:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CCC61716
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 08:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F077C433D2;
        Fri, 12 May 2023 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683879694;
        bh=igVf5Y5OrG2fxhQOW6HeE1uxNC/YcsfS2raPVx85M5o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=drFNY6ExSX0sdVmnVM7h34vLHTwRDhtLMcJo6XS6VZ7CoM68EPKaAwNfKHC2/lSxO
         zX2ArvjXYvzrJCvjjgaEIoy4YsbWzNchwheVadDg3OV34luHgsea0GpG32/oS1q+eu
         MkU4VzBck8pgdRjT/JQVS3/26z8WwHOYMy1KTqc8CQPV8QNB+QdQrkEMnmLjx9YoH7
         P2/I1gtoJMadAU/VOmel+Vdc7QDmpiI/A+5E1xhzpeGTIGI6jpU5kyQMd+im7vX7Ic
         nc+ejaWdk9bYa3uIO8d2hracgqp/iohUwBoRHTKMRhHikloFUlvsowX5EufTBUxqG7
         0GLv5c9YBlqvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: mt76: mt7996: fix endianness of MT_TXD6_TX_RATE
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
References: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168387969017.10206.12108697708746087667.kvalo@kernel.org>
Date:   Fri, 12 May 2023 08:21:32 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> wrote:

> To avoid sparse warning:
> sparse: warning: invalid assignment: |=
> sparse:    left side has type restricted __le32
> sparse:    right side has type unsigned lon
> 
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

2 patches applied to wireless.git, thanks.

cdc26ee89bdd wifi: mt76: mt7996: fix endianness of MT_TXD6_TX_RATE
c7ab7a29ef5c wifi: mt76: connac: fix stats->tx_bytes calculation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


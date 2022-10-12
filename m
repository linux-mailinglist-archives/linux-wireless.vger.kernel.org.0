Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1635FC02B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 07:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJLFrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 01:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJLFrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 01:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346282D32
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 22:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4BF611B9
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 05:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C021C433C1;
        Wed, 12 Oct 2022 05:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665553620;
        bh=8jHj2mA5t2FOoahzh6jv0QBWos/VpumnAgdAN0iBecM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aJhe1slpXGllOxiah/e7qiNCdbGRmvmrtCuymgH9SxlfkDM44AvBKJX/StrHA+Ypf
         6V1ZbHhFRMONx+NWfR+w9ZotmGRiRPAbZPV5E3axb6OVV3vYoVLgFnVJtrdlTllXwv
         HdQCqULSy4cmJvuLHBEtq7jWd8ZbGQOAIViigtUVQXsF93IKb+s/6K6IDXN4AlnaTZ
         N3r8ObGelu5NuF4MfXyuTf45cpbqs7395kgb+H57srLD1IoNDebPjyOB7eYIm50AmO
         3/IJijsY3oluXqOCCB6gZYeDBp5N/+8nu9Hp4dSkmBJKX5IvHG8gAWRB0r3w7U6DsV
         ApBGP3NvtJYPA==
From:   Kalle Valo <kvalo@kernel.org>
To:     <sean.wang@mediatek.com>
Cc:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <kuabhs@google.com>, <druth@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/7] wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
References: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
Date:   Wed, 12 Oct 2022 08:46:54 +0300
In-Reply-To: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
        (sean wang's message of "Wed, 12 Oct 2022 08:16:15 +0800")
Message-ID: <87mta14mr5.fsf@kernel.org>
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

<sean.wang@mediatek.com> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> add mt76_connac_mcu_uni_set_chctx to set up the channel context per BSS
> in the firmware
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

BTW a cover letter, with an overview what the patchset does, would be
nice. But no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

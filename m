Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C15A7C51
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiHaLkx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiHaLkv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 07:40:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A432D8C
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 04:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAD4DB8205C
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 11:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF8C433C1;
        Wed, 31 Aug 2022 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661946047;
        bh=DotZ1YqFsP2lhFErXQST8bScy9jCXdAhHcJLnPpqtb4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TdnG2BcEAk6ZmIXD+P6Ikw+tTJPz1vIUefums92ETNFtBqyZIUKWyAvBIw1GQdiE2
         JM5PpEupl1Ub+xtOgu3TFEid/llV9CQyTAMMa5fYKvwARekcClWskY6Ca7R7gwSLCV
         9GcEe5D2L9Yw+ha2E3oj37/jhapZoUlxnUWxayDM3f8u/PJhOo5YGoqLHHQo+TpIy1
         861K/iHgcG4yU+IeoHlu/Lb55H1CwAUPi39DGO+Xk7PZgfQjTQ7hT2R9mkJ6Vmenjb
         Xr+dMfSaPd1tuHoA/G+dVmDyYYcO+ZEBpReJqYi3H7eu0hSgWP6H63Tq2Eoq2PZM0P
         VSRhimhrj/EVw==
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
Subject: Re: [PATCH] mt76: mt7921: get rid of the false positive reset
References: <95b03bb77ce93cb2cade98d947309cd669721939.1660519674.git.objelf@gmail.com>
Date:   Wed, 31 Aug 2022 14:40:40 +0300
In-Reply-To: <95b03bb77ce93cb2cade98d947309cd669721939.1660519674.git.objelf@gmail.com>
        (sean wang's message of "Mon, 15 Aug 2022 07:37:14 +0800")
Message-ID: <87bks0fxon.fsf@kernel.org>
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

<sean.wang@mediatek.com> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> False positive reset would be possibly triggered by those commands we
> applied in suspend with HZ MCU timeout, especially it happened when we
> enabled kernel log in pm core to diagnose how much time we spend in each
> driver during suspend procedure. So we enlarge the value and align the MCU
> timeout as other commands we did to reduce the false positive reset.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Please use the new "wifi:" prefix, so for this patch it should be:

wifi: mt76: mt7921: get rid of the false positive reset

No need to resend but please use this in all new patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

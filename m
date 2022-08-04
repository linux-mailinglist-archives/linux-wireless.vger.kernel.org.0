Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E878F58979E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 08:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiHDGH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 02:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHDGH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 02:07:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFB6068E
        for <linux-wireless@vger.kernel.org>; Wed,  3 Aug 2022 23:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2DCE4CE2544
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 06:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDBCC433D7;
        Thu,  4 Aug 2022 06:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659593241;
        bh=qD4WESCBpdKVJwtb6NvKw/sL7Gg1CFWcsifaEdp2uUI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=C7Zyh4SBS0UXSRciLF+MHsN57ykfujucy18TAQE8lYrvXsdbQwcylxzbcsM9X04Jv
         /fTDriYcjqEVz+79SyW9w6xgnkJfi3sWn10lcXmrMYst0v8178GZeTqQTDoqCfTjhx
         hC4mvLMIgUJWSK2vTpr2sI+ORqUCcvdX6QKIXgFjf5o4aHrsOtsoqjErZXFZ8xu7eE
         NCrSa+KlevgGi7/fgM/QP5DAaIPGdBYdUhA4xwc63dka8wr4izoFhL34pg2NP11O5Z
         FDQTeyUAoS+oubTlUGM16dfgUuwJnff1S+MRoi3ZKwp2fxP06hQFP3+d2aEp41DvIN
         afkFx6lBlLsVw==
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
Subject: Re: [PATCH] mt76: mt7921: apply the previous MCU timeout
References: <b0dfe8afc5cf88ab9a6d54c88fba4a29631c125a.1659571732.git.objelf@gmail.com>
Date:   Thu, 04 Aug 2022 09:07:14 +0300
In-Reply-To: <b0dfe8afc5cf88ab9a6d54c88fba4a29631c125a.1659571732.git.objelf@gmail.com>
        (sean wang's message of "Thu, 4 Aug 2022 08:26:31 +0800")
Message-ID: <87v8r8ilt9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Apply back the previous MCU timeout that can trigger the chip reset to
> recover the fatal error in time.
>
> Fixes: 8fcd1fb7cbd5 ("mt76: move mt76_connac2_mcu_fill_message in
>  mt76_connac module")

Fixes tag in one line, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

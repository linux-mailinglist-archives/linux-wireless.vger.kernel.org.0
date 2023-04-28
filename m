Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E86F1136
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 07:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbjD1FDb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 01:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjD1FDa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 01:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0D26A2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 22:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD18560D3D
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 05:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F7FC433D2;
        Fri, 28 Apr 2023 05:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682658205;
        bh=KeAjELWR8MQg9MqM1OtAJaVWpO2/4TbzOdm52pKlkq8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nCLGyvI4OOaNgy/CQ2++p2r6avT//Yh9fHaTXLGdNrG059hHwVCZMCz7J6jYudvZo
         GJiRKrU9B9iDbg7oZqtR6uRkWC7Vi00mkPTpyxEBgaHubmk6X/34v06omt3d2p6RgP
         JcKTon/eupRUM0f6yKCbd7z3jNW0ELrQcI5KDRFEFeyE1AtmAiSPEtAgpl4v6S4+Ty
         r0SvCp134W80BUM2oJ+/Ri7xUbP8KHU2crp7CBFacYcdSSnQkCbDNApJLLvP+AiZua
         xlWPlQvcY4a3HcXlPQhgHfugbLFn3/LODRR9EGYmT0Ko74LLu3pZacQUV+P3GjfwVV
         8A6LTUDc3k8tw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7996: fix endianness of MT_TXD6_TX_RATE
References: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
Date:   Fri, 28 Apr 2023 08:03:18 +0300
In-Reply-To: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Mon, 24 Apr 2023 05:39:05 +0800")
Message-ID: <87r0s4ppih.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> To avoid sparse warning:
> sparse: warning: invalid assignment: |=
> sparse:    left side has type restricted __le32
> sparse:    right side has type unsigned lon
>
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

I guess this is the fix for Jakub's report? I should take it to wireless
then?

What about patch 2, should I also take it to wireless? Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

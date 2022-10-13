Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A715FD498
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 08:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJMGRk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 02:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMGRj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 02:17:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637ADD2CD5
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 23:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025CF61703
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 06:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B70EC433D6;
        Thu, 13 Oct 2022 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665641857;
        bh=fCqRqjwspf5o8J5mYashSzNulw/nujWeIOJ5fKOgJCU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V+QfS0wHd+41GVD/ypWzSFW0Gqd8CvK1iETSVyIRJBcktM4kanvCquU0GmVy+ib1b
         m/tKQcox4PphIwpl+qXHs/gbQxOOjWuFNOQc9imqvBO9OcIN5kCaBk1des04cjonSE
         n4k7BgxXJGNnhzZ6xtRrj8sgPQe6G15VuajashvZGz/AOWOlf8DQcvqMaUpoBs1jF4
         KavhLVrH5oETa0+BJHzDw5PE7Wn5lI4m2Yxwwf6cZee/zEkD2uLt/4x9s+X5fyA/vW
         W8faWQZ1q/Gt/e1K46V8UijRIoiAwnBD8LbAznLwL7AQ/U4COLq8LlDAC+Dg6qwzHv
         Y4zvAcCGOw+lw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
References: <cover.1664356281.git.lorenzo@kernel.org>
        <87r0zd4mxw.fsf@kernel.org> <Y0aH8T8pTARNWcPE@lore-desk>
Date:   Thu, 13 Oct 2022 09:17:31 +0300
In-Reply-To: <Y0aH8T8pTARNWcPE@lore-desk> (Lorenzo Bianconi's message of "Wed,
        12 Oct 2022 11:25:05 +0200")
Message-ID: <87zge0memc.fsf@kernel.org>
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

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Enable WED TX support for mt7915 and mt7986-wmac drivers running on MT7986 SoC.
>> 
>> What's WED TX?
>
> It is the same as we did for MT7622. It is the capability to offload traffic
> from lan/wan to wlan. I specified "TX" since MT7986 supports even RX
> offloading (I am working on it at the moment).

It would be nice to mention in the commit log that the feature is about
offloading traffic from lan/wan to wlan. That way it's stored to to git
history and people like me have some clue what the patch is about,
otherwise we are totally in dark.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

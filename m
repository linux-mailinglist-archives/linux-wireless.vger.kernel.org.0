Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59ED69781C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 09:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjBOI0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 03:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjBOI0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 03:26:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D71367CE
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 00:26:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97BC2CE206A
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 08:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E3DC433A0;
        Wed, 15 Feb 2023 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676449591;
        bh=zQtGlDG1xVHfxVULJ3poQHX7O/rMIjMzR3+yzqktZ5o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FZTnt2lRasjFXMBj5DkWa1Kl00FlFl+WVMK8W3vvV5X4qs/2RUoGzhs0QrvMmzLn1
         EM0HjmojIaPni/Z1Xb+LqBpLs8WQVxggIf3C6D+etthl+uaDzbh8YX24fkZeLGg+gd
         /5qfPyadi9g2PHE2f2YNc/TlfDrIsrfCUxi05lHUUaHUoztxSck4Q9FpKGPyYUQjXX
         F/QHVJsSrk1MyKwVP1XIxlIHHIw+ffHI2tDv6mUmn6FMZMugD7jaSxBjcoUmpFZbTR
         sIw07p+VtxKWnht/TjvQE/DV0w7O5RLcUXn0PcVvmhzjL94IoUUnabwTXHaWsmttd6
         2vTe+qOJyc6/A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix radiotap bitfield
References: <79c72b8b101f561bae2350b7945cb41bef86aa83.1676095591.git.ryder.lee@mediatek.com>
Date:   Wed, 15 Feb 2023 10:26:28 +0200
In-Reply-To: <79c72b8b101f561bae2350b7945cb41bef86aa83.1676095591.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Sat, 11 Feb 2023 14:13:58 +0800")
Message-ID: <87pmab49mz.fsf@kernel.org>
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

Ryder Lee <ryder.lee@mediatek.com> writes:

> Update radiotap bitfield.

The title says "fix radiotap bitfield" and the commit log "fix radiotap
bitfield", neither really explain anything. Please but more effort when
writing commit logs and make sure all Mediatek engineers understand the
importance of this. This is not the first time I'm mentioning about this
to patches from Mediatek. More info in the wiki link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

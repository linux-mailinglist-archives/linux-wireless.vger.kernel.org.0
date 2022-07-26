Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD55813D2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jul 2022 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiGZNHH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jul 2022 09:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGZNHG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jul 2022 09:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5024F07
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 06:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F52261557
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 13:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FC8C341C0;
        Tue, 26 Jul 2022 13:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840814;
        bh=Fp0ETMXSf1u3HJPg8GQaoP+P+FapvKLn/mwE+gJI7rs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YCboPrdPeQPwh2ex7MGeu+llbROZNF9gz6JMv7KfTuPLd1oy8qycF38zn5HFiHaV5
         c5Hv8wFscyatMyzj/C4px+BlemLaFSQoMI279jvzONakFAiOlecn1/lgrhNzC7QbyU
         b0vIx8nuuI6DVqhDXwoFGitbNDFFX6J2/NBVj1SncSIbauQajrGfU8ynftH+GJpt/O
         FfcNZx0L3xUQVcH/MY3Ef9dFW2Sa4dk9+b9/hJ1r3hTMKm+qYg+GUHOVvEAzCpYAVo
         3fNiaGD/vrg+GCAhJlh1eWT9xRnIbkNxJxsXNDSNxGmJwmwThJp3CFNq3ExAGvZyhs
         TEcI/hFmYwNOg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lian Chen <lian.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: address4 null frame using fixed rate to trigger WDS
References: <20220706090901.88929-1-lian.chen@mediatek.com>
Date:   Tue, 26 Jul 2022 16:06:50 +0300
In-Reply-To: <20220706090901.88929-1-lian.chen@mediatek.com> (Lian Chen's
        message of "Wed, 6 Jul 2022 17:09:01 +0800")
Message-ID: <87wnc0koph.fsf@kernel.org>
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

Lian Chen <lian.chen@mediatek.com> writes:

> From: "lian.chen" <lian.chen@mediatek.com>

Please don't use dot in your name and capitalise it as well. So this
should be:

From: "Lian Chen" <lian.chen@mediatek.com>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

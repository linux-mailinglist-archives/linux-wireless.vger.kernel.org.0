Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8178BE94
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjH2Gir (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjH2Gil (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 02:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32381198
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 23:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB61963139
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 06:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEFFC433C7;
        Tue, 29 Aug 2023 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693291118;
        bh=x/iqnYEMiERFgFB3t6SZXqvZT0osBSR/qTcOQ2PyUNw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=joke98uu+nHTaahbAOQutcUSq8mvmquk3EWQ+dGYEd4vqQSzjMUAV4pV2bNR9GFcL
         +nTcXWGJzMWmelJ57VU3gQAixT4hcHibD9SWYep+BkNdndhL37Cl8Z0qGl7GtBIhlf
         aPMcoh5rHfl4EilfVFVjey4Yky67j4xV4xi2gOS72C/nF/N3Vf0bkzavIicQnLPmyZ
         HACIRihQSMWzZuurRoeOS2I8SgNr/hD016uDYnedPwu8IVMBbXrQ4iHOKlOz7vYlOl
         iN1ENqJnzD/GKge+IqMxImWvJCaGIFRMxELT+bqgU+ZIcdJGi5tg4viEKB51Y0ktli
         anHuYKTf7l06g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Alexey D . Filimonov" <alexey@filimonic.net>
Subject: Re: [PATCH] wifi: mt76: add ability to explicitly forbid LED
 registration with DT
References: <b08ef4d7c91c54e273c61784272e5c6f70c3c137.1692896654.git.ryder.lee@mediatek.com>
Date:   Tue, 29 Aug 2023 09:39:47 +0300
In-Reply-To: <b08ef4d7c91c54e273c61784272e5c6f70c3c137.1692896654.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Fri, 25 Aug 2023 01:08:37 +0800")
Message-ID: <87edjmtkr0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Add ability to explicitly forbid LED registration using DT led\status = "disabled".
>
> Tested-by: Alexey D. Filimonov <alexey@filimonic.net>
> Signed-off-by: Alexey D. Filimonov <alexey@filimonic.net>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Is this a generic Device Tree feature and already documented in DT
bindings?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

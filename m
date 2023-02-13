Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D1694618
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 13:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBMMoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 07:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBMMoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 07:44:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373DA7A91
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 04:44:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FC561019
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 12:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE4DC433D2;
        Mon, 13 Feb 2023 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676292260;
        bh=jrLyf/GztDce91rXsuNwGlZZizqPgYCMfxS3dR7fo2c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Vp92LeHeRxy3a3k7lx7Q1Xdz2yyfIR8QtHrubDHG7dH4cwBDxAyH9akiMICG6A4bR
         vzIFixpZ7z6VgReJzirTi1HTKQTCKTo3t0coS2hJ1RbLX+MowBdCavdrCso1M9ENtL
         HqLBC96Xwb/2DRn+I4kidjleRLBtxyyrKLr4hX8K0gYaA3OnV02Wt2kH16ZqbsFJtQ
         byhi96Fs7vkiTGZ9jOP4Bwe8K7AykEZMt2hNXn1tvbBkFK0/O/oxFVy+feGDH97MgM
         tCG8H8N0uSQr4nup7pWqLji8GU5m86oo9+9MlB5aHm7Nzp9kKS6WidbIm2fUVfH+Jb
         RpO0Bb4OUtA/w==
From:   Kalle Valo <kvalo@kernel.org>
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Money Wang <Money.Wang@mediatek.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7915: remove BW160 and BW80+80 support
References: <20230104090352.31938-1-MeiChia.Chiu@mediatek.com>
Date:   Mon, 13 Feb 2023 14:44:15 +0200
In-Reply-To: <20230104090352.31938-1-MeiChia.Chiu@mediatek.com> (MeiChia
        Chiu's message of "Wed, 4 Jan 2023 17:03:52 +0800")
Message-ID: <87fsb968gw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

MeiChia Chiu <MeiChia.Chiu@mediatek.com> writes:

> Remove BW160 and BW80+80 capability in mt7915.

This patch is already applied, so too late to change it, but I comment
anyway as this is important:

The commit log should _always_ answer to the question "why?" and explain
the reason behind the patch. For example, I have no clue why you are
removing these features from mt7915.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

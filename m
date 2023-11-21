Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF797F2C03
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 12:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjKULsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 06:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKULsD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 06:48:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F39C
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 03:48:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9165CC433C7;
        Tue, 21 Nov 2023 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700567280;
        bh=jAkO0wCcoQAJh9kzzWEPvEYnyVg9GBQBsbrBcf4OCYs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YiBmB7g4IWPSTl6o4cY+YpPGW+h1wj1Y93vHEIqoH75K9Nw7p6dSlecIAV0uYbxHR
         ZtSjJ6DnREKiOSycEFmzPa7OXt/gA/i9LhY1RdoSBNoNopXeVrCxP7QVi/45IcYXC7
         f6HXQs8QdjX1mCASGS5IX6nYiW73o1OdTls//fLDRAOria/uw3BgaU25c/Ua8J3Bi8
         UGd/hWV+WaZuGLqttEBt7TaoGvH4lymxMpPH685/4UTibh3+Mxni/Zm7aeEMvf0c2t
         GtISl7o1Pvsq/JN+VOJUe8BNTBpISM3uM6610R2jybk7iQM8Hr/IrwBy3NvP9MIgL6
         dqKwYylq489cQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc:     <nbd@nbd.name>, <lorenzo@kernel.org>, <deren.wu@mediatek.com>,
        <Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
        <Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/3] wifi: mt76: mt7921: series with CLC patches
References: <20231120032750.19747-1-mingyen.hsieh@mediatek.com>
Date:   Tue, 21 Nov 2023 13:47:53 +0200
In-Reply-To: <20231120032750.19747-1-mingyen.hsieh@mediatek.com> (Mingyen
        Hsieh's message of "Mon, 20 Nov 2023 11:27:47 +0800")
Message-ID: <87fs0z8h06.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mingyen Hsieh <mingyen.hsieh@mediatek.com> writes:

> From: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
>
> Sync internal mt7921 patches for CLC.

What's CLC? The patch title and the cover letter are gibberish for me.
They should have an understandable introduction in plain english.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

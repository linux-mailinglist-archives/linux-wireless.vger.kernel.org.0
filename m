Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E67F2C0B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjKULuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 06:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjKULuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 06:50:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D4D1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 03:50:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700CAC433C7;
        Tue, 21 Nov 2023 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700567403;
        bh=TctL7ube5UouPXuNkuXmxJ9dst6jjdEmdZ8tTRazoOY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GeyDXz5Raso7UvKamvDSPVf2gXeu/HV0DEtApSwItxC/BGDzGclV8+4HAVJiJwy0F
         Ong1awnNfpcY/cIXr7cxDEntQbKqWK9idtmP6dwuSUYUNfkbU7TWBPTe1zj1ThI1yO
         zsudFhsAN+sbTHhoJTAjjZND3AnW8VDpgfUNyiwm+YalH4kkjecqkhKMZaq2hM85pq
         veAQ0ek8AuVTbrCjG7qSGy1gyKC2f+Cu/Gu2FxsleAZeX/yQ5WsLfSU3bvRcsYjs4Q
         sGs1HRXgviGPAsvgpMY4/xyOIb6VgE8Ud9A2FAbU0uK8bgGLO3C2uhxC07P9lGfx6v
         gOjfZScGSucbQ==
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
References: <20231120111212.4478-1-mingyen.hsieh@mediatek.com>
Date:   Tue, 21 Nov 2023 13:49:58 +0200
In-Reply-To: <20231120111212.4478-1-mingyen.hsieh@mediatek.com> (Mingyen
        Hsieh's message of "Mon, 20 Nov 2023 19:12:09 +0800")
Message-ID: <878r6r8gwp.fsf@kernel.org>
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
>
> ---
>
> Ming Yen Hsieh (3):
>   wifi: mt76: mt7921: fix country count limitation for CLC
>   wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
>   wifi: mt76: mt7921: fix wrong 6Ghz power type

v2 missing from subject. Please carefully read the wiki link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

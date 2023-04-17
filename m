Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B276E4471
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjDQJuk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjDQJuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 05:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6329037
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 02:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37DCA6210A
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 09:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E94C433D2;
        Mon, 17 Apr 2023 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681724881;
        bh=J8FxZwN+gfbiP3np1stFrIDazA6qGv8fKwmLZKiH1wk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KFHXSXRIGul36gPyae+YeyCgbmk99tlcqbqSU7VzNVUKKoWFPUFjaskOOe9trjSGN
         NAa722rvjcE6rc5LkRxA4eC88oz+g19DJp515MXjYB06smEfgYn9D7h5v8GURW0As8
         a+jzMAEQg3tJFkdmVcbq7zPlT+QDA5F+HdjF3i21GybNQkjZCl2LRBme8MvMRhuhP2
         ssSHsdlmoVVpiDjRMSpkSk8DyVEzkpUN3XDfuOUxS0FNfOooksCOq6v+sUipO5XUNI
         l6Jy2gSKh9fjJEeohQRtrCrLm4mBtY53WUU5riUi6yTB6NetIwwv3lkK261UroWgD0
         OjucWflakwrRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: support WoWLAN mode for 8852be
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230410053438.10682-1-pkshih@realtek.com>
References: <20230410053438.10682-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172487696.26465.13379459123168725853.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 09:48:00 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> To support WoWLAN mode for 8852be, we add one PLE quota setting and
> WoWLAN stub, which shows that supported WLAN events include receiving
> magic packet, rekey packet and deauth packet, and disconnecting from AP.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

6863ad915d32 wifi: rtw89: support WoWLAN mode for 8852be
deb1b2aed763 wifi: rtw89: fix power save function in WoWLAN mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230410053438.10682-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


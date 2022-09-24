Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED685E8C9D
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIXMhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiIXMgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 08:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C822AF193D
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 05:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD24B810F7
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 12:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B88AC433C1;
        Sat, 24 Sep 2022 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664023012;
        bh=sOwYYB2xZVzF4Sh8+ygZUaCx08mtoKN7wi2EaoA96KQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VOmTLEuOs9bcfuK+fQSydql7fd32JP9zNK+N3Xj9Epryyml15RtKAmZhNoTwG682O
         ELLZmKadYfeAxGylKCtYFNx2R/0PHVDwUPWy7q5/EPIXFbOv34HI52UAkth31yeHel
         1S/dv5OUpOq60ho94lLR4Kb6jguMMogLDfaf4DFavp4D8vIQbdJBacuUV5Jg2UA3Ug
         N/lny5Ozc8EuTiYOrR7AOywfSdWTk7LIaL8d5c9ypOPXOmiieHwMzB34lGLfP16O82
         8bNersEeRQWsSj4NBF1sl7ycvL+TlF0PrzZT/o6DHocjDUC1ppcFjDYOhFGyUNGy5U
         TYvQcBT2InWXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: support P2P
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220922010435.12167-2-pkshih@realtek.com>
References: <20220922010435.12167-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166402300909.7040.1754686766857937320.kvalo@kernel.org>
Date:   Sat, 24 Sep 2022 12:36:51 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po Hao Huang <phhuang@realtek.com>
> 
> To support P2P in driver, we set P2P interface mode to the wiphy
> allocated for 802.11 PHY and add a change interface function to
> switch the interface type to P2P.
> 
> Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

e8ecfdd656ab wifi: rtw89: support P2P
3788c599da62 wifi: rtw89: send OFDM rate only in P2P mode
487b7b70250c wifi: rtw89: set wifi_role of P2P
71392bb249d8 wifi: rtw89: support WMM-PS in P2P GO mode
f4a43c3b95a0 wifi: rtw89: support for processing P2P power saving

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220922010435.12167-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


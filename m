Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4F69A82D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBQJeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 04:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBQJeT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 04:34:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844074B507
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 01:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE2561746
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07BBC4339B;
        Fri, 17 Feb 2023 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676626457;
        bh=WiupnMj/VRShKJfX+eZ5coBxiHKZAEotlYGj2d8c33w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OsBecHhiJxO8XMgL/q8qs/p2jFVgj3cSN1dg+etD5xpOzz1HzOK5H3As9v3VvB7A3
         EekdjUVrwq6/itfMz68SbxKlL9pkxSjfaDKjwPMGru+5Qlzq4GTWweP8yKTxXW55ob
         ALRnL8SWg91UjAVFZhPsG5j4wp1bAx8LZe6p4VyAbxxNZEY05tBTbTGL4aSCE6Vw+d
         rdFgZhqgaDvvlAfwaKF/pxi1Ouz/S8wxEXbHATmha3N+M4gOZ0o2ILpR++tNg07aFf
         siQSBwkaA7M8N7WJs5BK8tUGyYyZsfQriXSUtS7Vqw121ACRCTVSR7fkPKK/S4bFHR
         KlKq60Ft31Djw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fix AP mode authentication transmission
 failed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230216082807.22285-1-pkshih@realtek.com>
References: <20230216082807.22285-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167662645468.23451.13872151055729900939.kvalo@kernel.org>
Date:   Fri, 17 Feb 2023 09:34:16 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> For some ICs, packets can't be sent correctly without initializing
> CMAC table first. Previous flow do this initialization after
> associated, results in authentication response fails to transmit.
> Move the initialization up front to a proper place to solve this.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

0731d0b664f2 wifi: rtw89: fix AP mode authentication transmission failed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230216082807.22285-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


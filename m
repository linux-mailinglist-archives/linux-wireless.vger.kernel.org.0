Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259B703C83
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbjEOSVq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbjEOSV3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 14:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F81A3AD
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 11:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DEF63163
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 18:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE59C433D2;
        Mon, 15 May 2023 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684174781;
        bh=sPGj3wUvKkGvX6ucvXxr19BMmg8jC165fTb+gTv88BU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sTxOklfMjCLWl8G7wJVMdBk7Q1VEBwMnTosD06SMuPhinu2B9DTNvcvrn6CX2vEID
         70MaCuxxHghRrLP4PmdlNo7lRJoPagjy9Jcdy3v3a7HVZZ4x2wtYx+yBP0hnK+alYS
         GhHnD/79iWyuUdjOtyIXSMrM9eZ2sXxTMfYwH5YCbe4c1760yZx6ImusQJU9yg5mC8
         j9Zh/sF7kihAsj0HyIJ9shi+LYU0i388LIHy8sLrNrQiu+5P/eUwE8e7a0mxAwsnTs
         0P6K516ITbsARbQu50vBNMLOPbUPdFa60HBAeo8N3U66n7pVAJi/18O6zzYB7kDwR4
         LGqtBePxum1qg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: rtl8xxxu: fix authentication timeout due to incorrect
 RCR value
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230512012055.2990472-1-luyun_611@163.com>
References: <20230512012055.2990472-1-luyun_611@163.com>
To:     Yun Lu <luyun_611@163.com>
Cc:     Jes.Sorensen@gmail.com, Larry.Finger@lwfinger.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168417477523.32723.7861980499011954948.kvalo@kernel.org>
Date:   Mon, 15 May 2023 18:19:38 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yun Lu <luyun_611@163.com> wrote:

> From: Yun Lu <luyun@kylinos.cn>
> 
> When using rtl8192cu with rtl8xxxu driver to connect wifi, there is a
> probability of failure, which shows "authentication with ... timed out".
> Through debugging, it was found that the RCR register has been inexplicably
> modified to an incorrect value, resulting in the nic not being able to
> receive authenticated frames.
> 
> To fix this problem, add regrcr in rtl8xxxu_priv struct, and store
> the RCR value every time the register is written, and use it the next
> time the register need to be modified.
> 
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> Link: https://lore.kernel.org/all/20230427020512.1221062-1-luyun_611@163.com

Patch applied to wireless.git, thanks.

20429444e653 wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230512012055.2990472-1-luyun_611@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


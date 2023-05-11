Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375786FF28E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbjEKNTb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjEKNTH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 09:19:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99870A5C5
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 06:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 837BA64D06
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 13:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0117DC433D2;
        Thu, 11 May 2023 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683811055;
        bh=AvwwjXUEDNsnXp9hgyODyKUzP9pGTc9XnK9Z3C6cgqg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cyTFNBCgs+nXebwmHJGoDLxLBFLAS/hex2IbcN1bebEIH9XD2lEZjMFckQdqrhWRv
         svJqGkwaKkkVcdG6PcEidfwXbHUYchRoKvhr55X/pVwExorZMtJde+6yrRNW9+FCIY
         yqAXNsiWuNAfNODMOMjJyoXWUvluxbMUMU0Gi5VQQ9V2vL8xLRZLkoy+NZDFDxbY30
         2AIsp8tUfmaywfkxUc2uKbpwz91gDJK4Ew7KYY7K6yz16cylpY1O8gVaxxOponNubt
         L43P80wXYcKi1Yq05KAN7Yi6KJ+pU+5VegHY+saYzHxe6tb7gTJjhGPf76iwgETlqb
         xGlrB/D9cF9Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <c43d971c-21bf-6714-d852-c76e515438b0@gmail.com>
References: <c43d971c-21bf-6714-d852-c76e515438b0@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168381105207.27145.15003359039951078717.kvalo@kernel.org>
Date:   Thu, 11 May 2023 13:17:34 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This is a newer chip, similar to the RTL8710BU in that it uses the same
> PHY status structs.
> 
> Features: 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps.
> 
> It can allegedly have Bluetooth, but that's not implemented here.
> 
> This chip can have many RFE (RF front end) types, of which type 5 is
> the only one tested. Many of the other types need different
> initialisation tables. They can be added if someone wants them.
> 
> The vendor driver v5.8.6.2_35538.20191028_COEX20190910-0d02 from
> https://github.com/BrightX/rtl8192fu was used as reference, with
> additional device IDs taken from
> https://github.com/kelebek333/rtl8192fu-dkms.
> 
> The vendor driver also claims to support devices with ID 0bda:a725,
> but that is found in some bluetooth-only devices, so it's not supported
> here.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase on top of wireless-next.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtl8xxxu: Support new chip RTL8192FU
Patch failed at 0001 wifi: rtl8xxxu: Support new chip RTL8192FU

2 patches set to Changes Requested.

13229225 [v2,1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
13229226 [v2,2/2] wifi: rtl8xxxu: Rename some registers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c43d971c-21bf-6714-d852-c76e515438b0@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


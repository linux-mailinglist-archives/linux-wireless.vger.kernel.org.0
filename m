Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173FB703C93
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbjEOS0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 14:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbjEOS0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 14:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ACF100C5
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 11:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1483563155
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 18:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2C8C433D2;
        Mon, 15 May 2023 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684175180;
        bh=vDBhSExFs7qNYo/EtW87lKbW9mG+gur31TTW9A/cmjQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=M0/w8qrwMdhMpaY64bEYxQ1w3yafit2utoA9v+VHqUZdFpdobixnt+8NVrSXpDQxa
         NO5BgmCE1JAcfjUelRziJMQouaHvvclE4wp66lj2aRzsf+iE9QQ/fP/UpSH3GNaOg2
         EAL0AwP3nLe4g1HLFSaLtPtnoyi++e2+2o/QtL2QZgfsDRiD/Q4VvjAaC9/hGeLcCL
         SbIS0JXdxiKntL/P5x1peoQM4rFdk7FACj3r63C1Vx/848bidsbIBWwxtyIOwF7MdT
         usdybg3qeVmEZTYjoT4bXO41rOLn5YUQPFKpih2Am87cpyrlszcFvw1u4WR1B3F3Q5
         vmkr/WYuyLJWQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7dcf9fb9-1c97-ac28-5286-2236e287a18c@gmail.com>
References: <7dcf9fb9-1c97-ac28-5286-2236e287a18c@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168417517782.10390.1881353027436496537.kvalo@kernel.org>
Date:   Mon, 15 May 2023 18:26:19 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> This chip can have many RFE (RF front end) types, of which types 1
> and 5 are the only ones tested. Many of the other types need different
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

2 patches applied to wireless-next.git, thanks.

c98411dc8cf6 wifi: rtl8xxxu: Support new chip RTL8192FU
103d6e9d61e0 wifi: rtl8xxxu: Rename some registers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7dcf9fb9-1c97-ac28-5286-2236e287a18c@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


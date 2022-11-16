Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3AA62B678
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 10:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiKPJ0d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 04:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiKPJ01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 04:26:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D5BF5F
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 01:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FDC2B81C6B
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 09:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70210C43470;
        Wed, 16 Nov 2022 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668590784;
        bh=UneZ1eVyisoC3xA8JaNVn9/1IFAuDK5xDg0JrJPGO6w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Kj6dDJmZHoGs9GyNmFgiF5VX6uAJzV7woiSxFl8dM5VrY9R14uGjrOkeUFTfsO5lQ
         btQupjnLLMRoj0OEvTaV0rHC5G/WPkfsiVElS84IIIckdwGh7Hfzu+Jtbj/3iZPQss
         U04hclM9GWmxuLYLCVmSHJJEw2pKnHod2p1sCkkbigEn+yBTSS5dO6otQgNFkuoeuY
         nHb//hvtXiYyi0YostZRetJ4to5DUUZrlUdl2S4tMrB/MWmkA7Eto2tj4KMDXGoLAL
         kewgmboHRuAb0m3X/QN+jolEhlu9bjdsANjOhwEngkZRowK1iznH+WRHe7n72V8qVP
         ZXSpAj0W0Ql2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166859078114.16887.13775363906135869110.kvalo@kernel.org>
Date:   Wed, 16 Nov 2022 09:26:23 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> No changes to functionality, just moving code to make
> rtl8xxxu_init_device look nicer.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

3 patches applied to wireless-next.git, thanks.

bcfcb712e414 wifi: rtl8xxxu: Move burst init to a function
14566bbfdfaf wifi: rtl8xxxu: Split up rtl8xxxu_identify_chip
e948023d5fc8 wifi: rtl8xxxu: Rename rtl8xxxu_8188f_channel_to_group

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


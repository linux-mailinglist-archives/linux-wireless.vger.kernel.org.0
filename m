Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEB4FE2D3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245512AbiDLNiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356343AbiDLNiN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:38:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23652D1CA
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 06:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD9BB81DA9
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247E6C385A6;
        Tue, 12 Apr 2022 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649770553;
        bh=SuXlMzwcDmn7a5+aJzr1vKBKmzOIHZZ8lGMmDoXDmsA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FbJmq3tBjAQHayGQse35WzjUClm2GYj6ZNEzSOzO7nmDdZRW0is2R6Mtwh1r7rRyz
         HYpSbtgz5zvHOKCsvM8GJu8r1omnk2YyaHqpQ4+fJX6gkpE9JMzAupJPlpKx049Vea
         p8nbiTS6I/zts8LUl+KJ7WV3jqhesSinXExGKnTtp9H5+b2pGSx3+nffN4o5bs/RxY
         pltHHIyHst0ft/n+ZiwoW5B4gxBGK4s9MMnDUqfOu5qlnuDxyWLwlA8CBMYlKMVMN1
         ITVw0nO2ISAviE4LjoPD8fmN5ZNVD9PUxXAscIbcgLO0bZNqdUIaGhw9WFiwdtqQS1
         jN3F2mgA/eZTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 10/13] rtw89: extend H2C of CMAC control info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220408001353.17188-11-pkshih@realtek.com>
References: <20220408001353.17188-11-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164977055030.31115.15520119707373894158.kvalo@kernel.org>
Date:   Tue, 12 Apr 2022 13:35:51 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In order to support new chip that has capability of 160M, we need new
> format to fill new information, so add a new V1 ID for newer use. Since
> most fields are the same, fill fields according to the function ID of chip.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw89/core.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: rtw89: extend H2C of CMAC control info
Patch failed at 0001 rtw89: extend H2C of CMAC control info

4 patches set to Changes Requested.

12805942 [v2,10/13] rtw89: extend H2C of CMAC control info
12805945 [v2,11/13] rtw89: add new H2C to configure security CAM via DCTL for V1 chip
12805944 [v2,12/13] rtw89: configure security CAM for V1 chip
12805943 [v2,13/13] rtw89: pci: correct return value handling of rtw89_write16_mdio_mask()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220408001353.17188-11-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


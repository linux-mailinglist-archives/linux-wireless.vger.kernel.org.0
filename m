Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6125E7C4E57
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKJSH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 05:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjJKJSH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 05:18:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378191
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 02:18:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8761CC433CB;
        Wed, 11 Oct 2023 09:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697015885;
        bh=Z/W/TCU7A9cONG6bvKZER6FKS9MWUsG7YsU+cspr+lo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Q2qozJlgovs6tEG94YsKvDcNPtpJhKGlIHR6AUTRz71+64DsVNNTjUeX4QHunofiH
         lVvCiI3IhnIxTdtjsyLS9CiCwIFnMcgoAqtHKMDrIEkHCRrB1dxNGdKMAWK+znuckI
         yvPc/ieGzFETQs+6wIJmlvMsu87BftTxqtt+9sLF7+X6bzActm/wOZbnQKcx97eZps
         D0sEsP74WK9EdvOo/Pucnwskzbk3oxr9v4kVHr3saJaFaYwPS2W5BVfZCyqsX0B+oI
         K7MqFIM47m6WXQqiLWL+sMGq3mys9jXwDvpooaEGhXtdRcTo9OFQ/nPUy0LvbZjF/C
         DVYeX+vrzNZkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: Remove duplicate NULL check before calling
 usb_kill/free_urb()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231008025852.1239450-1-ruanjinjie@huawei.com>
References: <20231008025852.1239450-1-ruanjinjie@huawei.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        neo_jou <neo_jou@realtek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Ulli Kroll <linux@ulli-kroll.de>,
        <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169701588177.2760941.7597653842457844227.kvalo@kernel.org>
Date:   Wed, 11 Oct 2023 09:18:03 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Both usb_kill_urb() and usb_free_urb() do the NULL check itself, so there
> is no need to duplicate it prior to calling.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

de8dd0969498 wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231008025852.1239450-1-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


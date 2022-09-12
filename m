Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1645B59BB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiILL6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiILL6F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:58:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D8E24F2E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C9AFB80D24
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92469C433C1;
        Mon, 12 Sep 2022 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662983882;
        bh=sLDSilHdxZhBficGjDGoxG08sdiY4xNe6V0lm3Hxz7c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qgz2bzEZazQ2wHr2ZhHSeUG8mS2MgHSRYELH9cbpeMt4N4YAiXcnq9rSmIrGByJWv
         WeerGASUgvOJmXlx3qHQV11FiBZzZYY8d4M5UoKMi+Q6uqDf79OmmYJK9fmHeHpHzI
         W1BRa1Q/LWcxy6Md2tBq1coCBCaJCGBOU3ECpf7X+DsHc1ZwXhG/LUHRg+s49AhXz8
         gzSxTuVlNqJEKZyZHG0ij6A65P761lfDPrD7OTdEjg7wlMXi49ChD+RkVwWBV9tnz3
         FLMLvWswLjwSXS/qDV5Lrt6NPsPUjojU1DttKkrRWJUS6F1ry2g9UUaCQFL7PpMSI3
         a0zO3dHgxY/yg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: Remove copy-paste leftover in
 gen2_update_rate_mask
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <d5544fe8-9798-28f1-54bd-6839a1974b10@gmail.com>
References: <d5544fe8-9798-28f1-54bd-6839a1974b10@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298387947.4036.9724333459201506008.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:58:01 +0000 (UTC)
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

> It looks like a leftover from copying rtl8xxxu_update_rate_mask,
> which is used with the gen1 chips.
> 
> It wasn't causing any problems for my RTL8188FU test device, but it's
> clearly a mistake, so remove it.
> 
> Fixes: f653e69009c6 ("rtl8xxxu: Implement basic 8723b specific update_rate_mask() function")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

d5350756c03c wifi: rtl8xxxu: Remove copy-paste leftover in gen2_update_rate_mask

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d5544fe8-9798-28f1-54bd-6839a1974b10@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


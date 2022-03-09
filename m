Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD74D2E40
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 12:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiCILla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 06:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCILl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 06:41:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1174D158D92
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 03:40:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A044361842
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 11:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806FCC340E8;
        Wed,  9 Mar 2022 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646826030;
        bh=N0TjLAO+JFvHF9D+gQvFyxKtcO3n9sdYUV7uoTWlRgE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LEgHNb/sMji2fmUcPuONqMICgKaNBFG6lV3bXmHTmGjVe7rPgaDrHPsWx96Y9DvRz
         kY2tU1iKvxKHyAWAk1ig/ZPzGhZEk6ld7WKxDNTnWvS/VJ8CRTKGgq0kzxNcf5CAAD
         wMHQaw9Fkni8GToqQmVEPObkPaA3LLLZMUAzpm3QZnFNC1x9at3loo34s1BZ2AOyGv
         m3UfEwFv5vDDZOeczKKOWPokt5UbgU8o+VTbvdjahD/pyMZtX5DsB+j4gd6tfAY2Z5
         0oEUkVay+63xS1jtE3fZNi/HEXnQW6gp4B6XYaRs/VxPOYfJ394Mp7BFqO+0pU7ecq
         XJce7jH7vVHbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw89: declare HE capabilities in 6G band
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220307012741.6371-1-pkshih@realtek.com>
References: <20220307012741.6371-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164682602775.8809.4552949115449966474.kvalo@kernel.org>
Date:   Wed,  9 Mar 2022 11:40:29 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To work properly in 6G band, declare HE 6G capabilities. Without this fix,
> it can only TX/RX with OFDM rates.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

12b604d4ba69 rtw89: declare HE capabilities in 6G band

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220307012741.6371-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


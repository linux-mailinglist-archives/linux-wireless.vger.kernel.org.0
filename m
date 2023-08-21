Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA96A782E0A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjHUQPM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjHUQPL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E63DB
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760B763D4C
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 16:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCA4C433C7;
        Mon, 21 Aug 2023 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634507;
        bh=8eSubEh3Gmcy0RBDKQb3lhUFQSQ5/vCei+zx/UuNniY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PEOpyio/gDRZyuPUU8yLtzmDc7/feolVrvU8vMPIspxxD8bY3DTqwepvhGBOJuDoI
         h+xRjpSDk4K6jydGkIr1hL/yC7NTnnu0S3VUJ72Ucn1HW3BVDKudXV/JkTp9zU2BAh
         UVxaby9ZsxGDeyTLkMihq5FPEgNrfLUbpOncJuH3j9krKCyJqgKI0wXr4ljR4wz2Zu
         6uJqlC7EGrXaKjxc7gjsEOz2TqFd80j5Vev8sLBko2N9MnX+rt6hj3UEEEPI+39QEH
         2DbNwuKEPT3oGIxh1rQSpljxa45T5QO6VWyHQGKTD2kHSFddaXl48t0586YyvGH/nd
         weieF4JG3Gegw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtw89: regd: update regulatory map to R64-R43
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230815120253.9901-1-pkshih@realtek.com>
References: <20230815120253.9901-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263450532.572263.4799953092053555520.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 16:15:06 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Sync Realtek Regulatory R43 and Realtek Channel Plan R64.
> 
> 1. add entry for XK (Kosovo)
> 2. change TH (Thailand) to Realtek regd world-wide
> 3. configures Realtek 6 GHz regd for below countries
>    * AR, MX, HT -> FCC
>    * LB, ZA, BF, LA, MN -> ETSI
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

f585f4ab0b99 wifi: rtw89: regd: update regulatory map to R64-R43

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230815120253.9901-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


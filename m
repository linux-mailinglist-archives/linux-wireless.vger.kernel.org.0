Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8578A7EADE8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 11:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjKNKXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 05:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKXM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 05:23:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998FF83
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 02:23:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8221FC433C8;
        Tue, 14 Nov 2023 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699957389;
        bh=qSEdwVZse2vVgloTvH6hovs96UUb3q4uEgGqFpJ3GcA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HsJmFQ1feqv91lAS4ljsXQ/WBNzJEA4U9fxZoAopFs1Efcz4v+C7yqOgE9GpzE8Gn
         WRcTNU5hf9ZAwVyr1mOmATKz+DBvmXAHbgmPWbqxoGtUDO7yUKaWr4P6vvqBnpk9t5
         zP5TWOLyVZaQTUUcad6SeMeWhsuBrNR7nzvgpH6a+NsLCa/8k/q1Fw/IEdTPJ7PzIp
         p6bTbL0OL69iq9PGRHi69HTVDSn9F2ueuAgSHZJXj6OlJekPFgFhuXazR9Wavhb6rg
         ytwHh3rvcWdOVhobTh9jwEcgezjxEjoUNPsGOGAo5qyfdxaVK4SAj4jBiMWvFB+96D
         nuTcn9mJp1HpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: pci: reset BDRAM according to chip gen
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231110012319.12727-2-pkshih@realtek.com>
References: <20231110012319.12727-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169995738668.3786790.11636776803988939397.kvalo@kernel.org>
Date:   Tue, 14 Nov 2023 10:23:08 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Configure callback of reset BDRAM (buffer descriptor RAM) by chip gen.
> Refine the one of 802.11ax chip gen and drop a redundant duplicate of it
> in 802.11ax chip gen. Then, assign right callback of rst_bdram for HCI ops
> which needs to do callback according to chip gen.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

d5d717a77640 wifi: rtw89: pci: reset BDRAM according to chip gen
d720cca762ed wifi: rtw89: pci: stop/start DMA for level 1 recovery according to chip gen
9e1aff437a56 wifi: rtw89: pci: add pre_deinit to be called after probe complete
aa70f76120ee wifi: rtw89: pci: generalize interrupt status bits of interrupt handlers
d8872fb60e72 wifi: rtw89: 8922ae: add v2 interrupt handlers for 8922AE
9f08c77b7769 wifi: rtw89: pci: correct interrupt mitigation register for 8852CE
0a78bb64a499 wifi: rtw89: pci: update interrupt mitigation register for 8922AE

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231110012319.12727-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


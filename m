Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6D63AA3B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiK1N5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 08:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiK1N5S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 08:57:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E9209B1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 05:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C22B610A7
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 13:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB9C433D6;
        Mon, 28 Nov 2022 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669643836;
        bh=Wgd4ZqdNPCxDsHQQCn8t/PzEfvkc8SojOes48tArWtE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O/sKEogaGIEQ5XDfJ/FIPvp5lY/E0dfog9eWxSe/JAFEN8DC5rJMXH5oCTEG5cu4G
         swzMSMcF6UKo54/iN7fVn8srQXc5Rjr+jwbjOc0b6TcGylfk3oWvvFniQAEk/KuoIv
         UZWIRBYxHngST0USWA/1jBMVA5A0XW+GcYPVjYo2inUYGKGFQZ7oUo4eRR7l9sqCrc
         bAS8Fr0+9rMbljX+Z+BJPcxXVgqYGot3smNYMezXac6MO7xTpLwwvgN467O4tDF5rP
         HYMw95zOmeB8+TVw954dyLjtmfCgUqiQtpbPmqMN8TP8mvH3c/rgaIr/5ggqaFlgVd
         ZuOVDIyVy4V2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix use after rcu_read_unlock in
 rtl8xxxu_bss_info_changed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <3c82ad09-7593-3be1-1d2c-e58505fb43cb@gmail.com>
References: <3c82ad09-7593-3be1-1d2c-e58505fb43cb@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166964383356.4701.9676468780142047023.kvalo@kernel.org>
Date:   Mon, 28 Nov 2022 13:57:15 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Commit a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
> introduced a line where the pointer returned by ieee80211_find_sta() is
> used after rcu_read_unlock().
> 
> Move rcu_read_unlock() a bit lower to fix this.
> 
> Fixes: a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

7927afb5e27b wifi: rtl8xxxu: Fix use after rcu_read_unlock in rtl8xxxu_bss_info_changed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3c82ad09-7593-3be1-1d2c-e58505fb43cb@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


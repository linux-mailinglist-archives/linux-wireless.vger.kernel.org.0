Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7923F791C0C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjIDRbX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 13:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDRbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 13:31:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24478DF
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 10:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C5D8CE0E24
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 17:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5261C433C8;
        Mon,  4 Sep 2023 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693848675;
        bh=VOt6gicPaeIPvqwLgLnfcVzbmnlaq9APj1gvs0E06/Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uVPsoIZtL9u9pOgUQNQ/iuTDiIUfsUG786kv/iVhwQfLK5+I5cvIqLoqKgNMAy+1l
         5aH+ffqXvpdcCTzwe3BuR1vOaq8OUFRw+qSMyyeK9Z6Fb84sJl7prVfyOWOaJREsDY
         d79kwW6ax2KTv+K9oJ7/4XbLHhdCOKIKvgTsD/5g/T/Y3+SDjrsZBdl8gSuoyHKU7w
         kvJdMUxohafpIiV8naej5ArjYu7kl/B/q8LQBMLs9I1tDPS/D7lVMhhKCdaOKivT+7
         4mQkemiFcJJE2nv5S2CfZ4XBtK9DF2BhzT+rs9fHWEgzNWpE8RBNLO5+dAJUBhjNQX
         VlWKYMhNyqnHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw88: fix typo rtw8822cu_probe
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230825062404.50813-1-pkshih@realtek.com>
References: <20230825062404.50813-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384867273.3484948.17225830257356214987.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:31:14 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> The probe function of 8822cu is misplaced to 8822bu, so we fix it. Just
> cosmetics, no changes in functionality.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

497840a1fc5c wifi: rtw88: fix typo rtw8822cu_probe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230825062404.50813-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681F56F7DFA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjEEHeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjEEHeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 03:34:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B617FD6;
        Fri,  5 May 2023 00:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C86E63BDF;
        Fri,  5 May 2023 07:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7692C433EF;
        Fri,  5 May 2023 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683272043;
        bh=jou+LQyRCQeaGqtTBsEiVuLJnU3kOUVjVpVeFNIl5Ko=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KD8aHhQAFm5Q+jkMUhdKwNqSdtUZx8KYgUV+nSnu0TU6U/OHW2ixhUQ/3vLWnkFwF
         4I6UfdRf8Brxc/wEravSL6tad5g7lnkPNCJi5GxmX2PepXfJack9f6vtIOSAeI/DFu
         BNp/hQvbN4e5zoTsXvWJsoe+wv8Kv+063Dng7izZF+FfCvRnowAstQIDYbUqqv6P1x
         FMl/S6D2MFYoLQd2hRT2/fgYlwt9cAPw/EfIAufkylQMC5q48laVFYidtJ5lRzpjHe
         PE3RHf9Nwr/7Bfuybi/c5lLeUBaZkW9Mo6H06WprAwyotv0xnR0zgSS1sdXxCF89O8
         H6dWD51cZ5sLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtl8xxxu: rtl8xxxu_rx_complete(): remove unnecessary return
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230427185936.923777-1-martin@kaiser.cx>
References: <20230427185936.923777-1-martin@kaiser.cx>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168327203908.10202.16212695864478416217.kvalo@kernel.org>
Date:   Fri,  5 May 2023 07:34:00 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Martin Kaiser <martin@kaiser.cx> wrote:

> Remove a return statement at the end of a void function.
> 
> This fixes a checkpatch warning.
> 
> WARNING: void function return statements are not generally useful
> 6206: FILE: ./drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:6206:
> +  return;
> +}
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

271a588d34ed wifi: rtl8xxxu: rtl8xxxu_rx_complete(): remove unnecessary return

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230427185936.923777-1-martin@kaiser.cx/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


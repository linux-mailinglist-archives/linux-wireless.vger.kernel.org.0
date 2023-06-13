Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37E72DC84
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjFMIb7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbjFMIb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B231E188
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C518163210
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C869C433EF;
        Tue, 13 Jun 2023 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686645112;
        bh=810ANMJOJe05cXQJf2iu3tB0bGE5HE0U1LC3MB7XogY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pPZhDlWculNdB7/aU4yNG9abO/dxRjdnxP2IyQoB3I+/h/1H8s0ZSA1pOFZdACwra
         Og7IYfK7eUTEpSyUPmyDmah87bUMaMbWhaxxd7r5TOtvFtfelyi0MbdwH9PTNweaqQ
         nv68Rh3fKJhyoxyH7MEFORuk+5BPMu1j2IJSeZvt7uAv3AtwzEsbda+T0gAtTVkAnv
         lZa4khGbvaIB3hN/CfuBNjS8GHxBSgQqN3swbjb9ub+OgMIMAdMXTGkJtdCdRrPtXC
         dFF2+vCPZuZgDuOZYhDoEPThjUirp/Y55YghYic/vRrhqgxVmOsMfiwcCZWauN/2kc
         V3jqtLmKAJbsg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230608095051.116702-4-dmantipov@yandex.ru>
References: <20230608095051.116702-4-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664510862.24637.10587241603155144086.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 08:31:51 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Introduce 'rtl_init_sw_leds()' to replace per-chip LED
> initialization code (and so drop 'struct rtl_led' as no
> longer used), drop 'init_sw_leds' and 'deinit_sw_leds'
> fields from 'struct rtl_hal_ops', adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Is there a reason why you are changing error messages to debug messages like here:

-		pr_err("switch case %#x not processed\n",
-		       pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"unknown LED pin %d\n", pin);

The commit log mentions nothing about that.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230608095051.116702-4-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


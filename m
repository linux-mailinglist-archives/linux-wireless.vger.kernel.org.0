Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CEA6E232B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDNMZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjDNMZ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA5B446
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29BE362B56
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D157EC433EF;
        Fri, 14 Apr 2023 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475119;
        bh=KPcMzblFzjiIQjs1XuT1QyHsnofXmhZrXLO59bPQc7s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lgzBIw7UzwJLWRgKFw+sUPA0SLrhqdFuTFOoxwQnG3FmXEohn+WJgjPxOwMrB4pPr
         FZZIWdRbD6WNjE5MS63eCG1abqrPlCnmzT1zki3GXtD1vrIx+try2EZJyp6k/QQ5UK
         nuTfqPkAzNKXd/Pw+mIrCTAM/r2FI68juVPLogt7zN+kYIDOsOZ5vOtopnrXwf2pae
         mkkTUSdNoq3hjcq2Q3wzEc/GsHn0dqOMAHo+B/k2qlCVDRvp1l7uaXpsrW0teTz003
         PaMoHa+kIRbmjqVMKOPvioEp+8xD9bNtdDYAjO085bQfK/9Q4peCp6L2ND1MOjNxEe
         foGK95UE9Lbow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: correct 5 MHz mask setting
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230406072841.8308-1-pkshih@realtek.com>
References: <20230406072841.8308-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147511716.16522.13018836565914749986.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:25:18 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> Use primary channel index to determine which 5 MHz mask should be enable.
> This mask is used to prevent noise from channel edge to effect CCA
> threshold in wide bandwidth (>= 40 MHZ).
> 
> Fixes: 1b00e9236a71 ("rtw89: 8852c: add set channel of BB part")
> Fixes: 6b0698984eb0 ("wifi: rtw89: 8852b: add chip_ops::set_channel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

d33fc8d0368c wifi: rtw89: correct 5 MHz mask setting

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230406072841.8308-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D167B2239
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 18:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjI1QZZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1QZY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 12:25:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360AB139
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 09:25:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF88C433C8;
        Thu, 28 Sep 2023 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918321;
        bh=a6FPpoxSHlYTIWmLaAXwhE9B0RHYQd7GxvWPzpMPuO4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Tti6LxSE5a30G3r21TC5MoMnfKgBoX/u/C64cips76PYtK9+XjriJ5TT9SdFvxxUH
         ZjwWOegR9x6JCRqSXzlyN4HiEKrSMKlreHhdu9nyPQeMf3v2t1xWva2WLhlIGCJ2OS
         7sUulUALrkHt+F0Nm66SL0rvo7cI24AVx1LSp3/hWUJsfj1O2usaLK7QTDjQDauEQ1
         HDGJ9alWwuJyawvVQ0lx+Q71wPNhMeuBpE3Zbr2tOOz9cucA8fhJSUc5ETdeUuDX8G
         xYbOjKcK1lk3G4ZGABF3bzkKl33XBI3Swm/3ZUWit0PdBfDvzLd7Ac4CrI5tpWHt2y
         We2VgopyWBPaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: mcc: fix NoA start time when GO is
 auxiliary
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230921003559.11588-2-pkshih@realtek.com>
References: <20230921003559.11588-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591831921.3187104.11096006562898285558.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 16:25:20 +0000 (UTC)
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
> Under TDMA-based MCC (multi-channel concurrency), there are two roles,
> reference and auxiliary. We arrange MCC timeline based on time domain
> of reference role. Then, we calculate NoA start time according to MCC
> timeline.
> 
> Besides, when MCC runs GO+STA mode, we plan an offset between GO time
> domain and STA time domain to make their TBTTs have a time gap.
> 
> However, if GO is auxiliary role instead of reference role, NoA start
> time is described by STA time domain instead of GO time domain. To fix
> this, we apply the offset mentioned above to NoA start time to convert
> time domain from STA to GO.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

a4d7c872eb87 wifi: rtw89: mcc: fix NoA start time when GO is auxiliary
5f499ce69b8d wifi: rtw89: pause/proceed MCC for ROC and HW scan
0f93824ed720 wifi: rtw89: 8852c: declare to support two chanctx
8e73c0455b12 wifi: rtw89: declare MCC in interface combination

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230921003559.11588-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1876614691
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 10:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKAJZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 05:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAJZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 05:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1D1209B
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 02:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880B46153C
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 09:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C98C433C1;
        Tue,  1 Nov 2022 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294720;
        bh=ppGtIxe9KgtjjF2kT8EXlNp/+vE/2Q2/6ID07rh1Bfk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=A6PYBwJ5z50mQaEwOukHHwH5Ak5nl4pu7aP8MBFw7I6d0s9/6lfxw+3c88tTRyQiQ
         IMuUb0i6f9oKaJQDEkSu3+/U20kyg3LXLqBUarkyPBy3g7/n+ZhqOLkIMExgzssYZx
         yv5aunrQch1ToKnlKXv3bkmyu96L/uvIiD+KjduvzjtgjrPBma7q9D38oQRv0QfJjW
         JHHAb4cKx2vvAek23p/PqfBNEY0I2jm9v6OOhS66whwlqT7qip+ADOgTd/4X/BK8me
         rs9tC4w5VSbJiYwhoX2l89Rnqm/nKxjoxT3/yJMAObdDX+WoMIzHKN8LlCfjEvvlIj
         1WF0i6rDLijig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: declare support bands with const
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221020052702.33988-1-pkshih@realtek.com>
References: <20221020052702.33988-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166729471747.21401.17808128062164705834.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 09:25:19 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> They are just default declarations and we won't modify them directly.
> Instead, we actually do moification on their memdup now. So, they
> should be declared with const.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

a29dba478b6f wifi: rtw89: declare support bands with const
e69ae29e00ce wifi: rtw89: 8852c: make table of RU mask constant

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221020052702.33988-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


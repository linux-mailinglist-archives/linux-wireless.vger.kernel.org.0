Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8F694DAA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBMRFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBMRFo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:05:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF81E5F6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:05:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0FC6B815DB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE4EC433EF;
        Mon, 13 Feb 2023 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307939;
        bh=iz5cw6TGO21rYbD5MwmQn+gmJhhujCn74vBPrYZoP58=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IQYFA+uOzDnKyfU7jxBBtO3hLQmqvBaheMz8orNsmgesbXdj+iW4nCPuJh6dluVzJ
         9xWzpVnYQW1ot+EdP70UMTcBg6wjXv9OfdRNiZfj6wZOFxqZrxEJP8BocTQEnQ0eCQ
         8g349avd8WYZGqA9chXr2Lg8oeRaufSoTR5210HCEbyEgdjAAt5JrI7qNag5tNoEpF
         mBpzd9tgVUwczihD8AXZ3R4H14/rTxSJHe4H9Jl0RcnRn9US3v4BmVM+3vIsWlV4C9
         Ie8NdDILlD5t65hIxq9Zr5cWADUKWdBjE4DCPGUIFR3D0chYBaIP8f2iWYGLzOH58C
         j2Ao+Hyk5nM2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: debug: avoid invalid access on
 RTW89_DBG_SEL_MAC_30
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230119063529.61563-2-pkshih@realtek.com>
References: <20230119063529.61563-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630793682.12830.1912048566879679277.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:05:38 +0000 (UTC)
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
> Only 8852C chip has valid pages on RTW89_DBG_SEL_MAC_30. To other chips,
> this section is an address hole. It will lead to crash if trying to access
> this section on chips except for 8852C. So, we avoid that.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

c074da21dd34 wifi: rtw89: debug: avoid invalid access on RTW89_DBG_SEL_MAC_30
f5d98831badb wifi: rtw89: deal with RXI300 error

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230119063529.61563-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


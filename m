Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7207AFC1D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjI0Hbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0Hbk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 03:31:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F0BF
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 00:31:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17837C433C8;
        Wed, 27 Sep 2023 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695799898;
        bh=fFM9dWLKbSW12rKgbiUTbCaH38+Vd2o9XQRwQlOmW2Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ShZ4KDJpeHUsv0JlPRIwdd9EAQKi8fiEJtVc9zU9+65uzuNYVW3EwxfZMDkAaHX9R
         JM0VynrPrUaJXUX7bTv+Z4rGuEYNLEPxqIfhMaDdER67zpd6nGLHQCSpYtwtgTfznr
         5u1tKSwMYwJIrKSc/G//CzcSw1UMVQkaeuMnVN5uRCEjOapmJ91BqkiUFv2OH2crY0
         X5VmKmbgcoYCeZLA+LberAxUx0y6QDuiLAvGr6MrkQvCWAioIwobDGO+LXgPTuFWu/
         9av0QxIqHaJvxOaY6wBu++EQu2tXmeobJJ2TmuORUKPzSEZbjATBIJC4CFSdU+WUzv
         YNt2Y4LnrEsGw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/4] wifi: rtw89: update to follow regulations of China
 and Thailand
References: <20230927072156.26336-1-pkshih@realtek.com>
Date:   Wed, 27 Sep 2023 10:31:35 +0300
In-Reply-To: <20230927072156.26336-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 27 Sep 2023 15:21:52 +0800")
Message-ID: <8734z0842w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Recently regulations of China and Thailand are changed, and these chips
> have gotten new certifications, so apply new TX power tables.
>
> Zong-Zhe Yang (4):
>   wifi: rtw89: regd: configure Thailand in regulation type
>   wifi: rtw89: 8852c: update TX power tables to R67
>   wifi: rtw89: 8852b: update TX power tables to R35
>   wifi: rtw89: 8851b: update TX power tables to R34

I don't see patch 2 in patchwork but I did receive it to my
kvalo@kernel.org adddress, maybe it was too big for the list?

But I can also apply that manually so no need to split that patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

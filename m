Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3E728488
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjFHQDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFHQDF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 12:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F32D75
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 09:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D96964EC5
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 16:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42BDC433D2;
        Thu,  8 Jun 2023 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240179;
        bh=ccNwXS6wfNIJqLvLU0cbMkaH/vN8oPNrERyc4D3lCo4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rfXZt5wnY5cku25NArmHdShcMVucaDnlkxOrhwveLEuTS3jJQULsrTrrG4vS7zzJp
         z/nAPBziym3KYoVCUZFvDA0uLHTRrZ6O1EQqL45HEqUBrcmKpdZvWiOMwbO+IoSi2n
         Hs8Hz5Hiqy4nJtdDKAuKrubs7yaP0cWvCPjslHJOwYW7dJJHEzheOW1nok9R8n3Egj
         WoQLeG95NcDTpRYVho5HdwucuV44ykGkZ2BIJBDbfyT5EgUayy7k3iKkit3n7dUiGw
         5gTb5s7fqRDnhCkL5MJoOkW7Yrt0I5OKpNKM2TtYX9SzUfECJ/VG8pvyzAmV1Tzp2h
         Pa6eDM9H6JOlw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [v6] wifi: rtlwifi: remove unused timer and related
 code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230602065940.149198-1-dmantipov@yandex.ru>
References: <20230602065940.149198-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168624017677.5828.7488882043375974583.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 16:02:58 +0000 (UTC)
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

> Drop unused 'dualmac_easyconcurrent_retrytimer' of 'struct rtl_works',
> corresponding 'rtl_easy_concurrent_retrytimer_callback()' handler,
> 'dualmac_easy_concurrent' function pointer of 'struct rtl_hal_ops'
> and related call to 'timer_setup()' in '_rtl_init_deferred_work()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

358b94f0a7ca wifi: rtlwifi: remove unused timer and related code
557123259200 wifi: rtlwifi: remove unused dualmac control leftovers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230602065940.149198-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


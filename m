Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800F72848B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 18:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFHQD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjFHQDj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 12:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D430D8
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 09:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB5B0618B9
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 16:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60690C4339B;
        Thu,  8 Jun 2023 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240206;
        bh=FgTRkTfcB8xOAPM0OyjbLgrmPYSUNf1AkM9cFCELobU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gVZRs5AB0Q5N026Ep8ObE0GlIJ9vGUWL9xEEvF7TkrT51Lo7gaj2S6L4XoNAdkEGb
         9lIlA7DpXa4hWb+nAyKqSzQeKhD9EZ8LjvYifY9KoIWOmWmm4Z8hDLNqZQwDUgaTdP
         zMeDubcWSyyup7sVMhnLcFljZ6u1627AUy0TKeZYnAGyoQII1PpGwkY1P3/3ec6FzJ
         GfHpfiswJBTQAE3WfO/esIvVFjIA7RkpE5rH0gh4q/igYS1q2/T72tEtcLALCVyF7O
         MymThd0cAzqOtOJwq4tKYBSamfhMxdVWefjT4MCnSJe5Zdb9MVLCz7ejlO4w8PWTSd
         vcZmz6iOqVVkg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: remove misused flag from HAL data
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230605100700.111644-1-dmantipov@yandex.ru>
References: <20230605100700.111644-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168624020331.5828.12429802348098485707.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 16:03:25 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Always rely on 'driver_is_goingto_unload' of 'struct rtl_hal'
> and remove (presumably misused) 'driver_going2unload' from it.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

fef0f427f712 wifi: rtlwifi: remove misused flag from HAL data

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230605100700.111644-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


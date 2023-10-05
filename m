Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6587BA0E2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJEOmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjJEOhD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBB4788A
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 07:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166EC43397;
        Thu,  5 Oct 2023 06:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696488911;
        bh=s4wfOStNsmrkgPGdk7Y3LZFrIkcZotb3BHd+Syzv3fA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=siL559ixFxvb3XeOtUcGNvvqwp4g0d9pQfIjaYFsRS1vwMK0liRrVdm7RqJmjvSrn
         Hbfqd6fpnroT1WnF5rh5CRHktcD3aF3C/kG4lxuis1gt1Ag8F0YCrcxq0izf0RPos8
         dJjD+uMs8DqsLJ3wRv9ib8YuvoDFPFvaw/imwBSnPpEsF7MlvQpnsfIjwW7z9l9al2
         g3gPUKGJXIvRi+D9jrTjvg+5HT2ok/QFYNdwugtYEk6dlc3135nWL7gf+ToEJt1jQo
         CTop1YhneZYG5xZybjTpfTVsFODqUSPL72bYEV1rxcTfbRjH4588X3OtYlWIuFIW0q
         xWEQrAx/Y0Q0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: rtlwifi: remove unreachable code in
 rtl92d_dm_check_edca_turbo()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231003043318.11370-1-dmantipov@yandex.ru>
References: <20231003043318.11370-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169648890847.613656.9599178129343011800.kvalo@kernel.org>
Date:   Thu,  5 Oct 2023 06:55:10 +0000 (UTC)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since '!(0x5ea42b & 0xffff0000)' is always false, remove unreachable
> block in 'rtl92d_dm_check_edca_turbo()' and convert EDCA limits to
> constant variables. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9418edf8ff01 wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231003043318.11370-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


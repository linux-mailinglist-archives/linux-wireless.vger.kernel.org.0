Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138677AAAA5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjIVHpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIVHoz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 03:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1573410C4
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 00:43:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8EC433C8;
        Fri, 22 Sep 2023 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695368616;
        bh=+f8zGftn3d5DLHUAhA2ti+9ph0p0emRcrgqvWCGeRXI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cKGT3bSFLbTSM57i5Bj8/qDbxudN63hnfH9R6JdikO/gitRpgX4S12XE/+d/RSEHe
         BXgn/nZjko1KK3F2KzaJeElb50CTDG0V8fEHIceRgRNHfX6mZjEGhH45nBeQS8c/s2
         PdnTBBaS35EObq1nbOgFySsYwIvkpqe1k4j944mn/sJdAm61EZRK0WZTq3lccrcKEI
         jApqJ5fEVPQlyTkrrf2Hrz7eYkJkU2fwN+lW5O8VX9Sb6NPCqmjVMxPkrk3iZWlYHl
         z+7odRKfR7a9H/DxGgiA2iMRvAT/6vvgO4Ujrw0+WlsCS0ZCsb7C5MHaEDD82R2Lcp
         M4WLmPomZ55Sg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify PCIE write operations
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919132804.73340-1-dmantipov@yandex.ru>
References: <20230919132804.73340-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169536861298.2011393.6026492051683606786.kvalo@kernel.org>
Date:   Fri, 22 Sep 2023 07:43:34 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'mwifiex_write_reg()' just issues void 'iowrite32()',
> convert the former to 'void' and simplify all related users
> (with the only exception of 'read_poll_timeout()' which
> explicitly requires a non-void function argument).
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Brian Norris <briannorris@chromium.org>

2 patches applied to wireless-next.git, thanks.

c2e01a3a7b9a wifi: mwifiex: simplify PCIE write operations
804edf4d18e2 wifi: mwifiex: followup PCIE and related cleanups

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919132804.73340-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


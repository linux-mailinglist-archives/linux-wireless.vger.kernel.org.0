Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5F7C6DB9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378413AbjJLMOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjJLMOI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 08:14:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814BB7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 05:14:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15922C433C8;
        Thu, 12 Oct 2023 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697112847;
        bh=pwfx4DyzKcp+aoQKNkiNPVaI14yTKqnUi3ikmvwEd0M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=urgQcKiruDB7MCvXnZoDyFzXSReTrNbuJ1BnMuOrQdpuEjTSZVw4RGYce4eDEJNrm
         KLtsv2HO8XYVefP0kdHeUEqcjDIF3DBxlMvrM7CNEWq+bbdCeB0KFFvUkWS89zMf8T
         9QNIWg2yLMYiKt8+yACm4XkiXiy57qy85OsDagwcQqJgi/MJF0xxE4kkwi7deHwUwW
         bxKeRqtL0VMh7SnPXP2bl6Ud5JDUO7eXuafWcEQ7aIz6rAl4H3/uTLc6mod2e81bqU
         pbLJt/7CdBkr2pe1IFd8vdAYunRy8CGp4FA7BsP+owh+AxQjFc2JdytH9OJbgcCGro
         w77s0eYpJyhEw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: rtlwifi: use convenient list_count_nodes()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011045227.7989-1-dmantipov@yandex.ru>
References: <20231011045227.7989-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169711284392.2932680.11294505669650865034.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 12:14:05 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Simplify 'rtl92ee_dm_common_info_self_update()',
> 'rtl8723be_dm_common_info_self_update()', and
> 'rtl8821ae_dm_common_info_self_update()' by using
> 'list_count_nodes()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

0c27d27258ff wifi: rtlwifi: use convenient list_count_nodes()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011045227.7989-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF73E5850F1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiG2NfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2NfT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 09:35:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102365F3
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 06:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40F2EB82748
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 13:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61833C433D6;
        Fri, 29 Jul 2022 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659101713;
        bh=d6OVrjc7or8UfPrtJn4Zf+OJlrDIjPv9eer3BFndJ+0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=k6kqj+Z5n5AN9V4WdB6jzyHunYJFm1Zk3pf5zZnnJcsrPhuww/rAk64pCPX5/S72U
         XpU5zqJDONxr/ATNgtBkyTwg3v8QoOHOXEjozxGRraOCiJGQIh8lyYRdgYkTUKrLMZ
         9UqCD4ENg9bftxNruKxOUp/POguGktwOpE0NUbFEVgtdfcbzPPLdtg0ohPpU9XWOCO
         hbwYxfGx2m6TnIm8niZSehzeyE5Hqx8M/ISL5UvT+PmsEYwqc/8MKIXUzyNwPVnnnj
         yfPOYdJ9H+XrMSb+NtXHgH4Tq5hJEmNVTwfACK4P9Z0bzkRUAFeG0XVRtTmSQvZ+uY
         Mr4h5eS3nUw6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw89: 8852a: update RF radio A/B R56
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220622091937.11325-1-pkshih@realtek.com>
References: <20220622091937.11325-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165910170872.2014.8921303487805496036.kvalo@kernel.org>
Date:   Fri, 29 Jul 2022 13:35:13 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Update to internal tag HALRF_027_00_060.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

87de35cbf65c wifi: rtw89: 8852a: update RF radio A/B R56

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220622091937.11325-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D856E231A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNMXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNMXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20675BAE
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5935D60DFC
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E04CC433EF;
        Fri, 14 Apr 2023 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475001;
        bh=80TpWEVwwYnz0uVkBSN4+dx7DGBTSO0U0e05TH4cSJI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H9oZ5RGGL66tO9+oWyUnlUTF+NlItmGAH29wIpencLfK5sd+9/ZUxFnZOY6xFRXHF
         tQ76JQGqM+ZD2S8fcxN2Youu3SwJvM4m0ko6iCqgqsyfBOUDDXe9WL0lc85hFtusNp
         UJgrnuPIdbR7wzJi+hcXzrCxDPQUEdnDqNAjM4iQQrrJZQrTisYeqxMUDeExSLX+Mt
         PwcK6T3yWa0/87f/Kv1oXplczK5Pe3Zq8hbPvPZ4kJwWP9cKvmXwIP++1yuNi3+f2W
         aIZAWBIRzPPSHng/5sQOps66pLvtf2vXrngJm+cTOepa31k074kruBPu7B8vMkI3vq
         PvTi6WwnQ3FIw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: use hardware CFO to improve performance
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230330132352.13647-1-pkshih@realtek.com>
References: <20230330132352.13647-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147499922.16522.1929022539576024230.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:23:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> Turn on hardware CFO (central frequency offset) compensation based on IC
> capability, and improve digital CFO compensation accuracy by using
> more fixed points number.
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9f9882dbe2ee wifi: rtw89: use hardware CFO to improve performance

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230330132352.13647-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


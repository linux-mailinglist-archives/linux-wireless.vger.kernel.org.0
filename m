Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD45E8CA2
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIXMh6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIXMh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 08:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A994F3FA2
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 05:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BFC612D7
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 12:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E195AC433D7;
        Sat, 24 Sep 2022 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664023075;
        bh=pAhpr0vD5VJrnFfsJD/ORel9b/HJOFaW0YCdvUACijk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eEpipuRzMcBwC7W5pGk1dDKhw3gORJZ74zkGkKhygJXT5irZG7sM0LF+I3P4aF1wH
         t5aMQDPbugG2kNAlIOFKrptpHCf0Jd3fbRM+5AVHhTKR8bxkVlfTq8jnJwBKGZkT7u
         xV2l+bMiZWc0SGhmj0tUjMchLnj9sBL6Gel1JwnBek5OeFCZbgwAuO7MVJaHkCs8qE
         uW6IPLZ9f2I2OsABYaD6OfmJmSMCqKYMq//Z3GDtxtODJte4g74rToNpbyc4b531Ym
         dLDtWrHvbqTzbLU45CPxaIZd7Gt5SXuc3/Ft4ayTywkhsDXHIKow7sLtBaqyGMgGWe
         7dhpxzMxDwtvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: support for enable/disable MSDU aggregation
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220922012737.15091-1-pkshih@realtek.com>
References: <20220922012737.15091-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166402307272.7040.10876353612599473848.kvalo@kernel.org>
Date:   Sat, 24 Sep 2022 12:37:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> To enable/disable amsdu in set_tid_config, and currently only support to
> configure all tids (==0xff) for AMSDU, not individual tid.
> 
> The command example is:
>   iw wlan0 set tidconf tids 0xff amsdu off
>   iw wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0xff amsdu on
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

f3d8232331a3 wifi: rtw89: support for enable/disable MSDU aggregation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220922012737.15091-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


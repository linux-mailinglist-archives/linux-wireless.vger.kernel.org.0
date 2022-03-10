Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD944D4E31
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiCJQJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiCJQHy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:07:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D126186479
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:06:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A504261A7B
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D285C340E8;
        Thu, 10 Mar 2022 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646928413;
        bh=760maQ9sjCUDAySBGRxEwKBwF2H6XRivXPdFNKAewA0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EN92yeuo+d4IIHzcHLQ1sVCa7x0/ax8TvYQIw9G8lYtx45wR07Aonag3fsirzvjX0
         hmH2opTnE45u2sOn1UHfcUE1pWeCSDWi5ecF8BIKcxm1A1fHE4fse+y3dEFXH+ScJu
         pAxh0Tt58GXAJCOlhawtAFafquEBrFHmuyiQsA5RqM6U9W4OjocZSykIeNGwcyUE3k
         Au5zidTQIdvadDt9tiZMhoLLozmCJoT3JnQQcIzbmPaan2hbxkCOgdzkaaJXgAqUzW
         NCWkoIVEJvpfZu0LeRA11SoMUzt1rz0X4ci8L1bTeQFtczAZYdLSGFV5vZLPn9qIAr
         o+dY9J7rQdQpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: brcm80211: remove Infineon maintainers
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220222015947.169224-1-double.lo@infineon.com>
References: <20220222015947.169224-1-double.lo@infineon.com>
To:     Double Lo <double.lo@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Double Lo <double.lo@infineon.com>,
        Kurt Lee <kurt.lee@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <Double.Lo@infineon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164692840844.6056.3832881511546847810.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 16:06:50 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Double Lo <double.lo@infineon.com> wrote:

> From: Double Lo <Double.Lo@infineon.com>
> 
> These email addresses no longer work, so remove them from MAINTAINERS.
> 
> Signed-off-by: Double Lo <Double.Lo@infineon.com>

I cleaned up the subject and the commit log. You didn't mention that in the
commit log but you were also adding yourself as the maintainer, so I changed
that as well. Adding maintainers should be a separate discussion.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220222015947.169224-1-double.lo@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


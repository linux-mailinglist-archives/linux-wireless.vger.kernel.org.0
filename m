Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6582E46DB20
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhLHSfB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:35:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44204 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbhLHSfB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:35:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A937CE2328
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9123BC00446;
        Wed,  8 Dec 2021 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988286;
        bh=IYQKbvNuWTDxoZnjGxiIuIBQcWtLfeiEN1OYVs8UaHM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=u+ttsxn7fKxSOCYOrhs8eFaB22xsDQd186F7Owpf76lBOTGJ2uF+A0Yww+7OWWwXF
         DF/UA2jVct1k66Zs4wRbkZG1HG+xK6K7VUbDZRSe5Y2o31Q2AbeC+nv1C7RxvSY8HL
         kMG0Jx6/9n31EhutRR8REE11YQZpSHsFX/LTbo7P8kYcdXUFHXCzhJ5ROPPfx4f5oZ
         xy2zl+gdFS6MVB78Sx0+Z1hcnQ22y029vo2C7uaNuqAWRBKcM3l4WN6foObmLTHSm1
         Vql1fKBY6CvkkzjPifXKfgXpIKUOfsc+9eP4Pvt2j0gSNUuimqp9q073uCS/cDlnf+
         ISK+3i9jMdzgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: don't kick off TX DMA if failed to write skb
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211201093816.13806-1-pkshih@realtek.com>
References: <20211201093816.13806-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <dan.carpenter@oracle.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898828387.25635.4513505665745914358.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:31:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> This is found by Smatch static checker warning:
> 	drivers/net/wireless/realtek/rtw89/mac80211.c:31 rtw89_ops_tx()
> 	error: uninitialized symbol 'qsel'.
> 
> The warning is because 'qsel' isn't filled by rtw89_core_tx_write() due to
> failed to write. The way to fix it is to avoid kicking off TX DMA, so add
> 'return' to the failure case.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

a58fdb7c843a rtw89: don't kick off TX DMA if failed to write skb

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211201093816.13806-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


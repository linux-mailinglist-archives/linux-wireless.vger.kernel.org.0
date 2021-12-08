Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD946D733
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 16:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhLHPoz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhLHPoy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 10:44:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F9C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 07:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40532CE1FAC
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17207C00446;
        Wed,  8 Dec 2021 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638978078;
        bh=3qaV02N+c2xkdfF2KhkjlcHBGBbrD+nsu321FHilB+g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mPYP970hRieP9/dOfgET7o771y+ro9TdCewwKxLihZ63/9d2E2hLTYVS6KsGcxcLC
         uHM5sL+tlBZukRAmkEuAEwXEU0FpW/tgKD9WkDYY92l4mEnRvlrOTfSwJ7APRtAhWs
         tiZREK1FdoWY6fPQP56awNjqEEN05Twwo/S3Itp1Wid3xoIi+Rq8me61liIR5CbEkl
         7t8OmO4nbAWiSZsEoNcY4lEDmk8nVNcsyQ+9JR2ke+BhcrQyEO5eLifQkQ66smwMqY
         6v/kyz01A3ohP/6HJo8hUVsjMW+PK6OZVXD+XcxXEIZB6EpSFEp5P186KkN8a9FHEf
         6cQHjEVFodEMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 1/3] ath11k: switch to using ieee80211_tx_status_ext()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20210404125235.5589-2-pradeepc@codeaurora.org>
References: <20210404125235.5589-2-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163897807415.29276.3770719545792112108.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 15:41:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> This allows us to pass HE rates down into the stack.
> 
> Co-developed-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Doesn't apply anymore, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/dp_tx.c:483
error: drivers/net/wireless/ath/ath11k/dp_tx.c: patch does not apply
stg import: Diff does not apply cleanly

3 patches set to Changes Requested.

12182277 [v9,1/3] ath11k: switch to using ieee80211_tx_status_ext()
12182281 [v9,2/3] ath11k: decode HE status tlv
12182279 [v9,3/3] ath11k: translate HE status to radiotap format

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210404125235.5589-2-pradeepc@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


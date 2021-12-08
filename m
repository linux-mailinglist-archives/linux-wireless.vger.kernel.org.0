Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878EB46DB1C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbhLHSee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbhLHSed (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:34:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59268C0617A1
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 10:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A9E62CE2329
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C25C00446;
        Wed,  8 Dec 2021 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988258;
        bh=1ECTA8ZydcOs+egPyIHj+O/C38Tzc6EJXZMKkduo/PY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ViAlja9fpt4CgqnrJYmRYJsgWMvGMK+RHhVbmnPKu7GokRdpnGTlMlv8DP6Und6O5
         UcABjvuCq6qo8lhQDbvXpgp+3k+H9UN0b/FuyrouSna0IChomBHFZ8xok6uFU2/usr
         LHAo+hpnt3cMf9ppmlYAMZDC4fveNTQGw1jMndXpm0xKcqRddbj4M5psRRoQDYoAis
         fy/b5jEtmlct81d38hyEKtjOuX64ctoiNIA4Mg474uhwub/Nj93COi25TjObpFieUz
         lFy1fQ3uicocd57K9F8/lxCxBNEEY8QtVqUpPWo9iL4n3hKA2O2fxcai9egc4gQZzR
         vr9zKBvFdK/Yg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: remove cch_by_bw which is not used
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211201080901.12125-1-pkshih@realtek.com>
References: <20211201080901.12125-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898825553.25635.8120321819130059737.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:30:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Originally, cch_by_bw recorded center channels of each available
> bandwidths under current bandwidth. And the plan was to iterate
> cch_by_bw as parameters to query other configurations. However,
> we have not used it for the time being. Keeping it will disturb
> the follow-up things, such as bandwidth 160 MHz, so we remove it
> for now. If it's really needed at some point, we will redesign it.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

c2258b29985e rtw89: remove cch_by_bw which is not used

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211201080901.12125-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


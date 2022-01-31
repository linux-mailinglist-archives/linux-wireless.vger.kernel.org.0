Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF94A4A88
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359765AbiAaP3X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 10:29:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34386 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiAaP3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 10:29:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EED4B82B51
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 15:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEFFC340E8;
        Mon, 31 Jan 2022 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643642961;
        bh=1rRU0LWguILqDG6BNbTmXW3+jt/sraXkxfrk33pSNro=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=U8E/mCMgOYGBMdW0GgsY4trzWkdmtnQXCdJCyCtJqSEgtoxERMYyOO4tTCtCbZR9Q
         ne/JNj0fgJTc3HPpw4Wn0Mbm+yevz5SqE/6fl/NO1ZZoB0XsPkL4FTfgx3Tj+gz+dJ
         j8k1W60ppmXb5oOutUpqXIFIxJC1+2ans0YtBk++BgZDJhaH6gVuA+Fh4hKVIBikGz
         AMvBdURL0qYX+dmXQpNeIKNHWs8u7dBXT1+5euuDsvkg7OnC3PAQIM4HI4ioIPZrc6
         tWxvqC09n7j9PCCrLPLKKcfhzwsiE/1oFRxkTdQWZSUGHDRAOowNdEHNL/EE6WZY7X
         izdNVnRqX62WQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: rtw8821c: enable rfe 6 devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220107024739.20967-1-Larry.Finger@lwfinger.net>
References: <20220107024739.20967-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        masterzorag <masterzorag@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164364295528.21641.12931918158777730175.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 15:29:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> In https://www.spinics.net/lists/linux-wireless/msg217116.html, Ping-Ke Shih
> answered a question for a user about an rtl8821ce device that reported
> RFE 6, which the driver did not support. Ping-Ke suggested a possible
> fix, but the user never reported back.
> 
> A second user discovered the above thread and tested the proposed fix.
> Accordingly, I am pushing this change, even though I am not the author.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reported-and-tested-by: masterzorag <masterzorag@gmail.com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Lore links are preferred as they include the message id, so I'll change the link to:

https://lore.kernel.org/linux-wireless/3f5e2f6eac344316b5dd518ebfea2f95@realtek.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220107024739.20967-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


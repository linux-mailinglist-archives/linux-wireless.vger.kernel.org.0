Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D261B4A4AE8
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379864AbiAaPsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 10:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379948AbiAaPr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 10:47:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471EC061741
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 07:47:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A0D56145B
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 15:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA83C340E8;
        Mon, 31 Jan 2022 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643644074;
        bh=g+8b69fzydaQnNs/8zPvnD6F04sILmfvEs2g+oOnZ/4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=E2JlxgdQC+643EddsoSSs6yj/AGruU8v4+g5dCF7U4gGaaqOxBF1sLBbyxzexWLfM
         HQehuIVSh+rrjyX96Kvos54eR5iHjE75tfyowaaFNlSdTABB6TA0GqJ4g2Q41vMpFR
         HaIbo1HS20l/WfShXmyGBN9dA5d0EIvOY7dgu/mYbOn150b8ZuooUABm80ztdELMjW
         plC4z4MzfrjJowCdVoGDBFWScYOGeCJAr2LbZUCjd0iwgCQ9E47ed93wgcxL5r2fht
         qOnKBrZhS7pKJdO1T1Nqfo8adcaXUo2/qxcuy4EC4N1+QGFHKk7SMulD8IudWLnlZJ
         6cV0BF8jLZ0Gw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtw88: rtw8821c: enable rfe 6 devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220107024739.20967-1-Larry.Finger@lwfinger.net>
References: <20220107024739.20967-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        masterzorag <masterzorag@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164364407205.21641.13263478436415544062.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 15:47:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> Ping-Ke Shih answered[1] a question for a user about an rtl8821ce device that
> reported RFE 6, which the driver did not support. Ping-Ke suggested a possible
> fix, but the user never reported back.
> 
> A second user discovered the above thread and tested the proposed fix.
> Accordingly, I am pushing this change, even though I am not the author.
> 
> [1] https://lore.kernel.org/linux-wireless/3f5e2f6eac344316b5dd518ebfea2f95@realtek.com/
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reported-and-tested-by: masterzorag <masterzorag@gmail.com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-next.git, thanks.

e109e3617e5d rtw88: rtw8821c: enable rfe 6 devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220107024739.20967-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


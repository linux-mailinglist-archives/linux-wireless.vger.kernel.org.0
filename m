Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3351046EAA5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhLIPLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhLIPLM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 10:11:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4DC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 07:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24084B8249D
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 15:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08874C004DD;
        Thu,  9 Dec 2021 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639062455;
        bh=yUyk/DQFlEUejBdWzLfLiyyUs9+ywlMtyny1127mUxs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UQRgzOXBF7XOEwQd9gwPReORcf00ZiKAIKMhtdGZlc5AueAPgy9mIdczGPiGTMV4d
         Em4jHdLJs/e9ksXqKb4/REuORjG/wOVXR1B/4QylU2PenuKQIImD5ZeMhq9LERTHqI
         1+S+Kvb8MX5fSWirvqt4FG7ben0L+fIfF8KdWRGpmm9Ci50/B+QQ0z5nTMC/AtYXAj
         GPi7FoDB1snfNaDcHk4RN3U56tsk5Q7WD6DS3tLXPmBbCPktkW7MMm2IDtHhc1Azsy
         3fYUDvl+RPBqbd/SLkTc7hJTR3gD5prL4xsFjyhkuI6eCMg+0NJvfnr3TyjgxyYrZK
         k4ThmmfHKc76w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/6] ath11k: implement hw data filter
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-4-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 17:07:31 +0200
In-Reply-To: <20211011193750.4891-4-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:47 -0400")
Message-ID: <87zgp9zuj0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Host needs to set hw data filter before entering WoW to
> let firmware drop needless bc/mc frames to avoid frequent wakeup.
> Host clears hw data filter when leaving WoW.

Please try to use full words to keep the commit log readable:

ath11k: implement hardware data filter

Host needs to set hardware data filter before entering WoW to let
firmware drop needless broadcast/multicast frames to avoid frequent
wakeup. Host clears the hardware data filter when leaving WoW.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

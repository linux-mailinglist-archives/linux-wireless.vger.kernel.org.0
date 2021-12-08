Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8344E46DB0B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhLHSa3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:30:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42498 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhLHSa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:30:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1128ECE231F
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B888C00446;
        Wed,  8 Dec 2021 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988011;
        bh=Sf1HJ9NhMlVHrNv4yD/Ju/3TnPvTqFOyB9nYWjdST6E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NoQ3L4UWYboZlTn777Bcn669sTqpQr2B7kT1jvW+XrVI8HvoBX4/x+onqMsHTfNdO
         6lykvZ3rg8ENjrAk5pZEudDcaozPtQgEvRjvK6IzAh858jp7X3L2uN5TnL7lzTpprr
         71vAvQtiRcabLzHLNsVVwzd15Mbv01aqTB4yR0N4kR3ib4sXglBOmBArmd1jSoTCxt
         8+KTJm2v/4fsmMsBOlN9iI4MRMVkjQNfu2Xja8VYltGnKc8CdIOYYaAL0gEvwuWHVt
         11PgItCOZi4uz0OC25INURzjAz2zwTS2Y5mjJ+84/XlLR6gbLYhcHZLK6tFTxuLXV2
         e8PmjGm2vQnvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/3] rtw89: add const in the cast of le32_get_bits()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211119054512.10620-3-pkshih@realtek.com>
References: <20211119054512.10620-3-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <tiwai@suse.de>, <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898800513.25635.17892720462660014384.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:26:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add 'const' to be clear that this is a read-only access, and this patch
> doesn't change logic at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

2 patches applied to wireless-drivers-next.git, thanks.

321e763ccc52 rtw89: add const in the cast of le32_get_bits()
00224aa70891 rtw89: use inline function instead macro to set H2C and CAM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211119054512.10620-3-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98B48AF90
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiAKOaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 09:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiAKOaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 09:30:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CD1C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 06:30:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECAF261684
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 14:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4D8C36AE3;
        Tue, 11 Jan 2022 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641911422;
        bh=3YbvXQFmoeKr2zfRncYcsBgKf0u9oU4rKKvV8f5NIlc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OYshFZk95oY2p64CHl23tb8JQMXUmqR8SN8OD5QPbpSMAFcIB28Jfr6hDkfrRe4XM
         /dP14IcarB12CBlctSPQJPhNgC8vNS1kfM9VfCif9Jh/oGqM7uw4/515lAruEMQ5AE
         q7/iF2lkIal3Ll43QxmrEzuZTzlOdX3h+lmtRM4u2vnT+Rou3XX1e0Qu9LbEwY6tW5
         szqYEuYHnHXv9OAzGZQ0fKoVBY18+g32yu1rtxaMcda3J9NvMdd0feE8RldlO6/HbN
         nYZ6htPbEbKpW8X3oWEQwT7t7ka6PtFQ2zZth+N8prlQ3K3jh5LIghFLgMraCpBDq2
         Ce6Y5t3Gv9NUQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix memory overwrite of the WoWLAN wakeup packet
 pattern
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211222031347.25463-1-quic_wgong@quicinc.com>
References: <20211222031347.25463-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164191141967.24158.14971399294793691071.kvalo@kernel.org>
Date:   Tue, 11 Jan 2022 14:30:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> In function ath10k_wow_convert_8023_to_80211(), it will do memcpy for
> the new->pattern, and currently the new->pattern and new->mask is same
> with the old, then the memcpy of new->pattern will also overwrite the
> old->pattern, because the header format of new->pattern is 802.11,
> its length is larger than the old->pattern which is 802.3. Then the
> operation of "Copy frame body" will copy a mistake value because the
> body memory has been overwrite when memcpy the new->pattern.
> 
> Assign another empty value to new_pattern to avoid the overwrite issue.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Fixes: fa3440fa2fa1 ("ath10k: convert wow pattern from 802.3 to 802.11")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e3fb3d4418fc ath10k: fix memory overwrite of the WoWLAN wakeup packet pattern

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211222031347.25463-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


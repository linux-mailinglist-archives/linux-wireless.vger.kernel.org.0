Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F621C6841
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 08:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEFGP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 02:15:59 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52645 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgEFGP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 02:15:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588745759; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QuB5VzBHOvE3e2y1kGw5Ju3I/xMKwBoNv0353dWhaXg=;
 b=aDSvJPDzssQXk0mYj6D8HaPK4Ti7oplajxYy9Lw8O8bunkVOHsbYcv0AmCdGZ/vRQOyR8jb6
 M0bogSFJ0+25PrzLg+IwoPMf2/hH/W/RNKlmk0KLyLYJpXvlVfShJ2eQ4ghR8sTz/RSq6f6B
 fduSfRwhxSlNhNXYwrGlT4R3m1Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb25614.7fc19423c420-smtp-out-n02;
 Wed, 06 May 2020 06:15:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 43424C433BA; Wed,  6 May 2020 06:15:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 908FDC433D2;
        Wed,  6 May 2020 06:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 908FDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support to reset htt peer stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588610147-20231-1-git-send-email-tamizhr@codeaurora.org>
References: <1588610147-20231-1-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506061548.43424C433BA@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 06:15:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam <tamizhr@codeaurora.org> wrote:

> This patch add supports to reset the per peer htt stats.
> 
> Usage:
> 
> echo 1 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/<peer MAC addr>/htt_peer_stats_reset
> 
> While doing so, sync the wmi services between FW and host.
> 
> Signed-off-by: Ashok Raj Nagarajan <arnagara@codeaurora.org>
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

559ef68f5f69 ath11k: Add support to reset htt peer stats

-- 
https://patchwork.kernel.org/patch/11526701/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

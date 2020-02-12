Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE8B15AD3D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgBLQWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 11:22:24 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49982 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728674AbgBLQWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 11:22:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581524543; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=KOQTPvHewDnLtlXaKDGSsBGAKz5fVAwfY9Bsymf4EC8=;
 b=R5TK/wAvAYPZL8KBT4j7kmx4rIjYf0NycLb+bArSLDnZ87BR/+fepPAbvg08vvH1xir2AQYY
 bCnhasCSYJaPT8vc762RdwXyvTdHhqgdoeW5hUeyIVLRE26mlifBpM2mc3BNQwDyhmolNG54
 pv7i1JwGPSYJcY4J+/OzNskQbsA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e44263e.7f9e53128f80-smtp-out-n03;
 Wed, 12 Feb 2020 16:22:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A977DC447A0; Wed, 12 Feb 2020 16:22:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 45EF7C43383;
        Wed, 12 Feb 2020 16:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45EF7C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200204120614.28861-1-yhchuang@realtek.com>
References: <20200204120614.28861-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200212162222.A977DC447A0@smtp.codeaurora.org>
Date:   Wed, 12 Feb 2020 16:22:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some tests shows that using AMSDU to aggregate TCP ACKs to specific
> APs will degrade the throughput on 2.4G band in 20MHz bandwidth
> (< 10 Mbps, should be ~100 Mbps for 2x2). Also found that there's
> barely no negative impact if we disable TX AMSDU on 2.4G to connect
> to other APs. So it seems like we can just tell mac80211 to not to
> aggregate MSDUs when transmitting on 2.4G band.
> 
> Note that we still can TX AMSDU on 5G band and benefit from it by
> having 50 ~ 70 Mbps throughput improvement.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

Patch applied to wireless-drivers-next.git, thanks.

74c3d72cc134 rtw88: disable TX-AMSDU on 2.4G band

-- 
https://patchwork.kernel.org/patch/11364515/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

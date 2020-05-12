Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C362F1CEFD2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgELI57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 04:57:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52626 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgELI57 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 04:57:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589273878; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kbfNlsxQgIZWHGIpq55p7bDgbyT7GdC2wnws9e1zImI=;
 b=uGIEm9fs3oVsUxbhiwCaatoATmrd3Y/AzWWGLsr6AhvHNPBakI13Kfwongci4karYRFH7LR+
 T6B201LKAFfNH9OhoTQw1LENdl2fv1rhgJ8itQ6punCUS+Bhto0Ew4htgq0edoJmGhceC3wa
 EEua51AGYm1IMbmf+/3o4NGd+Y4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba6509.7f93ab527180-smtp-out-n04;
 Tue, 12 May 2020 08:57:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEC42C433BA; Tue, 12 May 2020 08:57:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5594CC433CB;
        Tue, 12 May 2020 08:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5594CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipw2x00: Fix comment for CLOCK_BOOTTIME constant
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200508195139.20078-1-pali@kernel.org>
References: <20200508195139.20078-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200512085744.DEC42C433BA@smtp.codeaurora.org>
Date:   Tue, 12 May 2020 08:57:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> Correct name of constant is CLOCK_BOOTTIME and not CLOCK_BOOTIME.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

5bb4e125815a ipw2x00: Fix comment for CLOCK_BOOTTIME constant

-- 
https://patchwork.kernel.org/patch/11537529/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

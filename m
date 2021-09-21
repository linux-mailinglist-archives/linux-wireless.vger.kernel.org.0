Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4284135C1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhIUPEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 11:04:50 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30249 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhIUPEu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 11:04:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632236601; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bsSyjO77usODxPNl9U4WuLitIVjcU7QWauyIkVpnW1I=;
 b=FyVRE3v7+vQvxSqTmTFIqyxUB2GgKNC5+Q8OSs6I5ENKOa07H2p5OGkiTCKcZNgSv1+++S/d
 5LvrWYN/3tvtxaRrOw/ossGWNot5eO2gqLdvzP21aLrpYHmXUaO4hgqtkfmgoYpOopd2gYqK
 Thh4Sf7z+zBZY98H3X4WP4c9mQI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6149f41fbd6681d8edec436e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 15:02:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E59F6C4361B; Tue, 21 Sep 2021 15:02:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8888AC4338F;
        Tue, 21 Sep 2021 15:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8888AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/9] mwifiex: Small cleanup for handling virtual interface
 type changes
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210914195909.36035-2-verdre@v0yd.nl>
References: <20210914195909.36035-2-verdre@v0yd.nl>
To:     =?utf-8?q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?utf-8?q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?q?Pali_Roh?= =?utf-8?q?=C3=A1r?= <pali@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210921150254.E59F6C4361B@smtp.codeaurora.org>
Date:   Tue, 21 Sep 2021 15:02:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Dreßler <verdre@v0yd.nl> wrote:

> Handle the obvious invalid virtual interface type changes with a general
> check instead of looking at the individual change.
> 
> For type changes from P2P_CLIENT to P2P_GO and the other way round, this
> changes the behavior slightly: We now still do nothing, but return
> -EOPNOTSUPP instead of 0. Now that behavior was incorrect before and
> still is, because type changes between these two types are actually
> possible and supported, which we'll fix in a following commit.
> 
> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>

9 patches applied to wireless-drivers-next.git, thanks.

babe2a332dc4 mwifiex: Small cleanup for handling virtual interface type changes
abe3a2c9ead8 mwifiex: Use function to check whether interface type change is allowed
c2e9666cdffd mwifiex: Run SET_BSS_MODE when changing from P2P to STATION vif-type
54350dac4e6a mwifiex: Use helper function for counting interface types
fae2aac8c740 mwifiex: Update virtual interface counters right after setting bss_type
25bbec30a2c7 mwifiex: Allow switching interface type from P2P_CLIENT to P2P_GO
5e2e1a4bf4a1 mwifiex: Handle interface type changes from AP to STATION
c606008b7062 mwifiex: Properly initialize private structure on interface type changes
72e717500f99 mwifiex: Fix copy-paste mistake when creating virtual interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210914195909.36035-2-verdre@v0yd.nl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


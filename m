Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290381B2657
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgDUMku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:40:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61121 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728739AbgDUMkt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:40:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587472848; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=UvZWvK6qxZ1S/tC6OgSC+nwBy7kAWbfgH4Qg5vZXk0s=;
 b=OKHlylQZUgGPJzmydZVeyeh8/1Mk7P57Tb3mrZ/UZG7sYLrCI9u5wqmjhQfA0JEfVLFzTUdw
 s2KjfaHOm4TNmBn6UjpNqGcm3rp+8ieByO11t1U7Rsl8C2SRmvUiOnutq3c6cdKEmhzvITzC
 U9vdlHMPCT+cdTbun9K7hVeTZ/c=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9ee9cf.7efc43d96e30-smtp-out-n04;
 Tue, 21 Apr 2020 12:40:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27395C433BA; Tue, 21 Apr 2020 12:40:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20AD5C433CB;
        Tue, 21 Apr 2020 12:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20AD5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 v5.7] iwlwifi: fix WGDS check when WRDS is disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20200417133700.72ad25c3998b.I875d935cefd595ed7f640ddcfc7bc802627d2b7f@changeid>
References: <iwlwifi.20200417133700.72ad25c3998b.I875d935cefd595ed7f640ddcfc7bc802627d2b7f@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200421124047.27395C433BA@smtp.codeaurora.org>
Date:   Tue, 21 Apr 2020 12:40:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> In the reference BIOS implementation, WRDS can be disabled without
> disabling WGDS.  And this happens in most cases where WRDS is
> disabled, causing the WGDS without WRDS check and issue an error.
> 
> To avoid this issue, we change the check so that we only considered it
> an error if the WRDS entry doesn't exist.  If the entry (or the
> selected profile is disabled for any other reason), we just silently
> ignore WGDS.
> 
> Cc: stable@vger.kernel.org # 4.14+
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205513
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

1edd56e69dca iwlwifi: fix WGDS check when WRDS is disabled

-- 
https://patchwork.kernel.org/patch/11494719/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

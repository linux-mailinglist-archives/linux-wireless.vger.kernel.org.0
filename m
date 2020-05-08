Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514121CA80A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEHKPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 06:15:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37062 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgEHKPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 06:15:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588932901; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BaqcliA4p3nNEO59IReAl9bjVvlaxz1X2IHSkwXX9qE=;
 b=Wd1T3ZbRbsTSbZW638/B2+ORK2SiahojptfKd3HmYbQ81xcT+fcAXjw7ZTG48aPL1qjzYvCt
 +u3kCKhJLN0L1+oBNwHjkNHddJydS3B5KihYx4PFzjMZvsdS2/EywWM0HaputI1EEpShIVMJ
 OF4sXBYIVkahwTD8ZibfC3gT+no=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb53125.7fae59a88298-smtp-out-n05;
 Fri, 08 May 2020 10:15:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1243CC433BA; Fri,  8 May 2020 10:15:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61DEEC433D2;
        Fri,  8 May 2020 10:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61DEEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.7] iwlwifi: pcie: handle QuZ configs with killer NICs
 as
 well
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20200424121518.b715acfbe211.I273a098064a22577e4fca767910fd9cf0013f5cb@changeid>
References: <iwlwifi.20200424121518.b715acfbe211.I273a098064a22577e4fca767910fd9cf0013f5cb@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200508101501.1243CC433BA@smtp.codeaurora.org>
Date:   Fri,  8 May 2020 10:15:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The killer devices were left out of the checks that convert Qu-B0 to
> QuZ configurations.  Add them.
> 
> Cc: stable@vger.kernel.org # v5.3+
> Fixes: 5a8c31aa6357 ("iwlwifi: pcie: fix recognition of QuZ devices")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Tested-by: You-Sheng Yang <vicamo@gmail.com>

Patch applied to wireless-drivers.git, thanks.

f92f26f2ed2c iwlwifi: pcie: handle QuZ configs with killer NICs as well

-- 
https://patchwork.kernel.org/patch/11507349/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

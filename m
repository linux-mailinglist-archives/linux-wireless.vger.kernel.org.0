Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3E125103
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRSwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:52:35 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:11172 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbfLRSwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:52:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695154; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qqLoe3S+idtCl7QDSrixxsCMJrzF58nYFDZhEJl1XxY=;
 b=p3PNNLIstjWO1K6+s+cJFYJmrQmfj0aJGpBG7PBL/4QVqLTHrmN7doJofIBseBV3uT8PVeNl
 6W75O8QwcCZI1xSHkvXXAcqHv2OdFE8wJ3xmKfqEZ93fMrI/SyswdlpVRTK6v10sh9bY6nRa
 Ef2cen2aTVKmjPZjCpkn/0Zgfb8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa756e.7f705bf48420-smtp-out-n02;
 Wed, 18 Dec 2019 18:52:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63104C4479C; Wed, 18 Dec 2019 18:52:30 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F9D6C433CB;
        Wed, 18 Dec 2019 18:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F9D6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] libertas: Fix two buffer overflows at parsing bss
 descriptor
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191128105104.52920-1-huangwenabc@gmail.com>
References: <20191128105104.52920-1-huangwenabc@gmail.com>
To:     huangwenabc@gmail.com
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218185230.63104C4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:52:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

huangwenabc@gmail.com wrote:

> From: Wen Huang <huangwenabc@gmail.com>
> 
> add_ie_rates() copys rates without checking the length 
> in bss descriptor from remote AP.when victim connects to 
> remote attacker, this may trigger buffer overflow.
> lbs_ibss_join_existing() copys rates without checking the length 
> in bss descriptor from remote IBSS node.when victim connects to 
> remote attacker, this may trigger buffer overflow.
> Fix them by putting the length check before performing copy.
> 
> This fix addresses CVE-2019-14896 and CVE-2019-14897.
> This also fix build warning of mixed declarations and code.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Wen Huang <huangwenabc@gmail.com>

Patch applied to wireless-drivers.git, thanks.

e5e884b42639 libertas: Fix two buffer overflows at parsing bss descriptor

-- 
https://patchwork.kernel.org/patch/11265751/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

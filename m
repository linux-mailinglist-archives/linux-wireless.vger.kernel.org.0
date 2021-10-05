Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6346E421DFA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhJEFec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 01:34:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47812 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEFec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 01:34:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633411962; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oeik4SHJ7/zT6Y6tH9SdWj4ivrSScffini1rxo27Ae8=;
 b=uc5rf3Ogd0tGcbd4sY1Vx8nbPafJG/45OGtHJxSbN2Cz1FnN+1LQZFvTcDu57S6K736rR4yc
 Fqc/Mw6wQlowfsHSzRD2K7e21wTqcqjd6bdXT3SnqUFYYEeRRrf4JSCE1qZEojgDS3Mp9Bhd
 Rc7MYcZJXR7GkFGMekANAxfTwHk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 615be377519bd8dcf0212176 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 05:32:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E8DEC4338F; Tue,  5 Oct 2021 05:32:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 446F7C4338F;
        Tue,  5 Oct 2021 05:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 446F7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: drop unneeded initialization value
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210930194920.15847-1-sohaib.amhmd@gmail.com>
References: <20210930194920.15847-1-sohaib.amhmd@gmail.com>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     unlisted-recipients:; (no To-header on input)
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)Sohaib Mohamed <sohaib.amhmd@gmail.com>
                                                                     ^-missing end of address
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20211005053239.3E8DEC4338F@smtp.codeaurora.org>
Date:   Tue,  5 Oct 2021 05:32:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sohaib Mohamed <sohaib.amhmd@gmail.com> wrote:

> Do not initialise statics to 0
> ERROR found by checkpatch.pl
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

5668958f6a92 bcma: drop unneeded initialization value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210930194920.15847-1-sohaib.amhmd@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


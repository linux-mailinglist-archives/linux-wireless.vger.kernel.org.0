Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4332D0E30
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 11:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLGKlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 05:41:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:25929 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgLGKlN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 05:41:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607337650; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=SJSbCik9Tek06j7dEaYsZTY3s+Lwk19Ci7mR6nO9gjk=; b=uVd47ICIHKN+S21UE6wNBI0XEOtq2mU2/tTG/jF28CuGG+6ViUbEr9oeNku2DjKPAR0VEWBB
 CJNNoD4XF3AI8fZWBR/iavpSlbfIf6xk4XO2j7/aMMla0ZOahyDr+Rd9cjm5sq/iqsx1IanW
 qawbR6laH7dCgGjf0D5xZAN8D0g=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fce0692ae7b105766e29497 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 10:40:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24AF6C433C6; Mon,  7 Dec 2020 10:40:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B24E1C433CA;
        Mon,  7 Dec 2020 10:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B24E1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-drivers-next-2020-12-03
References: <20201203185732.9CFA5C433ED@smtp.codeaurora.org>
        <20201204111715.04d5b198@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Date:   Mon, 07 Dec 2020 12:40:14 +0200
In-Reply-To: <20201204111715.04d5b198@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
        (Jakub Kicinski's message of "Fri, 4 Dec 2020 11:17:15 -0800")
Message-ID: <87tusxgar5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu,  3 Dec 2020 18:57:32 +0000 (UTC) Kalle Valo wrote:
>> wireless-drivers-next patches for v5.11
>> 
>> First set of patches for v5.11. rtw88 getting improvements to work
>> better with Bluetooth and other driver also getting some new features.
>> mhi-ath11k-immutable branch was pulled from mhi tree to avoid
>> conflicts with mhi tree.
>
> Pulled, but there are a lot of fixes in here which look like they
> should have been part of the other PR, if you ask me.

Yeah, I'm actually on purpose keeping the bar high for patches going to
wireless-drivers (ie. the fixes going to -rc releases). This is just to
keep things simple for me and avoiding the number of conflicts between
the trees.

> There's also a patch which looks like it renames a module parameter.
> Module parameters are considered uAPI.

Ah, I have been actually wondering that if they are part of user space
API or not, good to know that they are. I'll keep an eye of this in the
future so that we are not breaking the uAPI with module parameter
changes.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

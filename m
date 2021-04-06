Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71E3550D4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbhDFK2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 06:28:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:46142 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbhDFK2h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 06:28:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617704910; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=K6EhGe1V+iV/Jx8e5vtPsFsEFj1CoOb4lphM0O1+pQg=;
 b=K7VdotVqDKbWbIsdR4qE7tUN1g86jPb+o+E9VKH4Jq/LJeiAyvF04M/ioiPscyIBJ71A9MMz
 upwIbd3utSHCyYi5kJ99AP+52xzb6S7VfQ4xee2/7NlnEB4iEd4/T6Tu1U+OqEJOOMvrI6fS
 KvIGnYmz5sd0TtK648S8hIRimus=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 606c37a2f34440a9d4c8a6a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 10:27:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E8E4DC43461; Tue,  6 Apr 2021 10:27:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0BBBC433C6;
        Tue,  6 Apr 2021 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0BBBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 for v5.12 1/7] iwlwifi: fix 11ax disabled bit in the
 regulatory capability flags
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20210326125611.6d28516b59cd.Id0248d5e4662695254f49ce37b0268834ed52918@changeid>
References: <iwlwifi.20210326125611.6d28516b59cd.Id0248d5e4662695254f49ce37b0268834ed52918@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210406102745.E8E4DC43461@smtp.codeaurora.org>
Date:   Tue,  6 Apr 2021 10:27:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> When version 2 of the regulatory capability flags API was implemented,
> the flag to disable 11ax was defined as bit 13, but this was later
> changed and the bit remained as bit 10, like in version 1.  This was
> never changed in the driver, so we were checking for the wrong bit in
> newer devices.  Fix it.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Fixes: e27c506a985c ("iwlwifi: regulatory: regulatory capabilities api change")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

7 patches applied to wireless-drivers.git, thanks.

07cc40fec9a8 iwlwifi: fix 11ax disabled bit in the regulatory capability flags
25628bc08d45 iwlwifi: pcie: properly set LTR workarounds on 22000 devices
97195d3cad85 iwlwifi: add support for Qu with AX201 device
9c04fd95fa83 iwlwifi: fw: fix notification wait locking
08f4b0b1c07b iwlwifi: pcie: add support for So-F devices
39fb06f79142 iwlwifi: mvm: rfi: don't lock mvm->mutex when sending config command
65db391dd874 iwlwifi: mvm: fix beacon protection checks

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20210326125611.6d28516b59cd.Id0248d5e4662695254f49ce37b0268834ed52918@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


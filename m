Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0A3550A9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbhDFKRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 06:17:35 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24585 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbhDFKRe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 06:17:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617704247; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/78AVRM4b7OSKvTf03z7HAJfWU0Qy6FbRlrGsgHAe8A=;
 b=v1fis361ZJJlj9/uhp4GJzMWukReYNuoqVaIZmft+XSfF0SlkJNlne1fPQ/qz8slLLI+IcdQ
 tcM1Zv6qyfJfM7MC2wFCoK1JzfUmOxcFtSJSNbtBF478C8Gn+1aDdqjLtzEMqbg2kvQ6v9Oq
 hUYD28y+8lLhOBKcIRyASugKBJU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 606c3521f34440a9d4c32fc5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 10:17:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28C72C43461; Tue,  6 Apr 2021 10:17:05 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27DD2C433CA;
        Tue,  6 Apr 2021 10:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27DD2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.12 regression fix resend 1/1] brcmfmac: p2p: Fix
 recently
 introduced deadlock issue
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210405205429.19304-2-hdegoede@redhat.com>
References: <20210405205429.19304-2-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210406101705.28C72C43461@smtp.codeaurora.org>
Date:   Tue,  6 Apr 2021 10:17:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> Commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
> driver") replaced the rtnl_lock parameter passed to various brcmf
> functions with just lock, because since that commit it is not just
> about the rtnl_lock but also about the wiphy_lock .
> 
> During this search/replace the "if (!rtnl_locked)" check in brcmfmac/p2p.c
> was accidentally replaced with "if (locked)", dropping the inversion of
> the check. This causes the code to now call rtnl_lock() while already
> holding the lock, causing a deadlock.
> 
> Add back the "!" to the if-condition to fix this.
> 
> Cc: Johannes Berg <johannes.berg@intel.com>
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This is already applied:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=bd83a2fc05ed323d7ae38443a6d2e253ef1c4237

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210405205429.19304-2-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


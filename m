Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84174183687
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCLQss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:48:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37651 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgCLQss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:48:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584031728; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Ap9E5bMKSocM3DjPyxyV6uLyg/WngWDZ+aLgRloHeBc=;
 b=gFFmW9+1I1ES7yje+Z0LgwRM3buPEj785LZL6aBFqRaM5HhDKlay9TD9c2P54zSmG2cTUMKq
 pNEqSVoyyRLle9EcguwZ8ws3ot5vDfLd5qFclmc/k0jRmC+0hrNxsiu8PM/Usm9QKMh8JIvO
 iV2JQJ5+INPpZqDV+IUvCpb4m8A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a67e2.7f6723d34420-smtp-out-n02;
 Thu, 12 Mar 2020 16:48:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CE44C43637; Thu, 12 Mar 2020 16:48:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2A8BC433D2;
        Thu, 12 Mar 2020 16:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2A8BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wlcore: remove stray plus sign
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200312090405.5b1ee546a14b.I0a6a1a4c07a68ed1a435edb9553694bdb844e3a8@changeid>
References: <20200312090405.5b1ee546a14b.I0a6a1a4c07a68ed1a435edb9553694bdb844e3a8@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Maital Hahn <maitalm@ti.com>,
        Hari Nagalla <hnagalla@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312164834.6CE44C43637@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 16:48:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The commit mentioned below added a stray plus sign, likely
> due to some conflict resolution (i.e. as a leftover from a
> unified diff), which was harmless since it was just used as
> an integer constant modifier. Remove it anyway, now that I
> stumbled across it.
> 
> Fixes: cf33a7728bf2 ("wlcore: mesh: Add support for RX Broadcast Key")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-drivers.git, thanks.

e2e57291097b wlcore: remove stray plus sign

-- 
https://patchwork.kernel.org/patch/11433415/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6EF1831DD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCLNob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:44:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19027 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCLNob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:44:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020671; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1zvbSSJV5/G4gIkEFljTt/POzjrGG0CVdWz5AD80Z4U=;
 b=ZK8GLqJzdoO8uYkraXPzpf98LDUmYemXNFhwWxioXiIvi+RvwCWgrRblu6cDfkWtTjt3/che
 q+UKp3DsC52ODLwXsBQGE/kTI468ZTQgg/m1/QFNNJF8qccdmEo7C02aFYtK6r8V8zwD7YeK
 p/OEKemhs09sfNjDSWJUd4vBbcY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3cbe.7faaf13bb298-smtp-out-n02;
 Thu, 12 Mar 2020 13:44:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6B7BC433D2; Thu, 12 Mar 2020 13:44:29 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99F21C433CB;
        Thu, 12 Mar 2020 13:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99F21C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: Use scnprintf() for avoiding potential buffer
 overflow
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200311091739.22635-1-tiwai@suse.de>
References: <20200311091739.22635-1-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312134429.A6B7BC433D2@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:44:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:

> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Patch applied to wireless-drivers-next.git, thanks.

ca44e47a2b86 ssb: Use scnprintf() for avoiding potential buffer overflow

-- 
https://patchwork.kernel.org/patch/11431209/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

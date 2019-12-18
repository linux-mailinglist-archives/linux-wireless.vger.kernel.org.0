Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C281251AD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 20:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLRTRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 14:17:21 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:59086 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbfLRTRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 14:17:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576696640; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=0aEP2Sp3eZIk92bi5/Z9oakJLITSM32pzxma96nkWu4=;
 b=UXXxahC9a85ltYj38Rh26cr979UntrWLVisfgp9iiV4mxHFGUrnMPeiAOOsXFL7Kx7VBoc6w
 0Jgjw/JOjv5wi6Sq/xhtjr5QmhsIR9Byl0+D+iKcsBbcVzW1iU1RRt0PYHxphNBGWFSOoX1P
 /u7qMSRZrTHtLklmGQZ0IW3UhOI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa7b3c.7fb727ead7a0-smtp-out-n02;
 Wed, 18 Dec 2019 19:17:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A7D6C43383; Wed, 18 Dec 2019 19:17:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 945B7C43383;
        Wed, 18 Dec 2019 19:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 945B7C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: change Gruszka's email address
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191209091305.5998-1-sgruszka@redhat.com>
References: <20191209091305.5998-1-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218191715.6A7D6C43383@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 19:17:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> My RedHat email address will soon stop work. Change to my private one.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Failed to apply to wireless-drivers, please rebase.

Recorded preimage for 'MAINTAINERS'
error: Failed to merge in the changes.
Applying: MAINTAINERS: change Gruszka's email address
Using index info to reconstruct a base tree...
M	MAINTAINERS
Falling back to patching base and 3-way merge...
Auto-merging MAINTAINERS
CONFLICT (content): Merge conflict in MAINTAINERS
Patch failed at 0001 MAINTAINERS: change Gruszka's email address
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11278661/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

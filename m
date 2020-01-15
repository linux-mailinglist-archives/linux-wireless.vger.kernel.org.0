Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C813BC47
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 10:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgAOJTI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 04:19:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29782 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729377AbgAOJTI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 04:19:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579079948; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2o0fFlApbWK5OFnQjFIIAF4ECTyKAd32LPLprQ0QcMA=;
 b=P0ncW4Du/x3zlWqWxjnDsQxNU6KrRJ1lpX64Md4HGHWBFOBRrp/iKfT/3zrAMxSMWhvoeLz1
 VuFaUhhKrdsBFOW5lZweywhw3U2ZmeklMv053iGwhg5Bnmth/KE2ulk/rIa5I4/rHL45VPa4
 yLy+ZW/QnBlGUf31+boEUU+J5BQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1ed908.7fb92ec15688-smtp-out-n02;
 Wed, 15 Jan 2020 09:19:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EC3FC4479C; Wed, 15 Jan 2020 09:19:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47829C43383;
        Wed, 15 Jan 2020 09:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47829C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix up some error paths
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213105448.b7lic5ddih6c3sqy@kili.mountain>
References: <20191213105448.b7lic5ddih6c3sqy@kili.mountain>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Crispin <john@phrozen.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200115091903.7EC3FC4479C@smtp.codeaurora.org>
Date:   Wed, 15 Jan 2020 09:19:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> There are two error paths where "ret" wasn't set.  Ideally the compiler
> would have warned about these bugs, but we initialized "ret" to zero so
> it silenced the warning.  I have removed that.  Also if
> ath11k_hal_srng_get_entrysize() fails then we need to free some
> resources before returning.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Failed to apply:

error: patch failed: drivers/net/wireless/ath/ath11k/dp_tx.c:646
error: drivers/net/wireless/ath/ath11k/dp_tx.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11290443/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

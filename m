Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1136D1A95C2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635528AbgDOIGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:06:39 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30935 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635453AbgDOIEp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:04:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586937884; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=tKPUKvoHl3cQZvzd/QIwPOdZJPMNsAMUU3WubV/MYgQ=;
 b=DcKuqXogs0MhST0dqoT159foUydLKwi1Msj/9FubNrcMo3ULWWaV6mJL06N48ZTMIPNMPUT7
 B1ZBznLvxNHnctuMxkLT2SzVMdIvoe4jmi8gQUhAF0dD+69QMuPvkEgxNgdyRipeKeJR+xB1
 uQupGeNhqlKNCBY+WxUmJIfK+BE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96c01c.7f2c6d8ec928-smtp-out-n01;
 Wed, 15 Apr 2020 08:04:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1B45C43636; Wed, 15 Apr 2020 08:04:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42E05C44792;
        Wed, 15 Apr 2020 08:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42E05C44792
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: cleanup reo command error code overwritten
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586776872-25766-1-git-send-email-gsamin@codeaurora.org>
References: <1586776872-25766-1-git-send-email-gsamin@codeaurora.org>
To:     Govindaraj Saminathan <gsamin@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415080443.A1B45C43636@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:04:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govindaraj Saminathan <gsamin@codeaurora.org> wrote:

> should not overwrite the error code. No buffer available then return
> invalid. For other failures return the error code of actual failure.
> 
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e190bc05b191 ath11k: cleanup reo command error code overwritten

-- 
https://patchwork.kernel.org/patch/11485447/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

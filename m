Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE4182B18
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCLIWK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:22:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63909 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgCLIWJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:22:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584001329; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=E2G4Qml6OjdHGKMn6Uh+cBEOG0pksFOETHSpomcONkQ=;
 b=MAf/61VZ/LDIrmFESGshC7GZ6w/fIfCwFaN6obXLJN9/JwIaAoLY1k79TjNdO444qM2u9AIF
 PKDqLzVUrTtDQnsbviL3DoEQpyeOprV7ocT5mb4LQDl6BjkkawHceAKJzlgHjM7e9/P5Ncnq
 fivo348M42i2F8E8qw2BG3k0DY0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e69f131.7f76a3a23068-smtp-out-n04;
 Thu, 12 Mar 2020 08:22:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 293AEC433D2; Thu, 12 Mar 2020 08:22:08 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EA73C433CB;
        Thu, 12 Mar 2020 08:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EA73C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] ath11k: Use scnprintf() for avoiding potential buffer
 overflow
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200311084713.18220-2-tiwai@suse.de>
References: <20200311084713.18220-2-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312082208.293AEC433D2@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 08:22:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:

> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Cc: ath11k@lists.infradead.org
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

bc8f237823bc ath11k: Use scnprintf() for avoiding potential buffer overflow
dfb252c7b680 ath5k: Use scnprintf() for avoiding potential buffer overflow

-- 
https://patchwork.kernel.org/patch/11431143/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1471C683D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEFGPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 02:15:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52645 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgEFGPI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 02:15:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588745707; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=K5CgiaXyZ1JLVVLOzoY1KwEfcahG7NiVoZwLWjULHco=;
 b=LXB680uEp3iWKoMIGwiDKm5jXdIYjV8MyQGhn9/ixfgHX8DdmeDXIzD9oLnQ43kAuBz3x2ns
 t9jBnLEOj6yzedYCseJ36IYnMdJRx9jlP2IHN4agdhQioxiHqu1fb8xJT8goUGYF99DRuQJu
 uI6t7CEAQoPU9eUzf9MfvSTjR6g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb255e4.7fe5ffb6c8b8-smtp-out-n05;
 Wed, 06 May 2020 06:15:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 010F2C432C2; Wed,  6 May 2020 06:15:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFC00C433CB;
        Wed,  6 May 2020 06:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFC00C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] carl9170: remove P2P_GO support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200425092811.9494-1-chunkeey@gmail.com>
References: <20200425092811.9494-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, fschaefer.oss@googlemail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506061500.010F2C432C2@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 06:15:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch follows up on a bug-report by Frank Schäfer that
> discovered P2P GO wasn't working with wpa_supplicant.
> This patch removes part of the broken P2P GO support but
> keeps the vif switchover code in place.
> 
> Cc: <stable@vger.kernel.org>
> Link: <https://lkml.kernel.org/r/3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
> Reported-by: Frank Schäfer <fschaefer.oss@googlemail.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b14fba7ebd04 carl9170: remove P2P_GO support

-- 
https://patchwork.kernel.org/patch/11509803/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

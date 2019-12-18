Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03A124F8F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 18:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLRRkl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 12:40:41 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34296 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727031AbfLRRkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 12:40:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576690840; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=tQcJY9ItuwSoDSlZnw3JeOq9Hp3Za/HwGnSnm5q0L1U=;
 b=uoizi0INV7avXlgMpwDapityFSNkQlL0wp/iduhAMd07sxrxnAZ/LOv2Oo4myuip1XOQ2CNU
 Njp567bwgqfJ3bXc1nAKJ8oHqGkVEEAMG1ig+H+ADHOhnTyqAGnNQyRzei3EQM0+eeWaAm0F
 mKBwO0rMmYrdwmYCdXJpUADTBlo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6495.7fb98880d180-smtp-out-n02;
 Wed, 18 Dec 2019 17:40:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D6C9C4479C; Wed, 18 Dec 2019 17:40:37 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11233C433CB;
        Wed, 18 Dec 2019 17:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11233C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 7/9] ath11k: move some tx_status parsing to debugfs code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153839.12372-8-john@phrozen.org>
References: <20191213153839.12372-8-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218174037.8D6C9C4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:40:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> Some of the fields are only used by debugfs. Move the parsing of these
> from the data hot path to the debugfs code.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

8cfa7ef8127b ath11k: move some tx_status parsing to debugfs code
d0998eb84ed3 ath11k: optimise ath11k_dp_tx_completion_handler
2ad578fdb7b5 ath11k: optimize ath11k_hal_tx_status_parse

-- 
https://patchwork.kernel.org/patch/11290753/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

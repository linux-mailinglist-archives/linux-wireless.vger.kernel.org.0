Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A28189B40
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 12:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRLwA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 07:52:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:36286 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgCRLwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 07:52:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584532319; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=m4Z3PP38ejK3kjpwlDQdtjt7aI6OIWdFM55itztVZ4Y=;
 b=xMdv2JJlt2WKBrEbIJKMeYqpSuwmrsmVzOTVmeWzzUTRXn3jytmnty1Uq9oc2i5oSVMHWDBE
 u35eFkCPUsphDakp1aFRxmuNzTgG0JektRYCpeRNhes+Qe4k94T/HNMqtlFX/EEM1ofbihKW
 fApg/Pl1goICq0LYXMfZN814qE8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e720b5e.7f859f7d47d8-smtp-out-n02;
 Wed, 18 Mar 2020 11:51:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73041C432C2; Wed, 18 Mar 2020 11:51:58 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D821FC43637;
        Wed, 18 Mar 2020 11:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D821FC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: dump SRNG stats during FW assert
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584437534-7521-1-git-send-email-mpubbise@codeaurora.org>
References: <1584437534-7521-1-git-send-email-mpubbise@codeaurora.org>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200318115158.73041C432C2@smtp.codeaurora.org>
Date:   Wed, 18 Mar 2020 11:51:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <mpubbise@codeaurora.org> wrote:

> Dumping the SRNG stats during FW assert, this would help
> in debugging ring stuck issues.
> 
> Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5118935b1bc2 ath11k: dump SRNG stats during FW assert

-- 
https://patchwork.kernel.org/patch/11442081/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

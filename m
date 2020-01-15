Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4A13BC65
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgAOJZH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 04:25:07 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:56790 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729143AbgAOJZH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 04:25:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579080307; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SukfpqQRllYa8S/OCtnzI5fuA8khm+ubReqXcRkQWV4=;
 b=BHjxpwIzrTghB/Xj/ftN/mIZEILvxQEaLQzHfpLd7tKUxL35VQBEH6f9v5lbbhpndCzjgItL
 ltc1DCWYCXGGyrk9M8PWrPXO38fh67YiLN7Sltzy5zLG6tWY/Ai9lkahGVGiyhcYHKOnCsqx
 DI1U3Eza4V70sAOTNTLuruqq/TA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1eda6e.7f0c87e17d18-smtp-out-n01;
 Wed, 15 Jan 2020 09:25:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5809EC447A1; Wed, 15 Jan 2020 09:25:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B4C4C433CB;
        Wed, 15 Jan 2020 09:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B4C4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: mask out vht beamforming if a fixed rate is set
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217171827.6780-1-john@phrozen.org>
References: <20191217171827.6780-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200115092502.5809EC447A1@smtp.codeaurora.org>
Date:   Wed, 15 Jan 2020 09:25:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> From: Ritesh Singh <ritesi@codeaurora.org>
> 
> After setting a fixed vht-rate we see a FW assert if a STA tries to
> (re)assoc with the mu_bfee cap set. This patch masks out the capability
> bits if a fixed rate is set.
> 
> Reviewed-by: John Crispin <john@phrozen.org>
> Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>

John's s-o-b missing. Also no magic numbers, please. Isn't there a proper
define for 0x3?

-- 
https://patchwork.kernel.org/patch/11298287/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

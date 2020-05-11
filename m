Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0A1CD9CD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgEKM2Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:28:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49335 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728084AbgEKM2Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:28:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589200103; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hLaLy1KiAjg43QH7az5vP1E207Sae9WoWzCr2QN8hYw=;
 b=tKc3qHBq8LR163Ka4LR9gLPRf8l5x0NMsdgJCmQaBy+ZI15Xhwlq2xWXImPnWbx+hs2VAS8w
 Uc6mX747pedEt7pSIWxlSsmx/Rl//UBrhh1K2Lsf8WpeQzd2ZPjFJVNpKtxBcrEkKDveryMx
 +Fs/LvllWQ4CCORkRyWEBkGXK7w=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb944ca.7f1e2974b180-smtp-out-n04;
 Mon, 11 May 2020 12:27:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A00E6C432C2; Mon, 11 May 2020 12:27:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3201C433CB;
        Mon, 11 May 2020 12:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3201C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove stale monitor status descriptor
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588642063-6950-1-git-send-email-rmanohar@codeaurora.org>
References: <1588642063-6950-1-git-send-email-rmanohar@codeaurora.org>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miles Hu <milehu@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200511122754.A00E6C432C2@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 12:27:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rajkumar Manoharan <rmanohar@codeaurora.org> wrote:

> The driver is not handling monitor status descriptor whenever
> the done bit of status descriptor is not set by hardware. This leave
> a stale entry in monitor status ring and flooding warning message.
> Fix that by removing the descriptor and move forward to next one
> in monitor status ring.
> 
> Co-developed-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

32a2be499c01 ath11k: remove stale monitor status descriptor

-- 
https://patchwork.kernel.org/patch/11527999/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

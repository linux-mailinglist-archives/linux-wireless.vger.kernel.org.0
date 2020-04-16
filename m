Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B51AC577
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408948AbgDPOTu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 10:19:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:25401 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407374AbgDPOTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 10:19:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587046786; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Y/lvftTAinlizZpdL/m+YjsZfXIvM/SvcTj+ykDUaTc=;
 b=mR2WdSFvGUSKao0JhzOVIe5bBrj8pn+RTkWvZj1pszrMKt52MVBvDSghOJqaiiG2YGyU71ZB
 bm5sikNBsPV+jfhrLiskvZgonlT905Mou9ehNpdJGM/AwJxEm9Biff//6sdtvTDaLnuZsh26
 0YTiqyQYwhpgXnkuO0uAnU05A0Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e98696a.7fc5c5cf4f80-smtp-out-n05;
 Thu, 16 Apr 2020 14:19:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A56EC44791; Thu, 16 Apr 2020 14:19:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69F75C433F2;
        Thu, 16 Apr 2020 14:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69F75C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: set power trim according to efuse PG values
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200416031407.5899-1-yhchuang@realtek.com>
References: <20200416031407.5899-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200416141922.0A56EC44791@smtp.codeaurora.org>
Date:   Thu, 16 Apr 2020 14:19:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> 8822C devices have power trim, thermal and PA bias values
> programmed in efuse. Driver should configure the RF components
> according to the values.
> 
> If the power trim is not configured, then the devices might have
> distortion on the output tx power.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

You didn't use read_poll_timeout() like Chris suggested?

-- 
https://patchwork.kernel.org/patch/11492217/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

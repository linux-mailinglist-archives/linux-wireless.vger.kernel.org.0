Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA01C6BE1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgEFIfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 04:35:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46935 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728524AbgEFIfp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 04:35:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588754145; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pbzG9Kz6eaBiSU4vMurLm7yRFlz1BHejW9uZ/87zo9s=;
 b=KT4IFCqO/C7xCf6skVUcogKRVKdUoW6tM7g13iPGqhuw99bachG/LNDmpQE7qTMzTq4mN6sg
 IMnnJHVV3I68oFc8m6uhRS0QsieN5L3hi8sEqTgqWlvOj8kgNj+muJcINUVGZKss3//yCpKl
 wyy0WPwXCHQWBN+cpwdg47x9sTw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb276e0.7f0d1f0cafb8-smtp-out-n03;
 Wed, 06 May 2020 08:35:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36F06C4478C; Wed,  6 May 2020 08:35:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 862FEC43636;
        Wed,  6 May 2020 08:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 862FEC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/8] rtw88: 8723d: Add DIG parameter
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200504105010.10780-2-yhchuang@realtek.com>
References: <20200504105010.10780-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506083543.36F06C4478C@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 08:35:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> To improve user experience in field, we need DIG to adjust RX initial gain
> depends on field situation. Since each chip has its own register address,
> this commit defines 8723d specific address.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

8 patches applied to wireless-drivers-next.git, thanks.

db39a9ddacad rtw88: 8723d: Add DIG parameter
158441a2bed4 rtw88: 8723d: Add query_rx_desc
5f028a9cf4b9 rtw88: 8723d: Add set_channel
614b1f874454 rtw88: handle C2H_CCX_TX_RPT to know if packet TX'ed successfully
3ac14439152d rtw88: 8723d: some chips don't support LDPC
439d4a978d48 rtw88: 8723d: Add chip_ops::false_alarm_statistics
fc637a860a82 rtw88: 8723d: Set IG register for CCK rate
1757940430ef rtw88: 8723d: add interface configurations table

-- 
https://patchwork.kernel.org/patch/11525449/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

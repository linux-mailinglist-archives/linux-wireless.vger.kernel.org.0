Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD01A8131
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407218AbgDNPEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 11:04:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:22454 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407184AbgDNPE2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 11:04:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876668; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HmWtBOhc5ul8DMonc70f3CKeVbSyX2fnAYsC76ntthg=;
 b=ghKbMsJkgT8aU+V5EIhT3CKBYY53SGePVGchbn6uAWxb+JFIuI6Wd8NBRItV5Nb+N9iZHbPk
 gjmHegJgQbdY6o19UKcDMlbS2/XXr3vFne4X3XzFtVzaLO27Cgc556obExDUZ6lX/ozvBM+F
 eLDJiqRieGveVuX5qwiekAQkcTI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d0e2.7f022a4c7a40-smtp-out-n03;
 Tue, 14 Apr 2020 15:04:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4440C44788; Tue, 14 Apr 2020 15:04:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEC7FC432C2;
        Tue, 14 Apr 2020 15:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEC7FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8723ae: fix spelling mistake "chang" ->
 "change"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585815557-20212-1-git-send-email-hqjagain@gmail.com>
References: <1585815557-20212-1-git-send-email-hqjagain@gmail.com>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     pkshih@realtek.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414150402.A4440C44788@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 15:04:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Qiujun Huang <hqjagain@gmail.com> wrote:

> There is a spelling mistake in a trace message. Fix it.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

a24993e54b9c rtlwifi: rtl8723ae: fix spelling mistake "chang" -> "change"

-- 
https://patchwork.kernel.org/patch/11470277/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

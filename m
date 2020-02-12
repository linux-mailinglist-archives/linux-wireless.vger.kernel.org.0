Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2655715AD1D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBLQTH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 11:19:07 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:33357 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgBLQTH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 11:19:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581524346; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fLI2ORpDXRSqU30fr94VObLWsikBkwUu737//cEHG6M=;
 b=dmTr6GYYsLChPxTm11jx5ccXHVn9rUgrTHVykgQJtAxTESLZ99YUy1ZBg6Q/c9/E3fHlxxiM
 UiD211R6RzUzmfD3uAQKEWqPKBOnXmr9rzIVU7/VECZ6bvJImxSOBkmqIIhVSgdCRkShBU99
 Cd+P4hoUPG5q1HecWkOoJDXBeSo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e442577.7f0b9800dc38-smtp-out-n02;
 Wed, 12 Feb 2020 16:19:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9705C447A0; Wed, 12 Feb 2020 16:19:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58487C43383;
        Wed, 12 Feb 2020 16:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58487C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] rtw88: remove unused parameter vif in
 rtw_lps_pg_info_get()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200205070858.15386-2-yhchuang@realtek.com>
References: <20200205070858.15386-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200212161902.E9705C447A0@smtp.codeaurora.org>
Date:   Wed, 12 Feb 2020 16:19:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> vif is not used, remove it
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

7 patches applied to wireless-drivers-next.git, thanks.

597fc0e6ad59 rtw88: remove unused parameter vif in rtw_lps_pg_info_get()
9e01c07069db rtw88: add rtw_read8_mask and rtw_read16_mask
2a4225551afb rtw88: pci: 8822c should set clock delay to zero
398b9bdab2c3 rtw88: move rtw_enter_ips() to the last when config
6eab0ba99bc2 rtw88: avoid holding mutex for cancel_delayed_work_sync()
55cc84421c30 rtw88: add ciphers to suppress error message
8299adec99b2 rtw88: 8822c: update power sequence to v16

-- 
https://patchwork.kernel.org/patch/11365825/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

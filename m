Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E31831C8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgCLNlE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:41:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47056 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbgCLNlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:41:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020464; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=OW811nEQHKGfc/7AlbAVoyMbjsDCL3uRBlX6m0NFH6U=;
 b=OiLKb6QxjevJ8TpyxgKSPJ+4VqjTcoZ33v0tOWjrV/adbA+1hpMtGEaFndsAo8qHBkZC2YOU
 zxHrxcDQxQhnWBYbUVuuhhd7Pa5dOsD3po3ojfvwZes+gedBRIQ81W0YxJ/dUGLr/+acOkLi
 CmsL8tMjnahy4ZRBGSF58AenGe4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3bef.7fa82de146f8-smtp-out-n02;
 Thu, 12 Mar 2020 13:41:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D99DFC433BA; Thu, 12 Mar 2020 13:41:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11D8DC433D2;
        Thu, 12 Mar 2020 13:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11D8DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] b43legacy: replace simple_strtol() with kstrtoint()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1582085759-17998-1-git-send-email-qiwuchen55@gmail.com>
References: <1582085759-17998-1-git-send-email-qiwuchen55@gmail.com>
To:     qiwuchen55@gmail.com
Cc:     Larry.Finger@lwfinger.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312134102.D99DFC433BA@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:41:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

qiwuchen55@gmail.com wrote:

> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> The simple_strtol() function is deprecated since it does not
> check for the range overflow. Use kstrtoint() instead.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Patch applied to wireless-drivers-next.git, thanks.

871b4b48cdbf b43legacy: replace simple_strtol() with kstrtoint()

-- 
https://patchwork.kernel.org/patch/11390321/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

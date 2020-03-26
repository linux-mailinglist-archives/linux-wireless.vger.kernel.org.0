Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06E8193C1A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgCZJnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:43:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31886 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbgCZJnp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:43:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585215824; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3IlGhUqNJijTIwuRbDcDxuXhaZ7kecPrANGlpvtz3o0=;
 b=jTV6mP/DE9IwvvpKUdp4qDmWUUIXHKUIN7kOwW+ekgGveUHgwZeL5UzCIFBZfA4ocqLvVx0k
 gSPPvb0PqF+tZsKIBhrBJnWtslzeMrLLoYMBo4ZYUwB8jt38q3BtrwbpG32JcAgWoEIs2Co9
 kOv9sv/OueWnYPYrzxTzwGShKwA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c7940.7f87b3843ab0-smtp-out-n03;
 Thu, 26 Mar 2020 09:43:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA68C433BA; Thu, 26 Mar 2020 09:43:27 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C250AC433D2;
        Thu, 26 Mar 2020 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C250AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] rtl8xxxu: add enumeration for channel bandwidth
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200320063833.1058-2-chiu@endlessm.com>
References: <20200320063833.1058-2-chiu@endlessm.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes.Sorensen@gmail.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200326094327.CDA68C433BA@smtp.codeaurora.org>
Date:   Thu, 26 Mar 2020 09:43:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chris Chiu <chiu@endlessm.com> wrote:

> There's a data field in H2C and C2H commands which is used to
> carry channel bandwidth information. Add enumeration to make it
> more descriptive in code.
> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>

2 patches applied to wireless-drivers-next.git, thanks.

a66b8b4108f1 rtl8xxxu: add enumeration for channel bandwidth
0985d3a410ac rtl8xxxu: Feed current txrate information for mac80211

-- 
https://patchwork.kernel.org/patch/11448459/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

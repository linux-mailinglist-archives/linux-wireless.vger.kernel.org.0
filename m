Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F9C3A7B8B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhFOKOU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:14:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55499 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhFOKOR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:14:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623751933; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HtF3PF2tjZafAWrKo+UP2bf/9Xr+8dpjl2fpn8A22zA=;
 b=X5kvuwaBm2H53wRKH5iKZi+BjaUxKGHXsNF0AlshIYmtUXqs1YAdKN9Vn4W330ga/Rvj1HVu
 Vf9UbfznEVRZEHaelIeK1Sc/8alkZMK1w/qNg5D3+9hcecHV5DdSERjkCXbwDmzlkH9laca3
 62jQwNiYVKfCEnhtOKh9sZv8D4g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60c87cfcf726fa4188d9a346 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:12:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6D01C43460; Tue, 15 Jun 2021 10:12:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B479C433F1;
        Tue, 15 Jun 2021 10:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B479C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/1] ssb: use DEVICE_ATTR_ADMIN_RW() helper macro
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210603082218.11718-2-thunder.leizhen@huawei.com>
References: <20210603082218.11718-2-thunder.leizhen@huawei.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Michael Buesch <m@bues.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615101211.A6D01C43460@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:12:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Use DEVICE_ATTR_ADMIN_RW() helper macro instead of DEVICE_ATTR(), making
> it simpler and easier to read.
> 
> Because the read and write function names of the sysfs attribute have been
> normalized, there is a natural association.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

573f1af86891 ssb: use DEVICE_ATTR_ADMIN_RW() helper macro

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210603082218.11718-2-thunder.leizhen@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


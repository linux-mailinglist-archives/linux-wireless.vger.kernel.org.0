Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962BB1B26E8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgDUM6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:58:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43539 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728337AbgDUM6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:58:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587473913; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jo0br9dg4CvETK0pU6lhBnpTh/mb+eL8ZbmzHSNlw2M=;
 b=YwkLH+Iv+LVGh1P5onoAwlu7Zj9QE6xBebim4lrPLpBtDm5jFx3FgCEBhaSkIWg/NPcQeYZ3
 /yXxMV657xhSi6LHgFPFFYulLZl1WqAvGW5xFSy/EX4yrkkxxr8tNgJtaptEDzY/KVokPoBo
 qg+OdZp8VNRUH/wP5LrRmgk2ago=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9eedf2.7f8673e960a0-smtp-out-n01;
 Tue, 21 Apr 2020 12:58:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9968C433BA; Tue, 21 Apr 2020 12:58:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37292C432C2;
        Tue, 21 Apr 2020 12:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37292C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] rtlwifi: rtl8188ee: use true,false for bool variables
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200418070236.9620-2-yanaijie@huawei.com>
References: <20200418070236.9620-2-yanaijie@huawei.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <pkshih@realtek.com>, <davem@davemloft.net>, <amade@asmblr.net>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200421125826.B9968C433BA@smtp.codeaurora.org>
Date:   Tue, 21 Apr 2020 12:58:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following coccicheck warning:
> 
> drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c:70:1-34: WARNING:
> Assignment of 0/1 to bool variable
> drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c:72:1-34: WARNING:
> Assignment of 0/1 to bool variable
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

5 patches applied to wireless-drivers-next.git, thanks.

bec095ab477d rtlwifi: rtl8188ee: use true,false for bool variables
23c2ddb574c6 rtlwifi: rtl8723ae: use true,false for bool variables
c13a83b01010 rtlwifi: rtl8192ee: use true,false for bool variables
47361089d987 rtlwifi: rtl8723be: use true,false for bool variables
e8277abd453d rtlwifi: rtl8821ae: use true,false for bool variables

-- 
https://patchwork.kernel.org/patch/11496299/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

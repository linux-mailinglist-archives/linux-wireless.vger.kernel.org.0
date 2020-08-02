Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6012357F0
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHBPLY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:11:24 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:57574 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgHBPLY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:11:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596381083; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=noJOmZBUfmKwC6NPBQWiGOMLzdSMwaShNzRtd8ZKtHY=;
 b=PmJpXNH5Rphpyy4X3P3pVpyPUIrfOoqsmYOINsFBhSDGqZ2drBT0n7bAMDSlaTSJCs7LEwqa
 oNvMWQNvdPvuHdqruZSUrhgWF8KqIQfv8pRfQmW7n5Bay/H73WyV+KZz1bgppm49CRBEzVhv
 lHpFV6jD9opXiqZmnj99s+wAD7Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f26d79a90893260dd08e31d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:11:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7E15C433C6; Sun,  2 Aug 2020 15:11:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C32E4C433C9;
        Sun,  2 Aug 2020 15:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C32E4C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200716085749.11105-1-miaoqinglang@huawei.com>
References: <20200716085749.11105-1-miaoqinglang@huawei.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kubakici@wp.pl>,
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802151121.B7E15C433C6@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:11:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Fails to apply to wireless-drivers-next:

fatal: sha1 information is lacking or useless (drivers/net/wireless/mediatek/mt7601u/debugfs.c).
error: could not build fake ancestor
Applying: mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
Patch failed at 0001 mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11666949/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


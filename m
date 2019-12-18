Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67BC12464E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRL6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:58:22 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:33792 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfLRL6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:58:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576670302; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fHKMOhKZxwO+qlRs+vikj3W/zJw5PVOU3nv4b2GIiuA=;
 b=vSHCH+TrYqquSbocQh+XSnCvCAt2TsnU+ag0BL/Yf5sGUTeuljyt+FsZViUlr2nskq+/YZwz
 k3tYJ0gVpul1AUTUYphUknKCnvANmq71bpi4l/PH7XEf05LVDyJ4/2z4WPLa40TPAohUvytJ
 swornvzLy0izGWeot+MuZde9Y78=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa145d.7f5ffc80ff10-smtp-out-n02;
 Wed, 18 Dec 2019 11:58:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0096C43383; Wed, 18 Dec 2019 11:58:20 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73DF7C433CB;
        Wed, 18 Dec 2019 11:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73DF7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2] ath11k: add OMI debug support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191205062812.6208-1-john@phrozen.org>
References: <20191205062812.6208-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218115820.F0096C43383@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 11:58:20 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> This patch allows us to initiate a OMI transaction for test purposes using
> a debugfs interface. the xmit_omi file expects 9 parameters. The first two
> are VHT and HE followed by the 7 A-Control fields from D4.0/9.2.4.6a.2.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This had new warnings, fixed in pending branch:

drivers/net/wireless/ath/ath11k/wmi.c:5718: line over 90 characters
drivers/net/wireless/ath/ath11k/wmi.c:5739: line over 90 characters

-- 
https://patchwork.kernel.org/patch/11274229/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

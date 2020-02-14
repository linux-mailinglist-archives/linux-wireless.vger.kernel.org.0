Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB3815D792
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgBNMnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 07:43:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:31003 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgBNMnQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 07:43:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581684195; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VG6QJ9drYg8xNGVpuD2yhPg0bLSunOdeGRciwUs26Jk=;
 b=fEUtSnNZwr2zOtzoRrCDKevqFpmLQc7lWpDRip3CnZ6vfC8mBw1aLBRtuTV8j7127akmwOgx
 AnzNd1z+lGBz+sapay6hKyt2frqFemyvCbphDcmOGVl572RlCetAfSli3EkeOPSTwwpCMXGj
 zewlDf3kCnjsNiqH4aMQzmKZMBY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4695e2.7fec51317960-smtp-out-n01;
 Fri, 14 Feb 2020 12:43:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1881DC4479C; Fri, 14 Feb 2020 12:43:14 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E3DFC43383;
        Fri, 14 Feb 2020 12:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E3DFC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mwifiex: change license text from MARVELL to NXP
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581524230-10212-1-git-send-email-ganapathi.bhat@nxp.com>
References: <1581524230-10212-1-git-send-email-ganapathi.bhat@nxp.com>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     linux-wireless@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        James Cao <zheng.cao@nxp.com>, Cathy Luo <xiaohua.luo@nxp.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200214124314.1881DC4479C@smtp.codeaurora.org>
Date:   Fri, 14 Feb 2020 12:43:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <ganapathi.bhat@nxp.com> wrote:

> As of 6-DEC-2019, NXP has acquired Marvell’s Wireless business
> unit. This change is to update the license text accordingly.
> 
> Signed-off-by: James Cao <zheng.cao@nxp.com>
> Signed-off-by: Cathy Luo <xiaohua.luo@nxp.com>
> Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>

Patch applied to wireless-drivers-next.git, thanks.

932183aa35c6 mwifiex: change license text from MARVELL to NXP

-- 
https://patchwork.kernel.org/patch/11378735/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

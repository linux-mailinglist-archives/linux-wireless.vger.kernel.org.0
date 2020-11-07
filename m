Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285052AA678
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgKGPyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:54:46 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:11825 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKGPyq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:54:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604764485; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oLW7VVVrXAavCrbrWhpU2bT+ilRC36U5DjuisCSbgHc=;
 b=Eo/BGT76Kusdl3qdCM5p+A9cHp9fix2p7ZbsLLJF3Eel3tszJ66WxZN3lPUdimPeLf6Tz3qv
 t1saprrMza8suOGNS37ou5n/JKWgtYngDYyieQzrY+1up5H/mXXPqCmEWjkeG6czIEL1ArMr
 qUouHL44ZiFDZL/xBTEVCracgcY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa6c31860d947565244eacd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:54:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B6BAC433C8; Sat,  7 Nov 2020 15:54:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F428C433C6;
        Sat,  7 Nov 2020 15:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F428C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] rt2x00: save survey for every channel visited
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201104142524.94375-1-stf_xl@wp.pl>
References: <20201104142524.94375-1-stf_xl@wp.pl>
To:     stf_xl@wp.pl
Cc:     linux-wireless@vger.kernel.org,
        Markov Mikhail <markov.mikhail@itmh.ru>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107155400.2B6BAC433C8@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 15:54:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

stf_xl@wp.pl wrote:

> From: Markov Mikhail <markov.mikhail@itmh.ru>
> 
> rt2800 only gives you survey for current channel.
> 
> Survey-based ACS algorithms are failing to perform their job when working
> with rt2800.
> 
> Make rt2800 save survey for every channel visited and be able to give away
> that information.
> 
> There is a bug registered https://dev.archive.openwrt.org/ticket/19081 and
> this patch solves the issue.
> 
> Signed-off-by: Markov Mikhail <markov.mikhail@itmh.ru>
> sgruszka: remove unused variable
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

5447626910f5 rt2x00: save survey for every channel visited

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201104142524.94375-1-stf_xl@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


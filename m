Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E251E19FA0E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgDFQYN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 12:24:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11917 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729005AbgDFQYN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 12:24:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586190253; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=K3ZH4zZZBAfUueC+WCVf/r6RJPEI+8w7E4Iy6KW4Zso=;
 b=WaagjZxunn3C9veXgGPGeGCxBn533NidQr53vcxKknLB86FOF1cvAtgAF6F0G8t+QtAPZ5/q
 Euh1mukqb9AD1OFtdXfotHJ1dYAedGLtukDxfRYRI1OplCSVvBKUY9vsYwf6pjtQYDsujtsU
 Mrn79uMaVpOkfSdOSAkE5bX31FM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b57ac.7f31c139e880-smtp-out-n05;
 Mon, 06 Apr 2020 16:24:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D25C8C433BA; Mon,  6 Apr 2020 16:24:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70A93C433F2;
        Mon,  6 Apr 2020 16:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70A93C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Avoid mgmt tx count underflow
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585567028-9242-1-git-send-email-srirrama@codeaurora.org>
References: <1585567028-9242-1-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406162411.D25C8C433BA@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 16:24:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> The mgmt tx count reference is incremented/decremented on every mgmt tx and on
> tx completion event from firmware.
> In case of an unexpected mgmt tx completion event from firmware,
> the counter would underflow. Avoid this by decrementing
> only when the tx count is greater than 0.
> 
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

800113ff4b1d ath11k: Avoid mgmt tx count underflow

-- 
https://patchwork.kernel.org/patch/11465279/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2291BB96B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgD1JCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 05:02:55 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60283 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgD1JCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 05:02:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588064574; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=nqGeqod3whf/TgPfQu7bjDYmD5fXb+oKraNuRwPqfsY=;
 b=Mx6v3JAV6BmZbjmOrPIp4GfUlDlY5HcN+zh/G9vHyyE8m5Qdw3uHuYshGfDHOUP4V0bFuorv
 Bks7WnGurI0Bn/YzTe4R+8AmLTTxC1pcisndZFUnHSAZ4iuoBs7xDoTnjO1YduTG6iadwLle
 H9eTidRFmQem1gkpDa/S6vYJZSE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7f134.7f852ae04848-smtp-out-n03;
 Tue, 28 Apr 2020 09:02:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DB34C433BA; Tue, 28 Apr 2020 09:02:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCE3DC433D2;
        Tue, 28 Apr 2020 09:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCE3DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: scan: fix block comments coding style issues
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200425155233.19624-1-john.oldman@polehill.co.uk>
References: <20200425155233.19624-1-john.oldman@polehill.co.uk>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200428090243.5DB34C433BA@smtp.codeaurora.org>
Date:   Tue, 28 Apr 2020 09:02:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Oldman <john.oldman@polehill.co.uk> wrote:

> Fixed coding style issues
> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>

Patch applied to wireless-drivers-next.git, thanks.

86501437d885 ssb: scan: fix block comments coding style issues

-- 
https://patchwork.kernel.org/patch/11509937/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

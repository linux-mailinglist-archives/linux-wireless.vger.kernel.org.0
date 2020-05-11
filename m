Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F631CD9E9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEKMcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:32:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63390 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728367AbgEKMcB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:32:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589200321; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mE+eflbY/lm0yBry5TNweEh0p1uT1xNPSHaBIh67Oq4=;
 b=iTxgBkLcop54INbUYpTHPEF5KplbkLL2c+zKOK0qL1ly5ZUjeS44WKC14+kVFD6IwDzxh6hr
 3OceyFNJ2LL5y2W6yUtASrwJlClMQ4r7Kbf9dhzhS8dZs80gVEBSyqxQuihF4vxeeN3v70Wk
 1BSDEHDQHk/5eZrRXJZUZQZlyA0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb945c0.7fb55ea43df8-smtp-out-n02;
 Mon, 11 May 2020 12:32:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF5D8C43636; Mon, 11 May 2020 12:31:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B0AAC44792;
        Mon, 11 May 2020 12:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B0AAC44792
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Skip handling del_server during driver exit
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588663061-12138-1-git-send-email-pillair@codeaurora.org>
References: <1588663061-12138-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200511123159.EF5D8C43636@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 12:31:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> The qmi infrastructure sends the client a del_server
> event when the client releases its qmi handle. This
> is not the msg indicating the actual qmi server exiting.
> In such cases the del_server msg should not be processed,
> since the wifi firmware does not reset its qmi state.
> 
> Hence skip the processing of del_server event when the
> driver is unloading.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7c6d67b136ce ath10k: Skip handling del_server during driver exit

-- 
https://patchwork.kernel.org/patch/11528317/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEF2F7C8B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 14:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbhAON0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 08:26:21 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:64588 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbhAON0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 08:26:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610717180; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=VfNv5JfVDe8cpm3HhLuTk+6726uEESWvIr0zCga7Mpk=; b=iE58i3n+mNAJsoD5t33WFwwYXx9csto44chcYHnVuhazJrgrN6Wz7XWMSzWHbqfHAhfDhoVm
 g5lRuUeXO63JtviydPAq3+i1e1GbJH8Kgf5IhUZ5cUbRMcRNOB/zCPyzKY5noqVlxFb/FXx4
 ZhvHs5EG+wpp3BBQ+o8lw0zvkvg=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 600197d3f94f20d8b73e6f91 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 13:25:39
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 719ABC433CA; Fri, 15 Jan 2021 13:25:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [103.149.159.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2699C433C6;
        Fri, 15 Jan 2021 13:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2699C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1593197633-9014-1-git-send-email-pillair@codeaurora.org> <87k0tbngz6.fsf@codeaurora.org>
In-Reply-To: <87k0tbngz6.fsf@codeaurora.org>
Subject: RE: [PATCH v2 0/2] ath10k: Fixes during subsystem recovery
Date:   Fri, 15 Jan 2021 18:55:33 +0530
Message-ID: <005901d6eb41$e9ce47a0$bd6ad6e0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHK1UA7L8ou4VjNidoeHu16b5pDlgHqoQMdqjGCxPA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Tuesday, December 22, 2020 12:07 AM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 0/2] ath10k: Fixes during subsystem recovery
> 
> Rakesh Pillai <pillair@codeaurora.org> writes:
> 
> > This patch series includes some fixes when the device
> > is in recovery mode, i.e. when the firmware goes down.
> >
> > - Pausing TX queues when FW goes down
> > - Removed unwanted/extra error logging in pkt TX path
> > - Skipping wait for FW response for delete cmds
> > - Handling the -ESHUTDOWN error code in case of SSR.
> >
> > Rakesh Pillai (2):
> >   ath10k: Pause the tx queues when firmware is down
> >   ath10k: Skip wait for delete response if firmware is down
> 
> This has been tested only on WCN3990. How do I know that this doesn't
> break other hardware families?

" ath10k: Pause the tx queues when firmware is down"
This is done only for SNOC (wcn3990) target and does not affect other
targets.

" ath10k: Skip wait for delete response if firmware is down"
The skip for wmi responses is done based on the flag
"ATH10K_FLAG_CRASH_FLUSH", which is generic for all targets.
Since if the FW is down, there wont be any response from the FW for any
target.

> 
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches


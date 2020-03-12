Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67C1831D2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCLNmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:42:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34557 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCLNmc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:42:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020552; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=brj+jEimEbgqUT3L9Fd4dgJ89y8xN4cQmfXxdzVnq20=;
 b=HGQ0BJ43E4Hn5GRXPAHIw4beShYnBUhCqhahtzC5cxOSHRsqsacROOAO2+KUMJABwYVcuVce
 NOFAH965xvYLxpvo3FSc3MyCTafKBlxGC6LsoQ1rsnYcqfUOuuwjOfWi/16Fw2Acjv/N9dmh
 DPMhZNKwpgJqroV/VXVQ7IrpFn0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3c32.7ff2f309fa40-smtp-out-n02;
 Thu, 12 Mar 2020 13:42:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1FC1DC433BA; Thu, 12 Mar 2020 13:42:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 435A7C433CB;
        Thu, 12 Mar 2020 13:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 435A7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: set needed_headroom, not hard_header_len
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200227000511.256055-1-briannorris@chromium.org>
References: <20200227000511.256055-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Arend Van Spriel <arend@broadcom.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312134210.1FC1DC433BA@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:42:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> hard_header_len provides limitations for things like AF_PACKET, such
> that we don't allow transmitting packets smaller than this.
> 
> needed_headroom provides a suggested minimum headroom for SKBs, so that
> we can trivally add our headers to the front.
> 
> The latter is the correct field to use in this case, while the former
> mostly just prevents sending small AF_PACKET frames.
> 
> In any case, mwifiex already does its own bounce buffering [1] if we
> don't have enough headroom, so hints (not hard limits) are all that are
> needed.
> 
> This is the essentially the same bug (and fix) that brcmfmac had, fixed
> in commit cb39288fd6bb ("brcmfmac: use ndev->needed_headroom to reserve
> additional header space").
> 
> [1] mwifiex_hard_start_xmit():
> 	if (skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN) {
> 	[...]
> 		/* Insufficient skb headroom - allocate a new skb */
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Ganapathi Bhat <ganapathi.gbhat@nxp.com>

Patch applied to wireless-drivers-next.git, thanks.

9454f7a895b8 mwifiex: set needed_headroom, not hard_header_len

-- 
https://patchwork.kernel.org/patch/11407493/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5112507B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLRSWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:22:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:32971 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbfLRSWI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:22:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576693328; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Ft0r9gFjIspzCYSzCwsv5fgMEUGGAawnep5akQbIAj4=;
 b=NmzVG1DIDQZEw5X9Skf0balFVKBqp8p3OMDUh8dkhnb9ib4ybnCpluwCtDkscMNSxJV9owgf
 vCIk7gQuixv5Jk2SkeLRbAxPcwPO/OOBQC+qFPe2rlfsvfRrlG0U37uqqItN+NJnwyJRc/l1
 cgU8UNTdaKNdMKLX3vKWhx85g34=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6e4c.7f6fc44fd030-smtp-out-n02;
 Wed, 18 Dec 2019 18:22:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49E65C447A0; Wed, 18 Dec 2019 18:22:03 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB8C4C433A2;
        Wed, 18 Dec 2019 18:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB8C4C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] rtlwifi: rtl8192de: Remove unused GET_XXX and
 SET_XXX macros
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191125183229.19063-2-Larry.Finger@lwfinger.net>
References: <20191125183229.19063-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218182203.49E65C447A0@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:22:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> As the first step in converting from macros that get/set information
> in the RX and TX descriptors, unused macros are being removed.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

4 patches applied to wireless-drivers-next.git, thanks.

b8e1ada81fb7 rtlwifi: rtl8192de: Remove unused GET_XXX and SET_XXX macros
08f6ef39bc3d rtlwifi: rtl8192de: Replace local bit manipulation macros
fa2b36a344f5 rtlwifi: rtl8192de: Convert macros that set descriptor
96c21a254053 rtlwifi: rtl8192de: Convert inline routines to little-endian words

-- 
https://patchwork.kernel.org/patch/11260753/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

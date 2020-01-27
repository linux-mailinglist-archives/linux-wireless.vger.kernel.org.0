Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570F314A637
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 15:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgA0Oe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 09:34:56 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:21255 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgA0Oe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 09:34:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580135695; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TBG/08Dd19MO7yisqXc6fgYsEFJDB6xSxWVF5Ds2H0o=;
 b=XHyEHJzMV9N6hsH+J2glX9oRQaZdDKU8X5CrhFOLFMWD5VjErTRbNk7bAwN3pK3KE0BfVUOw
 5tVJ22e0obkm8MmuLmLRcALn64RiGZNOq1XFeU52jNIxexBbF7MAcxadIVQecIPyxsjgcVjv
 z9Hk1OnSbG3/z8FYuLjVNv7/7oQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2ef50c.7f52239b3998-smtp-out-n01;
 Mon, 27 Jan 2020 14:34:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0CF8C4479C; Mon, 27 Jan 2020 14:34:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C109C433CB;
        Mon, 27 Jan 2020 14:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C109C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] mwifiex: Fix possible buffer overflows in
 mwifiex_ret_wmm_get_status()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200102023927.4687-2-m1s5p6688@gmail.com>
References: <20200102023927.4687-2-m1s5p6688@gmail.com>
To:     m1s5p6688@gmail.com
Cc:     linux-wireless@vger.kernel.org, amitkarwar@gmail.com,
        nishants@marvell.com, gbhat@marvell.com, huxinming820@gmail.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200127143452.B0CF8C4479C@smtp.codeaurora.org>
Date:   Mon, 27 Jan 2020 14:34:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

m1s5p6688@gmail.com wrote:

> From: Qing Xu <m1s5p6688@gmail.com>
> 
> mwifiex_ret_wmm_get_status() calls memcpy() without checking the 
> destination size.Since the source is given from remote AP which 
> contains illegal wmm elements , this may trigger a heap buffer 
> overflow.
> Fix it by putting the length check before calling memcpy().
> 
> Signed-off-by: Qing Xu <m1s5p6688@gmail.com>

2 patches applied to wireless-drivers.git, thanks.

3a9b153c5591 mwifiex: Fix possible buffer overflows in mwifiex_ret_wmm_get_status()
b70261a288ea mwifiex: Fix possible buffer overflows in mwifiex_cmd_append_vsie_tlv()

-- 
https://patchwork.kernel.org/patch/11315253/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

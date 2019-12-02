Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9B10E836
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 11:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLBKHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 05:07:35 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:33620
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfLBKHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 05:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575281254;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=cLeNu81ClBU0podQJ9rpP21GnCcW8uTo3of4/Ze/v9M=;
        b=Nb+qwwB6vY1sV5u6/mRQ2bIWayZ4gv7iYSlOooKQKP2tnP+oaYQqEnOv8A1RmXXP
        cIg51UVDyN5BSHsqZ0J6z8MsZur4ky63mNzNucf9cm6lLWFGDkJmih6WsxeK7XrO0tq
        R/7XNJajDHWTKul9HxD5elXLJwy0Bfv832BEE5PE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575281254;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=cLeNu81ClBU0podQJ9rpP21GnCcW8uTo3of4/Ze/v9M=;
        b=ahmJDP/X10w+CbR+xEGP0f3ukP5Slfzm2gPGmcQgIGKcZdHOgvc9lYPHeXEgdW77
        N+mNi5wJg9/H8omfc9AQ4VftF00YSf285Pqj1ieCIU4sV3xtVgO3HtkGr/r12Om/088
        bG7ndCQSTDBRxMeZpCPWLz2C59vhuzPcL+Fk3V28=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 592DBC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: change bundle count for max rx bundle for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ea72cd3fc-d998517d-4033-4659-b1f8-2b6dd2717682-000000@us-west-2.amazonses.com>
References: <0101016ea72cd3fc-d998517d-4033-4659-b1f8-2b6dd2717682-000000@us-west-2.amazonses.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ec6146132-ee6bbb99-3f0e-4a3f-8d41-94387378dc7c-000000@us-west-2.amazonses.com>
Date:   Mon, 2 Dec 2019 10:07:34 +0000
X-SES-Outgoing: 2019.12.02-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For max bundle size 32, the bundle mask is not same with 8/16.
> Change it to match the max bundle size of htc. Otherwise it
> will not match with firmware, for example, when bundle count
> is 17, then flags of ath10k_htc_hdr is 0x4, if without this
> patch, it will be considered as non-bundled packet because it
> does not have mask 0xF0, then trigger error message later:
> payload length 56747 exceeds max htc length: 4088.
> 
> htc->max_msgs_per_htc_bundle is the min value of
> HTC_HOST_MAX_MSG_PER_RX_BUNDLE and
> msg->ready_ext.max_msgs_per_htc_bundle of ath10k_htc_wait_target,
> it will be sent to firmware later in ath10k_htc_start, then
> firmware will use it as the final max rx bundle count, in
> WLAN.RMH.4.4.1-00029, msg->ready_ext.max_msgs_per_htc_bundle
> is 32, it is same with HTC_HOST_MAX_MSG_PER_RX_BUNDLE, so the
> final max rx bundle count will be set to 32 in firmware.
> 
> This patch only effect sdio chips.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Fixes: 224776520ead69e ("ath10k: change max RX bundle size from 8 to 32 for sdio")
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4a9912451630 ath10k: change bundle count for max rx bundle for sdio

-- 
https://patchwork.kernel.org/patch/11261779/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


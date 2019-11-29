Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C515910D1F7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 08:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfK2Hoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 02:44:37 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:43162
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2Hoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 02:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575013476;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=p+y1rMEnDjbDzSRwv+hNOFPILx85VSeZxDrYtcqO7ag=;
        b=WkoQychTeTHcgTiXb4VAqcQ9R/kxI2Gb05FuuSgO/THHVfTMPmeUoplJ4ZyR80d5
        7zhNEvfd+BrSzs2KWsvmiVj5Ius3GK0fq7uI4wIXrC7ObMj1UBRtzg6lnXSAIOl4un7
        sSmw3A22+4qYrqrrrrJwFaQNfv9UR303QRuObzVE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575013476;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=p+y1rMEnDjbDzSRwv+hNOFPILx85VSeZxDrYtcqO7ag=;
        b=eOeK26cfRDlXpE7t2UgKrrbvExYK8figy0T/UBa2z1WgEtiQk9hN63yQsLcJCMNX
        Nq1ovC1TAEnZ17u4n2+aSdGU/rVIHkJLXsutrrCZ38yeytrNGiAuH1tYIdiU4gGQzED
        9P5tSIPA1iYOU4+F1xKK+QRbWBkVF9E8AXScPKHE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5234EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: change log level for mpdu status of sdio chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016eaaeb8dba-59b83dae-1133-48b3-8aab-a51f765322bf-000000@us-west-2.amazonses.com>
References: <0101016eaaeb8dba-59b83dae-1133-48b3-8aab-a51f765322bf-000000@us-west-2.amazonses.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb61e67ed-0234fea9-e7ab-4db3-ac80-d9e57d5c1b0e-000000@us-west-2.amazonses.com>
Date:   Fri, 29 Nov 2019 07:44:36 +0000
X-SES-Outgoing: 2019.11.29-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Change log level from warn to dbg level of mpdu status
> of sdio chip.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5d2467299a17 ath10k: change log level for mpdu status of sdio chip

-- 
https://patchwork.kernel.org/patch/11263361/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


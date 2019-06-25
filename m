Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7354F4D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfFYMt7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:49:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbfFYMt7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:49:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F3B1606DC; Tue, 25 Jun 2019 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561466998;
        bh=mr/xt+cVO5VfX8b/8gPbYA+kREY82BW9CmvRxREWjL8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TXXha/82m3Ck5WTbTkTYjQETpV+2tvuY3tEp+f+qgOutpV8vB5SR8UOQ5qffU9kDI
         aJm0AVVC/1kqu8PaiHHKK4CxOC+wah0nJkFvIVH16l5zIMRJ9i6fiNW0x1smQoRoID
         +5s9sKh1MO8j867yLNEuWE37vlBd+HyEnFFj1gxI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D350D601E7;
        Tue, 25 Jun 2019 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561466998;
        bh=mr/xt+cVO5VfX8b/8gPbYA+kREY82BW9CmvRxREWjL8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eMIGOK6Ze9OgngPXA1DwipHbXZAHTtVtp6rTEXbHvyTVoavvInn40y62qsQ9YhPtB
         NoGM7gFk2yCa61KvviEGBHZQhNaEGU4DXKnuujL41YW77wdVUMeP/r605jDJO/xK75
         tOCLZT5W26DePkZu7qxnRLnGXq/YrnkevCYbteyo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D350D601E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] ath10k: Add wrapper function to ath10k debug
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556283505-29539-1-git-send-email-vnaralas@codeaurora.org>
References: <1556283505-29539-1-git-send-email-vnaralas@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Kan Yan <kyan@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625124958.5F3B1606DC@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:49:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> wrote:

> ath10k_dbg() is called in ath10k_process_rx() with huge set of arguments
> which is causing CPU overhead even when debug_mask is not set.
> Good improvement was observed in the receive side performance when call
> to ath10k_dbg() is avoided in the RX path.
> 
> Since currently all debug messages are sent via tracing infrastructure,
> we cannot entirely avoid calling ath10k_dbg. Therefore, call to
> ath10k_dbg() is made conditional based on tracing config in the driver.
> 
> Trasmit performance remains unchanged with this patch; below are some
> experimental results with this patch and tracing disabled.
> 
> mesh mode:
> 
> 		w/o this patch          with this patch
> Traffic       TP      CPU Usage      TP      CPU usage
> 
> TCP          840Mbps    76.53%      960Mbps    78.14%
> UDP          1030Mbps   74.58%      1132Mbps   74.31%
> 
> Infra mode:
> 
> 		w/o this patch          with this patch
> Traffic        TP      CPU Usage      TP      CPU usage
> 
> TCP Rx       1241Mbps   80.89%      1270Mbps   73.50%
> UDP Rx       1433Mbps   81.77%      1472Mbps   72.80%
> 
> Tested platform	: IPQ8064
> hardware used	: QCA9984
> firmware ver	: ver 10.4-3.5.3-00057
> 
> Signed-off-by: Kan Yan <kyan@chromium.org>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9d740d6380e5 ath10k: Add wrapper function to ath10k debug

-- 
https://patchwork.kernel.org/patch/10919117/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


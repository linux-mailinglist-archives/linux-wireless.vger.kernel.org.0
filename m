Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C391F7274
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 11:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKKrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 05:47:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfKKKrd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 05:47:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E133D6090E; Mon, 11 Nov 2019 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573469252;
        bh=b/nwPztZBKNlDkwNmJw1aM7FU3Q5/+p+Y9WObfBkYBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JBxEiM6VY2Z0rsO1wJ7pLHRWnpPccMFSHCCLS8bhOj9id4TZj5R/2e57LYJh20yjI
         X9/kt+O/+K3f/F6m4WGe5wkLrju95YnasiryxZL0yeXvyoVv6IACtX5KW+m+ZnIXK9
         gt02a8bWC6Yp5BKX+YMljyKvpxpXHLaNDxSVoY40=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8ACCA6083E;
        Mon, 11 Nov 2019 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573469252;
        bh=b/nwPztZBKNlDkwNmJw1aM7FU3Q5/+p+Y9WObfBkYBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JBxEiM6VY2Z0rsO1wJ7pLHRWnpPccMFSHCCLS8bhOj9id4TZj5R/2e57LYJh20yjI
         X9/kt+O/+K3f/F6m4WGe5wkLrju95YnasiryxZL0yeXvyoVv6IACtX5KW+m+ZnIXK9
         gt02a8bWC6Yp5BKX+YMljyKvpxpXHLaNDxSVoY40=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 11 Nov 2019 18:47:32 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
In-Reply-To: <3f3641ad49a2664d346558760e38b404@codeaurora.org>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
 <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
 <3f3641ad49a2664d346558760e38b404@codeaurora.org>
Message-ID: <70f8f208f631a2a2c7337f45b873a16e@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-01 15:42, Wen Gong wrote:
> On 2019-10-31 17:08, Kalle Valo wrote:
> 、> I just realised that this is RX path so we should use 
> ATH10K_SKB_RXCB()
>> instead. I made the change below to this commit in pending branch:
>> 
> I will test with the new patch together with other performance patches.
Hi Kalle, I have tested with the patches of pending branch, it is 
success.
result is same with the public review which I tested before.

the patches I tested on pending branch:

ath10k: enable alt data of TX path for sdio
ath10k: add htt TX bundle for sdio
ath10k: disable TX complete indication of htt for sdio
ath10k: enable napi on RX path for sdio
ath10k: sdio: remove struct ath10k_sdio_rx_data::status
ath10k: sdio: cosmetic cleanup
ath10k: add workqueue for RX path of sdio
ath10k: change max RX bundle size from 8 to 32 for sdio
ath10k: enable RX bundle receive for sdio


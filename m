Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4672265D1B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgIKJ6D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 05:58:03 -0400
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:55712
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgIKJ56 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 05:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599818277;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=T1hXfuGShw0ymsSSW9Mnm74BMeurvo8OT/Wn8QF9SfU=;
        b=BNkMgG4yiUVkLE8/WEHYEQA/N4cVvWv0EVFNOClcRQeVZmERE9kjYT+recfC/eyi
        dct2PFrBXRVSyZ2KglR1bnulmiv7/J1cz3CkTvza9gBcPjpQ2hc6TI51D+X2uSgm0jg
        uN3OCX+If0+Oq5EsiBSJlGSl60JgnA8s9e2+ACg4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599818277;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=T1hXfuGShw0ymsSSW9Mnm74BMeurvo8OT/Wn8QF9SfU=;
        b=B5s4WuzNoqTHPAfbieyosHPUhKvvgvwGzx+o0qoj4lWySpJpvnuasT30ZoreSUtE
        r9THuNTCTjEqFUpiMKJmf7G0SCiC2JsSeReYxjEXbLtkyo/8l77IPhErTwrSE9A+V8E
        Eq1uv+m5+L23xZuXJbLZa1Sd4l9WRpWCJ3g1rvIU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C71CFC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove calling ath11k_init_hw_params() second
 time
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <010101746d2a40d3-25cd7dbe-c0dd-4fdf-8735-366d7fb40207-000000@us-west-2.amazonses.com>
References: <010101746d2a40d3-25cd7dbe-c0dd-4fdf-8735-366d7fb40207-000000@us-west-2.amazonses.com>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101747c99a22a-665d2d5b-035c-4d70-8503-bf6ed1958d5d-000000@us-west-2.amazonses.com>
Date:   Fri, 11 Sep 2020 09:57:57 +0000
X-SES-Outgoing: 2020.09.11-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> During probe ath11k_init_hw_params() is called from ath11k_core_pre_init()
> and is not needed agian in ath11k_core_init().
> 
> Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 1ff8ed786d5d (ath11k: use remoteproc only with AHB devices)
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a9d9e03858ad ath11k: remove calling ath11k_init_hw_params() second time

-- 
https://patchwork.kernel.org/patch/11763091/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


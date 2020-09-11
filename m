Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856D6265D16
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgIKJ5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 05:57:09 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:38884
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgIKJ5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 05:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599818228;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=ElgRM4NtukT2n8ovEbtIqMOWvX4QC264dSdzTj5EASo=;
        b=fV8wodTJpioEZBeWXWbWtFVr18zbqlXu3YiTZqMBOuOOUs0pG4ypu+KrpWXmrWwC
        Kw4v76Su56lMPgTF5LzSw2cXnl+Bygk+7OjNRpN6ZxIuNo9nRSu1cqRF8C/dOmfyfBf
        IOfJnyqtNRAhh/NMCKFEv0iQrctgQITI4wxgtP+4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599818228;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=ElgRM4NtukT2n8ovEbtIqMOWvX4QC264dSdzTj5EASo=;
        b=fxej2YNLFu5UBkTV2e3ZRor4HAS5npYQUNP6Ksqu4ff6yRB+/o0MRH7VE/yUkMeN
        w4YLwer3G500oIAHirE/AGdfSVJBH2SyLZygEXsLUIbCe5u4iOe0RjWCyazi0cqUoCj
        R9BzP0dXQo7fBAUcr9SMnPjXuo8BVrPys4BIxFiU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D33F1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] ath11k: add raw mode and software crypto support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <010101746c6a52d9-18302a2c-0d6d-4057-aa4b-95960c809646-000000@us-west-2.amazonses.com>
References: <010101746c6a52d9-18302a2c-0d6d-4057-aa4b-95960c809646-000000@us-west-2.amazonses.com>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101747c98e0f2-5c341f4f-0d50-4f66-acb8-7ab4a1003d51-000000@us-west-2.amazonses.com>
Date:   Fri, 11 Sep 2020 09:57:08 +0000
X-SES-Outgoing: 2020.09.11-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> wrote:

> Adding raw mode tx/rx support. Also, adding support
> for software crypto which depends on raw mode.
> 
> To enable raw mode tx/rx:
> insmod ath11k.ko frame_mode=0
> 
> To enable software crypto:
> insmod ath11k.ko crypto_mode=1
> 
> These modes could be helpful in debugging crypto related issues.
> 
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

aa2092a9bab3 ath11k: add raw mode and software crypto support

-- 
https://patchwork.kernel.org/patch/11762567/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


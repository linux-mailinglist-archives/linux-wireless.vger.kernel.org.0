Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49CE10D1E5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 08:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfK2HjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 02:39:06 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:41548
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2HjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 02:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575013144;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=yoqfKJYFtB2wZZlk5yMP//J9SR/zR3LRyTDSp/Ss/mc=;
        b=LZp0IYZ6lSo/lYzVvj+mCLPb9Pxmrof2hC8p0vghjNDgWPLty0/2yYhf8/oUfPJC
        +ujSLsoTdeLh9jvcwnxsQHpcDw+5fPzfS+JLtrGi1QcyNbPSP/C7VTZllKqPYK0C3li
        +q8NayD+MmKxVBw5cgjnCNsWtedwzJNBuOdFT/1Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575013144;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=yoqfKJYFtB2wZZlk5yMP//J9SR/zR3LRyTDSp/Ss/mc=;
        b=hSGhzZKEFg83i6YChdEi9JqfuQK1HR6oQE2axRR+O164YbmJQ8WcRJTpTncDBMOC
        cXQkDGjZdpxZR8W15AiCRQ18lTjciKOKQyWfsvxoBFeO1x/dsPfXIkpOV2GhXKzRIFc
        xNByTjfmGEkphHTGC2cCPPEv69fl2iWlNRtOLnYg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C03AC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] ath11k: Fix htt stats sounding info and pdev cca
 stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ea76291c1-5098ab8c-5e07-4a40-a582-6bd9ae513b74-000000@us-west-2.amazonses.com>
References: <0101016ea76291c1-5098ab8c-5e07-4a40-a582-6bd9ae513b74-000000@us-west-2.amazonses.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb6195852-b9f6933e-839e-4168-b559-8f43765c123d-000000@us-west-2.amazonses.com>
Date:   Fri, 29 Nov 2019 07:39:04 +0000
X-SES-Outgoing: 2019.11.29-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> The Previous configuartion of htt stats sounding info and pdev cca stats
> are invalid due to that getting time out error.
> 
> Changing htt stats sounding info value from 0xFF to 0x00 and htt pdev cca
> stats from 0x10 to 0x00
> 
> Signed-off-by: Ganesh Sesetti <gseset@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

10 patches applied to ath-next branch of ath.git, thanks.

86d4def890fd ath11k: Fix htt stats sounding info and pdev cca stats
5e97128759b4 ath11k: fix resource leak in ath11k_mac_sta_state
5b90fc760db5 ath11k: fix wmi service ready ext tlv parsing
0f37fbf43c3f ath11k: update tcl cmd descriptor parameters for STA mode
293cb5839729 ath11k: optimize RX path latency
f1d34a01ed54 ath11k: avoid WMM param truncation
d12ac6c47a32 ath11k: remove unused tx ring counters
d2f510fa0103 ath11k: Fix skb_panic observed during msdu coalescing
79c647a3c59d ath11k: Fixing TLV length issue in peer pktlog WMI command
051cefa44667 ath11k: Fix target crash due to WBM_IDLE_LINK ring desc shortage

-- 
https://patchwork.kernel.org/patch/11261935/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67BF108D3B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKYLtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 06:49:47 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:44946
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbfKYLtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 06:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574682586;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=qRAPzMoq9zDnzg5lo80rTzCgJ3H+Ek6YWbnr4Fr6y7c=;
        b=Pblrg6o0/GQsGmCaSaV8qaiH5H23ABMA1pW85aFWf1ACLcPja5eTggOaTa3eV4aA
        0BMk2Q6boR0bZ0UsuLea2GM0fnS1kFGAWSKjbbJOfUCFip4nqi/pCqbVKvS6yigvBxn
        23dNPufoFr/jmxUQAc4q1inOFq4BgNlfGF0Fbnp0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574682586;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=qRAPzMoq9zDnzg5lo80rTzCgJ3H+Ek6YWbnr4Fr6y7c=;
        b=Ehg0u2X+XSFnh5a8+TtS+8XBSRsQquRr7DzTNiVY0y0FpuN0OjJimqyqh6ZnHvWf
        eDzr0Npdoco5NijIK1h6naDEwA0+cPDTeSwnNaJ2Nk8LD9+fOjB6n/8NaE+51/qg+08
        dY0Sv8YPZ4AqgPfN7v7wvnXaiOP+crxAEZp1D+aM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1341FC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 1/3] ath10k: enable RX bundle receive for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1569402639-31720-2-git-send-email-wgong@codeaurora.org>
References: <1569402639-31720-2-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ea2656bea-fec594ce-191d-43ce-a06f-568a8c5df250-000000@us-west-2.amazonses.com>
Date:   Mon, 25 Nov 2019 11:49:46 +0000
X-SES-Outgoing: 2019.11.25-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> The existing implementation of initiating multiple sdio transfers for
> receive bundling is slowing down the receive speed. Combining the
> transfers using a bundle method would be ideal.
> 
> The transmission utilization ratio for sdio bus for small packet is
> slow, because the space and time cost for sdio bus is same for large
> length packet and small length packet. So the speed of data for large
> length packet is higher than small length.
> 
> Test result of different length of data:
> data packet(byte)   cost time(us)   calculated rate(Mbps)
>       256               28                73
>       512               33               124
>      1024               35               234
>      1792               45               318
>     14336              168               682
>     28672              333               688
>     57344              660               695
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
> 
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

8d985555ddaa ath10k: enable RX bundle receive for sdio
224776520ead ath10k: change max RX bundle size from 8 to 32 for sdio
67654b26c903 ath10k: add workqueue for RX path of sdio

-- 
https://patchwork.kernel.org/patch/11160247/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


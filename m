Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C441068FF
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKVJp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 04:45:29 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:55966
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbfKVJp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 04:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574415928;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=am+FFL6VsTvZN6iBIEE+fypD9VaYtOR93JqaXHR6Suo=;
        b=bq9yxUsBVoeVTiN9PdjZKFPoIDxrSOrhyfKZ+TPfsdYHHLdoMJBULJO65EPL+/jR
        mP4jrV8Jhl3mYStfLLYD3KEfeLGrGTvh37rBztnQZEiOnsEU2pvVyt3FPs+hWclurUU
        GtMdJRXY8QIj9A2dCOMVc0EhUZkqfJHvXcdgWgVM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574415928;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=am+FFL6VsTvZN6iBIEE+fypD9VaYtOR93JqaXHR6Suo=;
        b=NQVHAO37hpxBDBNIxU8fsQoJXv26kdJJHQKf5wy2BvbIA3Hz8vrjOd4berYdimO1
        gryPt4eYKyBtj5VpQDPbYbFx75MlbhVh84LJThomSZAsOvtUVvlKXm1VhBdLRpoL9ZC
        tewM5TmM6l0bHzSKVrlrAewidzXzgl7ugrQUe6p0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A660C447A9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zhi Chen <zhichen@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC, v2] Revert "ath10k: fix DMA related firmware crashes on multiple devices"
References: <1573808573-12159-1-git-send-email-zhichen@codeaurora.org>
Date:   Fri, 22 Nov 2019 09:45:28 +0000
In-Reply-To: <1573808573-12159-1-git-send-email-zhichen@codeaurora.org> (Zhi
        Chen's message of "Fri, 15 Nov 2019 17:02:53 +0800")
Message-ID: <0101016e92808aff-6e101d7c-069d-4db9-8149-9b12e3393920-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.22-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi Chen <zhichen@codeaurora.org> writes:

> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
> PCIe hung issue was observed on multiple platforms. The issue was reproduced
> when DUT was configured as AP and associated with 50+ STAs.
>
> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
> issue happened. It broke PCIe spec and caused PCIe stuck.
>
> Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
>          QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
>          Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040
>
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
> ---

All comments under --- line is not added to the git repository.

> v2: revert 10.4 only because old chips have different AXI RD/WR CFG

So you should also mention this in the commit log so it gets properly
archived.

And in the next version please remove RFC, as it seems we are reaching a
consensus that is the right approach. Or are there any comments?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

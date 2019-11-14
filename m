Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D3FC9F1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNP3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 10:29:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNP3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 10:29:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FEA460EB7; Thu, 14 Nov 2019 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573745371;
        bh=YECjVZw1OtqdDC/hqLRVhw3jSck8p1UeEqN1VmS1fg8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RPPn6PVYwtmBYLdqP87kgz2T6IEqOYUXYq1VVe8Y3H2UuW501AY8rBj0yffd7Az3L
         tlhMp1/ZDC6wwZ1NtFXpuNkKKWKdLuhn9kBEdA+9/iZ8JDGGAC6AdLgdWVv+IQw3z1
         ury7OWHaXjITsycvQLZVWQMXF4SkgBM3TuL8VvTU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CC8A6076A;
        Thu, 14 Nov 2019 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573745370;
        bh=YECjVZw1OtqdDC/hqLRVhw3jSck8p1UeEqN1VmS1fg8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eZ7OLA2RCFRVjXXWqYEREYSI/EYn+64AeQzOuLxzZk2XLWa3NSSI5WdjUPhA0iZPu
         JSZR9hq8F5M4PT4Gw0EW55c5S57Py2c85IeexJmROpcPR3v79FCXw9MJBnoW/sQeOZ
         ZPHKPupdmr/R5zVjteykW80jNj+bdJqpU1TXW3fM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CC8A6076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] qtnfmac: fix using skb after free
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191113110639.9226-2-sergey.matyukevich.os@quantenna.com>
References: <20191113110639.9226-2-sergey.matyukevich.os@quantenna.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191114152931.8FEA460EB7@smtp.codeaurora.org>
Date:   Thu, 14 Nov 2019 15:29:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> wrote:

> KASAN reported use-after-free error:
> 
> [  995.220767] BUG: KASAN: use-after-free in qtnf_cmd_send_with_reply+0x169/0x3e0 [qtnfmac]
> [  995.221098] Read of size 2 at addr ffff888213d1ded0 by task kworker/1:1/71
> 
> The issue in qtnf_cmd_send_with_reply impacts all the commands that do
> not need response other then return code. For such commands, consume_skb
> is used for response skb and right after that return code in response
> skb is accessed.
> 
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

7 patches applied to wireless-drivers-next.git, thanks.

4a33f21cef84 qtnfmac: fix using skb after free
dd4c2260dab0 qtnfmac: fix debugfs support for multiple cards
24227a9e956a qtnfmac: fix invalid channel information output
97aef03cb71b qtnfmac: modify Rx descriptors queue setup
46d55fcec163 qtnfmac: send EAPOL frames via control path
239ce8a79778 qtnfmac: handle MIC failure event from firmware
0756e913fc02 qtnfmac: add support for getting/setting transmit power

-- 
https://patchwork.kernel.org/patch/11241691/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


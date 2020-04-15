Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02B71A9729
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894873AbgDOImw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:42:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61196 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894846AbgDOImt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:42:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586940169; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QKDw62bpMO1wwchuPEun25pneBt8hRj+Wno/6nm/b3Q=;
 b=FzsC5wNY+1oOoqkCdkeNYedyTTYxK5Zf5LgVhDnbQIbHJARtP6qlfQtdMKfhgCzwaECQU6BU
 KTquQDflO1qPRKB/V+zv77KqJJZ/4fpyTStlFOM4QjzQXKnttuOSS0wp2e1xfDaWUVWNwq2n
 MHrVNpxrp0MuHf9xP5Sg1MfkDQU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96c908.7ff158d1c768-smtp-out-n02;
 Wed, 15 Apr 2020 08:42:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD050C433CB; Wed, 15 Apr 2020 08:42:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D3F5C433F2;
        Wed, 15 Apr 2020 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D3F5C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/9] hostap: Add missing annotations for
 prism2_bss_list_proc_start() and prism2_bss_list_proc_stop
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200411001933.10072-4-jbi.octave@gmail.com>
References: <20200411001933.10072-4-jbi.octave@gmail.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Jouni Malinen <j@w1.fi>,
        "David S. Miller" <davem@davemloft.net>,
        zhong jiang <zhongjiang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-wireless@vger.kernel.org (open list:HOST AP DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415084247.CD050C433CB@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:42:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jules Irenge <jbi.octave@gmail.com> wrote:

> Sparse reports warnings at prism2_bss_list_proc_start() and prism2_bss_list_proc_stop()
> 
> warning: context imbalance in prism2_wds_proc_stop() - unexpected unlock
> warning: context imbalance in prism2_bss_list_proc_start() - wrong count at exit
> 
> The root cause is the missing annotations at prism2_bss_list_proc_start()
> 
> Add the missing __acquires(&local->lock) annotation
> Add the missing __releases(&local->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

1c0e3c73e98d hostap: Add missing annotations for prism2_bss_list_proc_start() and prism2_bss_list_proc_stop

-- 
https://patchwork.kernel.org/patch/11483853/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

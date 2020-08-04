Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF923BB0F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgHDNTX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 09:19:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12730 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgHDNSn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 09:18:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596547091; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=75YPg+nO5o5PVjx5I51lEmqudShT1L8G5M3L1YVscj8=; b=pEzkEgR36AlmJalcEivR2z83DMw9u1+xIvOjXr8E3hQGwxG94jT/o9OaaLIBrBtujsWA+ung
 Etl5o9D3YWGqHUGd6wMdv8s8ifv90oYpm7YifeBM+o3cIrqve8oy1cVCRBHNuzeqgOSZB4Gp
 +IiGcdUOhVwCdgPY7VHbnoNFRP8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f295fff37790be1d05a3072 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 13:17:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51DBCC43395; Tue,  4 Aug 2020 13:17:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CDEFC433C6;
        Tue,  4 Aug 2020 13:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CDEFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
References: <20200803080359.64b417e3@canb.auug.org.au>
Date:   Tue, 04 Aug 2020 16:17:47 +0300
In-Reply-To: <20200803080359.64b417e3@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 3 Aug 2020 08:03:59 +1000")
Message-ID: <87wo2epn2c.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> In commit
>
>   4c7e1711cf4c ("mt76: mt7915: fix potential memory leak in mcu message handler")
>
> Fixes tag
>
>   Fixes: c6b002bcdfa6 ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")

Yeah, that should have been it but it's too much work to fix this now so
I'll just leave it be. Thanks for the report.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

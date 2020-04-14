Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA71A8183
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440338AbgDNPJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 11:09:49 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18374 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440331AbgDNPJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 11:09:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876965; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=OS+STgIODNgZTcpBgh6hwEBupTearScuPMfVu+byNqk=;
 b=eScg1wDWmgdo0zaJDcQsjHw0VefgIWLNBDkJDRzMDEKFmddFlf8i61Tf5dsFPXlmckL8xj8O
 AOdZluQJWopTtJdftMiJCjctup921B6Sb7coJglVd2vp4ke0rHXWynhRD8D6VS0EtOKFuwL3
 /teL9wHM4JyVaQk7eyJizOWSnT0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d21d.7fe913496d88-smtp-out-n01;
 Tue, 14 Apr 2020 15:09:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E73AC433CB; Tue, 14 Apr 2020 15:09:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A766C433BA;
        Tue, 14 Apr 2020 15:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A766C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] qtnfmac: Simplify code in _attach functions
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200407193233.9439-1-christophe.jaillet@wanadoo.fr>
References: <20200407193233.9439-1-christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     imitsyanko@quantenna.com, avinashp@quantenna.com,
        smatyukevich@quantenna.com, davem@davemloft.net,
        huangfq.daxian@gmail.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414150917.1E73AC433CB@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 15:09:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> There is no need to re-implement 'netdev_alloc_skb_ip_align()' here.
> Keep the code simple.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Patch applied to wireless-drivers-next.git, thanks.

c960e2b384ef qtnfmac: Simplify code in _attach functions

-- 
https://patchwork.kernel.org/patch/11478939/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

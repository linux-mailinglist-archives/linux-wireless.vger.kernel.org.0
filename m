Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD1399DE2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFCJhR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 05:37:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48686 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCJhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 05:37:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622712933; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CoDUZzaw4o/hGDbYV678zJhrcKCRPmjONW/25p15Llc=;
 b=PBkDkelh1gzV9Z8SR8vPcOd6Gg+Mes9J+VeFJUJGq40aOhq3HsDk/6inc3hvKmOro0ZvHrf+
 +NJYcLC9+FJJ8Ptbv1Y785Avv80zJkipwUm6uoW92Oynmzn7k3SXr7FzxuD3/v6v4URpn6qi
 qkHDHtgbL471kztZMNwoNmt4KIA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60b8a263f726fa4188b23640 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 09:35:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F5C7C4323A; Thu,  3 Jun 2021 09:35:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72C4EC433D3;
        Thu,  3 Jun 2021 09:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72C4EC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ipw2x00: Minor documentation update
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1619347842-6638-1-git-send-email-jrdr.linux@gmail.com>
References: <1619347842-6638-1-git-send-email-jrdr.linux@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     stas.yakovlev@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210603093530.3F5C7C4323A@smtp.codeaurora.org>
Date:   Thu,  3 Jun 2021 09:35:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Kernel test robot throws below warning ->
> 
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:5359: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Minor update in documentation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>

Patch applied to wireless-drivers-next.git, thanks.

080f9c10c773 ipw2x00: Minor documentation update

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1619347842-6638-1-git-send-email-jrdr.linux@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEC6248533
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgHRMtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 08:49:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34450 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHRMtN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 08:49:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597754952; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=f6/sdyiEI31gcUzpbwYfNc9X/mSeCyD7/fVOkfJ4NN8=;
 b=Pojb5F7wUe60bai5Cz8eDZul5aNmnz0GAsDUZlz422GsGZHhxn+9ZLu7jYxUq/4CdTPOXOZM
 qIJXVL1t8aLHBtM4ntpUsI94EGQ3lDZhPIsXI4YGAjlEpHaG6Kktgfaqxws6OJM46gZt4I4u
 lWF93abN+FFFwTS8LlxoWcNW/3g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3bce36856720175164d4e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 12:48:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55502C433A1; Tue, 18 Aug 2020 12:48:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98BBAC433CA;
        Tue, 18 Aug 2020 12:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98BBAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] brcmfmac: use %*ph to print small buffer
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200730155327.40130-1-andriy.shevchenko@linux.intel.com>
References: <20200730155327.40130-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-wireless@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818124853.55502C433A1@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 12:48:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied to wireless-drivers-next.git, thanks.

838933ca5b9c brcmfmac: use %*ph to print small buffer

-- 
https://patchwork.kernel.org/patch/11693383/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


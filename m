Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E50262759
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIIGti (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 02:49:38 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:40126
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgIIGth (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 02:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599634176;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=p4ypZmhWXG8yORYJ/mTAYIPFxIMn8mkGqNNLuk4db3Y=;
        b=kTam4RHs9mXYwQIkx/ZAu/9ERnPzsOXPG9WVMAx+i1/D13GL0E/r89IKYXN1Cdsl
        /jbmR05sSqLPEpZYw/5ueh0zTr5KYdYw76gDhGHKNdn20RlDdjL0eJu1fXsJO9eNXNi
        A4Mfk/DZD7nAy4RAEaayKY+gujPv5XT7RDBgW1H0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599634176;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=p4ypZmhWXG8yORYJ/mTAYIPFxIMn8mkGqNNLuk4db3Y=;
        b=AlOS+0zfPQeNUaXPIOsDPytCQDdZbOOrY4r2rz/DtfiqedYxworPw5aYi0VhiUZT
        hGxKEvVRIxPrTrVuwfiwwZqkcePJGUA8FFyXzr4iznImNjrLg0xySl7jUz3ONjhyJ6Z
        TEb6QCCBcLEHCOAOBtCnPHKZ5w6Hst2lgrWtVBV8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2928FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] ath11k: fix uninitialized return in
 ath11k_spectral_process_data()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200619142922.GA267142@mwanda>
References: <20200619142922.GA267142@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <0101017471a07992-e553dd64-fb73-44d0-bd54-ee6367163e50-000000@us-west-2.amazonses.com>
Date:   Wed, 9 Sep 2020 06:49:36 +0000
X-SES-Outgoing: 2020.09.09-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> There is a success path where "ret" isn't initialized where we never
> have a ATH11K_SPECTRAL_TAG_SCAN_SEARCH and then ret isn't initialized.
> 
> Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c7187acc3cd0 ath11k: fix uninitialized return in ath11k_spectral_process_data()

-- 
https://patchwork.kernel.org/patch/11614313/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


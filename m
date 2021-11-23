Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652645A06C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhKWKmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 05:42:40 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:56654 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbhKWKmc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 05:42:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637663963; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3nwGKStbNyFN0QQbQljMgm6itmwD1QOYjOmKyUbV4GU=;
 b=lJDfFBZrPrvDBPMFEWSwXS2GfH/kuI+rt1ZmPUdd7YP3DoOwUfBchCymANepQGEb+nzTXf/1
 J8ujEVaWYfqR2yTfKxjLBjgiQ2qsYFAZplH0Z/JjXgXRmBGKJuRBn6gsp1+Fe48JTsnLg1iC
 YjXUlsCbAnK86S8ukd/+lbC86js=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 619cc4db135a8a9d0efbb7db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Nov 2021 10:39:23
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78160C43616; Tue, 23 Nov 2021 10:39:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7764CC4360C;
        Tue, 23 Nov 2021 10:39:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Nov 2021 16:09:21 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v4 2/2] ath11k: Use reserved host DDR addresses from DT
 for PCI devices
In-Reply-To: <2802525.9g7TWp2vRq@ripper>
References: <1637504521-30997-1-git-send-email-akolli@codeaurora.org>
 <1724585.GBsqGgcNsD@sven-l14>
 <a6f4fd77b1f8729368fee13a435fe652@codeaurora.org>
 <2802525.9g7TWp2vRq@ripper>
Message-ID: <69b243375da1358f39955186fb69a55d@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-22 13:20, Sven Eckelmann wrote:
> On Monday, 22 November 2021 07:12:27 CET Anilkumar Kolli wrote:
> [...]
>> >> +			start = reg[0] + reg[1];
>> >> +			size = reg[2] + reg[3];
>> >
>> > See my messages for v2 [1] and v3 [2]
>> >
>> >
>> Thanks for the review,
>> 
>> Here addresses are always within 32-bit.
>> so I will change the API to read only 2 integers and update start
>> addresss and size.
> 
> The size of address and size depends on the reserved-memory node - not 
> the
> qcn9074 node. So please don't make such assumptions in your code.
> 

Yes, correct.

of_address_to_resource() returns start/end address properly.
I will update and send next version.

- Anil.

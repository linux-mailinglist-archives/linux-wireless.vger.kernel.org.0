Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8589A25404D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgH0IG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 04:06:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38066 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgH0IGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 04:06:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598515615; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OU6ogiMDCDerjBed0JS9e8FiPYb6BntthFpbYOqrkj4=; b=vuXf5U/1b2DK0NTdIrEfwR4VPNJcHDxhwD4qpdYJLaIwAbyhHKAeLdrt+gPJ1uewWTJV+rrB
 raen/0z+Jm2JrGbVBJiQIFqjs3eF/bRbnkX95cky0LRWHeesL3E8jRstcprQ6XXUEdKPaogt
 tWNfxD7UZTXcL7BkY/ly08RfEKA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f47697e5d0d4a9f0412e66b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 08:06:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F92EC433CB; Thu, 27 Aug 2020 08:06:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BA78C433CA;
        Thu, 27 Aug 2020 08:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BA78C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org
Subject: Re: [PATCH 00/36] wcn36xx: Add support for WCN3680 802.11ac
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
        <87r1rt77hm.fsf@tynnyri.adurom.net>
        <add1cb82-6dac-6424-dba8-c9cd9803f23a@linaro.org>
Date:   Thu, 27 Aug 2020 11:06:17 +0300
In-Reply-To: <add1cb82-6dac-6424-dba8-c9cd9803f23a@linaro.org> (Bryan
        O'Donoghue's message of "Wed, 26 Aug 2020 17:17:55 +0100")
Message-ID: <87eensldhi.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 26/08/2020 16:27, Kalle Valo wrote:
>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>>
>>> This series adds support for the 802.11ac data-rates available on the WCN3680.
>>
>> To review 36 patches is just too much, so I'm going to take this in
>> smaller pieces.
>>
>> In the future please limit the patchset size:
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#maximum_of_7-12_patches_per_patchset
>>
>
> OK, I will break this up into groups of 8-10 patches on the rebase.

Great, thanks.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

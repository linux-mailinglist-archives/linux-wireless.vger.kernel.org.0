Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAF2A4711
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 14:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgKCN5t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 08:57:49 -0500
Received: from z5.mailgun.us ([104.130.96.5]:51950 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgKCN5P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 08:57:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604411835; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=C7aq5TQXMg9wY6ovYiL8WXO2rB5LU2IgMJEWeaP4HPk=; b=SkZOcxG8nyPcDGTVmMyoRa8FnMXgdcpXu4zoj3GCw275FNAyyregN/FIWbUZW131vLtX2WeE
 BcOe8eqiNbX841xkqnEz8Tv/9vXk029NE2vCtA1y7tjul6GY8Xg2gYdEqNvblhH23j65bIqh
 D/8zx7w6Xr0gs8eNg2rrA4ppi+E=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa161af0ce128468b11683c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 13:57:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 814D2C433C9; Tue,  3 Nov 2020 13:57:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED8E0C433C8;
        Tue,  3 Nov 2020 13:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED8E0C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Devin Bayer <dev@doubly.so>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: ath11k with QCA6391
References: <c9fb5fa6-297e-a595-7670-c9105641bc83@doubly.so>
        <87wnz3twvo.fsf@codeaurora.org>
        <5f3ee526-e96f-3c88-a17e-e7ebf9703ed1@doubly.so>
Date:   Tue, 03 Nov 2020 15:56:58 +0200
In-Reply-To: <5f3ee526-e96f-3c88-a17e-e7ebf9703ed1@doubly.so> (Devin Bayer's
        message of "Tue, 3 Nov 2020 11:53:55 +0100")
Message-ID: <87d00uo85x.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Devin Bayer <dev@doubly.so> writes:

> On 02/11/2020 19.51, Kalle Valo wrote:
>> 
>> To my knowledge, from ath11k point of view, QCA6391 should look the same
>> as QCA6390 but most likely the board file for QCA6391 is different.
>> 
>
> Thanks. If I get to that point, I have been given firmware files from the
> vendor:
>
> 4076546464 3602624 amss.bin
> 1400223385 57936 bdwlan.bin
> 1400223385 57936 bdwlan.e0102
> 1400223385 57936 bdwlan.e0104
> 1400223385 57936 bdwlan.elf
>  691636418 57936 bdwlan01.e01
> 1400223385 57936 bdwlan01.e02
>  691636418 57936 bdwlan01.e03
> 3117335203 57936 bdwlan01.e04
> 1014175487 266684 m3.bin
>
> They are different than those from your repo, but maybe I can use
> bdwlan01.e04 as the board file.

Yes, that's what I would also suggest to test first: take the firmware
from ath11k-firmware.git and the board file from the vendor.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

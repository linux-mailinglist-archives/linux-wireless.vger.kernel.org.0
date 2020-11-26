Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553A12C51C3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 11:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgKZKEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 05:04:51 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:61753 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbgKZKEu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 05:04:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606385090; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=64QOHkD7nZIcKZ/FzIeGhS5LW89JrFwlD6gBg9kc1gQ=; b=TATWRzZxWwEMOX91yK4t8ERxzXKlsyC2mq0ocMzj4hd7ZfywROkSk3V4M7Nn6YW0zPm+PcvL
 S4uVNMSIvS2txiOleoUuKLunlt9L9fCWfphjOs4EUKjxVp6K/RU6sKZzLxLdEdrOLkR3kBWq
 kr9rN9Kj281kfkyx1vsXGbGvSUY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fbf7dc122377520ee754377 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Nov 2020 10:04:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3956C43460; Thu, 26 Nov 2020 10:04:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83156C433ED;
        Thu, 26 Nov 2020 10:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83156C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Devin Bayer <dev@doubly.so>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: ath11k with QCA6391
References: <c9fb5fa6-297e-a595-7670-c9105641bc83@doubly.so>
        <87wnz3twvo.fsf@codeaurora.org>
        <5f3ee526-e96f-3c88-a17e-e7ebf9703ed1@doubly.so>
        <87d00uo85x.fsf@codeaurora.org>
        <48f37c07-ca63-7ba9-1518-a31681777b15@doubly.so>
Date:   Thu, 26 Nov 2020 12:04:45 +0200
In-Reply-To: <48f37c07-ca63-7ba9-1518-a31681777b15@doubly.so> (Devin Bayer's
        message of "Wed, 25 Nov 2020 14:22:19 +0100")
Message-ID: <87a6v4ph6q.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Devin Bayer <dev@doubly.so> writes:

> On 03/11/2020 14.56, Kalle Valo wrote:
>> Devin Bayer <dev@doubly.so> writes:
>> 
>>> On 02/11/2020 19.51, Kalle Valo wrote:
>>>>
>>>> To my knowledge, from ath11k point of view, QCA6391 should look the same
>>>> as QCA6390 but most likely the board file for QCA6391 is different.
>>>>
>>> [snip]
>>>
>>> They are different than those from your repo, but maybe I can use
>>> bdwlan01.e04 as the board file.
>> 
>> Yes, that's what I would also suggest to test first: take the firmware
>> from ath11k-firmware.git and the board file from the vendor.
>
> I would like to report that with your latest qca6390-bringup branch my QCA6391
> card is working well with just the one MSI vector. I'm using the board file for
> 6390 from the linux-firmware repo.
>
> Thanks for the fixes :)

Great, thanks for the report. It's always helpful to know what is
working or not working on the field.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

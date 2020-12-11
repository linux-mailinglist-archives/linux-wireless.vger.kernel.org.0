Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B337D2D7035
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 07:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbgLKGcT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 01:32:19 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:62707 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390670AbgLKGb7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 01:31:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607668295; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=W8N84GyQduUiMjF1lxp66AvS3Tf0GJQ+TGc3pwNrUGs=; b=UYqExS5B2zUrxw2aS5hVMPZ8LXqJu7+AOUBMyiGEHx+kcQnLwrDtjnvs/ALXeGeGaJoH+sjl
 GWk7lGEmBDprtj8k+iPTL26G4JiUQru/++M+SV5VB3DjmH2yjAV+hRd7Hzr0gYjVN8wFjj3j
 9gM5KU6rq/vw1sU6sTRJDZjULVk=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fd3123842c04000266aa59f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 06:31:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B167C433C6; Fri, 11 Dec 2020 06:31:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B945AC433CA;
        Fri, 11 Dec 2020 06:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B945AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Peter Oh <peter.oh@eero.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/6] ath11k: pci: disable VDD4BLOW
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
        <1607609124-17250-6-git-send-email-kvalo@codeaurora.org>
        <d9b860d3-4ccc-f16c-9b0c-e0e7a0646e64@eero.com>
Date:   Fri, 11 Dec 2020 08:31:16 +0200
In-Reply-To: <d9b860d3-4ccc-f16c-9b0c-e0e7a0646e64@eero.com> (Peter Oh's
        message of "Thu, 10 Dec 2020 14:04:43 -0800")
Message-ID: <87a6uk97m3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Oh <peter.oh@eero.com> writes:

> On 12/10/20 6:05 AM, Kalle Valo wrote:
>> From: Carl Huang <cjhuang@codeaurora.org>
>>
>> It's recommended to disable VDD4BLOW during initialisation.
>
> Can you explain more about "recommended by whom and why"?

It's coming from the internal teams, I understood the internal driver
does the same.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859F327507E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Sep 2020 07:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIWF4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Sep 2020 01:56:30 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:42744 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWF4a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Sep 2020 01:56:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600840589; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8gJeOxpLmK2L3t+U1TnHcEniQWu5rJBKiUI7aOGaKdw=; b=TDN3IeL02PuQxgdF7EPSTL9z0McPMSJB8VKoUttNp6kYOF3TwVLC3YliGfFGELyevbyL4pmE
 yIev8P7YGcbICvveYwjW1An49tSjep7up8i3iR+Up/kO7oqQhwcIn69MxbGIisrYQ5RxRfUF
 YMqRbbOk2YdQ3ytJJA5E4qqD8xo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f6ae37e722ceb032700eafd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 05:56:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F810C433CB; Wed, 23 Sep 2020 05:56:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA757C433CA;
        Wed, 23 Sep 2020 05:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA757C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5.9] mt76: mt7615: reduce maximum VHT MPDU length to 7991
References: <20200923052442.24141-1-nbd@nbd.name>
Date:   Wed, 23 Sep 2020 08:56:10 +0300
In-Reply-To: <20200923052442.24141-1-nbd@nbd.name> (Felix Fietkau's message of
        "Wed, 23 Sep 2020 07:24:42 +0200")
Message-ID: <87blhxxchx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> After fixing mac80211 to allow larger A-MSDUs in some cases, there have been
> reports of performance regressions and packet loss with some clients.
> It appears that the issue occurs when the hardware is transmitting A-MSDUs
> bigger than 8k. Limit the local VHT MPDU size capability to 7991, matching
> the value used for MT7915 as well.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I'm planning to queue this to v5.9 and I assigned the patch to me in
patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

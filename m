Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66D2DE963
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 19:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgLRS6y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 13:58:54 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:58764 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLRS6x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 13:58:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608317914; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ODdPiC7psQVXXHgo8fq1cxq4RFwNcwXkZDtOyRJi91o=; b=AnYiyhZ1aJUBMgkZrsGTuurvre9HvPK04ece6qg9Z4NBbyTm8Zdg/3XidfufMxW4krRMTEg5
 JZP5IXrGaHr0cFzdnTg6etNiVa1EneX+wL/Ozunhbwcsi9huQsLRQLIwBX/Cggdu8xBEpkN8
 jA3WJVyFqApkQVmkZDOB/A4n9A0=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fdcfbbbbfd08afb0d366fef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 18:58:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19220C433ED; Fri, 18 Dec 2020 18:58:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B964FC433CA;
        Fri, 18 Dec 2020 18:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B964FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH -next] net: wireless/mediatek/mt7915: fix MESH ifdef block
References: <20201218173202.23159-1-rdunlap@infradead.org>
        <87eejnrluw.fsf@codeaurora.org>
        <488abe6b-3893-557a-8324-1be9b75657ce@infradead.org>
Date:   Fri, 18 Dec 2020 20:57:57 +0200
In-Reply-To: <488abe6b-3893-557a-8324-1be9b75657ce@infradead.org> (Randy
        Dunlap's message of "Fri, 18 Dec 2020 10:50:25 -0800")
Message-ID: <87a6ubrlfu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 12/18/20 10:48 AM, Kalle Valo wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> 
>>> Fix a build error when CONFIG_MAC80211_MESH is not enabled:
>>>
>>> ../drivers/net/wireless/mediatek/mt76/mt7915/init.c:47:2: error:
>>> expected expression before '}' token
>>>   }, {
>>>   ^
>>>
>>> Fixes: af901eb4ab80 ("mt76: mt7915: get rid of dbdc debugfs knob")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Shayne Chen <shayne.chen@mediatek.com>
>>> Cc: Ryder Lee <ryder.lee@mediatek.com>
>>> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
>>> Cc: Felix Fietkau <nbd@nbd.name>
>>> Cc: linux-wireless@vger.kernel.org
>>> Cc: Kalle Valo <kvalo@codeaurora.org>
>> 
>> Thanks, but why -next? I would rather queue this to wireless-drivers for
>> v5.11 as af901eb4ab80 is in Linu's tree now.
>
> Sorry, I found the build error in linux-next.
> My bad for not checking mainline.

Ah.

> Shall I resend it?

No need, just wanted to make sure that I'm not missing anything. I'll
queue this for v5.11.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

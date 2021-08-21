Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108A53F3A1B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhHUKKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 06:10:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34304 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhHUKKC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 06:10:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629540563; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nOvqcu25C6/yT1j6aF71MaY76ONTEhRWrcplxPoxqGQ=; b=Fom0rYFDHuXoXuUKzA/z+UlJjMC2WoPAlgLQdb2SccbRY1CCcPNuKnSuH+dm9vNgf739z/Jz
 kBRxaX0or4SJF8kCqO9GNreTbVcnxrZltdD2SZ463OW0ej5R6kflY50bXSyjML6GB7ydNbIk
 quSUxRAWp7rCpAeZsXTTB/1uh/w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6120d0b6f588e42af104fe2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 10:08:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C77AC43617; Sat, 21 Aug 2021 10:08:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E074AC4338F;
        Sat, 21 Aug 2021 10:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E074AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/4] mt76: mt7615: checkpatch cleanup
References: <77372f644903053e09d671325c0cd44cf75e14ac.1628301615.git.ryder.lee@mediatek.com>
        <1991c856459c2014386d1a16f6657e9ba82b6d1f.1628301615.git.ryder.lee@mediatek.com>
        <87wnoha1rd.fsf@tynnyri.adurom.net>
        <45c67ffb65debdd62a417c0b68af2ba7f1932195.camel@mediatek.com>
Date:   Sat, 21 Aug 2021 13:08:49 +0300
In-Reply-To: <45c67ffb65debdd62a417c0b68af2ba7f1932195.camel@mediatek.com>
        (Ryder Lee's message of "Fri, 20 Aug 2021 09:29:00 +0800")
Message-ID: <8735r3un2m.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> On Thu, 2021-08-19 at 18:32 +0300, Kalle Valo wrote:
>> Ryder Lee <ryder.lee@mediatek.com> writes:
>> 
>> > Fix reasonable checkpatch warnings.
>> > 
>> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> 
>> One logical change per patch, please.
>
> I prefer collection all checkpatch warnings into the single patch.

But in upstream we prefer one logical change per patch, for example
makes it a lot easier to review and bisect.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

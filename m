Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCF2F7388
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 08:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbhAOHJX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 02:09:23 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:39937 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOHJW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 02:09:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610694542; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=J4sUTQORyuJGi6GMa0id2fvAFBFse3MYUiMRSsOHoqs=; b=vTAgt1Xi0LGWANECMcUkI8Gcb9JtnjbNPl5iFdqruO/aWIBVb97og6oT94taDf+Wg21Wdb/7
 WkOX/r+6T24SsoM7Zt3mvg5piDnY1qPqRC7DWAXdMW8niBUOYy8XtQVatlMHvUAFLh6dYuT7
 HlDs1eX41f1dZXPM7p397MQ1OyE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60013f671e3bf9b669ec9e87 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 07:08:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52EF8C43465; Fri, 15 Jan 2021 07:08:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 670D3C433CA;
        Fri, 15 Jan 2021 07:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 670D3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org, nbd@nbd.name, sean.wang@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: mt7663s: fix rx buffer refcounting
References: <dca19c9d445156201bc41f7cbb6e894bbc9a678c.1610644945.git.lorenzo@kernel.org>
Date:   Fri, 15 Jan 2021 09:08:18 +0200
In-Reply-To: <dca19c9d445156201bc41f7cbb6e894bbc9a678c.1610644945.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Thu, 14 Jan 2021 18:26:47 +0100")
Message-ID: <87k0ser82l.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Similar to mt7601u driver, fix erroneous rx page refcounting
>
> Fixes: a66cbdd6573d ("mt76: mt7615: introduce mt7663s support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I'll queue this to v5.11 and assigned to me on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

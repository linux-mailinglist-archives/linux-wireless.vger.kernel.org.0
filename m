Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C4F45B639
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 09:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhKXIKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 03:10:49 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:46671 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhKXIKs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 03:10:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637741259; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GW6Gk0j92IWgzC2u2el8cZXZA8j9HGu5jwTO2JI/Eak=; b=FO1lCTRmq+AOtUlvnGx2HRo0LKGt/P4LnLNuiVOc7u/C0cZLvwnRvOh6TwLzhxJ3He0dAYhA
 VaWpzvl9nAVqRWbS/QIki5uhv8R2es2Ear+uS70K8KZPBlU2b3GzvDEc13UFAomC5c/2YEg8
 6ziF9EET7su0tS2o0Sf15bjtELo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 619df2ca6bacc185a5eed756 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 08:07:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0415C4360C; Wed, 24 Nov 2021 08:07:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C70CC4338F;
        Wed, 24 Nov 2021 08:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3C70CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
Date:   Wed, 24 Nov 2021 10:07:34 +0200
In-Reply-To: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Mon, 22 Nov 2021 18:34:03 +0100")
Message-ID: <875ysi6kop.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix a possible idr pkt-id leak if the packet is dropped on tx side
>
> Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I can take this to wireless-drivers and the patch is already assigned to
me. Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

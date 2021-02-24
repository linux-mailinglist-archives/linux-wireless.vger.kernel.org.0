Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAABE3236DC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 06:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhBXF3O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 00:29:14 -0500
Received: from z11.mailgun.us ([104.130.96.11]:28665 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233585AbhBXF3N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 00:29:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614144533; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bqZgK84veN6xeoN7CZnEfdbEuapwt1aQ7AG/IzhUPDs=; b=UCHvTrWu5QVG54DOsz6eerIHWngTfUA5E9XmtoHst+z8gB522qZIRg14NTU0R3JJPgzq1Bdr
 N+79YOyNivn1gCny+JqUQohfqoz3nFBrNZPxeJAWonk9ZleiDLSwW798O+iO2+dKv8gGx9uA
 zmKjUfk4OD5lTNscRAsXb7klYz0=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6035e415ba08663830a7fef6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 05:28:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 205F5C43464; Wed, 24 Feb 2021 05:28:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF438C433ED;
        Wed, 24 Feb 2021 05:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF438C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH v2 3/8] mt76: mt7921: switch to new api for hardware beacon filter
References: <cover.1613755428.git.lorenzo@kernel.org>
        <22be936230c356e9b57f541aaa40d6552783e92d.1613755428.git.lorenzo@kernel.org>
Date:   Wed, 24 Feb 2021 07:28:45 +0200
In-Reply-To: <22be936230c356e9b57f541aaa40d6552783e92d.1613755428.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Fri, 19 Feb 2021 18:28:46 +0100")
Message-ID: <87wnuydofm.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Current firmware only supports new api for enabling hardware beacon filter.
>
> Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
> Beacon filter cmd have to rely on the associatied access point's beacon
> interval and DTIM information.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

The Fixes tag is in odd place.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

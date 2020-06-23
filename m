Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC2204D95
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgFWJLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 05:11:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43526 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731941AbgFWJLe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 05:11:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592903493; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=URJMAy2kMHYmo7L30NLkdmxA75Vd5batIlRwsEao3Ks=; b=AB1fLba1mSzYFWOvlzHn7iHgVob/yv4WoXgz4qUgYR6ZulkKQBLteMVC24VJQ3+jg19oxoD2
 wODMjR2SS4q8KogKdiBZv7fpIw0QNthLxtHob42vOdjlHz4VLqzjeoxD3RebZ4MSM5GY9pBu
 r0T/vGWYjQD2DHzZzCYmPfcPmDY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ef1c7426f2ee827dae3aab3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 09:11:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC6C9C433CB; Tue, 23 Jun 2020 09:11:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8C42C433C8;
        Tue, 23 Jun 2020 09:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8C42C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, shayne.chen@mediatek.com,
        evelyn.tsai@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: wireless: mt76: add power-limits node
References: <20200616192544.97938-1-nbd@nbd.name>
Date:   Tue, 23 Jun 2020 12:11:25 +0300
In-Reply-To: <20200616192544.97938-1-nbd@nbd.name> (Felix Fietkau's message of
        "Tue, 16 Jun 2020 21:25:41 +0200")
Message-ID: <87o8padu4i.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This subnode can be used to set per-rate tx power limits either per
> country code / regdomain or globally.
> These limits are typically provided by the device manufacturers and are
> used to limit sideband emissions and stay within regulatory limits
>
> Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

I think Shayne's s-o-b should follow the Co-developed-by line.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

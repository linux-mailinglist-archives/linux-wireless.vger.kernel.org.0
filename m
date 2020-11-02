Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008F32A2F56
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKBQIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 11:08:07 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46895 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbgKBQIG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 11:08:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604333286; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0UCpEuMOoCHB1MG1en0aAbbu7QfLzWhBLrgBOS21emM=; b=pMI0T+Tm5DUF/BMCIqNHzt14bRpQg5sNmgyLIOWw19375EP0OBjTEfEr7RDaRdricx30DruK
 ubbvf7ZOjr4GtOBDNdkJQWOrwJC1uWEpFiYykwhnP+la2ax2SPbX2FoqmnX6EsrOl0J/05Fg
 JmLl8NSzCPOyjO6/Vi52nUB/NRs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fa02eaf1037425ce1c4ca5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 16:07:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1F64C3858C; Mon,  2 Nov 2020 16:07:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E825BC3852D;
        Mon,  2 Nov 2020 16:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E825BC3852D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Daisy Zhang251 <daisy.zhang251@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Daisy Zhang1 <daisy.zhang1@unisoc.com>
Subject: Re: [PATCH] cfg80211: make wifi driver probe
References: <1602833787-4206-1-git-send-email-daisy.zhang251@gmail.com>
Date:   Mon, 02 Nov 2020 18:07:02 +0200
In-Reply-To: <1602833787-4206-1-git-send-email-daisy.zhang251@gmail.com>
        (Daisy Zhang's message of "Fri, 16 Oct 2020 15:36:27 +0800")
Message-ID: <87a6vzpwt5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Daisy Zhang251 <daisy.zhang251@gmail.com> writes:

> From: Daisy Zhang1 <daisy.zhang1@unisoc.com>
>
> Register a WiFi driver of IEEE80211 WLAN for the Unisoc Marlin3
> chipsets. The following code is a simple architecture for probing
> driver.
>
> Signed-off-by: Daisy Zhang1 <daisy.zhang1@unisoc.com>

Can you clarify what this driver actually does? The commit log is very
confusing to me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

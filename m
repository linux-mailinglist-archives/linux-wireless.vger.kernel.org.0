Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039411D98A5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgESNzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 09:55:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57727 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729072AbgESNzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 09:55:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589896518; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ROfrbBaxvxLtngpQZLAh+i8K7EIg6PUQZmSZUFmNAmo=; b=bLYqDO5cwR7AwcIh+ni8U0sEEECjE+tL7+IwzMhmwqVE2/VJq+QpKLJFYq59pl+5voMzxxEX
 L91NbaV7icQ3EP8iQTJiCVUC7qAu6EOIPF/3uhT3ruDQ7cS0nDPIgXE4kncSKcRVjMJoTdkM
 0w8DPzL/e9OAXNo3Yhf+S/mEpVg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec3e5374e523733abf31da7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 May 2020 13:55:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB474C43637; Tue, 19 May 2020 13:55:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69426C433F2;
        Tue, 19 May 2020 13:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69426C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: Re: [PATCH 0/4] brcmfmac: SoftAP creation and dcmd buffer size changes
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
Date:   Tue, 19 May 2020 16:54:58 +0300
In-Reply-To: <20200519110951.88998-1-chi-hsien.lin@cypress.com> (Chi-Hsien
        Lin's message of "Tue, 19 May 2020 06:09:47 -0500")
Message-ID: <87zha4do7h.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:

> Allow SoftAP creation via ioctl from test tool; also update dcmd buffer size
> settings for new firmware. Also fix a sparse check error.

What ioctl is this exactly? Wireless drivers should be using nl80211,
not any ioctl interface.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B15225ADE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGTJIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 05:08:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17487 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbgGTJIk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 05:08:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595236120; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=R+wTlZqD00XiA38VzkMA7Og/JED+RtDCCav37iNYXKU=; b=N2PmD3oK+RiYfS45g0IMJPB28r2cX5nCtDNy6V/cXNJ6+5YvRwJA7ODuzQsusiJspe5npjYF
 60r6e+l/J78X6i9xIXztGiOAa0sVm3g/vzDRXosy/n/cJdMnWM5M6u9nVx3BxlDH0YDiKP0r
 ydau+NWTjvVPh4PUe5pa1gmOqK8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f155f17ed710aec627517e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 09:08:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CED6C43395; Mon, 20 Jul 2020 09:08:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 776FAC433CA;
        Mon, 20 Jul 2020 09:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 776FAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] rtw88: 8821c: coex: add functions and parameters
References: <20200720020924.2254-1-yhchuang@realtek.com>
Date:   Mon, 20 Jul 2020 12:08:34 +0300
In-Reply-To: <20200720020924.2254-1-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Mon, 20 Jul 2020 10:09:24 +0800")
Message-ID: <87lfje7dv1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Ping-Cheng Chen <pc.chen@realtek.com>
>
> Without this patch, RTL8821CE will not have coex support,
> and will crash the system because of the NULL pointers
> for the coex functions.
>
> While RTL8822C series are WiFi + BT combo chips, it needs
> the co-existence mechanism for the device to work on both
> WiFi and BT without interfering each other. And the coex
> support has already been added before, most of the mechanisms
> are implemented. The driver should just add corresponding
> functions to operate on different types of chips and its
> coex parameters.
>
> Fixes: f745eb9ca5bf ("rtw88: 8821c: Add 8821CE to Kconfig and Makefile")
> Signed-off-by: Ping-Cheng Chen <pc.chen@realtek.com>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

What changed from v1?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

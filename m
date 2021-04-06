Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C635508F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 12:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhDFKLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 06:11:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51574 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhDFKLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 06:11:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617703853; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=CT4MUQeP09vQ/eL36nG57ptiWDfKZQ2azktOH/Iyv14=; b=OKKDylgTDYTqIVbSIgKuXHlGlvfr7i0Q2X1D0dkcsk5V+ahI8gpR2zTLzduJ7WvJKdMQ8vmC
 DWqL0JLCG7sySXCvDxR9ZYx1/2L3O5rBNXRGoxytfb7pOoVnEEHeLjGgAIfgi7GNNPyVG1N+
 jUky+2Dh1n5hGZh2RGZBC7b2wL4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 606c33ac8166b7eff70eeabd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 10:10:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF622C43461; Tue,  6 Apr 2021 10:10:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 45149C433CA;
        Tue,  6 Apr 2021 10:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45149C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-03-15
References: <6c132956-ef8d-6175-4a1d-bc3d4aa2e816@nbd.name>
Date:   Tue, 06 Apr 2021 13:10:48 +0300
In-Reply-To: <6c132956-ef8d-6175-4a1d-bc3d4aa2e816@nbd.name> (Felix Fietkau's
        message of "Mon, 15 Mar 2021 14:55:02 +0100")
Message-ID: <87mtuboh93.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.13.
>
> The following changes since commit 05a59d79793d482f628a31753c671f2e92178a21:
>
>   Merge git://git.kernel.org:/pub/scm/linux/kernel/git/netdev/net (2021-03-09 17:15:56 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-03-15
>
> for you to fetch changes up to 8ffdcfcd7f111f3b89975f26da11fb43a0a37eb6:
>
>   mt76: mt7921: remove redundant check on type (2021-03-15 00:07:18 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.13
>
> * code cleanup
> * mt7915/mt7615 decap offload support
> * driver fixes
> * mt7613 eeprom support
> * MCU code unification
> * threaded NAPI support
> * new device IDs
> * mt7921 device reset support
>
> ----------------------------------------------------------------

There are some issues, please fix and resend.

In commit

  baa4eda1eb50 ("mt76: mt7915: fix mib stats counter reporting to mac80211")

Fixes tag

  Fixes: c6b002bcdfa6 ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")

has these problem(s):

  - Target SHA1 does not exist

In commit

  858ec6661022 ("mt76: mt7615: fix TSF configuration")

Fixes tag

  Fixes: cd795267612d ("mt76: mt7615: support 16 interfaces")

has these problem(s):

  - Target SHA1 does not exist

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

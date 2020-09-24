Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5A2771FC
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgIXNPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:15:46 -0400
Received: from z5.mailgun.us ([104.130.96.5]:40120 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgIXNPq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:15:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600953346; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=G/pobf+eXErdOYtD3b7hJ+MdOcPjBKqHww1ZUz/A+Y0=;
 b=tuBKXzGXbtPe18fkt+CPfbtEhWnkWH3RZCutHKB05/+icVZIzCuVHaKwk6dCHh/IGDCy6oAv
 rYmp6uGnxWaoSpDyrL+mffcfDvl/Rf5eRZOkAZS2GCaeSfwTNyFTj0+9T+usyTwvXIMXE8Pz
 stKdh+8pJ5D6q9ULwVxX5ZpN5j4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f6c9becefb844e003b2296a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 13:15:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82290C433C8; Thu, 24 Sep 2020 13:15:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36986C433CA;
        Thu, 24 Sep 2020 13:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36986C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.9] mt76: mt7615: reduce maximum VHT MPDU length to 7991
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200923052442.24141-1-nbd@nbd.name>
References: <20200923052442.24141-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200924131524.82290C433C8@smtp.codeaurora.org>
Date:   Thu, 24 Sep 2020 13:15:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> After fixing mac80211 to allow larger A-MSDUs in some cases, there have been
> reports of performance regressions and packet loss with some clients.
> It appears that the issue occurs when the hardware is transmitting A-MSDUs
> bigger than 8k. Limit the local VHT MPDU size capability to 7991, matching
> the value used for MT7915 as well.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

efb1676306f6 mt76: mt7615: reduce maximum VHT MPDU length to 7991

-- 
https://patchwork.kernel.org/patch/11793855/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


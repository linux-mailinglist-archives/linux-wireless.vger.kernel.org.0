Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5E24822F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 11:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHRJuA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 05:50:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63592 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgHRJt7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 05:49:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597744198; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=OwnIeEpytJAlk8P+8p3PguRZSTUtSX3ropjdjc8xK0Q=;
 b=QRQoWA+vHU059u3S4LxrFj0rCTJFCJJGQeIuD7yMIwGLRCwbW0/PGkThOyJl6jLIXR8zoYbL
 jbod1pz15Nxtk1BbZK4Mt6HcLzqjLCytwozPvzZVhtrO6Ka1MDZ4m0vnVDw6PIEVoQPZe95Y
 tuLvTPbCo2aXvyVUQxZK2B1WErM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f3ba438d48d4625ca2330da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:49:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C99FAC43387; Tue, 18 Aug 2020 09:49:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6638BC433CA;
        Tue, 18 Aug 2020 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6638BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix VHT NSS calculation when STBC is enabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1597392971-3897-1-git-send-email-murugana@codeaurora.org>
References: <1597392971-3897-1-git-send-email-murugana@codeaurora.org>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818094943.C99FAC43387@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 09:49:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sathishkumar Muruganandam <murugana@codeaurora.org> wrote:

> When STBC is enabled, NSTS_SU value need to be accounted for VHT NSS
> calculation for SU case.
> 
> Without this fix, 1SS + STBC enabled case was reported wrongly as 2SS
> in radiotap header on monitor mode capture.
> 
> Tested-on: QCA9984 10.4-3.10-00047
> 
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

99f41b8e43b8 ath10k: fix VHT NSS calculation when STBC is enabled

-- 
https://patchwork.kernel.org/patch/11713837/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


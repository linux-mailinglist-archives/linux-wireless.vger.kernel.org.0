Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50051F612D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 07:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFKFGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 01:06:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32015 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKFGE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 01:06:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591851963; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3Y4xGDZGNHr/xseUkMzaXTFQ1cu+i+52H1OtIWdvX+8=;
 b=Nostv7GmH84haEDDurtQugATyzwByW9wUK9sAB9MQyuNfF45IF9VF3i5MVNeZVKqB9J7lQeB
 da7BqnvmXHJuxDsMWCLQHpsW/Htg8aOKO7zuZJWxyGPK/lahc00qAvRy8DjdFUlivCpMoApF
 Sns2BZr5j5LRS5qFJ0P8rIT/4Hc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ee1bbb9c76a4e7a2abf1ce3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 05:06:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B6EBC43387; Thu, 11 Jun 2020 05:06:01 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82C0AC433C6;
        Thu, 11 Jun 2020 05:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82C0AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/8] ath11k: add 6G frequency list supported by driver
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200603001724.12161-2-pradeepc@codeaurora.org>
References: <20200603001724.12161-2-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200611050601.0B6EBC43387@smtp.codeaurora.org>
Date:   Thu, 11 Jun 2020 05:06:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> This patch adds support for 6GHz frequency listing.
> 
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

8 patches applied to ath-next branch of ath.git, thanks.

c5625abaf826 ath11k: add 6G frequency list supported by driver
22eeadcdeab6 ath11k: add support for 6GHz radio in driver
5dcf42f8b79d ath11k: Use freq instead of channel number in rx path
91270d709b21 ath11k: extend peer_assoc_cmd for 6GHz band
d387503df0cd ath11k: set psc channel flag when sending channel list to firmware.
194b8ea1ce5a ath11k: Add 6G scan dwell time parameter in scan request command
bff621fd113f ath11k: Send multiple scan_chan_list messages if required
74601ecfef6e ath11k: Add support for 6g scan hint

-- 
https://patchwork.kernel.org/patch/11584701/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


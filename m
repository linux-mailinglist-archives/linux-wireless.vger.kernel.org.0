Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66622112E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGOPdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 11:33:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19426 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgGOPdv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594827231; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=+mHeKpxy4OL7A+AhGE/gf7w/mDoQNzWI30jHQuYoCN4=;
 b=Ykr/8TtaZSIslb2+d5mKQsZRsG9oXGCdkEg6Zk9dCqQoa9WEExt8XCEQGeLgmvSLMb1sJgJu
 GmmYPT65j77TeUSEjzeGMtTjl8Htj5u3Irg0yYUjUPRTpEZMjRpS9GeJx6p2OIrsPAMymexB
 DaMqphzVMxPoN4+KArSGEWIdtoU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f0f21cae3bee1251075ab07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 15:33:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5704C433CB; Wed, 15 Jul 2020 15:33:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E3FCC433C6;
        Wed, 15 Jul 2020 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E3FCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wcn36xx: Fix multiple AMPDU sessions support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715153329.B5704C433CB@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 15:33:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> Several AMPDU sessions can be started, e.g. for different TIDs.
> Currently the driver does not take care of the session ID when
> requesting block-ack (statically set to 0), which leads to never
> block-acked packet with sessions other than 0.
> 
> Fix this by saving the session id when creating the ba session and
> use it in subsequent ba operations.
> 
> This issue can be reproduced with iperf in two steps (tid 0 strem
> then tid 6 stream).
> 
> 1.0 iperf -s                                # wcn36xx side
> 1.1 iperf -c ${IP_ADDR}                     # host side
> 
> Then
> 
> 2.0 iperf -s -u -S 0xC0                     # wcn36xx side
> 2.1 iperf -c ${IP_ADDR} -u -S 0xC0 -l 2000  # host side
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

What's the difference from the earlier version:

https://patchwork.kernel.org/patch/11609871/

A changelog would be nice.

-- 
https://patchwork.kernel.org/patch/11633975/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


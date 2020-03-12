Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0AD1831BF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCLNj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:39:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47056 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbgCLNj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:39:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020367; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lpaIW9Ulayl460e89wn5dAizp25Dsv9fNkx1gbcKJhI=;
 b=l/SLhAzcIpR1vVoor2HFggrrIIKoUL84rMlKR6ARxtU9almtD0TNgi3m9wRVR7VGi+EFdT42
 xLkFLoMpKDYWk7pzwqCvbiZ3zvfWPYXdzgtMaq+fc85GG3Eap2rE7qjxd5XxJ7dzzLBQ6mkw
 hRZXYitMHdR/5p3WYEIGm+8Mkq8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3b8d.7ff2f3bc0d88-smtp-out-n02;
 Thu, 12 Mar 2020 13:39:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADCB9C432C2; Thu, 12 Mar 2020 13:39:25 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76543C433D2;
        Thu, 12 Mar 2020 13:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76543C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] qtnfmac: support WPA3 SAE in AP mode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200213114518.4415-2-sergey.matyukevich.os@quantenna.com>
References: <20200213114518.4415-2-sergey.matyukevich.os@quantenna.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312133925.ADCB9C432C2@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:39:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> wrote:

> Enable WPA3 SAE support in AP mode. Driver currently supports cards
> that offload SAE authentication to userspace. So allow userspace
> software to subscribe and to send AUTH frames. Besides, enable
> AP mode support in external_auth cfg80211 callback.
> 
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

5 patches applied to wireless-drivers-next.git, thanks.

b3860e7a3e71 qtnfmac: support WPA3 SAE in AP mode
44d09764856f qtnfmac: support WPA3 OWE in AP mode
c3d476d21851 qtnfmac: set valid edmg in cfg80211_chan_def
616f5701f4ab qtnfmac: assign each wiphy to its own virtual platform device
2d83dddf85cc qtnfmac: add interface combination check for repeater mode

-- 
https://patchwork.kernel.org/patch/11380217/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

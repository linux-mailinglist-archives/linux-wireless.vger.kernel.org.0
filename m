Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD822B58B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGWSVf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 14:21:35 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20627 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgGWSVf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 14:21:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595528495; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=j/N4OgIpS8UJZ7Blrr8EIZX5QrRY20vZgZBo/jYgApY=; b=d991mgDjk3vpPqXRzetDVJrHOTkT4no08jiMLKy5ZimmNAXMwLrTvs2MtVjAngCK1V6qt340
 7/ehbDjKhmmrBOGxeV/qX7gnOK+KwTR8AGQe4dHWRR45WUOIWD2GGV4nXCrU0y5dLOaV2Dw9
 KzCHbbbK2UEOe9XRG2bg6yUMFUI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f19d51d427cd55766bb5fa3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 18:21:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EED04C43395; Thu, 23 Jul 2020 18:21:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25907C433C9;
        Thu, 23 Jul 2020 18:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25907C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Florian Fainelli'" <f.fainelli@gmail.com>,
        "'Andrew Lunn'" <andrew@lunn.ch>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <dianders@chromium.org>, <evgreen@chromium.org>
References: <1595351666-28193-1-git-send-email-pillair@codeaurora.org> <20200721172514.GT1339445@lunn.ch> <f6d93d76-9e59-c257-9318-31c71df28018@gmail.com>
In-Reply-To: <f6d93d76-9e59-c257-9318-31c71df28018@gmail.com>
Subject: RE: [RFC 0/7] Add support to process rx packets in thread
Date:   Thu, 23 Jul 2020 23:51:08 +0530
Message-ID: <002e01d6611e$0d8ac640$28a052c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG1Bu1FBYi7G1oVhHY/01uT1gSslwJNiRkqAuFxkXipLrYw8A==
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Florian Fainelli <f.fainelli@gmail.com>
> Sent: Tuesday, July 21, 2020 11:35 PM
> To: Andrew Lunn <andrew@lunn.ch>; Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org; linux-
> kernel@vger.kernel.org; kvalo@codeaurora.org; johannes@sipsolutions.net;
> davem@davemloft.net; kuba@kernel.org; netdev@vger.kernel.org;
> dianders@chromium.org; evgreen@chromium.org
> Subject: Re: [RFC 0/7] Add support to process rx packets in thread
> 
> On 7/21/20 10:25 AM, Andrew Lunn wrote:
> > On Tue, Jul 21, 2020 at 10:44:19PM +0530, Rakesh Pillai wrote:
> >> NAPI gets scheduled on the CPU core which got the
> >> interrupt. The linux scheduler cannot move it to a
> >> different core, even if the CPU on which NAPI is running
> >> is heavily loaded. This can lead to degraded wifi
> >> performance when running traffic at peak data rates.
> >>
> >> A thread on the other hand can be moved to different
> >> CPU cores, if the one on which its running is heavily
> >> loaded. During high incoming data traffic, this gives
> >> better performance, since the thread can be moved to a
> >> less loaded or sometimes even a more powerful CPU core
> >> to account for the required CPU performance in order
> >> to process the incoming packets.
> >>
> >> This patch series adds the support to use a high priority
> >> thread to process the incoming packets, as opposed to
> >> everything being done in NAPI context.
> >
> > I don't see why this problem is limited to the ath10k driver. I expect
> > it applies to all drivers using NAPI. So shouldn't you be solving this
> > in the NAPI core? Allow a driver to request the NAPI core uses a
> > thread?
> 
> What's more, you should be able to configure interrupt affinity to steer
> RX processing onto a desired CPU core, is not that working for you
> somehow?

Hi Florian,
Yes, the affinity of IRQ does work for me.
But the affinity of IRQ does not happen runtime based on load.


> --
> Florian


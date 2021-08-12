Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC93E9EB7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Aug 2021 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhHLGmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Aug 2021 02:42:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40803 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhHLGmi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Aug 2021 02:42:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628750528; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=ra0BXwoiZ00ktzsx5gh0Tm/Akz5ZQUafOLsEvx7Rd50=; b=mGD9zFZhPsV7IhNh+PlC1SUuVAUJK9L+5GwQgnU58c79xmPNP586YI3LSITtjSKjGdoZBIP4
 IhCmLTWhMWWA3vxGJXJKfbzjiKyVriOUwWTMOj9O7XaHM0xM/YgO9YlLF90oTQehMewIFmpY
 D/4JEzvxFaZpmteP2YtmqFiakxE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6114c2b1b14e7e2ecbd15af9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 06:41:53
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6256C433F1; Thu, 12 Aug 2021 06:41:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from MSINADA (unknown [98.45.135.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3263C433D3;
        Thu, 12 Aug 2021 06:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3263C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   "Muna Sinada" <msinada@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>
References: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>           <1607468044-31789-2-git-send-email-msinada@codeaurora.org>      <0f45b43c5a2dd4d0d2839487540611994ec10feb.camel@sipsolutions.net>       <000801d78e5b$55d46530$017d2f90$@codeaurora.org> <d94af0309a1c7a1dee1841580b5938898426a10b.camel@sipsolutions.net>
In-Reply-To: <d94af0309a1c7a1dee1841580b5938898426a10b.camel@sipsolutions.net>
Subject: RE: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA params
Date:   Wed, 11 Aug 2021 23:41:50 -0700
Message-ID: <000001d78f45$2234ccc0$669e6640$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEnZdCLZBNC6EG9F8ZPYUSPl+pHHAHggUnZAb6IkuACh8h3ywEBKPMIrJZ+jNA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

Please drop this patch.

Thank you,
Muna

-----Original Message-----
From: Johannes Berg <johannes@sipsolutions.net> 
Sent: Wednesday, August 11, 2021 3:07 AM
To: Muna Sinada <msinada@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA params

On Tue, 2021-08-10 at 19:48 -0700, Muna Sinada wrote:
> Hello Johannes,
> 
> I saw on your review comment that this wrapper is not needed. I wanted 
> to confirm with you if it would be ok to call a cfg80211 API from a
> mac80211 based driver, since that is what would be done if this 
> wrapper is removed.

Yes, that's fine.

>  Additionally, another reason I have this wrapper is so I can place a 
> tracepoint. What are your thoughts about this?
You already have a tracepoint on cfg80211, seems sufficient?

johannes



Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0BA41BCA1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 04:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbhI2CR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 22:17:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62327 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243048AbhI2CRz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 22:17:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632881775; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uaZB9ra4UVxF/ZwJklZQnctArUGuAc5SX7fYtLAImXE=;
 b=lHfRPixbJ+RPDnNj/1livJQzjOv6/3S6Ppj3ZIzhGxTO6eEw4KFiJpVUjhgM69BUgD2Nmtr5
 hBFm+BZ2vaKsnxBEfqbYHvtt9FWM6Xlr3B1cFa0COqqBb470QocXLmznql8vvonhAGlOHl8g
 baG3A/qPRcsWILUxOYXyhcaeh/c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6153cc52713d5d6f9659153d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Sep 2021 02:15:46
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19B60C43460; Wed, 29 Sep 2021 02:15:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FBC1C4338F;
        Wed, 29 Sep 2021 02:15:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Sep 2021 10:15:45 +0800
From:   bqiang@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: Change number of TCL rings to one for QCA6390
In-Reply-To: <87tui4pwdz.fsf@codeaurora.org>
References: <20210914163726.38604-1-jouni@codeaurora.org>
 <87tui4pwdz.fsf@codeaurora.org>
Message-ID: <42fa097a799050100b6978ef0ab4e8b8@codeaurora.org>
X-Sender: bqiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 23:12, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Baochen Qiang <bqiang@codeaurora.org>
>> 
>> Some targets, QCA6390 for example, use only one TCL ring,
>> it is better to initialize only one ring and leave others
>> untouched for such targets.
>> 
>> Tested-on: QCA6390 hw2.0 PCI 
>> WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>> 
>> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> 
> It's better? Please be more specific. Does this fix a bug or is this
> just a theoretical fix you found during code review?

Yes, this is just a theoretical fix. By "better" I mean there is no need 
to initialize
the other two TCL rings for QCA6390 since they are not used.

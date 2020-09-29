Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA727CCE8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgI2MkX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 08:40:23 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:22007 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgI2Mjw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 08:39:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601383191; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qnKjfeAqZgS/wv0jK17vPZZQ8cNXoaFEqYT3pTlsR2o=;
 b=m0URmKYMELsDzNn46tcoxwRlcafXvQzEXO+bKM5/RgKvP2bEG0Dba76Rzuz7pjgy+IapwuBS
 Z/B1Vj4+47kwR9EdcWa9lveQ9cXoqqX46xfPawx7RsyaRmZDV+8NmACRIz+eutCgPPLAJgbG
 7ZeT2K3BePj7ERCBrgge5MSFKzA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f732b1370602555f58d14cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 12:39:47
 GMT
Sender: vnaralas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BF4DC433CB; Tue, 29 Sep 2020 12:39:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9798C433A0;
        Tue, 29 Sep 2020 12:39:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Sep 2020 18:09:44 +0530
From:   vnaralas@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power
 save
In-Reply-To: <871rilf2th.fsf@codeaurora.org>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
 <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
 <871rilf2th.fsf@codeaurora.org>
Message-ID: <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
X-Sender: vnaralas@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-29 13:10, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
>> On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
>>> AP power save feature is to save power in AP mode, where AP goes
>>> to power save mode when no stations associate to it and comes out
>>> of power save when any station associate to AP.
>> 
>> Why do you think this requires a vendor command? I mean, that seems 
>> like
>> fairly reasonable - even by default - behaviour?
> 
> I have not studied the details, but doesn't AP power save break normal
> functionality? For example, I would guess probe requests from clients
> would be lost. So there's a major drawback when enabling this, right?

This AP power save feature will not break any functionality, Since one 
chain is always active and all other chains will be disabled when this 
feature is enabled. AP can still be able to beacon and receive probe 
request from the clients. The only drawback is reduced network range 
when this feature is enabled. Hence, we don't want to enable it by 
default.

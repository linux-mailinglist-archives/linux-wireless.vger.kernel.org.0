Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924693E159D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbhHENZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 09:25:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15022 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbhHENZp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 09:25:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628169931; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=Rqm82H3nLphN0crRFtYE2kconj/RynBCqWSE2rDCkeU=; b=vHMVAmt2PuzxnckOozxZWdGbGwel/Fbg63SCRGbuqYqWU1VhxX/Sc1zZKkYbYKsR2z1+Csgz
 Wau5bffdu9I3J/CR0x0EuE12uxjZ06aHuu/3pdmQUdfY7cXB3OfMKkiaYqzTTk5YEXPxw7e3
 zZ/7LMquSBBWanTdZE547YMTjSg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 610be6ca3f14248172b29274 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Aug 2021 13:25:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AA74C433D3; Thu,  5 Aug 2021 13:25:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89F66C433F1;
        Thu,  5 Aug 2021 13:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89F66C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho\, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
In-Reply-To: <CANUX_P0d0jrq9x99jM824oKOhmi0Wa5WqhECMsX=hd269H6atw@mail.gmail.com>
        (Emmanuel Grumbach's message of "Thu, 24 Jun 2021 22:56:49 +0300")
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-3-emmanuel.grumbach@intel.com>
        <87k0mji43p.fsf@codeaurora.org>
        <CANUX_P0d0jrq9x99jM824oKOhmi0Wa5WqhECMsX=hd269H6atw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 05 Aug 2021 16:25:23 +0300
Message-ID: <87sfzoc9bw.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

> On Thu, Jun 24, 2021 at 8:09 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>>
>> > iwlmei allows to integrate with the CSME firmware. There are
>> > flows that are prioprietary for this purpose:
>> >
>> > * Get the information the AP, the CSME firmware is connected
>> >   to. This is useful when we need to speed up the connection
>> >   process in case the CSME firmware has an TCP connection
>> >   that must be kept alive across the ownership transition.
>> > * Forbid roaming, which will happen when the CSME firmware
>> >   wants to tell the user space not disrupt the connection.
>> > * Request ownership, upon driver boot when the CSME firmware
>> >   owns the device.
>>
>> Vendor command requirements are documented here:
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
>>
>> The commit log is not really answering to those. For example, how a user
>> would use this? Or is there a user space tool?
>
> We intend to send those command from the NetworkManager.

I'm not really fond of the idea that NetworkManager uses nl80211 vendor
commands, sounds quite hacky to me. I would prefer that NetworkManager
uses generic nl80211 interface so that it works with every driver. But I
need to look at v4 to understand more how this all works.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

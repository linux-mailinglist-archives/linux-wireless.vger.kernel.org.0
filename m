Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683D5B03C2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfIKSjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 14:39:03 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:44599 "EHLO
        9.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfIKSjD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 14:39:03 -0400
Received: from player759.ha.ovh.net (unknown [10.108.42.75])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id B388510A779
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 20:32:35 +0200 (CEST)
Received: from awhome.eu (p57B7E67F.dip0.t-ipconnect.de [87.183.230.127])
        (Authenticated sender: postmaster@awhome.eu)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 4262A9BD64FE;
        Wed, 11 Sep 2019 18:32:31 +0000 (UTC)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1568226750;
        bh=qX5Y5CibUuOeLykiOfLjmkSRR0ryT2fWdLXAec9OBjA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mIz3QtPu5Jo+gFMtgjy2cr2XiHt6JeXafpu45EFVnNVxb3etpzYDz+RaFI9zRnX8V
         cX8wzz959Hkp1MxnrdSFbi4L+HVGp+t5HFwkrybPYGvdC42mUPYurS96KmrqZWk3P/
         goTk7/VRLl3ECg1KA7Hhfkgid+bylVsD/OEtKnV8=
To:     Kalle Valo <kvalo@codeaurora.org>, Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
Date:   Wed, 11 Sep 2019 20:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190910132315.D7AC7602F2@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4450400857231596664
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 10.09.19 um 15:23 schrieb Kalle Valo:
> Maya Erez <merez@codeaurora.org> wrote:
> 
>> Fix a race between cfg80211 add_key call and transmitting of 4/4 EAP
>> packet. In case the transmit is delayed until after the add key takes
>> place, message 4/4 will be encrypted with the new key, and the
>> receiver side (AP) will drop it due to MIC error.
>>
>> Wil6210 will monitor and look for the transmitted packet 4/4 eap key.
>> In case add_key takes place before the transmission completed, then
>> wil6210 will let the FW store the key and wil6210 will notify the FW
>> to use the PTK key only after 4/4 eap packet transmission was
>> completed.
> 
> This is rather ugly but I guess still ok. Or what do people think?
> 

I don't know anything about the driver here but in mac80211 the idea to 
avoid the race is to simply flush the queues prior deleting the outgoing 
key.

Now wpa_supplicant is not yet bypassing qdisks, but adding the socket 
parameter PACKET_QDISC_BYPASS is basically a one-liner in wpa_supplicant 
and should allow a generic way for drivers to avoid the race with a 
simple queue flush...

Alexander


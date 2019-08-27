Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5F9E399
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfH0JEZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 05:04:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 05:04:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6974A60D35; Tue, 27 Aug 2019 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566896664;
        bh=HS1OouRZhdolW8NM9h0nQjiU3lPKdOar2sWLkTzCqIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hklnlLAqmsvSOtq5T/om8QBF63iOcu7BXR6BbPH1dKiQqvI0R00QMq3ZwMwRiaFkY
         yDvRgvYZIRwGcdMEvSHv4FdjC6epE2BuIiPAk79+VWbpGq8DLkWdWSK+/xsBes+h+F
         qgEBM6UceEsYnyDV2WA9B0koy87IoDwfYwZL42Jw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B3BCE6044E;
        Tue, 27 Aug 2019 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566896663;
        bh=HS1OouRZhdolW8NM9h0nQjiU3lPKdOar2sWLkTzCqIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z+odZ4KFprdkXmC8ksOERWY0gRUlHknCnpCeMfZ0w+yI0utkR7sE99SQYqYypyMXU
         uia4IJmmH7m4YPm1wa2VmlJVQrBj0TtxKbmOhWcvA8WPDggCiKGi8qGC/x4hzBdA0p
         KE0X9egMkxKuRueOOaTWd2MHMnek++/L7I8ysgj4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Aug 2019 14:34:23 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 10/49] ath11k: add debug.c
In-Reply-To: <4441194.D8eDD6Tzdi@bentobox>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <2708501.D2hezO5Rnt@bentobox>
 <80bdedf3740960e0ce05b02a77d1b457@codeaurora.org>
 <4441194.D8eDD6Tzdi@bentobox>
Message-ID: <6622b83f754404ec05b9442027757c5e@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-27 13:05, Sven Eckelmann wrote:
> On Tuesday, 27 August 2019 09:33:39 CEST Anilkumar Kolli wrote:
> [...]
>> >     [ 4312.884650] The reading for sensor 4 is 0x002041f7
>> >     [ 4312.891499] The reading for sensor 5 is 0x002051f4
>> >     [ 4312.896415] Couldn't get reading for sensor 6
>> >     [ 4312.901189] Couldn't get reading for sensor 7
>> >     [ 4312.905561] The reading for sensor 8 is 0x002081e0
>> >     [ 4312.909902] The reading for sensor 9 is 0x002091f7
>> >     [ 4312.914645] Couldn't get reading for sensor 10
>> >     [ 4312.919364] The reading for sensor 11 is 0x0020b1fa
>> >     [ 4312.923791] The reading for sensor 12 is 0x0020c1fa
>> >     [ 4312.928621] Couldn't get reading for sensor 13
>> >     [ 4312.933425] The reading for sensor 14 is 0x0020e1f4
>> >     [ 4312.937941] The reading for sensor 15 is 0x0020f1e7
>> >     [ 4313.942700] Rebooting in 3 seconds..
>> >
>> > Maybe can be fixed by a different kernel (for the remoteproc). But I
>> > don't
>> > have this kernel at the moment.
>> >
>> 
>> The write of an "assert", sends 'WMI_FORCE_FW_HANG_CMDID' WMI command 
>> to
>> target firmware.
>> This WMI command forces the target to assert.
> 
> Yes, but it shouldn't kill the complete system.
> 
This will not kill the whole system, This will crash target and we have 
mechanism to recover the system.

Hope u have generated the crash with below patch,
https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/019-ath11k-disable-q6-recovery-to-crash-kernel.patch?h=win_ap.1.0

Please remove this patch to see the target recover after the crash.

Thanks
Anil


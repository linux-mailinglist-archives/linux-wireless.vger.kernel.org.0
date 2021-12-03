Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FAE467A55
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 16:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381804AbhLCPgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 10:36:36 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:32904 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381772AbhLCPgf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 10:36:35 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.118])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 249A11A0080;
        Fri,  3 Dec 2021 15:33:10 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E4A0F1C008C;
        Fri,  3 Dec 2021 15:33:09 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.71.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2E27013C2B0;
        Fri,  3 Dec 2021 07:33:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2E27013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1638545589;
        bh=RjdbDISN4XZGPzjCVblhcXoP3baEifjlSl3l1wr4zTw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gKkOuTeUSTLQMeY0GKL/QUClDmVYk3OWAJaDw4/393jEdbSQjUgJUIU4vhyfeZaXS
         MDLV7L6I5BXICDuZsyFruzgghchdkM3pFgm5ZmrLVN/hRub7YmE8QJpMBjux/rjMD4
         BnEo3RZi+/cBvrC9yFU/2oWr86sRRSOXdbcKghF0=
Subject: Re: [PATCH 04/11] mt76: mt7915: use nss for calculating rx-chains
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20211118164056.2965-1-greearb@candelatech.com>
 <20211118164056.2965-4-greearb@candelatech.com>
 <fc14e235-efce-514b-4f7e-8d83613eaffa@nbd.name>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <9449a4f6-fc86-23ef-0492-efa624093e41@candelatech.com>
Date:   Fri, 3 Dec 2021 07:33:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fc14e235-efce-514b-4f7e-8d83613eaffa@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1638545590-uyzzCsKHejz8
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/3/21 1:16 AM, Felix Fietkau wrote:
> On 2021-11-18 17:40, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> When group-5 is enabled, we can find the actuall NSS used.
>> In that case, update the rx chains info so that the upper
>> stack can give better idea of actual antenna usage.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
> I'm not sure this is correct. From my understanding, nss does not determine which antennas (and how many of them) are involved in receiving the signal.
> 
> - Felix
> 

I guess this would take some special knowledge of this chip and how firmware reports
the descriptor to know for sure.

Ath10k at least acts similar to how I wrote this patch....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

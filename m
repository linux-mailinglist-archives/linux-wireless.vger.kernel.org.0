Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40727754CD6
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jul 2023 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGPAAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jul 2023 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGPAAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jul 2023 20:00:33 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D2118
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 17:00:32 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 64FD0340061;
        Sun, 16 Jul 2023 00:00:30 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F3FBB13C2B0;
        Sat, 15 Jul 2023 17:00:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F3FBB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1689465629;
        bh=fEiPZ3FMcQFglGMn2iejpQZqWwaKcd+hEleVApCk4lM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=piNXzXWrgjI18l6uD3Pi2xEK7etpXTfjnzwDL1J1XhHIUrw0RmL0Dz2lsdXGLwNwG
         mBXT8ydYTti+p0yIJGZDeQoClX/45JG0kLWRYszDqlA1EEag+6bLp3y+EgFSA4IEge
         7BfiYxC/vTIBjSfrqwHM/sBsQ/HZVGI55nLKv/Lo=
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in
 mt76.h
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
References: <cover.1683930235.git.lorenzo@kernel.org>
 <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
 <486cb426-737e-fa57-20da-344fc44bb4de@candelatech.com>
 <ZLKI9tiNytMl8Vlo@lore-desk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <a168df1e-573a-43ba-b466-b7e5784dc2ff@candelatech.com>
Date:   Sat, 15 Jul 2023 17:00:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZLKI9tiNytMl8Vlo@lore-desk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1689465631-6GqKUXb52O1b
X-MDID-O: us5;ut7;1689465631;6GqKUXb52O1b;<greearb@candelatech.com>;0a45d51dfbd39c7bb3fe23128efe5de6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/15/23 4:54 AM, Lorenzo Bianconi wrote:
>> On 5/12/23 15:29, Lorenzo Bianconi wrote:
>>> mib_stats structure is shared by mostly all chipsets. Move it to shared
>>> code.
>>
>> In case this thing hasn't been pushed upstream yet, then a suggestion:
>>
>> Create a struct mt76_mib_stats_common class that has the common counters,
>> and then per-driver can have that struct as first member of its mib stats.
>>
>> I have added a lot of per-driver stats that never made it upstream
>> and are not fully shared across different drivers.
> 
> I would say mt76_mib_stats is quite a general name. I think we can do somothing
> like (if it is really necessary):
> 
> struct mt7915_mib_stats {
> 	struct mt76_mib_stats mt76;
> 	...
> };

Maybe:

struct mt7915_mib_stats {
	struct mt76_mib_stats common;
	...
};

I also noticed that Ryder added a few of my patches that extended the
stats, so I think there are probably a lot of stats in that struct
that are not set on the 7921 driver and probably older drivers too.

To me, unset stats are confusing, so I'd prefer to put stats that are mostly
common in a common struct, and have per-driver stats just found in the driver
itself.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

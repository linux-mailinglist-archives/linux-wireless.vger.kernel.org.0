Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5133F621CFB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKHT0J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 14:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKHT0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 14:26:08 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798002228E
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 11:26:07 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.118])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 900AB1A008D;
        Tue,  8 Nov 2022 19:26:05 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D93CB1C009A;
        Tue,  8 Nov 2022 19:25:59 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EA6B913C2B0;
        Tue,  8 Nov 2022 11:25:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EA6B913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1667935556;
        bh=IjdlIGM9PIIW1ik8V2pflGhZ/bQmruE9ZsCo9DfeLcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R+VuN5i2Ht/77zf5OxspSyW2o4q2lmHsqMjaoImXJvbOUzWLdo9yi5U9OtDAUsFOQ
         xCdL9GQJ5v6QiMaA3H/7+8xqj3oXojfd5g9AoiGkpaSGcdqFv/O27VoUON710g5rqq
         eV3FomPPaZFTpspvm4MvUXDdZ7H4B/zN8DhjYsDU=
Subject: Re: [PATCH 4/4] wifi: mt76: mt7915: enable coredump support
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <26aefa69d1002616412c4b00bf2e779f71ca3289.1667929344.git.ryder.lee@mediatek.com>
 <b26b285a001be954967ec77a1772a8b51faee21a.1667929344.git.ryder.lee@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f46cf0a9-c94f-aec4-1513-4b463107bbf1@candelatech.com>
Date:   Tue, 8 Nov 2022 11:25:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b26b285a001be954967ec77a1772a8b51faee21a.1667929344.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1667935566-osZEZ1SIQuvT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/22 11:02 AM, Ryder Lee wrote:
> Host triggered and catastrophic event triggered firmware core dumping
> for basic firmware issues triage, including state reporting, task/irq
> info, function calltrace and MCU memory dump.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7915/Kconfig |   1 +
>   .../wireless/mediatek/mt76/mt7915/Makefile    |   3 +-
>   .../wireless/mediatek/mt76/mt7915/coredump.c  | 409 ++++++++++++++++++
>   .../wireless/mediatek/mt76/mt7915/coredump.h  | 136 ++++++
>   .../wireless/mediatek/mt76/mt7915/debugfs.c   |   4 -
>   .../net/wireless/mediatek/mt76/mt7915/init.c  |  12 +-
>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  72 ++-
>   .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  59 ++-
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  22 +
>   .../net/wireless/mediatek/mt76/mt7915/regs.h  |  34 +-
>   10 files changed, 740 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/coredump.h

Please add a pr_err() or similar somewhere so that it is easier to see that
firmware crashed while looking at dmesg/etc.

And maybe suggestion of where to send the dump so that someone can get some
useful data out of it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


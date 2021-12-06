Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7099346A19C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhLFQrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 11:47:14 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:57638 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230445AbhLFQrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 11:47:14 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9136C1A0065;
        Mon,  6 Dec 2021 16:43:44 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ACCFE20007F;
        Mon,  6 Dec 2021 16:43:43 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.71.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8345013C2B0;
        Mon,  6 Dec 2021 08:43:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8345013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1638809023;
        bh=np4Kl8GmuBDzrnUel5OsncrVAHrzKSAOfRMvGQ5jMGo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aN2suCBu+kriULJRA2QHq0rE7QxtsS9xR4Was4e7iI3MNDItSZXPsuNLaw1cHpHzb
         heq/HMGxA6bzqDxf8RjX8/JyilganIe7DE6M6gHXUDwof/RDGK8n4AqY24faKBLU29
         R9HLiLGP7gG2605uxVf2nUM65OMVBxA0+ueVcQ6s=
Subject: Re: [PATCH] mt76: mt7915: add mu-mimo and ofdma debugfs knobs
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20211206141006.29632-1-MeiChia.Chiu@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <7158a937-57f3-2bd8-591e-124a18d2d8e8@candelatech.com>
Date:   Mon, 6 Dec 2021 08:43:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211206141006.29632-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1638809025-cW1BdMLclNrt
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/6/21 6:10 AM, MeiChia Chiu wrote:
> From: MeiChia Chiu <meichia.chiu@mediatek.com>
> 
> Add mu-mimo and ofdma packet counters statistics.

Hello,

Are these stats clear-on-read in the firmware?  If so, then we need to accumulate
them in the driver.

Is there any significant downside to enabling the stats?  For instance, a performance
degradation in the firmware/hardware?

Thanks,
Ben

> 
> Reviewed-by: Money Wang <money.wang@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7915/debugfs.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++-
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c     |  41 ++++++++
>   .../net/wireless/mediatek/mt76/mt7915/mcu.h     |  45 +++++++++
>   .../net/wireless/mediatek/mt76/mt7915/mt7915.h  |   3 +
>   4 files changed, 330 insertions(+), 1 deletion(-)
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

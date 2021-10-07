Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9824260CB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 01:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhJGX6G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 19:58:06 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:34324 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233133AbhJGX6F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 19:58:05 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 19:58:05 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D8F2125C6A
        for <linux-wireless@vger.kernel.org>; Thu,  7 Oct 2021 23:50:44 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.131])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 87C8A2005E;
        Thu,  7 Oct 2021 23:50:43 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1038E980068;
        Thu,  7 Oct 2021 23:50:42 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 47EA913C2B0;
        Thu,  7 Oct 2021 16:50:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 47EA913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1633650642;
        bh=T6vwDbx+pV/hvMObb7NO5tmpk+mAlu0GxmSe7c+x770=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iM9hpCjHp60OvIAgXA+5DhDX29oHTVCVya2oVGpoDLbaWs/jaypqjtvU2utVG+lzD
         Y+aO0wz9Sg4JsPf4UbgZdtyH4EsKlczxrsViRovmHZPBzZofI0S48gvc9EpDgXW84P
         HYKVPBoyAGT21G4Lyxdp1RkdWugLj0HkxPr2lWzI=
Subject: Re: [PATCH v5 1/8] mt76: mt7915: introduce
 mt7915_mcu_beacon_check_caps()
To:     Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20211001095355.10598-1-shayne.chen@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <dbe9af7e-dd5a-827b-aedc-c0fa767faf05@candelatech.com>
Date:   Thu, 7 Oct 2021 16:50:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20211001095355.10598-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1633650644-XrS8nWtV6ccy
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/1/21 2:53 AM, Shayne Chen wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Beacon elements might be changed by hostapd configuraion, so driver
> should compare both IEs and PHY capabilities to get the least common
> denominator before association.
> 
> Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
> v2: modify condition for mimo_dl_en
> v5: rebase to staging tree

Have you tested this in station mode?  I tried merging this into my tree
and it broke station mode.  Symptom was that it associated, but could not
get DHCP.  It worked if I disabled AX mode and made it associate as 11ac.

I think root cause is probably that the beacon is never set in STA mode,
but the code building the MCU messages are unconditionally looking at
the values derived from the beacon caps when making decisions about bfer/bfee
and ldpc and such.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


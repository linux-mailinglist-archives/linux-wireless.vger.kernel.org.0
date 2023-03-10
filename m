Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF96B32EA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Mar 2023 01:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJAuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 19:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJAue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 19:50:34 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF92125B5
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 16:50:32 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B66FEAC007F;
        Fri, 10 Mar 2023 00:50:29 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E9B5213C2B0;
        Thu,  9 Mar 2023 16:50:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E9B5213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678409429;
        bh=EJVz+TdW6NbIT299nfmymNsW/oWJlLvv8nx9PWrZf5o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IHYTV6jHESZccrd7gdQoaK0DYMFw/Cr8XtLPj8b0gyBT6dJJ5kwmHLp+tUQ1dda4v
         +jFE16DHevvR1Zr738s1dStf9LuB7vRu8PwHqWY3YkUtgNXHOwwl0YFwVFOw1DTOzK
         kPU+49zzlEOLcF2UIhbCA1y9f0J+i0/b0fadi6yo=
Message-ID: <79728d21-400d-d294-f48e-a2ee091869bf@candelatech.com>
Date:   Thu, 9 Mar 2023 16:50:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] wifi: mt76: mt7921: use driver flags rather than
 mac80211 flags to mcu
Content-Language: en-US
To:     Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <0c2eed5226aef8e7e219c748b9d20cb234cf9f8f.1678186986.git.deren.wu@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <0c2eed5226aef8e7e219c748b9d20cb234cf9f8f.1678186986.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1678409431-Xzc1GRKUxN6I
X-MDID-O: us5;ut7;1678409431;Xzc1GRKUxN6I;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/7/23 03:22, Deren Wu wrote:
> From: Neil Chen <yn.chen@mediatek.com>
> 
> FIF_* flags from mac80211 is not ABI. mt7921 should not pass it into mcu
> directly. Remap FIF_* to driver defined flags as mcu command input.
> 
> Fixes: c222f77fd421 ("wifi: mt76: mt7921: fix rx filter incorrect by drv/fw inconsistent")
> Signed-off-by: Neil Chen <yn.chen@mediatek.com> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>

I tried this plus the patch it is fixing on 6.2.2+ kernel with 7922 radios,
and behaviour seems worse than before the two patches were applied.

Original problem I was trying to fix is that my STAs will connect fine on 5Ghz,
but then when I try to move them to 2.4Ghz, most will not scan anything.
Packet sniff shows probe responses and requests, so I suspected firmware is
filtering when it should not.

With the two patches applied, even 5Ghz is showing failure, with lots of
beacon loss messages (I am disabling beacon filtering, which previously worked
fine on 7921 nic in 5.19 kernel).

Are there other patches that I should consider to get 7922 to work better in 6.2.2+
kernel?

[root@ct523c-3b7f ~]# cat /debug/ieee80211/wiphy0/mt76/version
chipset:       7922
ASIC-Revision: 0x79220010
hw_sw_ver:     0x8a108a10
build_date:    20221227123154a
bus:           0000:04:00.0
fwcfg:         fwcfg-mmio-0000:04:00.0.txt
WM-hw_sw_ver:  ____000000
WM-build_date: 20221227123243
WA-hw_sw_ver:
WA-build_date:


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



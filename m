Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08354F335
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380672AbiFQIkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381174AbiFQIkL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:40:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C4369B5B
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Akty9E+4cwobC/kYyekXkzh/9JPXGz5SU1JwQ8OtfU=; b=nU3KQEiw7kM/xNShDAc8aV1N8q
        i7Ait6136VZG9uLOfQsrrkYpMrmEJu3SuNho2GalR6AwRVxF2iWCsKeM7eCcvYwmFtPVp0VwuwpNh
        0deOXzmvaTPElPbQr3BstPzQpQehD9aRjXfe3Ndo9c04e8q5U2kyX8TtOd/wKNu/tzpE=;
Received: from p54ae95bf.dip0.t-ipconnect.de ([84.174.149.191] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o27Vt-0004hM-WB; Fri, 17 Jun 2022 10:39:34 +0200
Message-ID: <b7e3006a-03a9-fad6-3f57-10aed678f211@nbd.name>
Date:   Fri, 17 Jun 2022 10:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] mt76: mt7921: fix aggregation subframes setting to HE max
Content-Language: en-US
To:     Deren Wu <Deren.Wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <7f5145276d732cb4aebcbffd6fc4a5eb852dd3be.1655393246.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <7f5145276d732cb4aebcbffd6fc4a5eb852dd3be.1655393246.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.06.22 17:57, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> mt7921/mt7922 support HE max aggregation subframes 256 for both tx/rx.
> Get better throughput then before.
> 
> Fixes: 94bb18b03d43 ("mt76: mt7921: fix max aggregation subframes setting")
> Tested-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Reviewed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
When I made the change that you're reverting here, I used the values 
from the reference SDK that I got, and the change actually seemed to 
improve performance in my tests.
Did something change in the firmware, or is there a related chipset 
difference between 7921 and 7922?

- Felix

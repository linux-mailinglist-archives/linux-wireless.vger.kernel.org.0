Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F770508670
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377849AbiDTK5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbiDTK5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 06:57:05 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4C403FD
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ByaG4RWHCrXJDRCrH0eRM21F8h0r29Z2Sw9BM35Ne/s=; b=fJf0utWWMZOnO46t5IYlh2dIKz
        18ZIHcrqj5oEGNdTeuh8aGBtlcxCwOv9NznRe3WkjMCx7/RMa/qzWkyyWsOC4O7JcCLv5PXGkfCNu
        PjxPt25wT+K39LOj+nQCdwhCwcdrdBHt6MfKgApfQF/IlACSeNPupL8lGo/LboIR7LE0=;
Received: from p200300daa70ef200009e86881025829d.dip0.t-ipconnect.de ([2003:da:a70e:f200:9e:8688:1025:829d] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nh7yQ-0005OS-B0; Wed, 20 Apr 2022 12:54:14 +0200
Message-ID: <90e39a67-b765-1c88-384c-9a7873274163@nbd.name>
Date:   Wed, 20 Apr 2022 12:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] mt76: fix antenna config missing in 6G cap
Content-Language: en-US
To:     Deren Wu <Deren.Wu@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
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
References: <357763fe0b112838d500422a27b114b4281adb9a.1649511465.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <357763fe0b112838d500422a27b114b4281adb9a.1649511465.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09.04.22 15:44, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> To make sure we have the proper antenna config in 6g cap,
> move IEEE80211_VHT_CAP_[T/R]X_ANTENNA_PATTERN to stream init.
> 
> Fixes: f1103fa6b3492 ("mt76: add TX/RX antenna pattern capabilities")
The fixes line is wrong, since that commit is older than 6G support in 
mt76. I will change it to this instead:
Fixes: edf9dab8ba27 ("mt76: add 6GHz support")

Thanks,

- Felix

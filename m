Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4332152D7CD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiESPe1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiESPdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 11:33:36 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B836EB2A
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=VXKRNmlYsQ9lj/JBQ2sUU2Yg3wYqbJJEgqqLiKrZpcI=; b=goP4Zhrh57qnXNonS0OqumCV3y
        q9rOgCnV93bntFFJcLW9/bXtOJU/U089/4jev0SHsww8BHJKmNXW+2YZfu6w24SCmQ7srOrnQ9E14
        4g5HOacAjPRaZgiu+K8m35tJnXEkCmXPLozITrFSgFz+3qqDkXIsomccL95jz4ovZoAg=;
Received: from [217.114.218.28] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nri93-0001rs-Vg; Thu, 19 May 2022 17:32:58 +0200
Message-ID: <1a399493-bfa5-b40d-a430-c7f3cdd328fb@nbd.name>
Date:   Thu, 19 May 2022 17:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
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
References: <cover.1652941276.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 0/3] introduce BIOS SAR support
In-Reply-To: <cover.1652941276.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19.05.22 08:38, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> Introduce BIOS SAR support for mt7921 serials.
> 
> Deren Wu (3):
>    mt76: add 6G band support in mt76_sar_freq_ranges
>    mt76: mt7921: introduce BIOS SAR support
>    mt76: mt7921: introduce BIOS SAR config in tx power
Please replace BIOS with ACPI throughout the patch.

Thanks,

- Felix

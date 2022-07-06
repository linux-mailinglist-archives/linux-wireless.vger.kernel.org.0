Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED25688D6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jul 2022 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiGFNBO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jul 2022 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiGFNBN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jul 2022 09:01:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431713F55
        for <linux-wireless@vger.kernel.org>; Wed,  6 Jul 2022 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ndoPYQl5phK8tHt13nq9IJYJYv7E+XvLq6IbZ9sJpXM=; b=oFkjtNg8mrZAEIJvRse5kXsAg/
        grePMbfX0Bro9zPMJZa14N+8duYXXT+eadSinKgi8p01/V/x+qaPRB9D9nOg43wKs1JqfVA61gorp
        Ol9es4aSVpHqxxZnTFb67Z1nfPL2qkfDH7fHnIsY+6IBjdY+XhgBoombgZ5w/twWIeo8=;
Received: from p4ff132a0.dip0.t-ipconnect.de ([79.241.50.160] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o94eS-0006O3-LQ; Wed, 06 Jul 2022 15:01:08 +0200
Message-ID: <a4b4539e-759f-f8db-0e17-de0b07dc8190@nbd.name>
Date:   Wed, 6 Jul 2022 15:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] mt76: address4 null frame using fixed rate to trigger WDS
Content-Language: en-US
To:     Lian Chen <lian.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20220706090901.88929-1-lian.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220706090901.88929-1-lian.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 06.07.22 11:09, Lian Chen wrote:
> From: "lian.chen" <lian.chen@mediatek.com>
> 
> WDS function need address4 package to trigger the AP create wlan0.sta.
> while the address4 null frame is sent at a high rate.
> the AP can not receive it.
> so, using fixed rate to trigger WDS flow.
> 
> Signed-off-by: lian.chen <lian.chen@mediatek.com>
I think it might make more sense to set IEEE80211_TX_CTL_USE_MINRATE in 
the mac80211 function ieee80211_send_4addr_nullfunc().

- Felix

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BB686B22
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 17:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjBAQHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBAQHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 11:07:39 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0009265EE8
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VpHbTMyuGBdjvn+2lgzn+7pdm9u//Jy8FpkNkUYizn0=; b=sevUWYGqtV/jGcd5O4CoDb5GpM
        hwd84qSFRDN+6EXY3V5O34iluSQdMjETEwvRR+ax4LynpZ9uhVjWy0EfOZrfZOji8NBiXK60hQIA1
        nJlVIF8nkWzpAFHIhnHNj2i1FHcGACPO0AC6hVBlO59yU8ongtZjl+dwU00Advqqs6F8=;
Received: from p200300daa717ad0031deeb80938bfca5.dip0.t-ipconnect.de ([2003:da:a717:ad00:31de:eb80:938b:fca5] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pNFdq-004CvW-Bo; Wed, 01 Feb 2023 17:07:22 +0100
Message-ID: <d6244fd6-62bd-ba07-fe18-dee559594ece@nbd.name>
Date:   Wed, 1 Feb 2023 17:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] linux-firmware: update firmware for MT7916
Content-Language: en-US
To:     Shayne Chen <shayne.chen@mediatek.com>,
        Josh Boyer <jwboyer@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-firmware <linux-firmware@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20221123110743.22005-1-shayne.chen@mediatek.com>
 <20221123110743.22005-2-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20221123110743.22005-2-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23.11.22 12:07, Shayne Chen wrote:
> This patch updates firmware files v211120221031 for MT7916 WiFi NIC.
> 
> Signed-off-by: Shayne Chen<shayne.chen@mediatek.com>
More and more users are complaining that this firmware update introduces 
a regression of not being able to support 5 GHz and 6 GHz together 
anymore. Apparently the EEPROM data needs to be patched to limit support 
to one of the two bands, otherwise both don't work.
Switching at runtime apparently doesn't work without a firmware restart.

Is there any chance we could get a firmware that fixes this bug?

Thanks,

- Felix

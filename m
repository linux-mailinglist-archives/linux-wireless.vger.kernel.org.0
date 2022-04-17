Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BC550488C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiDQRFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiDQRFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 13:05:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E7366A3
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qcx0pxg3THp8SuY+6GUJd6UIv75TzlSrayGTu93JS8A=; b=RuQm7Dada5kfMyMugvlST2sGyR
        0cxUGnwttyWM5awLO/3NBSsNJm1kLmwfkY6S70R35mH6K2mwO0SKbFKX64YQzDX3sBfp9L2xRe93p
        yzxNEppML2QrmJoZgQ6FhEmeusDMxGzDRP2feCiUF3yHj0Q6T/EZatGSZozIT3wVLDA8=;
Received: from p200300daa70ef200ac595ede6c5152ba.dip0.t-ipconnect.de ([2003:da:a70e:f200:ac59:5ede:6c51:52ba] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ng8IB-0004qo-NE; Sun, 17 Apr 2022 19:02:31 +0200
Message-ID: <5ed02d6d-f4ae-3cea-f2c5-8bfa2f4b5eb1@nbd.name>
Date:   Sun, 17 Apr 2022 19:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ath9k: fix QCA9561 PA bias level
Content-Language: en-US
To:     =?UTF-8?Q?Thibaut_VAR=c3=88NE?= <hacks+kernel@slashdirt.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>
References: <EC4F8380-4725-441D-B3FF-8CD7048F2236@slashdirt.org>
 <20220417145145.1847-1-hacks+kernel@slashdirt.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220417145145.1847-1-hacks+kernel@slashdirt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17.04.22 16:51, Thibaut VARÈNE wrote:
> This patch fixes an invalid TX PA DC bias level on QCA9561, which
> results in a very low output power and very low throughput as devices
> are further away from the AP (compared to other 2.4GHz APs).
> 
> This patch was suggested by Felix Fietkau, who noted[1]:
> "The value written to that register is wrong, because while the mask
> definition AR_CH0_TOP2_XPABIASLVL uses a different value for 9561, the
> shift definition AR_CH0_TOP2_XPABIASLVL_S is hardcoded to 12, which is
> wrong for 9561."
> 
> In real life testing, without this patch the 2.4GHz throughput on
> Yuncore XD3200 is around 10Mbps sitting next to the AP, and closer to
> practical maximum with the patch applied.
> 
> [1] https://lore.kernel.org/all/91c58969-c60e-2f41-00ac-737786d435ae@nbd.name
> 
> Signed-off-by: Thibaut VARÈNE <hacks+kernel@slashdirt.org>

Acked-by: Felix Fietkau <nbd@nbd.name>

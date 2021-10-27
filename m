Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14543C2E6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhJ0GY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 02:24:29 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53990 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbhJ0GY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 02:24:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635315724; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=ps8/xgtg5gAKrPPoVBISwY+vty6tFr8afONeYrw77Eg=; b=JLxAOUv9zx5v4qKh0ScFm/alPbN0icdTi6NOAsig/p1zk0E6arh4ClfmEXKH6TxRle2iLI4r
 5yK43cidtyQgOWH/phG/PR13gPkPt5R5A1JyzvMJHgI4F9FVQpMJBtRzYUsAXeUWkGRffclL
 8nxbOI0pSUEX+E3hMyCx1+kCpiY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6178ef9a321f2400513e92fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 06:20:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7AB5C43617; Wed, 27 Oct 2021 06:20:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 253AFC4338F;
        Wed, 27 Oct 2021 06:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 253AFC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7663s: fix link error with CONFIG_PM=n
In-Reply-To: <20211026083326.3421663-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Tue, 26 Oct 2021 10:33:09 +0200")
References: <20211026083326.3421663-1-arnd@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 27 Oct 2021 09:20:03 +0300
Message-ID: <874k939egc.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The generic register access functions are compiled conditionally,
> causing a link failure in some randconfig builds:
>
> ERROR: modpost: "mt76_connac_mcu_reg_wr" [drivers/net/wireless/mediatek/mt76/mt7615/mt7663s.ko] undefined!
> ERROR: modpost: "mt76_connac_mcu_reg_rr" [drivers/net/wireless/mediatek/mt76/mt7615/mt7663s.ko] undefined!
>
> Move them out of the #ifdef block.
>
> Fixes: 02fbf8199f6e ("mt76: mt7663s: rely on mcu reg access utility")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Felix already submitted an identical patch:

https://patchwork.kernel.org/project/linux-wireless/patch/20211023112407.26448-1-nbd@nbd.name/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

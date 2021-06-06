Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7A39CDEE
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jun 2021 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFFHxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Jun 2021 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFFHxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Jun 2021 03:53:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A9C061766
        for <linux-wireless@vger.kernel.org>; Sun,  6 Jun 2021 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m4mfxV1cLh/U8mnTVlqg6bh+DS71kDcuBuvTfogr+e0=; b=sVg3hDUJodNb+TqZiAyXadK1q6
        4WaPA2GD32T2DcaMbZin+St2N80Y4wu0nUJyl4LdK8JR20wCuSce1opDcj8vrKjwGK8gWtvVM22wP
        Cp+WuTqxlSusUJ4lGiSg2HYej+uPsFmmmVTM2MBPtlP4NqNCJem9dxkh+g0V96BTJtv0=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lpnZ6-0007eZ-AY; Sun, 06 Jun 2021 09:51:24 +0200
Subject: Re: [PATCH] mt76: mt7921: enable VHT BFee capabiliity
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
        Stella Chang <Stella.Chang@mediatek.com>, jemele@google.com,
        yenlinlai@google.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <a5748514496b2b4e4b23be7b0b560d2585feafb6.1622627260.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <3bbdab20-60be-61fb-d731-5cf5d04f7f3c@nbd.name>
Date:   Sun, 6 Jun 2021 09:51:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a5748514496b2b4e4b23be7b0b560d2585feafb6.1622627260.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-02 17:17, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> enable BFee functions with proper BFee IEs
> 
> Tested-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
> Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
I've sent out a much simpler replacement for this patch, please take a look.

- Felix

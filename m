Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D95459047
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 15:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbhKVOg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 09:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbhKVOgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 09:36:55 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A91C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gS+N4akZ/XZOqsmtrfiHmr57eg/++9zj6ceGNTomSn0=; b=dcUPzf2h59Vc+G90WrB4T0LfVP
        UfJAKSSGadSWZymmTg95Z5MbyQVsGFqiOc7AIXWWhQ3d8KwRTJ3ellR1LJjBVHkLP87fQShN3MXDg
        EqgPA/6pHIan2Cqmlw5RfuPBjyYgPM7AP/8o5k+BDoUeY3IJQQE1sj8CSJJ6K7PYYh1w=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mpAO5-0005vJ-Q3; Mon, 22 Nov 2021 15:33:41 +0100
Message-ID: <262c146e-8c75-be20-54c0-2a20158c1473@nbd.name>
Date:   Mon, 22 Nov 2021 15:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] mt76: mt7921: fix timestamp check in tx_status
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
References: <934b51921e22ca6f8983d7cbd9feb5248f804303.1637590567.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <934b51921e22ca6f8983d7cbd9feb5248f804303.1637590567.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-22 15:25, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> Should keep SKBs only if timeout timestamp is still after jiffies.
> Otherwise, report tx status and drop it direclty.
> 
> Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Please drop the "mt7921: " from the subject, since it affects all 
drivers. Other than that, the patch looks good. Thanks!

- Felix

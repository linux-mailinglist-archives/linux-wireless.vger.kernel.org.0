Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDEE3ACFA0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFRQDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhFRQDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 12:03:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033DC061574
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L5tfF3qUoHfVzNZ9MEHYgKJJQ+VE6dPfO4oGXHMtAWo=; b=F+ZKs2RnAFTU/GvH1sKRP8UqAL
        APgOHVk4xD9sB7hFA1shc4xqfiVX86gVt0ETEUvxHGQx1yANf2xFQeQcIQLQU1UG9hC3s4r1WjEZW
        cd1jwCXrEv3dPmdoVgNh3SLc0MwP89NSoBokdtieSvrRq3GuUQytvaCsthNOmHIVSXXs=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1luGvu-00075O-LD; Fri, 18 Jun 2021 18:01:26 +0200
Subject: Re: [PATCH] mt76: mt7921: introduce PCIe ASPM support (L0s/L1/L1ss)
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
References: <eb6e8c6b45f3a8a71e9cff95108aff64d560cdc0.1623465371.git.deren.wu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <44283e4b-31ed-399e-699f-c2567bf10c32@nbd.name>
Date:   Fri, 18 Jun 2021 18:01:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb6e8c6b45f3a8a71e9cff95108aff64d560cdc0.1623465371.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-12 04:59, Deren Wu wrote:
> From: Deren Wu <deren.wu@mediatek.com>
> 
> for better power consumption, default enable PCIe ASPM
> 
> Tested-by: Leon Yen <Leon.Yen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
This seems to be duplicating functionality from drivers/pci/pcie/aspm.c
I think the driver shouldn't need to touch this, maybe it is enough to
remove the mt76_pci_disable_aspm call and enable ASPM in the kernel config?

- Felix

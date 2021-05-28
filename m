Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17955393F0C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhE1I6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbhE1I6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 04:58:21 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B149C061574
        for <linux-wireless@vger.kernel.org>; Fri, 28 May 2021 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SpSfsBsII+1PKcjb/5Zuio6S2J479RKFh2z8FdE5ebI=; b=Ew/PJBygVPiHSXendy1ZGj+/Sk
        XMRQpyBY3XBLrPBFP8i05QGUQ9XsDcceeaCcwDeBm2fIh3PfrPKOEaUjJ5X0Vb2XkCD2XcUwaBvzR
        QEoCPR6Xib9fvyK9BqM97Rg4nxhbQESc9LTl8cc1AsBwQb26ORPuHEZJ1cCsrFxdssCM=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lmYIJ-0003fd-5F; Fri, 28 May 2021 10:56:39 +0200
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20210504125225.2536-1-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] mt76: mt7915: add debugfs knob to read efuse value from
 FW
Message-ID: <32908981-c864-aa13-b182-8081610baa9c@nbd.name>
Date:   Fri, 28 May 2021 10:56:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210504125225.2536-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-05-04 14:52, Shayne Chen wrote:
> In efuse mode, mt7915 only reads efuse values from FW which driver need.
> Add a debugfs knob to read addtional efuse values from a specific field,
> which is useful in some cases such as checking if rf values in efuse
> are properly burned.
> 
> An example of usage:
> echo 0x400 > efuse_idx
> hexdump -C eeprom
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
I'd prefer if we read the entire efuse and put it in a "otp" debugfs
file, like on older chips.

- Felix

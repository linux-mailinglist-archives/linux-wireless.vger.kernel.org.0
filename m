Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E13EB3E4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhHMKPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbhHMKPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 06:15:41 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF17C061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EwBDn+MmZXsf2retNthI5UkmLCBolXZWJ/auLbis7XI=; b=emVUoEH4fQBscl4npECKzQRThY
        N1Qrb5YdQWpvAL8IUDrYISnYxdL66bqVXsao4YjlNp1GsTmRL0bt6xCneVmdwr2VNm1z7HhceG806
        igwYVsocgJ8It/V9QYrPUidnYug2eDAQ8vtJDMf9okWJJu2XgH59vWPfOTvDw2aZFPjU=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEUDN-00069Y-EJ; Fri, 13 Aug 2021 12:15:01 +0200
Subject: Re: [PATCH v4 1/2] mt76: mt7915: fix hwmon temp sensor mem
 use-after-free
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ben Greear <greearb@candelatech.com>
References: <9f5b0cf6c4296d3a9e78a95516cf26d1db4baba9.1627696765.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <04c61f83-e4ce-536f-7030-9050d8edfe78@nbd.name>
Date:   Fri, 13 Aug 2021 12:15:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9f5b0cf6c4296d3a9e78a95516cf26d1db4baba9.1627696765.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-07-31 04:17, Ryder Lee wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Without this change, garbage is seen in the hwmon name
> and sensors output for mt7915 is garbled.
Where does the use-after-free bug come from? It's not obvious to me why
using KBUILD_MODNAME instead of wiphy_name() fixes it.
I still think the phy name should probably be part of the prefix.

> With the change:
> 
> mt7915-pci-1400
> Adapter: PCI adapter
> temp1:        +49.0°C
> 
> Fixes: d6938251bb5b (mt76: mt7915: add thermal sensor device support)
The format is wrong (missing quotes), and the hash references a commit
that's not in any upstream tree.

- Felix

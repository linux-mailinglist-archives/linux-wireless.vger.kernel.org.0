Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00435C8D8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhDLOfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbhDLOfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 10:35:47 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04204C061574
        for <linux-wireless@vger.kernel.org>; Mon, 12 Apr 2021 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=toq0q2Pc+hYbxLquSM14b70SsyEBkW+k389b+Y6cpOY=; b=swfURh6WQrC4Got0sHj/1tvW/1
        +S8qgbmyo9J1rwle8j5k7Gdxvo7v879+tAbL4TumEtD8ZTc6LvU8x2/mvMg1zkNcypqBqesXxSXca
        LMBgoWNjRrnL9fuyp4ya/SwOvJSn5uVG10eeOMhdbOk2Hf+XSIfriQOI+Rtg5lnuFcuk=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lVxew-0003xp-GT; Mon, 12 Apr 2021 16:35:26 +0200
Subject: Re: [PATCH] mt76: mt7921: remove 80+80 MHz support capabilities
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20210411104751.24103-1-nbd@nbd.name>
 <18627505ec45f8e5a0e424c3f3f9ca204cb1830c.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <3a8e0269-cf1b-e77f-086e-15c9c1e3a2aa@nbd.name>
Date:   Mon, 12 Apr 2021 16:35:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <18627505ec45f8e5a0e424c3f3f9ca204cb1830c.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-12 14:45, Johannes Berg wrote:
> On Sun, 2021-04-11 at 12:47 +0200, Felix Fietkau wrote:
>> This mode is not supported by the hardware
>> 
> You say this "mode" (singular), and the subject says "80+80",
> 
>> -		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
>> -		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
> 
> but you proceed to also remove 160, was that intentional?
Yes. 160 MHz isn't supported and no capability was set for it either.

- Felix

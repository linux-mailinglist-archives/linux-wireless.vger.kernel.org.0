Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3420458548
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhKURQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKURQ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 12:16:58 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B92BC061574
        for <linux-wireless@vger.kernel.org>; Sun, 21 Nov 2021 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CEwcKOCTBD62Flf+A+wHLhM0ZeEGpWIW4/OgmHyinXc=; b=tokMm+gSsC/QIVMh7ftdwTXxrA
        zoGJhR0QPmuV1Kc5OKzMgo/YH0Y1jirm2RavanI7t3Evx7Rrs9xsVWbBwtCvO7S1rrI/cUVS0JKOU
        nqtqzQLGLmFzJ8s56geB7Ey+NFVsjwYgkDQNANkJqykJJcWZEMwbTFhTyPWc2yFahCBc=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1moqPS-0002kN-AY; Sun, 21 Nov 2021 18:13:46 +0100
Message-ID: <6b7327f2-4e29-ed23-cfcf-7d2e012c19a4@nbd.name>
Date:   Sun, 21 Nov 2021 18:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] mt76: mt7915: fix NULL pointer dereference in
 mt7915_get_phy_mode
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
References: <ddae419a740f1fb9e48afd432035e9f394f512ee.1637239456.git.lorenzo@kernel.org>
 <YZeFx0s8HUNtaODw@lore-desk> <87y25kcpcz.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <87y25kcpcz.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-11-19 13:16, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>>> Fix the following NULL pointer dereference in mt7915_get_phy_mode
>>> routine adding an ibss interface to the mt7915 driver.
>>
>> Hi Kalle and Felix,
>>
>> I guess we can apply this patch in wireless-drivers tree since the issue is
>> already in Linus's tree. What do you think?
> 
> Yeah, I agree that this should go to wireless-drivers. Felix, ack?

Sure!

Acked-by: Felix Fietkau <nbd@nbd.name>

- Felix

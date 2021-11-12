Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0812144E5C4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhKLLzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 06:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhKLLzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 06:55:41 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A2C061766
        for <linux-wireless@vger.kernel.org>; Fri, 12 Nov 2021 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Z7UVge4oAfupyRsAkMMB5dJhahHzHNxbOi2lNb0kE8=; b=pihKnAr7tXPDpRZvyNwzYzUNSa
        wDMjaCBSpt2ItB5dov95kQllx/jpLcyH8B8ZcrCFtn8oqraP5pPmfaiOAP62NP+FZPZykkOfUA/Lh
        horuRffjNOr896DnVm94RXkl1qmJ6p2mCPv4+rMxf40IKmfKPdnZtWxn97cmrfUrhz9o=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mlV6q-0003ZF-Ps; Fri, 12 Nov 2021 12:52:44 +0100
Message-ID: <9b087a78-fb5f-40f4-378b-77ca53de3aab@nbd.name>
Date:   Fri, 12 Nov 2021 12:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2] mt76: do not pass the received frame with decryption
 error
Content-Language: en-US
To:     Xing Song <xing.song@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20211110025404.174080-1-xing.song@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20211110025404.174080-1-xing.song@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-10 03:54, Xing Song wrote:
> Drop the received frame if decryption failed and mac80211 can not
> handle it.
> 
> Signed-off-by: Xing Song <xing.song@mediatek.com>
What happens if decryption failed? Do we receive the encrypted packets?
If so, I think we should return -EINVAL only if we don't have any 
monitor mode interfaces. If monitor mode is active, we should probably 
just clear RX_FLAG_DECRYPTED instead.

- Felix

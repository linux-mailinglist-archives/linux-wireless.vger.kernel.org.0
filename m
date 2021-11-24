Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF645B707
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 09:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbhKXJBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 04:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhKXJBV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 04:01:21 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98078C061574
        for <linux-wireless@vger.kernel.org>; Wed, 24 Nov 2021 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A0hu7B/0atKyp5jXhvkcPV7H7JptGZf6Vuxd9Rl1w9w=; b=AgYlJnbKocd0+MUOwy/Gui2f/P
        RT/MH4zYymooh0XsRTg+Dr5i6/XrvqeC4asIuLNpe1ZY74UrWl1dC/DoJlVcsH25LelNE9A3Mwn7m
        L2yXA3X6BarizxGdAPt0NzvFeK7cyNRLOMNSPTlaG7vYqfbtOe4l8cj9GQkNDeyJxl9o=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mpo6Q-0000sR-1h; Wed, 24 Nov 2021 09:58:06 +0100
Message-ID: <27634215-bc2a-aca8-a83f-dfbd7a543570@nbd.name>
Date:   Wed, 24 Nov 2021 09:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
 <875ysi6kop.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <875ysi6kop.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-24 09:07, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>> Fix a possible idr pkt-id leak if the packet is dropped on tx side
>>
>> Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> I can take this to wireless-drivers and the patch is already assigned to
> me. Felix, ack?
Acked-by: Felix Fietkau <nbd@nbd.name>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA87490557
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiAQJnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 04:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiAQJnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 04:43:10 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A8C061574
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JM9qHGDmn/ORcA0X8J8c72MRcJINtKVnJNfaSt0Uqh4=; b=Gao0qbUisMAW45K45/jGVAhN7M
        vcq4XDgwP6IKZazAxf3v0bD0mXRdQ1EKGVCXl1539L/z008qIIjqPIpwpS02gejsTjlFBARhkQCO0
        dWDiQnjQy90qRHXi7wtt2CDBYXZWw9zPQ2r7eCjtCUGEQ3KAoMNbtSSI1nW6QMwT/9PA=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n9OXT-0003Du-Ue; Mon, 17 Jan 2022 10:43:00 +0100
Message-ID: <6ba09c09-9248-99b9-f16b-1a2421e16cac@nbd.name>
Date:   Mon, 17 Jan 2022 10:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] mt76: connac: move common mac defs in
 mt76_connac_mac.h
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
References: <cover.1642336806.git.lorenzo@kernel.org>
 <39e05054ccb5fc9123bea06f45833348c5b08d4d.1642336806.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <39e05054ccb5fc9123bea06f45833348c5b08d4d.1642336806.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-01-16 13:43, Lorenzo Bianconi wrote:
> Move mac definitions shared between mt7921 and mt7915 in
> mt76_connac_mac.h header.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   .../wireless/mediatek/mt76/mt76_connac_mac.h  | 292 +++++++++++++++++
I think this should probably be put in mt76_connac2_mac.h or something 
like that. The definitions are different for 7663/7615 (connac v1), and 
they will probably be different again for newer chipset generations.

Maybe we should reorganize the code to make it clear which parts are 
connac2 specific.

- Felix

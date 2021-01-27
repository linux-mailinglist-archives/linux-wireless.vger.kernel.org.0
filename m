Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F45305321
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 07:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhA0GUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 01:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhA0GDX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 01:03:23 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980FC0613ED
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 22:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M/lGEXeRX94IlylSgvYqAduXyuhDR2CNPAlu4Y3bTng=; b=JcA67nVHQ2KMoVAjGwyVxp3OtB
        XO2MstpGJ8Z1lNXFvja8PHoMtxFoHi3yym7CoWVwbkFvUVuxaps0D5ed/dKWd6cy9Kvwlf1ZNS8Pd
        5o+e5Xn60AJ/WO3xy+/3itKDSwsZxPZkCXQ/A4xUSAGQ9himbhw/AlISGtecVNpkQKes=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4duc-0008NI-0X; Wed, 27 Jan 2021 07:02:42 +0100
Subject: Re: [PATCH wireless-drivers] mt76: dma: fix a possible memory leak in
 mt76_add_fragment()
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com
References: <4f9dd73407da88b2a552517ce8db242d86bf4d5c.1611616130.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <9ff610a9-78f1-0ffc-5728-d89b4e604ced@nbd.name>
Date:   Wed, 27 Jan 2021 07:02:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <4f9dd73407da88b2a552517ce8db242d86bf4d5c.1611616130.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-01-26 12:02, Lorenzo Bianconi wrote:
> Fix a memory leak in mt76_add_fragment routine returning the buffer
> to the page_frag_cache when we receive a new fragment and the
> skb_shared_info frag array is full.
> 
> Fixes: b102f0c522cf6 ("mt76: fix array overflow on receiving too many fragments for a packet")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Acked-by: Felix Fietkau <nbd@nbd.name>

Thanks,

- Felix

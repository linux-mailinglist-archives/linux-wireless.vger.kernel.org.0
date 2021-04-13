Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B468435DB20
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhDMJ1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhDMJ1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 05:27:24 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22EC061574
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OtgCHsWYPlJuex0DZzLsQBEBTnQ/M9pwex4ouMB0c4U=; b=nabzFeHMoowN+GY2yxjsIMn+xo
        22EidAR3XgUrpAl0R9r9jpStv0fZ2Zbor1X8/4a5AwRdqTz4Agy6SEg8CUcloewE4RblPt37l54bq
        6YrgWThNIM3Va+5fhN/SVL+qzJ2xIAmMK9FnV8gAck5S0WnCh1X0Fg9G02lovHoMRx5E=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lWFJw-0003SL-PW; Tue, 13 Apr 2021 11:26:56 +0200
Subject: Re: [PATCH] mt76: mt7921: add mt7921_dma_cleanup in
 mt7921_unregister_device
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
References: <e78ac49fa2e22c034b934f4ee433b5476e22706c.1618302972.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <9041dd42-8bc8-621c-171e-ef3efbde86bc@nbd.name>
Date:   Tue, 13 Apr 2021 11:26:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e78ac49fa2e22c034b934f4ee433b5476e22706c.1618302972.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-13 10:40, Lorenzo Bianconi wrote:
> In order to avoid memory leaks, clean the dma engine unloading the
> module
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Now it is accessing DMA registers after mt7921_mcu_exit has already
called mt7921_wfsys_reset.
Please move the mt7921_mcu_exit call further down.

- Felix

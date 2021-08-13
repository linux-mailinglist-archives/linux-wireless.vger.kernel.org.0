Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0BC3EBB2C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhHMRQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhHMRQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 13:16:34 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97ABC061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BUINg8Hpu6n9zV7Lxgu3Uh6X75DxFjgbgF9AjtIXSHU=; b=Yq3vSPbbuM4vjrCkRUccCugDhA
        dhpDkzqgjxIzLtdSxVotEALEY5hIsB9pTeikY4e0CD5rbV9wEnfW1Dgb4juuO6zCkn3s9UbFk8dh4
        C91vZZaHL2dpD4EM47f9EuFvY8QszTpYwNkRZ+D4EK57tzz+oQsx5mddcw/auJyfAJPU=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEamr-0001vN-9P; Fri, 13 Aug 2021 19:16:05 +0200
Subject: Re: [PATCH v5 05/11] mt76: mt7915: debugfs hook to enable TXS for
 NO_SKB pkt-ids
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <20210804134505.3208-5-greearb@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <02b63c52-9b34-b374-fa43-6e2148f3616d@nbd.name>
Date:   Fri, 13 Aug 2021 19:16:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804134505.3208-5-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-08-04 15:44, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This lets user turn on/off this feature.  Enabling gives better
> tx-rate related stats, but will cause extra driver and (maybe)
> firmware work.  Not sure if it actually affects performance or
> not.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 24 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 ++-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 ++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 91664ac63a8d..6be194f16548 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -344,6 +367,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
>  				    mt7915_queues_acq);
>  	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
>  	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
> +	debugfs_create_file("txs_for_no_skb", 0600, dir, dev, &fops_txs_for_no_skb);
I think this is a rather confusing name. Maybe "force_txs"?

- Felix

-

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77332B17F9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKMJNt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 04:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgKMJNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 04:13:48 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056FC0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5kzIrTeCquovS0+Gwl49sn6JqhqPJPdv4j4QLyEODfg=; b=nICS6zfTTUZo9FXocOudMUtWnL
        OztsrVFOaVAkyss4obwpWyrarikJudZWNCv8cv7O5NFVVpDCFAItU7hB1jxgqjXuL7CML93jDCPwV
        WXjUnd8ERgiuc25H1VYZt7XVX2/OdHcNYw3l9iC5FpgOIY248mtz7DSUCptNI05R5ur8=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kdV9M-00015Q-1D; Fri, 13 Nov 2020 10:13:44 +0100
Subject: Re: [PATCH 2/3] mt76: mt7915: remove unused mt7915_mcu_bss_sync_tlv()
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <879705a8af8fa44c711feb3aa0351c1138aeef6c.1603988327.git.ryder.lee@mediatek.com>
 <4e10985307260de60fea3fae0b6f41985136082c.1603988327.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <ea7d90d0-cb7d-a8d3-a60d-c9863b6caa56@nbd.name>
Date:   Fri, 13 Nov 2020 10:13:42 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <4e10985307260de60fea3fae0b6f41985136082c.1603988327.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-10-29 18:11, Ryder Lee wrote:
> mt7915_mcu_bss_sync_tlv() is no longer used, so remove it.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 ++-----------------
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 11 +----------
>  2 files changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 18383dcdaf35..ed767b28aa86 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
This patch was missing a chunk to remove
sizeof(struct bss_info_sync_mode) from MT7915_BSS_UPDATE_MAX_SIZE.
I've fixed it up locally.

- Felix

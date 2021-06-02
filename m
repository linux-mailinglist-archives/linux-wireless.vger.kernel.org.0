Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB93980DB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 07:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFBGBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 02:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhFBGB3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 02:01:29 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF41C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lN8/WHahPS6Oiuz3dBMVM7+Nsxw5i+AV4hZOC9FGpq4=; b=R26yzoy+oQb5oBSs57uUL8LDQq
        5sZIFKYWdxFE2xroyQfisxed/IzDiw25CTCS+F38p0AisNn8yCXtSViAGMQ87kn5aecbJcc3swjcM
        EGjyxXGkgTp4B0nc5Wiqfh75Cq86y7eDWWIojhdvhxjUhzl/+VvaY9p3CnvMRudlcFPA=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1loJum-0002lU-S7; Wed, 02 Jun 2021 07:59:40 +0200
Subject: Re: [PATCH v2 1/3] mt76: connac: add mt76_connac_mcu_update_sta_cmd
 support
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <6ddea8d1-551d-5a58-267c-506d22cc932f@nbd.name>
Date:   Wed, 2 Jun 2021 07:59:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <db74f1c3acd2a2729066810ad72b656681a30693.1622610746.git.objelf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-02 07:24, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add mt76_connac_mcu_update_sta_cmd support that is the prerequisite patch
> for we are able to update the station record with the current state the
> station has into the offload firmware at runtime.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v1->v2: no change
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 ++--
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 32 ++++++++++++++-----
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 16 ++++++++--
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +++--
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  3 +-
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
>  6 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index d64b8058b744..6666507f43ed 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -902,6 +902,14 @@ struct mt76_connac_suspend_tlv {
>  	u8 pad[5];
>  } __packed;
>  
> + /* 0: state 1 - unauthenticated & unassociated
> +  * 1: state 2 - authenticated & unassociated
> +  * 2: state 3 - authenticated & associated
> +  */
> +#define MT76_STA_INFO_STATE_1	0
> +#define MT76_STA_INFO_STATE_2	1
> +#define MT76_STA_INFO_STATE_3	2
Please turn this into an enum:

enum mt76_sta_info_state {
	MT76_STA_INFO_STATE_NONE,
	MT76_STA_INFO_STATE_AUTH,
	MT76_STA_INFO_STATE_ASSOC
};

The _1 _2 _3 suffixes are not that readable and add extra confusion by
not matching the numeric values.

- Felix

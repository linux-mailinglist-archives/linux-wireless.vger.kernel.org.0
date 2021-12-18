Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C276479CA0
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 21:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhLRUpj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 15:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhLRUpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 15:45:39 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724DC061574
        for <linux-wireless@vger.kernel.org>; Sat, 18 Dec 2021 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2uiCWB9hOey1dvgLnJaijiIARN+gpFHd6WC0lJTiwfY=; b=jE+VDrz+KOwhWPJ+yKHXeUOaRS
        TgwyCIccB9LPt0pSLLPVG5as9dC4p0/CMlMKQnT332fHEg2qV21cUqXByxYH1NJJygbmkLprwabwy
        LheRK8Cfvj9AjxWaxYjp5Yx0bw+sFh2AcruzXSKohH+umIJf/5Vvk5Fv4WsECD4p5z4E=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mygaD-00049u-EE; Sat, 18 Dec 2021 21:45:33 +0100
Message-ID: <55f272bc-da5d-42bb-d20d-a9fda020285e@nbd.name>
Date:   Sat, 18 Dec 2021 21:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 2/7] mt76: mt7915: rely on mt76_connac_mcu_alloc_wtbl_req
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
References: <cover.1639763123.git.lorenzo@kernel.org>
 <de5be711eae18d4d471ec142616a35a5247ab83b.1639763123.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <de5be711eae18d4d471ec142616a35a5247ab83b.1639763123.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-12-17 18:48, Lorenzo Bianconi wrote:
> Rely on mt76_connac_mcu_alloc_wtbl_req routine and remove
> duplicated code.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  8 +++-
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 43 ++++---------------
>   2 files changed, 15 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index fc5c870da420..ee512651d9f1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -309,8 +309,12 @@ mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
>   		*skb = nskb;
>   	}
>   
> -	if (sta_hdr)
> -		sta_hdr->len = cpu_to_le16(sizeof(hdr));
> +	if (sta_hdr) {
> +		if (is_mt7915(dev))
> +			le16_add_cpu(&sta_hdr->len, sizeof(hdr));
> +		else
> +			sta_hdr->len = cpu_to_le16(sizeof(hdr));
> +	}
>   
>   	return skb_put_data(nskb, &hdr, sizeof(hdr));
>   }
The change from the len assignment to addition was done as a bugfix in 
mt7915. I think it's likely that the assignment is buggy in the connac 
code as well and should be changed to match mt7915.

- Felix

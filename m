Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71C47A21E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhLSUu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 15:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhLSUu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 15:50:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70CC061574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iISHwiWe9s52Un+4+6loa8GB+wEgyGflH4QjgaIMNrw=; b=Drfyz2pa3B/BCgCVe9nXYRDI22
        tSubj9sESPlnvqACa0uBJdqNCi5bcNuzb4aARCyGrxtGG0z7Epo9X4OsjdqXYRONLAExIf9LnM+RG
        bG1X9nf5TSsz2B1oiIG2ZGqpJHW5oVo/zjrbufnP20dhDshHxveJ1gW64ZioSXqg3wxY=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mz38q-0000tI-VJ; Sun, 19 Dec 2021 21:50:49 +0100
Message-ID: <82bb897f-ef61-e7d8-44ca-0bbd825953d2@nbd.name>
Date:   Sun, 19 Dec 2021 21:50:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/9] mt76: connac: fix broadcast muar_idx in
 alloc_sta_req
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
References: <cover.1639935477.git.lorenzo@kernel.org>
 <fe60489b1aea76a7f3f61b2f42431ba424ceb9a1.1639935477.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <fe60489b1aea76a7f3f61b2f42431ba424ceb9a1.1639935477.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-12-19 18:40, Lorenzo Bianconi wrote:
> Set muar_idx for broadcast wcid to 0xe in mt76_connac_mcu_alloc_sta_req
> routine.
> 
> Fixes: d0e274af2f2e4 ("mt76: mt76_connac: create mcu library")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 5664f119447b..b150c7f2f005 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -271,7 +271,7 @@ mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
>   {
>   	struct sta_req_hdr hdr = {
>   		.bss_idx = mvif->idx,
> -		.muar_idx = wcid ? mvif->omac_idx : 0,
> +		.muar_idx = wcid && wcid->sta ? mvif->omac_idx : 0xe,
I took another look at the driver code, and I think this part is wrong.
I think it should be like this instead:
When deleting an entry (sta or vif wcid), we should set muar_idx to 0xe
When not deleting, it should be mvif->omac_idx if we have a vif, and 0xe 
otherwise.

- Felix

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE73EB3F6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 12:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhHMKWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbhHMKWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 06:22:53 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C523C061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oTyDeI6MWVlDAIwDb4K6hQ3vAcN5deIrYwf+28913Ao=; b=laobjqe4cc3nvthBn3QqWnBNP1
        vlD+szSGKW1QWGM1Ss/m8qFfnpwmIiie7a7TPDkoR4d/OVtg/m4OSnCQ6+KOgc+tayW7Pv2ge4WpR
        mV5Mh0kUJPHj0pfOWPtvmVWCIbJ96sFic0xRvRVQE7uC4CeuyM7ZntcbGYZ1w0JAC9GU=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEUKT-0006bm-4x; Fri, 13 Aug 2021 12:22:21 +0200
Subject: Re: [PATCH 1/2] mt76: connac: fix GTK rekey offload failure on WPA
 mixed mode
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1627426757-14811-1-git-send-email-sean.wang@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <8de0c710-0c61-2369-7730-b2f07a86e626@nbd.name>
Date:   Fri, 13 Aug 2021 12:22:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1627426757-14811-1-git-send-email-sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-07-28 00:59, sean.wang@mediatek.com wrote:
> From: Leon Yen <Leon.Yen@mediatek.com>
> 
> Update the proper firmware programming sequence to fix GTK rekey
> offload failure on WPA mixed mode.
> 
> In the mt76_connac_mcu_key_iter,
> gtk_tlv->proto should be only set up on pairwise key
> and gtk_tlk->group_cipher should be only set up on the group key.
> 
> Otherwise, those parameters required by firmware would be set
> incorrectly to cause GTK rekey offload failure on WPA mixed mode
> and then disconnection follows.
> 
> Fixes: b47e21e75c80 ("mt76: mt7615: add gtk rekey offload support")
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt76_connac_mcu.c  | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index a2555dc0f003..d71393b1c5e6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1957,19 +1957,22 @@ mt76_connac_mcu_key_iter(struct ieee80211_hw *hw,
>  	    key->cipher != WLAN_CIPHER_SUITE_TKIP)
>  		return;
>  
> -	if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
> -		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
> +	if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
>  		cipher = BIT(3);
> -	} else {
> -		gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
> +	else
>  		cipher = BIT(4);
> -	}
>  
>  	/* we are assuming here to have a single pairwise key */
>  	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
> +		if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
> +			gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
> +		else
> +			gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
Why is gtk_tlv->proto set to WPA version values based on the cipher
suite? That doesn't make much sense to me, since TKIP is supported by
WPA2 as well. I will apply this patch anyway, since this check is there
already, but this does look suspicious to me and should probably be
revisited.

- Felix

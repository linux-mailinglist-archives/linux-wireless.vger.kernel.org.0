Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43003D6B43
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 02:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhG0ABz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 20:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234435AbhG0ABy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 482C260E78;
        Tue, 27 Jul 2021 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627346541;
        bh=cxD7AhXGeOJ7ri9fEz9eGsgs5QhavYnZIAf+Z1BZr8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PK84Ni42i7bDoUYlU6dCicC/pXIDAUfFt5C+OXIZZlQdEczxzmTJuVNyNDar7Wo2c
         EiedDfFRj77hNo5A6ugBnvsgQ+XCgwmszr/iHyTTgIU07xz1Iz9WEPX9ZndDSIBVjg
         oDokxBjNTbE7XOugq7p4T/QXmzaGifJdxJr+z9D8+K2tMnOtpEsNDzhXEgttheoOZP
         JjJrHy1oYnvGnTy75U/BXROU1Bh5gPzkilc2ZKCdmfxhMJzkFpslkYQAEnxIlErFQG
         ncRcoshwdHK5FvWL4ixLGuRIbtgWY7AUPPbSF5k3qx2GYqkI/ijlRi7Rc27DEh3+QV
         PT+vNqfcdi+PQ==
Date:   Mon, 26 Jul 2021 17:42:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: fix build error implicit enumeration conversion
Message-ID: <YP9Warx1zcUofVhJ@Ryzen-9-3900X.localdomain>
References: <9b704807383f3048898944d2b9cb74e6b4e8d83d.1624174954.git.objelf@gmail.com>
 <62c5ed786f81ddea6d3587647520e9e4254c8612.1624174954.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c5ed786f81ddea6d3587647520e9e4254c8612.1624174954.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jun 20, 2021 at 03:48:07PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:114:10: error: implicit
> conversion from enumeration type 'enum mt76_cipher_type' to different
> enumeration type 'enum mcu_cipher_type' [-Werror,-Wenum-conversion]
>                 return MT_CIPHER_NONE;
>                 ~~~~~~ ^~~~~~~~~~~~~~
> 
> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:114:10: error: implicit
> conversion from enumeration type 'enum mt76_cipher_type' to different
> enumeration type 'enum mcu_cipher_type' [-Werror,-Wenum-conversion]
>                 return MT_CIPHER_NONE;
>                 ~~~~~~ ^~~~~~~~~~~~~~
> 
> Fixes: c368362c36d3 ("mt76: fix iv and CCMP header insertion")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

It would be nice if this could be added to 5.14-rc at some point in the
cycle as this shows up in clang builds for allmodconfig for various
architectures and I still do not see it in -next.

> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h | 3 ++-
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 863aa18b3024..c2e537a9c1dc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -111,7 +111,7 @@ mt7915_mcu_get_cipher(int cipher)
>  	case WLAN_CIPHER_SUITE_SMS4:
>  		return MCU_CIPHER_WAPI;
>  	default:
> -		return MT_CIPHER_NONE;
> +		return MCU_CIPHER_NONE;
>  	}
>  }
>  
> @@ -1201,7 +1201,7 @@ mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
>  		u8 cipher;
>  
>  		cipher = mt7915_mcu_get_cipher(key->cipher);
> -		if (cipher == MT_CIPHER_NONE)
> +		if (cipher == MCU_CIPHER_NONE)
>  			return -EOPNOTSUPP;
>  
>  		sec_key = &sec->key[0];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> index edd3ba3a0c2d..5b9b425bd836 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> @@ -1073,7 +1073,8 @@ enum {
>  };
>  
>  enum mcu_cipher_type {
> -	MCU_CIPHER_WEP40 = 1,
> +	MCU_CIPHER_NONE,
> +	MCU_CIPHER_WEP40,
>  	MCU_CIPHER_WEP104,
>  	MCU_CIPHER_WEP128,
>  	MCU_CIPHER_TKIP,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> index c2c4dc196802..81633be09e90 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -111,7 +111,7 @@ mt7921_mcu_get_cipher(int cipher)
>  	case WLAN_CIPHER_SUITE_SMS4:
>  		return MCU_CIPHER_WAPI;
>  	default:
> -		return MT_CIPHER_NONE;
> +		return MCU_CIPHER_NONE;
>  	}
>  }
>  
> @@ -619,7 +619,7 @@ mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
>  		u8 cipher;
>  
>  		cipher = mt7921_mcu_get_cipher(key->cipher);
> -		if (cipher == MT_CIPHER_NONE)
> +		if (cipher == MCU_CIPHER_NONE)
>  			return -EOPNOTSUPP;
>  
>  		sec_key = &sec->key[0];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
> index d76cf8f8dfdf..3334afd8aea9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
> @@ -199,7 +199,8 @@ struct sta_rec_sec {
>  } __packed;
>  
>  enum mcu_cipher_type {
> -	MCU_CIPHER_WEP40 = 1,
> +	MCU_CIPHER_NONE,
> +	MCU_CIPHER_WEP40,
>  	MCU_CIPHER_WEP104,
>  	MCU_CIPHER_WEP128,
>  	MCU_CIPHER_TKIP,
> -- 
> 2.25.1

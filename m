Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663D4FA5A9
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Apr 2022 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiDIH4r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Apr 2022 03:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiDIH4p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Apr 2022 03:56:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071AE38D95;
        Sat,  9 Apr 2022 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649490834;
        bh=luZq8lrGFZ4kx0jdQXktj//Kdt2hzMCkIhTuT7UjDa0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ks5LtJJLlSZxVTnqJdzqMzFugrZJuWp7j7+UpI6yWFsWB48eJjmGb2QOMiJE5tp3T
         21C3qNMqnBmS8Hfarje4hXo3i6ym2MeJ7E2mhUSeZPTFll+MNEZTC1GwhMjXI0Ytu3
         YHPtlkH4DVITE3HAmSqXPeQGBARekhiVv/HtJYPo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.86.95] ([95.91.192.147]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1nm8Cv2tHv-009fer; Sat, 09
 Apr 2022 09:53:54 +0200
Message-ID: <00a0f9f7-2fbf-8883-38e7-edec3687e6a8@rempel-privat.de>
Date:   Sat, 9 Apr 2022 09:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with
 invalid rxstatus->rs_keyix
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20220409061225.GA5447@kili>
From:   Oleksij Rempel <linux@rempel-privat.de>
In-Reply-To: <20220409061225.GA5447@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQxSM885JV9wHVfy28pZU9+jOPYcxASYy9IPAaGCyf7RpzyyJef
 Cegv2sKxKDFA/9XrBgxv4S+kf9yHgY3Bas73zf7jljPeMQf+Y6PeTtJMZhUHNASkkFbDPbi
 RTCResGG4WSD5RzvXIJooI0cnEqs/UNGgzQnTeLR4VhYT1F0f3ajBlb3HL1vXY+W6McKcAy
 T457rWNrT/Xo6gQnw9YDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEC/CnyNuDM=:7EPkAa0dFbHFCKmllImUJO
 zgUbTeHGxm6By72t4xcazSrf6/wd0/0HaChoXyDBvVpb/i+nZqjFbqaShY/9YqP4EXa98zvl5
 9VksbOL4Jc66TxyQjuf1/x7T6mvciWyH6bi5HDJdndGlTQInCINBJ+ncrDqfgvzJCuUegzc5w
 SbuyGmnYlBUjXg1blv/lCSKHPX8N8eU7MrKnON217kFtEDJ4Z1nI7afUUQwbKMdUvqcf++3ty
 oFN1VayPZEmkEvnls5oq6xwdk1Y3LmfRLMFXhmsdXNVDMvWFwbT6w7wyZVwN2+I43MLbzpoAe
 Yu9MdR/BY8c2idqpQDWyFr5T9ZWgkhtcmNoAdnSpMUN+1GttYj9xOIvBCpQXSc6G1PPDcisYQ
 9JBPfQQvUkZSoq4Xr0v5G5kImsfZN/ophrC7T0XgZLs1d2GQ0+nu4BTmhTPXo+J8pzuyqepX8
 4AZlIr4SZUPU0QA4YiJu4CEhul9o/HRJRX3aCrUBkY7imSOlvZLD9BiEe1VtvFyEzprLY0Y9x
 Waxa1zPYOo18uhbZyl0+bJM+EBh4Tw2xsmN7CGg9u9gx5q0/RoQtw36q8CPBOPe2BAQvSqtX/
 yI9sDh1HKQRonb61HUSnXgO9k1recXFjeB+5Etgcq6S466sQpnNCOaGh49Yh6Px4+lb9SEXg7
 WSA2X2ZuQ5kOpkWYbc/oHHl4uXhd4Oc0rOiFxO0ICewpYpylAJhNNSCPXJ1awH4Z2NdVrYpzQ
 u44Y6l+eD8oOwpBHVjEHHOUMHKQLDxZhN0b0D0fknqPzS6+rsdTkG0e++ljkbcgie+NAjPY1p
 MEyhcohY737xKKjXsTD6L3M+P90YFgy6Lz/OpVDBDAx94Gn82uXnKRnhDbWTXgkjHdI2W1iBy
 z5wmixTloAccOg0G/QH/mqR96JIjX+CxonxtqVk5tV2rUGOb1bE3wbo+lScg8+UxGkHPLxZV5
 9Qte2HHrMmA+G+xIuE2b1QAuITzBm131XoQTLnIZvJgq/gAB62y698iFWTbsmC/YXNQV/kPrg
 FHkJ8i59xC3qvN+EPNoHi73k4L6N9U9M5oakIQ7x76m/hcCsPWgnRC/W9kNcl+JSgI5iI6GUB
 6XydpXHTKsduu0=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

thank you for your patch.

Am 09.04.22 um 08:12 schrieb Dan Carpenter:
> The "rxstatus->rs_keyix" eventually gets passed to test_bit() so we need=
 to
> ensure that it is within than bitmap.
>
> drivers/net/wireless/ath/ath9k/common.c:46 ath9k_cmn_rx_accept()
> error: passing untrusted data 'rx_stats->rs_keyix' to 'test_bit()'
>
> Fixes: 4ed1a8d4a257 ("ath9k_htc: use ath9k_cmn_rx_accept")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net=
/wireless/ath/ath9k/htc_drv_txrx.c
> index 6a850a0bfa8a..a23eaca0326d 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> @@ -1016,6 +1016,14 @@ static bool ath9k_rx_prepare(struct ath9k_htc_pri=
v *priv,
>   		goto rx_next;
>   	}
>
> +	if (rxstatus->rs_keyix >=3D ATH_KEYMAX &&
> +	    rxstatus->rs_keyix !=3D ATH9K_RXKEYIX_INVALID) {
> +		ath_dbg(common, ANY,
> +			"Invalid keyix, dropping (keyix: %d)\n",
> +			rxstatus->rs_keyix);
> +		goto rx_next;
> +	}
> +
>   	/* Get the RX status information */
>
>   	memset(rx_status, 0, sizeof(struct ieee80211_rx_status));

Looks ok to me.

By the way, rs_keyix seems to have a wrong type. It is declared as u8, but=
 used as s8.

=2D-
Regards,
Oleksij

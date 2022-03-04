Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B154CD0ED
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 10:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiCDJUm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 04:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiCDJUm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 04:20:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5802D8C7EE
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kNrH53gU7VQVK0nXjsgwFpzT6QzCrp9xqzuMZHNv1kw=;
        t=1646385593; x=1647595193; b=HBuZGtOzO9O0iYBlftyAQ4W2c27j4TX7eomz4EL0le0TuAf
        +Ubxb9Rzb2MBUrjIchVdXygJaPI/AF7u1KxHxxinJrRufLOoyKmi3d4f0/JLYyqRH0H1Rm+rJ7Ki9
        061qOvq/JarnX0E5mJGBm5fsUxS9jhMMAJx1TifrMw1bKTYuv6XLkG/zR71x+nUD4jTWOr+vEr89H
        CPaAKuBfH+hPGO8XCFazKUhkfSboDisCrKlPCzNo2k2pReuNZWoxOWn5A9OmzCt7sPbv/FHMizIhk
        slTpU1LLrLlFNQcJx0csLORh78dl8ux8QZ/nys2//7zXP/TuMoATW6omojggaX6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nQ469-008dd9-M1;
        Fri, 04 Mar 2022 10:19:41 +0100
Message-ID: <050529f958bb628ee6e2819c944b42951b621893.camel@sipsolutions.net>
Subject: Re: [PATCH] rtw89: declare HE capabilities in 6G band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 04 Mar 2022 10:19:40 +0100
In-Reply-To: <20220304073443.27730-1-pkshih@realtek.com>
References: <20220304073443.27730-1-pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-03-04 at 15:34 +0800, Ping-Ke Shih wrote:
> To work properly in 6G band, declare HE 6G capabilities. Without this fix,
> it can only TX/RX with OFDM rates.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index a0086b14550a8..81c1c28e6e92c 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -2383,6 +2383,15 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
>  			he_cap->he_mcs_nss_supp.tx_mcs_160 = cpu_to_le16(mcs_map);
>  		}
>  
> +		if (band == NL80211_BAND_6GHZ) {
> +			__le16 capa;
> +
> +			capa = u16_encode_bits(0, IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
> 

le16_encode_bits()? I guess sparse would tell.

But it looks weird with the constants, I guess you mean

le16_encode_bits(IEEE80211_HT_MPDU_DENSITY_NONE,
		 IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
le16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K, ...) |
...

(there's documentation in ieee80211.h which value enums should be used)

johannes

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9E2F9FAB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 13:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbhARMa2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 07:30:28 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:33556 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391442AbhARMaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 07:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1610972981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcXZJtCMsN1bEAU2v8thA93ulKj3jUB/Kn5V4Q6D4t4=;
        b=mc8AYzN/gfhEVETSJ1chubqJYv0lR9UhOtuf3zu6BkSYNqvM0tjiLqfgMpl39eraHgliyU
        OTsXbRiBGOBnxIXaonIwtwXz3SEyAsF39ZUhFNfGSUmugwkoWm5UXg+wYypTk4rh7pJPKd
        KuhBrD8BWwYk3vnHr24sPGcknvTlz7s=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: Re: ath11k: IPQ8074: hw2.0: WMI_PEER_STA_KICKOUT after 3900 seconds
Date:   Mon, 18 Jan 2021 13:29:36 +0100
Message-ID: <12689791.y0N7aAr316@ripper>
In-Reply-To: <3150903.KgjxqYA5nG@ripper>
References: <3150903.KgjxqYA5nG@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4156957.MSiuQNM8U4"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4156957.MSiuQNM8U4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: Re: ath11k: IPQ8074: hw2.0: WMI_PEER_STA_KICKOUT after 3900 seconds
Date: Mon, 18 Jan 2021 13:29:36 +0100
Message-ID: <12689791.y0N7aAr316@ripper>
In-Reply-To: <3150903.KgjxqYA5nG@ripper>
References: <3150903.KgjxqYA5nG@ripper>

On Friday, 15 January 2021 15:22:02 CET Sven Eckelmann wrote:
> a rather odd behavior was noticed with ath11k and EAP.
[...]
> Btw. rekeying was disabled (but also setting it to 900s or 3600s doesn't 
> change the behavior at all. So here my hostapd config for completeness:

It seems like it also happens after 3900 seconds with PSK. So following
config will also create this problem:

    driver=nl80211
    logger_syslog=127
    logger_syslog_level=0
    logger_stdout=127
    logger_stdout_level=0
    country_code=US
    ieee80211d=1
    hw_mode=g
    beacon_int=100
    channel=6
    
    ieee80211n=1
    ht_coex=0
    ht_capab=[LDPC][SHORT-GI-20][SHORT-GI-40][TX-STBC][RX-STBC1][MAX-AMSDU-7935][DSSS_CCK-40]
    
    interface=ap2_1
    ctrl_interface=/var/run/hostapd
    ap_isolate=1
    bss_load_update_period=60
    chan_util_avg_period=600
    disassoc_low_ack=1
    preamble=1
    wmm_enabled=1
    ignore_broadcast_ssid=0
    uapsd_advertisement_enabled=1
    utf8_ssid=1
    multi_ap=0
    wpa_passphrase=testtest
    auth_algs=1
    wpa=2
    wpa_pairwise=CCMP
    ssid=psktest
    bridge=br-lan
    wpa_disable_eapol_key_retries=0
    wpa_key_mgmt=WPA-PSK
    okc=0
    disable_pmksa_caching=1
    bssid=f8:d9:b8:2e:37:d0

And this problem is trivial to see on the AP (with a single client) using the 
following patch:

    diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
    index 9fa6ff9..d1b2c61 100644
    --- a/drivers/net/wireless/ath/ath11k/wmi.c
    +++ b/drivers/net/wireless/ath/ath11k/wmi.c
    @@ -6504,6 +6504,7 @@ static void ath11k_peer_sta_kickout_event(struct ath11k_base *ab, struct sk_buff
     	ath11k_dbg(ab, ATH11K_DBG_WMI, "peer sta kickout event %pM",
     		   arg.mac_addr);
     
    +	WARN_ON(1);
     	ieee80211_report_low_ack(sta, 10);
     
     exit:


Maybe someone knows whether there is already a non upstream (keepalive?) patch 
from QCA in their wlan-open repository (in some of the branches) which I might 
miss.

Kind regards,
	Sven
--nextPart4156957.MSiuQNM8U4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAFfzAACgkQXYcKB8Em
e0agwhAAlv3QyHyUEC9IYllKc1ZoTQ0gZDsvIVnouZb9+PHQsr8Z2B46C9Nk9TPq
7AZek7cI14zdlJMYHXd42fcjNjclXiEhAXRfUrJWQv10nbEZl3lhB/wK4nuXhFW/
w1088Vj97egLPs9jfwNav51StGKqw47nYNWIKZE8ZeaD3FvmK8WPrcD48LfqYb1s
OS5Arv5jKnIWTQB7+ayy34BfXsswO65465txCZjHXv6dR8/SING1WcE3i+diPrUL
rbT7OhOL80+ToUIEmtHfRFsnUaY6UcGWAvP04djYhM7T3/HSdt5gVfjgKe0ZDnzu
eiNHaOhuPnwLVtb/JcZaN4kcO92sRlJuEx229IiA8Tk1HzHa/71IRSno0YI/uThi
9mYwEaVoplmzdcRj4jslyCw5L0XbpA/JDlsJo91/0QJMhU0L+jm1a1xky1v8zK+W
q5LnyOtiNrYpiAb0e93CNJ09ev3uKkU2boTDBuzL4wrZHUom4cbkB9654P7Le3Zw
12BRzsbCYIhXxMFVDJQihtxnVwRbcjbFf62UeA8xRxz9Q1RBxoSd3hVsNhvKmjC5
tVODXM6XAPDa3q7sx2Fgzv0njMkpzxQ75bDsJSzgRuOmAeTgWRcx8LBs05E6slRO
KQ8DNlImKtbu7eREjTn+TI05dTY0cFBM61X9SWiWHy0SZGIjvc0=
=A2Fa
-----END PGP SIGNATURE-----

--nextPart4156957.MSiuQNM8U4--




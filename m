Return-Path: <linux-wireless+bounces-27605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D0B94E8D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A916BF95
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29BF2EDD5D;
	Tue, 23 Sep 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KY1Fsktp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4E2E1746
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614687; cv=none; b=qDTlvJ7ZPQOF60ScS2rk02NQMe5jvC7PCHGZfOKQgwjqBlBeJwdClmz+GX1e2jFJcDpbbo26N3a9a92U57vpVyH8ZiSNozPkaLO+OpAGytYe1QhZlQqG2AfQNVx2wgPkbcBppt3G0W43ioNQxN+ww/Ju3Gj0B2HRp+AL8ITS9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614687; c=relaxed/simple;
	bh=q1WgresfBXhKDfegy1Bm756o3kmdPzapQV5PbbyUGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sJbOfFaJqEkrQS1JuJABHtrrOhVc9YlYm1xe6q3Nhxet2B0f1Zc+U6Ph7NEJXUIjVyf3hB+afXelJ5r6h8MOjTn2/rwJBgczgaD8T6foh3LmEQ3AxfAX8JeO8LI0n9U1utCOCszOAsx4EO05pNJ7lHU9rExcyx7MipOF0BJqiN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KY1Fsktp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso5658065e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758614684; x=1759219484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65gAs9t8N2uHZj/rvbjsiG4OJ6RKUb43eVRWusK5gqc=;
        b=KY1FsktpBt8CvdXjyIKYag9yFrpPKqd+UzTd5sJeInSwFhMtnLP6BMHxCVRyf1IzF4
         ttYFr3UmeOouau9J6mQQFHs2Nx8L6nvq3BsHkPGJdDMmI/IeOxMyotkOqQ0ZIbKorzz2
         q2M5EWA98LEtiRy15wet8HFbaQTv6MEJn4hQCm1ZoS1I965Gp9c3WA0DBzpnboqEKPW3
         P+yJvWW7uFR6/OVn8ViONi9xQrBUMqvbLtQwzgXW1waAahh4+f6/73zSzggXrci+senF
         eoFoydJBlEbkpApXt8bMkEGNdDO0EqUMpCSDKaQ1POZlnjy+ijVUHJE8jafZUBadtV9W
         4ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758614684; x=1759219484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65gAs9t8N2uHZj/rvbjsiG4OJ6RKUb43eVRWusK5gqc=;
        b=JvhL7gl5CGgW+ddzTTGPvd3I9kuWCIqznlG3/lcXLAjRxVMnX/BOYyUG5cpCUGs6wU
         UkXSpH3PSQGcfknEVn8DZM9a9IKNi8r9b19t1bOKbVY9wztb7dx6SAe4eHQ0bYYhKDG9
         DyaT7Oqi6RQRdTgSehELFyecc2mbzQHo0Riuk2LKSspM7J1s/ngki22iUrDyT6EkGwYb
         yBfnFfaf3uQEl8Phx2NbVfqiP1rjynNVxL6nMnrpV44WRWBvEHyTn7SAsnz+29151BrN
         v7Cf2WtAd3QSY3TNsQhvAUsP9Xr4J7H5yvE9ps2ydbKlmLrcuZxiSf5pdBBVlavg/zD5
         cOig==
X-Gm-Message-State: AOJu0YxQ7tqe49J3WpMLFNGKn0rbZ3VkCrnRK9f4LvSgDB9pNsw650AU
	ZZoaSDoT8h8ifIVFJAA1Zb5NEmnltq4RakXab6RDeyyzXup8WKdo5Dgi9bU6E/pRGDY=
X-Gm-Gg: ASbGncvKKkPnG9zktG9DBEwGHUmKtFjqzDs53I0HeNZxQ5V+9x4ZSSiAdJnaUTvHQ1I
	JpUhqCUbg1nA5PiFN28uowBGHKObivD8VwTRUjKMqKzmXnMfLYjIJcuFZg1CXmYyyYvUf0WG9ap
	P6JMrNFal+nNyn/+w2YZUu3yFZF9ADQygmfI6TDUmuODr2rRL0fbWpllQLZHRE8zQQUpz8obUsW
	sWKetz236IFS72nEmkqvkZVgaIpHQlG/da6pwDSeesAPuE8ya6pOdjm0NDwhWmxjmF0WQaT2vcg
	HoOE4rfM4nxIGxvASKooadZqQmjK/HH1QMrwkodlfgwRrhgsnnS+41S0vGyyZtchcjcuXYBiOc8
	s6ri1HgIpt6UKfcH0DTouTQ9uYTyT
X-Google-Smtp-Source: AGHT+IHD1aRmr7M0acgtf8ZgOWg/F5WmK0Susqm0FnRinUKRRdtG/uyGDvkVOypLtqWKN9ZkaxuzpA==
X-Received: by 2002:a05:600c:3b9e:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-46e1dae6142mr16344765e9.37.1758614683723;
        Tue, 23 Sep 2025 01:04:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e1d99f77esm9737165e9.5.2025.09.23.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:04:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:04:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilan Peer <ilan.peer@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: mac80211_hwsim: Add simulation support for NAN
 device
Message-ID: <aNJUlyIiSTW9zZdr@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ilan Peer,

Commit a37a6f54439b ("wifi: mac80211_hwsim: Add simulation support
for NAN device") from Sep 8, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/wireless/virtual/mac80211_hwsim.c:2011 mac80211_hwsim_tx()
	error: we previously assumed 'vif' could be null (see line 1978)

drivers/net/wireless/virtual/mac80211_hwsim.c
    1958 static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
    1959                               struct ieee80211_tx_control *control,
    1960                               struct sk_buff *skb)
    1961 {
    1962         struct mac80211_hwsim_data *data = hw->priv;
    1963         struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
    1964         struct ieee80211_hdr *hdr = (void *)skb->data;
    1965         struct ieee80211_chanctx_conf *chanctx_conf;
    1966         struct ieee80211_channel *channel;
    1967         struct ieee80211_vif *vif = txi->control.vif;
    1968         bool ack;
    1969         enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
    1970         u32 _portid, i;
    1971 
    1972         if (WARN_ON(skb->len < 10)) {
    1973                 /* Should not happen; just a sanity check for addr1 use */
    1974                 ieee80211_free_txskb(hw, skb);
    1975                 return;
    1976         }
    1977 
    1978         if (vif && vif->type == NL80211_IFTYPE_NAN && !data->tmp_chan) {
                     ^^^
Lets assume vif is NULL

    1979                 /* For NAN Device simulation purposes, assume that NAN is always
    1980                  * on channel 6 or channel 149, unless a ROC is in progress (for
    1981                  * USD use cases).
    1982                  */
    1983                 if (data->nan_curr_dw_band == NL80211_BAND_2GHZ)
    1984                         channel = ieee80211_get_channel(hw->wiphy, 2437);
    1985                 else if (data->nan_curr_dw_band == NL80211_BAND_5GHZ)
    1986                         channel = ieee80211_get_channel(hw->wiphy, 5745);
    1987                 else
    1988                         channel = NULL;
    1989 
    1990                 if (WARN_ON(!channel)) {
    1991                         ieee80211_free_txskb(hw, skb);
    1992                         return;
    1993                 }
    1994         } else if (!data->use_chanctx) {
    1995                 channel = data->channel;
    1996                 confbw = data->bw;
    1997         } else if (txi->hw_queue == 4) {
    1998                 channel = data->tmp_chan;
    1999         } else {
    2000                 u8 link = u32_get_bits(IEEE80211_SKB_CB(skb)->control.flags,
    2001                                        IEEE80211_TX_CTRL_MLO_LINK);
    2002                 struct ieee80211_link_sta *link_sta = NULL;
    2003                 struct ieee80211_sta *sta = control->sta;
    2004                 struct ieee80211_bss_conf *bss_conf;
    2005 
    2006                 if (link != IEEE80211_LINK_UNSPECIFIED) {
    2007                         bss_conf = rcu_dereference(txi->control.vif->link_conf[link]);
                                                            ^^^^^^^^^^^^^^^^

    2008                         if (sta)
    2009                                 link_sta = rcu_dereference(sta->link[link]);
    2010                 } else {
--> 2011                         bss_conf = mac80211_hwsim_select_tx_link(data, vif, sta,
                                                                                ^^^
It is dereferenced on the else path with no NULL checks.

    2012                                                                  hdr, &link_sta);
    2013                 }
    2014 
    2015                 if (unlikely(!bss_conf)) {
    2016                         /* if it's an MLO STA, it might have deactivated all
    2017                          * links temporarily - but we don't handle real PS in
    2018                          * this code yet, so just drop the frame in that case
    2019                          */
    2020                         WARN(link != IEEE80211_LINK_UNSPECIFIED || !sta || !sta->mlo,
    2021                              "link:%d, sta:%pM, sta->mlo:%d\n",
    2022                              link, sta ? sta->addr : NULL, sta ? sta->mlo : -1);
    2023                         ieee80211_free_txskb(hw, skb);
    2024                         return;
    2025                 }
    2026 
    2027                 /* Do address translations only between shared links. It is
    2028                  * possible that while an non-AP MLD station and an AP MLD
    2029                  * station have shared links, the frame is intended to be sent
    2030                  * on a link which is not shared (for example when sending a
    2031                  * probe response).
    2032                  */
    2033                 if (sta && sta->mlo && link_sta) {
    2034                         /* address translation to link addresses on TX */
    2035                         ether_addr_copy(hdr->addr1, link_sta->addr);
    2036                         ether_addr_copy(hdr->addr2, bss_conf->addr);
    2037                         /* translate A3 only if it's the BSSID */
    2038                         if (!ieee80211_has_tods(hdr->frame_control) &&
    2039                             !ieee80211_has_fromds(hdr->frame_control)) {
    2040                                 if (ether_addr_equal(hdr->addr3, sta->addr))
    2041                                         ether_addr_copy(hdr->addr3, link_sta->addr);
    2042                                 else if (ether_addr_equal(hdr->addr3, vif->addr))
    2043                                         ether_addr_copy(hdr->addr3, bss_conf->addr);
    2044                         }
    2045                         /* no need to look at A4, if present it's SA */
    2046                 }
    2047 
    2048                 chanctx_conf = rcu_dereference(bss_conf->chanctx_conf);
    2049                 if (chanctx_conf) {
    2050                         channel = chanctx_conf->def.chan;
    2051                         confbw = chanctx_conf->def.width;
    2052                 } else {
    2053                         channel = NULL;
    2054                 }
    2055         }
    2056 
    2057         if (WARN(!channel, "TX w/o channel - queue = %d\n", txi->hw_queue)) {
    2058                 ieee80211_free_txskb(hw, skb);
    2059                 return;
    2060         }
    2061 
    2062         if (data->idle && !data->tmp_chan) {
    2063                 wiphy_dbg(hw->wiphy, "Trying to TX when idle - reject\n");
    2064                 ieee80211_free_txskb(hw, skb);
    2065                 return;
    2066         }
    2067 
    2068         if (txi->control.vif)
                     ^^^^^^^^^^^^^^^^
Here is another check.

    2069                 hwsim_check_magic(txi->control.vif);
    2070         if (control->sta)
    2071                 hwsim_check_sta_magic(control->sta);
    2072 

regards,
dan carpenter


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2CE79E74C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbjIML4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIML4d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:56:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB3A1996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TJXbv58nZXH9xs0idbIKM4PwT3gIhgk7a+ziFWpPZk0=;
        t=1694606189; x=1695815789; b=DxWj+iSP0ff/w7GLeIULoFG0bBgmx+6xJQHsvwfDVtZJEjz
        1KTM4Ic6u2fMrLRDAPdy2DAI5VHWlcQ2DyL1ReCj4UFcpH178ffZM4UL2/FPynSacw5+Ifipjc0xZ
        vYmUeO9l2zd5Y/ld4d6A13TmKO9TXpzaHEkJypCo7dVOsseWfQRpwZNCe64y5Nkva+yeELLSBxk+j
        4fpdIveQAnPHpzhAX/z1VfLvc9XyOCNdOKC/BRClVdFP5oZua/dk1+7GtnOV9gfOLlKtUmfNQYHe6
        eQ8tqHTZUBlefMtjz1e1fYVbPxneXgpmt08ONh+f/WS7K/iw94ANSy5rbgpSKwjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgOTq-00EsIh-3C;
        Wed, 13 Sep 2023 13:56:27 +0200
Message-ID: <7f049725302e06040194e0aa76a8c34d6ecc024c.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/2] wifi: mac80211: S1G beacon/short beacon support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bassem Dawood <bassem@morsemicro.com>,
        linux-wireless@vger.kernel.org
Cc:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Date:   Wed, 13 Sep 2023 13:56:25 +0200
In-Reply-To: <20230810093556.33800-2-bassem@morsemicro.com>
References: <20230810093556.33800-1-bassem@morsemicro.com>
         <20230810093556.33800-2-bassem@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-08-10 at 19:35 +1000, Bassem Dawood wrote:
> From: Kieran Frewen <kieran.frewen@morsemicro.com>
>=20
> With the kernel able to send both short and long S1G beacons, include
> the ability for setting the short beacon period. If configured, use
> the S1G short beacon format. The S1G short beacon format includes a
> limited set of information elements. It also adds the support for
> distinguish short beacon head and tail.

Also here, I think that could be more elaborate.

And we like to also have commit logs in imperative voice.

> +++ b/net/mac80211/ieee80211_i.h
> @@ -259,10 +259,13 @@ struct ieee80211_color_change_settings {
> =20
>  struct beacon_data {
>  	u8 *head, *tail;
> +	u8 *short_head, *short_tail;
>  	int head_len, tail_len;
> +	int short_head_len, short_tail_len;
>  	struct ieee80211_meshconf_ie *meshconf;
>  	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
>  	u8 cntdwn_current_counter;
> +	u8 long_beacon_count;

I don't understand why this is called long_beacon_count?

> +++ b/net/mac80211/tx.c
> @@ -5260,6 +5260,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
>  	struct sk_buff *skb =3D NULL;
>  	u16 csa_off_base =3D 0;
>  	int mbssid_len;
> +	bool is_short =3D false;
> +
> +	if (vif->cfg.s1g) {
> +		if (beacon->long_beacon_count =3D=3D 0) {
> +			is_short =3D false;
> +			beacon->long_beacon_count =3D
> +				vif->bss_conf.short_beacon_period - 1;
> +		} else {
> +			is_short =3D true;
> +			beacon->long_beacon_count--;

It's decremented for every _short_ beacon, and then you get a long one
when it reaches 0 ... so it's surely not counting long beacons?


Seems like is_short now needs to be taken into account for the beacon
skb allocation, nowhere did you actually ensure that the short beacon is
indeed shorter than the long beacon ... you don't want to let userspace
crash us with that.

johannes

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20ED53541E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiEZTwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 15:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiEZTwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 15:52:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4A87A25
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4WfXY0IzjsKAiBYz0vcS9uXuN0iNy3ChhNrSmEZYmIg=;
        t=1653594758; x=1654804358; b=EPglELZteZSi1BWTlp710wE/ZFZUyIfKyiDHjJJ5XUc0Nc9
        sl/lu37L8y1ZZsMQnMudUc+FEtMD/mwmkrLZRPWa9M94ZNLFuB0ZvQ+FvhVWnCkb3qx0csAL/BHEX
        WTTz3veYiUMcnpuQxl2GR/e5PbozHO5jZhXKMf0vurOleg7AmKlGXQuNkja+uxFDpQCV+ExRxr89l
        h52doeP5/33NDIqV46bI1opzmOe1G/2Wa8XfwbfC25/jLcj/yzRK5XjwfWq0Hq+l31zvfrVMOaPm7
        C8uqDvb8AXiqnD3OQLqDLnOfjKOzeK1EXRJ1NofuFkfR4mWqKkX627MNrqUfg9BA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuJXA-005G5T-0q;
        Thu, 26 May 2022 21:52:36 +0200
Message-ID: <6d41d6d8089c15b485e9c5572995ad2a6dde0969.camel@sipsolutions.net>
Subject: Re: [RFC v2 39/96] cl8k: add mac80211.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 21:52:35 +0200
In-Reply-To: <20220524113502.1094459-40-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-40-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-24 at 14:34 +0300, viktor.barna@celeno.com wrote:
>=20
> +#define PPE_0US 0
> +#define PPE_8US 1
> +#define PPE_16US 2
> +
> +/*
> + * Extended Channel Switching capability to be set in the 1st byte of
> + * the @WLAN_EID_EXT_CAPABILITY information element
> + */
> +#define WLAN_EXT_CAPA1_2040_BSS_COEX_MGMT_ENABLED BIT(0)
> +
> +/* WLAN_EID_BSS_COEX_2040 =3D 72 */
> +/* 802.11n 7.3.2.61 */
> +struct ieee80211_bss_coex_20_40_ie {
> +	u8 element_id;
> +	u8 len;
> +	u8 info_req : 1;
> +	/* Inter-BSS set 1 when prohibits a receiving BSS from operating as a 2=
0/40 Mhz BSS */
> +	u8 intolerant40 : 1;
> +	/* Intra-BSS set 1 when prohibits a receiving AP from operating its BSS=
 as a 20/40MHz BSS */
> +	u8 bss20_width_req : 1;
> +	u8 obss_scan_exemp_req : 1;
> +	u8 obss_scan_exemp_grant : 1;
> +	u8 rsv : 3;
> +} __packed;

You should add these kinds of things to ieee80211.h, but of course they
should be endian safe and not use bitfields.


> +/* WLAN_EID_BSS_INTOLERANT_CHL_REPORT =3D 73 */
> +/*802.11n 7.3.2.59 */
> +struct ieee80211_bss_intolerant_chl_report_ie {
> +	u8 element_id;
> +	u8 len;
> +	u8 regulatory_class;
> +	u8 ch_list[0];

use [] not [0]

> +} __packed;
> +
> +/* Union options that are not included in 'struct ieee80211_mgmt' */

just add them

johannes

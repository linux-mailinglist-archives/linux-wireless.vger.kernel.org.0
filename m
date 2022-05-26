Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9079535406
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 21:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbiEZTiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiEZTiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 15:38:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157E1A06A
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LLitNcgih9K7mHEzEOACI7WJlh1JgQrxo44A9bktMnk=;
        t=1653593892; x=1654803492; b=jeheE0FAtdmvptqf/tki2DywuHHb6OZZUm5iryu6MBz7LJe
        HtKow+URqEucndELJff+jkc1MpIsBcpj8tQmxCgbQIWO+KicNFd8AG9WfGvufl5gc6KtVTRIpVU2j
        dDDE/9+SQtIg6XToXqKnq5eyEXpzv2Nrt20Gaz81rbC8lzEMpVGUhBmQ5VM+uC2x197nzeyNEl9yG
        ADt19Vwl0hqGeCR7TTrS2zk5bU8dAlROrsTs+GUwqFRBme6I2YdEGHGhWuJf8pSk6057AcyFbe3c7
        sOckhS+9GUGAds/kJwnbN5UxuBwLoPawIwwAUE6xMLyiz1NnCF3lQAMSjkTz6kIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuJJB-005Frr-M4;
        Thu, 26 May 2022 21:38:09 +0200
Message-ID: <09f6890123176f5b31e15a8b61303d65b83527a6.camel@sipsolutions.net>
Subject: Re: [RFC v2 36/96] cl8k: add key.c
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
Date:   Thu, 26 May 2022 21:38:08 +0200
In-Reply-To: <20220524113502.1094459-37-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-37-viktor.barna@celeno.com>
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
> +static inline void cl_ccmp_hdr2pn(u8 *pn, u8 *hdr)
> +{
> +	pn[0] =3D hdr[7];
> +	pn[1] =3D hdr[6];
> +	pn[2] =3D hdr[5];
> +	pn[3] =3D hdr[4];
> +	pn[4] =3D hdr[1];
> +	pn[5] =3D hdr[0];
> +}
> +
> +static int cl_key_validate_pn(struct cl_hw *cl_hw, struct cl_sta *cl_sta=
, struct sk_buff *skb)
> +{
> +	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
> +	int hdrlen =3D 0, res =3D 0;
> +	u8 pn[IEEE80211_CCMP_PN_LEN];
> +	u8 tid =3D 0;
> +
> +	hdrlen =3D ieee80211_hdrlen(hdr->frame_control);
> +	tid =3D ieee80211_get_tid(hdr);
> +
> +	cl_ccmp_hdr2pn(pn, skb->data + hdrlen);
> +	res =3D memcmp(pn, cl_sta->rx_pn[tid], IEEE80211_CCMP_PN_LEN);
> +	if (res < 0) {
> +		cl_hw->rx_info.pkt_drop_invalid_pn++;
> +		return -1;
> +	}
> +
> +	memcpy(cl_sta->rx_pn[tid], pn, IEEE80211_CCMP_PN_LEN);
> +
> +	return 0;
> +}

Why do you do this stuff in the driver if it's effectively the same as
in mac80211?

johannes

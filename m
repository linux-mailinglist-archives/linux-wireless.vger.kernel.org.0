Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A92264EC7E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLPN7x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 08:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPN7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 08:59:52 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABB20BE1;
        Fri, 16 Dec 2022 05:59:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E7BE1BF20A;
        Fri, 16 Dec 2022 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671199189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hp6TfbRZV7OcQ21tpJuS9gcMMMZK3grtCUQP++mcrBA=;
        b=NZe0Jr+99kUogF29pD8qI8MDP/nTg1tcjzmRLHVEngafoJ/xWgsWgW9pK4APGoW8DPixDT
        VcIn3/FkbZt+XmxHTKXEfxAZG9SLbANQiXF4mg2K7Yj9Ckdq6fLBpXsNq5+iKsho7vfBJc
        3/z3pvkQ0cjW7S49z99d+nqtw0Fdsfuve5l9kTD6U9d69Zt4Kbh3MIpgf595qylVD90bVo
        Kd5ynIr7S1mYjQTWyZL3kSK7E2+eCYZuvVi4RavqYUwS3jNAgvvFlJILKKHy9HVQQo+/Cz
        I0OMMUkoLrMWG5duJPZDO+cMEZn/5nrVeFZzlHBOcg78XEedQtjuJkWxtIUElg==
Date:   Fri, 16 Dec 2022 14:59:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-wpan@vger.kernel.org, linux-wireless@vger.kernel.org,
        Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [bug report] mac802154: Move an skb free within the rx path
Message-ID: <20221216145946.3b38c86f@xps-13>
In-Reply-To: <Y5rVW/Mb8nw0MCF3@kili>
References: <Y5rVW/Mb8nw0MCF3@kili>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

- wireless@ (not relevant for net/ieee802154 and net/mac802154 changes)
+ Alex and Stefan, the 802154 maintainers

error27@gmail.com wrote on Thu, 15 Dec 2022 11:05:47 +0300:

> Hello Miquel Raynal,
>=20
> The patch 4d1c7d87030b: "mac802154: Move an skb free within the rx
> path" from Oct 26, 2022, leads to the following Smatch static checker
> warning:
>=20
> 	net/mac802154/rx.c:307 ieee802154_rx()
> 	warn: 'skb' was already freed.

It took me a good minute to figure this one out, actually the main
purpose of commit 4d1c7d87030b ("mac802154: Move an skb free within the
rx path") is to do the freeing in one part, that's why we no longer need to
do it in __ieee802154_rx_handle_packet(). But, well, I forgot the very
first check at the top which was still freeing the skb upon parsing error.

I will immediately send a fix, thanks for the report.

Miqu=C3=A8l

> net/mac802154/rx.c
>     271 void ieee802154_rx(struct ieee802154_local *local, struct
> sk_buff *skb) 272 {
>     273         u16 crc;
>     274=20
>     275         WARN_ON_ONCE(softirq_count() =3D=3D 0);
>     276=20
>     277         if (local->suspended)
>     278                 goto free_skb;
>     279=20
>     280         /* TODO: When a transceiver omits the checksum here,
> we 281          * add an own calculated one. This is currently an ugly
>     282          * solution because the monitor needs a crc here.
>     283          */
>     284         if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
>     285                 crc =3D crc_ccitt(0, skb->data, skb->len);
>     286                 put_unaligned_le16(crc, skb_put(skb, 2));
>     287         }
>     288=20
>     289         rcu_read_lock();
>     290=20
>     291         ieee802154_monitors_rx(local, skb);
>     292=20
>     293         /* Level 1 filtering: Check the FCS by software when
> relevant */ 294         if (local->hw.phy->filtering =3D=3D
> IEEE802154_FILTERING_NONE) { 295                 crc =3D crc_ccitt(0,
> skb->data, skb->len); 296                 if (crc)
>     297                         goto drop;
>     298         }
>     299         /* remove crc */
>     300         skb_trim(skb, skb->len - 2);
>     301=20
>     302         __ieee802154_rx_handle_packet(local, skb);
>=20
> This frees skb.
>=20
>     303=20
>     304 drop:
>     305         rcu_read_unlock();
>     306 free_skb:
> --> 307         kfree_skb(skb); =20
>=20
> Double free.
>=20
>     308 }
>=20
> regards,
> dan carpenter

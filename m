Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011A74EEBC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGKMYz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGKMYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 08:24:37 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1651BC5
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 05:23:49 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso69892315e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689078084; x=1691670084;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8qL+FKB3NRMZQtW5eTuMeVwqoQBnBSAfsF2IIW3bbc=;
        b=kuM1GEoDt8Mocq9w/zJDYB5c9ttnEgfS5VXxqxZD/5oq0wwmArHOtCTNas3Av7JeNQ
         ufZAx7KjT/yMBMFSjxlCmvyRicdHAZokN8PJ0Z2zUcQ6QW4rraND/03Sn+GWrjZ56wgT
         Tw/F68zO6r/gjzl0JGqzGFMtkGuto4tZStEzNKzJQsad6lq1zZxYTwxvRYROzgGel1RD
         y/puRb38aWOdZY5wIUVchDBkmJ6sx71cUY865Luno1tN8z0VevwqejVG1AWr3+NrSIAZ
         JXS6BPDvxGQ2vD/NgFh8uUDz0VsMf6F4PkXsDuSENigk+gTOA+6MhEaS3hcF7aoE0+0I
         GsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078084; x=1691670084;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j8qL+FKB3NRMZQtW5eTuMeVwqoQBnBSAfsF2IIW3bbc=;
        b=A36704ZzautmBXW4Wq0GJ//zNhXtNUDOINaedUcpX8w36xtRuBxI+YVIOJW+nHhx+M
         vrBJv+CFZxtaQf++n0jSWjK/0HBYPydbnnJV77HWK3Nje18G3Ec7N1G+LXZOvCCt5+Ek
         UEADBLYnb9WbO+Zsngdk15Zah9XPzY38Qf1r2SB+AtIcwz62eAhpfGySUB9pZFfruChv
         1YMtAj4M2sxD2FJSLoZfa2v4EgB8ESigZ5shnBuqqhhXjtZn82GXuMnQ6TZ7m0wHD6hI
         G7JCWcG1mfWPtuEs4sG7ZTMhc5IZ3UsBWklTb9yLHR1IC219XJWlu3BKN7ZslukiYTw+
         312A==
X-Gm-Message-State: ABy/qLaHaq2i95ACHuKuBg8LSCNl0+KEG0+XLdjRzkjFNng0wc0Wpfyu
        GNhf1aaJwxvKH36TWQ+raSQ=
X-Google-Smtp-Source: APBJJlFQBUu6b2DbatZUXch40wSVSOfWoQq9oz1L4KwNOCmH910soO14F5zdUJUa2Pr+V+ihVR5JkQ==
X-Received: by 2002:a7b:cd94:0:b0:3f7:f2d0:b904 with SMTP id y20-20020a7bcd94000000b003f7f2d0b904mr20170516wmj.8.1689078083530;
        Tue, 11 Jul 2023 05:21:23 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0031437ec7ec1sm2166600wrw.2.2023.07.11.05.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:21:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Jul 2023 14:21:22 +0200
Message-Id: <CTZC7J3QNXPE.LQ6QWU7ZR0L8@syracuse>
Subject: Re: [PATCH wireless] wifi: cfg80211: fix receving mesh packets
 without RFC1042 header
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Felix Fietkau" <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
Cc:     <johannes@sipsolutions.net>
X-Mailer: aerc 0.15.1
References: <20230711115052.68430-1-nbd@nbd.name>
In-Reply-To: <20230711115052.68430-1-nbd@nbd.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue Jul 11, 2023 at 1:50 PM CEST, Felix Fietkau wrote:
> Fix ethernet header length field after stripping the mesh header
>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CT5GNZSK28AI.2K6M69OXM9RW5@syracuse/
> Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh=
 interfaces")
> Reported-by: Nicolas Escande <nico.escande@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/wireless/util.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 89c9ad6c886e..1783ab9d57a3 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -580,6 +580,8 @@ int ieee80211_strip_8023_mesh_hdr(struct sk_buff *skb=
)
>  		hdrlen +=3D ETH_ALEN + 2;
>  	else if (!pskb_may_pull(skb, hdrlen))
>  		return -EINVAL;
> +	else
> +		payload.eth.h_proto =3D htons(skb->len - hdrlen);
> =20
>  	mesh_addr =3D skb->data + sizeof(payload.eth) + ETH_ALEN;
>  	switch (payload.flags & MESH_FLAGS_AE) {

I tested this on my side and everything works again, so if you want/need it=
:

Tested-by: Nicolas Escande <nico.escande@gmail.com>

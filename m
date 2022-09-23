Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E4A5E749A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiIWHMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIWHMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 03:12:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99B12386B
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 00:12:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so18351690lft.12
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Q9XLgjH24Eqjg6RRtYVvfWduJ61UcgsEusT0WAtU5E8=;
        b=hzeeuLSH4lw7vzdJ93tAxggaRfrX4k3h+rzmlZJLjzINbxknhshkYu3oCP7+31RfjJ
         VimAgUp4uDylHufMWezg76DnXXXzlz42gFLHTrt4Qt+iJ+GMwXHzWzawWeYId63gsluG
         05Nd3tenY+qHIynBjcMp4cb2ZtWLyWthQGpwXC8PQFme5swtbcuk6e4JN581Ys0DAJAO
         nFggqgYNZwqD+IHBkvjmWC/uZySF8ODpOgQu7qdpRcOSJ+9aFB1FFj2Nwzg8WZEHqcuu
         DwP7jIE1B/sTaaiDXaDcbk/ICUIyFRDIfZJDga03qBmS5qeRqn3azPty7NrnaTw0Y/+8
         Ov1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Q9XLgjH24Eqjg6RRtYVvfWduJ61UcgsEusT0WAtU5E8=;
        b=7Pq+OBGJQZfu/Ng+IKQqQCrKRbG7R1wOz00f2OXDWlG/q22x0eNN61DFxOO0gupRBo
         3K0WUhA5Wkssr8H8mbJkVJDHKiCnOJZeKxNTuCTquwaP7U9zlNqsrMeYGon4ec/p0KHn
         UH+WMIuUD1ToAITN5u1+Oy0+y49g2D2Bun78XhGDyMeue/XK1ezRFk6lm+7rZOa56IVr
         jTRR5BlLJdkkf52adCSd3qlF3exxsLgFGOSy6hcEM2TyYQ01yTDP0DcmKK9G7o7U5Xg6
         yjhqhkdJCv722qtCW8QeBYJSyQPJXy2iZUwf+AC5k9Td9bS6698fZS8wj2/tE0lKGvDm
         IUFQ==
X-Gm-Message-State: ACrzQf2IrfOObf8rrRWB7zU8uXf8FYXFazFB6RuHl/eaLe7ShVVswZJv
        yzbw5aUAQmPVpqoEcTZFb3rVtrC28XYgc0PTF8WGk7AGVXE=
X-Google-Smtp-Source: AMsMyM7SUot99+odrVUx4EhthB5Xit8k7KgoNVBPCDxRXJJyq79wc67K8GDgmk2mZKzsDqgQboxM4OEk5XnEGcfBeFM=
X-Received: by 2002:a05:6512:685:b0:49f:4929:4c6e with SMTP id
 t5-20020a056512068500b0049f49294c6emr2890888lfe.642.1663917119095; Fri, 23
 Sep 2022 00:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220922203240.108623-1-marex@denx.de>
In-Reply-To: <20220922203240.108623-1-marex@denx.de>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Fri, 23 Sep 2022 09:11:48 +0200
Message-ID: <CANh8QzxfznS3jB8OgwRAp68wGcTDctzvBSeaXQH2bPicOSyyYA@mail.gmail.com>
Subject: Re: [PATCH] wifi: rsi: Fix handling of 802.3 EAPOL frames sent via
 control port
To:     Marek Vasut <marex@denx.de>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Angus Ainslie <angus@akkea.ca>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Siva Rebbagondla <siva8118@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marek,

On Thu, 22 Sept 2022 at 22:33, Marek Vasut <marex@denx.de> wrote:
>
> When using wpa_supplicant v2.10, this driver is no longer able to
> associate with any AP and fails in the EAPOL 4-way handshake while
> sending the 2/4 message to the AP. The problem is not present in
> wpa_supplicant v2.9 or older. The problem stems from HostAP commit
> 144314eaa ("wpa_supplicant: Send EAPOL frames over nl80211 where available")
> which changes the way EAPOL frames are sent, from them being send
> at L2 frames to them being sent via nl80211 control port.
...
> Therefore, to fix this problem, inspect the ETH_P_802_3 frames in
> the rsi_91x driver, check the ethertype of the encapsulated frame,
> and in case it is ETH_P_PAE, transmit the frame via high-priority
> queue just like other ETH_P_PAE frames.
>

> diff --git a/drivers/net/wireless/rsi/rsi_91x_core.c b/drivers/net/wireless/rsi/rsi_91x_core.c
> index 0f3a80f66b61c..d76c9dc99cafa 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_core.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_core.c
> +
>                 if (skb->protocol == cpu_to_be16(ETH_P_PAE)) {
> +                       tx_eapol = true;
> +               } else if (skb->protocol == cpu_to_be16(ETH_P_802_3)) {
> +                       hdr_len = ieee80211_get_hdrlen_from_skb(skb) +
> +                                 sizeof(rfc1042_header) - ETH_HLEN + 2;
> +                       eth_hdr = (struct ethhdr *)(skb->data + hdr_len);
> +                       if (eth_hdr->h_proto == cpu_to_be16(ETH_P_PAE))
> +                               tx_eapol = true;
> +               }
> +
> diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
> index c61f83a7333b6..d43754fff287d 100644
> @@ -168,6 +171,16 @@ int rsi_prepare_data_desc(struct rsi_common *common, struct sk_buff *skb)
> +       if (skb->protocol == cpu_to_be16(ETH_P_PAE)) {
> +               tx_eapol = true;
> +       } else if (skb->protocol == cpu_to_be16(ETH_P_802_3)) {
> +               hdr_len = ieee80211_get_hdrlen_from_skb(skb) +
> +                         sizeof(rfc1042_header) - ETH_HLEN + 2;
> +               eth_hdr = (struct ethhdr *)(skb->data + hdr_len);
> +               if (eth_hdr->h_proto == cpu_to_be16(ETH_P_PAE))
> +                       tx_eapol = true;
> +       }
> +

It looks like the same logic is being duplicated twice. Maybe create a
helper function for it, something like bool rsi_is_eapol(struct
sk_buff *skb) ?

Also I think it would be good to tag this for stable.

Martin

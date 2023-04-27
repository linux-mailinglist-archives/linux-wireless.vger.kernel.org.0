Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571206F013D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 09:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbjD0HIa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 03:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243013AbjD0HI3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 03:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64658469F
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682579260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlogBekyk2gSeEekDg86LcWxQDtHbn1xGkaDN0V88A0=;
        b=Et77/lmWqklBqJ745Br0WlrONTiGDqFwzJvWVdFukWEgnvMQy6lzksT56q18DTw2m9sYCm
        d4QSeuIGkl0EFnbmfP1uFwtnlvqfepj4fkueIeCBjK3ghVzGDKxLeSFC1FV/vNf3Dn8Gwx
        Ozlh70Ai3SgPPr9H4ZGW4ybiztxKCXE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-K5_VejmmPFyytd-JtxTGuQ-1; Thu, 27 Apr 2023 03:07:39 -0400
X-MC-Unique: K5_VejmmPFyytd-JtxTGuQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ecd50d9db9so12480511cf.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 00:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682579258; x=1685171258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlogBekyk2gSeEekDg86LcWxQDtHbn1xGkaDN0V88A0=;
        b=A0NRgg80V9Y946kHqDHdjflyl6x8FMkMMrTZ1gfFCU0V+B40nTt7Qrc6OifTNhbkzF
         8E9IXLuTC1e+jcxyNgLpuY6om2eGhN6JrgwpDaQJSFat5YBgKQK20Bpkjn99f6U9bZec
         B4t7rrxhYqSWOXb94oUvgNkScCn8NbzlfikiuuuJ0Zf0lCGjzWat+10AtO3cofl6D4iV
         WYwTj/k3GYjRR3dyO/bZoNLlK8J1WVH7ZPZktqdNtX8rkTZsnzEc65nAFxECH7VZKBl5
         rtv6SPcG3EbV4DzoSYUcucXdW1fkuVinDWfYAnsWntGmt6opWuqhaqVY9JqROlTP3Vou
         1neQ==
X-Gm-Message-State: AC+VfDxxxnmiuy0s39xugjCkryvvQPlwECoOw8zgDNt2M7vrxfUhAcho
        XmdeNR7Ee074ZafbRk4KLmKZzb4E2cFGdIqsqEBemwCqS/9Ym3YEppF8pgmaz4ER8R0oX15UcU2
        SpsUhRmVNiilzIXnHXZ8rpMCBlFg=
X-Received: by 2002:a05:622a:510:b0:3ef:37fa:e1d6 with SMTP id l16-20020a05622a051000b003ef37fae1d6mr818899qtx.2.1682579258346;
        Thu, 27 Apr 2023 00:07:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5F3RtmIl+pQlfLGDCcC43NoGUaeEyMbtQ1c/nG8/GmJLAbwkFZxTzib2OlzZCRXxLG9aqQUw==
X-Received: by 2002:a05:622a:510:b0:3ef:37fa:e1d6 with SMTP id l16-20020a05622a051000b003ef37fae1d6mr818879qtx.2.1682579258051;
        Thu, 27 Apr 2023 00:07:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-21.dyn.eolo.it. [146.241.243.21])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a094400b0073b8745fd39sm2198762qkw.110.2023.04.27.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 00:07:37 -0700 (PDT)
Message-ID: <e05d4d4d33a2c50973d139752b4fcfad5dbdf056.camel@redhat.com>
Subject: Re: [PATCH net-next] wifi: ath11k: Use list_count_nodes()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 27 Apr 2023 09:07:34 +0200
In-Reply-To: <87v8hiosci.fsf@kernel.org>
References: <941484caae24b89d20524b1a5661dd1fd7025492.1682542084.git.christophe.jaillet@wanadoo.fr>
         <87v8hiosci.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-04-27 at 07:35 +0300, Kalle Valo wrote:
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
>=20
> > ath11k_wmi_fw_stats_num_vdevs() and ath11k_wmi_fw_stats_num_bcn() reall=
y
> > look the same as list_count_nodes(), so use the latter instead of hand
> > writing it.
> >=20
> > The first ones use list_for_each_entry() and the other list_for_each(),=
 but
> > they both count the number of nodes in the list.
> >=20
> > While at it, also remove to prototypes of non-existent functions.
> > Based on the names and prototypes, it is likely that they should be
> > equivalent to list_count_nodes().
> >=20
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Un-tested
>=20
> I'll run sanity tests on ath11k patches. I'll also add "Compile tested
> only" to the commit log.
>=20
> Oh, and ath11k patches go to ath tree, not net-next.

Just for awareness, there are 2 additional patches apparently targeting
net-next but being instead for the WiFi tree:

https://lore.kernel.org/all/e77ed7f719787cb8836a93b6a6972f4147e40bc6.168253=
7509.git.christophe.jaillet@wanadoo.fr/
https://lore.kernel.org/all/e6ec525c0c5057e97e33a63f8a4aa482e5c2da7f.168254=
1872.git.christophe.jaillet@wanadoo.fr/

Cheers,

Paolo


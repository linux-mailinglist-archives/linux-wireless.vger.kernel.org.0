Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9E797485
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjIGPjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbjIGPZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 11:25:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0611BEF
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 08:25:15 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64c1d487e72so6805126d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694100312; x=1694705112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aycCTyJOheIDKo1ZgbnwW6zsxD+FQHxnfjQ1uwRRryI=;
        b=V4MvRtaAR2DyJfa3MYY14uOOv9cCujVC8hdQBPwZtG9vZzVuhk+tLy2lOhAYJP7gx7
         roUOCtbZzHU4uoMfTcpIk/6AvoLR4842IJLtUO8nVLlQ+rZUUh9o86Vv6p4hQcXgMXzO
         XZbvhm4GgwR/93b5dAfaYOB6JT/12ioS3i5AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100312; x=1694705112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aycCTyJOheIDKo1ZgbnwW6zsxD+FQHxnfjQ1uwRRryI=;
        b=WnE3ZeRN7WDQI+tHSVDalteG5+TSGJC8FeZ768F+MZzM2+66OZMaKyiII1bCGdvBY8
         q7xe0dja855N0rNMw7+uFHfoJpJInvdxlm5R9TtYQdMCQqoRbEPVZpQLT0Fu4Icp/o9q
         IVfbqLyqcCiwkc+ZIuNOPO0RVXPKugm1xlzQQnRWWKBJ3Mna5abJsUMzSlZnhbOgxLWK
         xxdTAn483bNGldVJvO3M8za5vQJyAsVDMxzTJdGvuthjBzq8ZTt6lraOPpVCvzesfJuc
         vjtww7rOXL8lBD+Wcb3lnd8tVoUt+mNBQOseNUkfwTnRU90g99DSv3VeP4lm4wqXInUq
         6ukA==
X-Gm-Message-State: AOJu0YwfZuZVoeBDsezpbZvq7rj4Xl0DHSr/6VF9WRDj9yb9pmuzg5Yc
        w352uWcLhb9OpogJeb7BTHDarxCaXFl/5shZwHra3D7kLzknzbC2
X-Google-Smtp-Source: AGHT+IFj2FlIKXoMOrdA8m6h1SxwqJEdWc5x6fTQOPsL29IpibzHq4rNR/U1JI7AAj1ZLriuWigLzvMPJRO0C0GjGD0=
X-Received: by 2002:a92:cc82:0:b0:34d:f026:7aa1 with SMTP id
 x2-20020a92cc82000000b0034df0267aa1mr18419028ilo.26.1694078781179; Thu, 07
 Sep 2023 02:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102940.1120269-1-treapking@chromium.org> <CABRiz0r8qHgx-4b7QdCj6iz9FDsyChznEHOn5eByVoUYuLa-PQ@mail.gmail.com>
In-Reply-To: <CABRiz0r8qHgx-4b7QdCj6iz9FDsyChznEHOn5eByVoUYuLa-PQ@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 7 Sep 2023 17:26:10 +0800
Message-ID: <CAEXTbpdqhxWVMSHz-8+=50_qd1UViKvD5YZY08=RFMBu5E6b2A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Matthew Wang <matthewmwang@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Matthew,

On Thu, Sep 7, 2023 at 5:10=E2=80=AFPM Matthew Wang <matthewmwang@chromium.=
org> wrote:
>
> > -       if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> > -                    sizeof(bridge_tunnel_header))) ||
> > -           (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> > -                    sizeof(rfc1042_header)) &&
> > -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_AARP &=
&
> > -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_IPX)) =
{
> > +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <=3D skb->len &&
>
> sizeof(*rx_pkt_hdr)?

Thanks for catching this. I'll upload a v2 for this.

Best,
Pin-yen

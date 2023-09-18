Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615E7A43C2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjIRIBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 04:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjIRIBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 04:01:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B82B6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 00:59:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c07e122a78so2792706a34.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695023941; x=1695628741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGqLnfLS16BMC5Edk6K47RqEUmOdv7ff2FeIy28NY94=;
        b=gdxGuCzASApUNDtwTJwfvEpqvASR8NdH0OHsRgz2Yh836wR7nREN/GwdEvmUZJFL39
         EDpXoYO0Z2hxo8+rsQPHcPPqfuoKhOz4qk6lfPVpTB0aklo3RkidBmpn9v5AM5NYQmjc
         rL1xcxm5gXp+VXoChj69jUDXccOgGHh12+h2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695023941; x=1695628741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGqLnfLS16BMC5Edk6K47RqEUmOdv7ff2FeIy28NY94=;
        b=JsBsUbfJEzyz1cdBhl+iy95RdfiePIRAeMYXgWALq8x+Q60WWvMD8yhmwwaBTD2bCx
         sX93Y24hLQ06iDTin9J90kCxGQWsMhKERbMLVrpYbKEO4Fvbpw20xlq0CqI/h3qdC3N+
         y5heC0EKwBcUtvydRYZjhlxCgasBdK4n26dh05W+TUT8Yzq/HIHj0mtrg8GaqLc2kq/N
         etP8cNL5hv8pJTitMNMfm5k3fPeFoUSi3Q6+JyLnS+esOfMi9SZ99ybtr0RsCjEuMl6w
         XPt0CVNPG7tXuvzBxQ0awDvelCHTM9Qe7s5ZkcozTwE/ap+sCHSw93tpoiH1qpLGSsFP
         rF5A==
X-Gm-Message-State: AOJu0Yy8O/F5QD4SZ4WsFXLgrhKlMaGqb8AX5eNkf0pnF/lGbB0lirV+
        CepZrb0RN1HNt2Os2N377+CP6QFVdgCCIbIUt4JZJuKLvSS8F4N4
X-Google-Smtp-Source: AGHT+IFQwkO1wOvSdW3thitMuylCuXAXRgN/DraI5tqYKk2lxwowV+q7D4RihOvOHn9tLlJa+cEHRbohaQVXnP48ZUI=
X-Received: by 2002:a4a:d208:0:b0:571:aceb:26d2 with SMTP id
 c8-20020a4ad208000000b00571aceb26d2mr8459102oos.3.1695023448533; Mon, 18 Sep
 2023 00:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230908104308.1546501-1-treapking@chromium.org>
 <ZQIcDWKrmgoPkwlN@google.com> <CAEXTbpc=QC6wC-W2VZCaRCp6rSpyNSsq5M6cxNcqAQxciNj0vg@mail.gmail.com>
 <ZQOZZZgHP2EeDNix@google.com>
In-Reply-To: <ZQOZZZgHP2EeDNix@google.com>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Mon, 18 Sep 2023 09:50:37 +0200
Message-ID: <CABRiz0ph56X48Y0VjS1yDEUW3=kihE4+WSHPuFVQv-CCdR=0cw@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Brian Norris <briannorris@chromium.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

lgtm

Reviewed-by: Matthew Wang <matthewmwang@chromium.org>

On Fri, Sep 15, 2023 at 1:38=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Thu, Sep 14, 2023 at 03:09:47PM +0800, Pin-yen Lin wrote:
> > On Thu, Sep 14, 2023 at 4:31=E2=80=AFAM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > > I'd appreciate another review/test from one of the others here
> > > (Matthew?), even though I know y'all are already working together.
>
> I'd still appreciate some comment here.
>
> > > > -     if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> > > > -                  sizeof(bridge_tunnel_header))) ||
> > > > -         (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> > > > -                  sizeof(rfc1042_header)) &&
> > > > -          ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_AARP=
 &&
> > > > -          ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_IPX)=
) {
> > > > +     if (sizeof(*rx_pkt_hdr) + rx_pkt_off <=3D skb->len &&
> > >
> > > Are you sure you want this length check to fall back to the non-802.3
> > > codepath? Isn't it an error to look like an 802.3 frame but to be too
> > > small? I'd think we want to drop such packets, not process them as-is=
.
> >
> > I did that because I saw other drivers (e.g., [1], [2]) use similar
> > approaches, and I assumed that the rest of the pipeline will
> > eventually drop it if the packet cannot be recognized. But, yes, we
> > can just drop the packet here if it doesn't look good.
> >
> > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/net/wireles=
s/intersil/hostap/hostap_80211_rx.c#L1035
> > [2]: https://elixir.bootlin.com/linux/latest/source/drivers/net/wireles=
s/intel/ipw2x00/libipw_rx.c#L735
>
> Hmm, I suppose. I'm frankly not sure how exactly all upper layers handle
> this, but at least in a non-raw mode, we'll drop them. (We might be
> delivering awfully weird packets to tcpdump though, but this is already
> a weird situation, if it's such a weird-looking packet.)
>
> > > If I'm correct, then this check should move inside the 'if' branch of
> > > this if/else.
> >
> > We can't simply move the check inside the if branch because the
> > condition also checks rx_pkt_hdr->rfc1042_hdr.snap_type. Though, of
> > course, it is doable by adding another `if` conditions.
>
> Right.
>
> I guess this is probably OK as-is:
>
> Acked-by: Brian Norris <briannorris@chromium.org>

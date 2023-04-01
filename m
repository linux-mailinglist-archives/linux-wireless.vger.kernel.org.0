Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89D6D2E21
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 06:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjDAEX2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 00:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDAEX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 00:23:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448831C1E6
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 21:23:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cj15so16079735qtb.5
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 21:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680323005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wYWtAIzbgTpBDndaeSAFsY/zzg9NhVUMB55w5k8wkQ=;
        b=fSL9GasNIxiAVGN0heUI5naARyu2/X+Xfys2Jv9cm309pqVDPY1+4Aj0VLi6nideoJ
         9p8AGd+Xf306zvbnhPlVPJEkeMBc0vS16nd6O+3QIxObWA6u5fEeFNiVVKYCY+Jb8DJJ
         yu9ULOI/yCGjy1lSTrDSGrv5yv98+HKWf9YddJ9jM0p/zgOzpMMlRO1NUOH0xSW+jCly
         qmpbE1HmT8apijtxp4uBwMPzG5TMyHrluKJiM/PZlVO3kWFEuWD8S0UVzZegzZg36MHc
         awXI04IyyRaXazMD2PdEG8doSEh2J8isiwJLVAWBuJB9+1+ZXkZRkfhDxhWJnit+6Ku9
         yXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680323005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wYWtAIzbgTpBDndaeSAFsY/zzg9NhVUMB55w5k8wkQ=;
        b=VpapHQum1XCtGmgRY7+Fvl1Bpii+B0Tt9vzBWTE7xQjgEgj9RJP3Yi6ByBwKos8hhn
         yilYD6yoQVywKrncB5wZjNXP3I2y453kPzOMoD3CmiPSjA4ileEruQzFdLG4LFbvJSo/
         86fQs1e0N7TvrPc95oig6RqhaLpPcZDI9N73X+9kXwekhbrHpxVR7Qawzs6ZjMLzgtKn
         ciqLTcqQMNulv4fByc+an8cM4pLcl/ai82uuLwi51S72bmUXWkwhm4QAXvNdBBzDcISn
         mFYBenWIRb3O5M7igzHCB98vxZMnCo6Nj8dcW2dQGUTh2WgTwiRUetVvq8ddNwv9xLYt
         N25g==
X-Gm-Message-State: AAQBX9ebts7gRKciFCaQ3deegYt2DOS30zmno9QyuP8O97/aGAWj1lQU
        S6Q8X73rOiEJCuQ6W+3K5r6az5d42yaq5X+rPsbv06pl
X-Google-Smtp-Source: AK7set/h2AQsrO2YLLAqK/rTKGTO1kiz5QXd39C6paCCvSx3Ua+TI4vcAskzR+dP9I0SL4heMD3YsLwAdEKISC9mbIQ=
X-Received: by 2002:ac8:5744:0:b0:3e0:c4ac:1620 with SMTP id
 4-20020ac85744000000b003e0c4ac1620mr11097575qtx.13.1680323005001; Fri, 31 Mar
 2023 21:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
In-Reply-To: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sat, 1 Apr 2023 15:23:13 +1100
Message-ID: <CAGRGNgUoEoN9Tm8=1LRtznbwm2KqiArtUHjXXZht0Nz1ZPunow@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bitterblue,

On Sat, Apr 1, 2023 at 7:18=E2=80=AFAM Bitterblue Smith <rtl8821cerfe2@gmai=
l.com> wrote:
>
> Add some new members to rtl8xxxu_fileops and use them instead of
> checking priv->rtl_chip.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++++
>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |  1 +
>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  5 ++++
>  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         |  1 +
>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |  9 +++++++
>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  3 +++
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 +++++--------------
>  7 files changed, 31 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/dri=
vers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> index 6a82ec47568e..af8436070ba7 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> @@ -1883,6 +1883,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops =3D {
>         .rx_desc_size =3D sizeof(struct rtl8xxxu_rxdesc16),
>         .tx_desc_size =3D sizeof(struct rtl8xxxu_txdesc32),
>         .has_tx_report =3D 1,
> +       .init_reg_pkt_life_time =3D 1,

I'm sure it's safe, but the fops structs that don't set the
ampdu_max_time and ustime_tsf_edca values feel odd.

>         .gen2_thermal_meter =3D 1,
>         .adda_1t_init =3D 0x0b1b25a0,
>         .adda_1t_path_on =3D 0x0bdb25a0,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/dri=
vers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> index 82dee1fed477..dfb250adb168 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> @@ -1746,6 +1746,11 @@ struct rtl8xxxu_fileops rtl8188fu_fops =3D {
>         .has_tx_report =3D 1,
>         .gen2_thermal_meter =3D 1,
>         .needs_full_init =3D 1,
> +       .init_reg_rxfltmap =3D 1,
> +       .init_reg_pkt_life_time =3D 1,
> +       .init_reg_hmtfr =3D 1,
> +       .ampdu_max_time =3D 0x70,
> +       .ustime_tsf_edca =3D 0x28,

The original code had comments for why the 8188fu had different values
for ampdu_max_time and ustime_tsf_edca. Should they be copied here?

>         .adda_1t_init =3D 0x03c00014,
>         .adda_1t_path_on =3D 0x03c00014,
>         .trxff_boundary =3D 0x3f7f,

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

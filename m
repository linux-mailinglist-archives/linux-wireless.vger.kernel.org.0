Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141E77985F1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbjIHKhw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjIHKhv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 06:37:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9791BC6
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 03:37:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34ca1bcb48fso6557705ab.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 Sep 2023 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694169467; x=1694774267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80krzZRowgddWNJtnNp7zFc+ghk0VyfSZBn4jNSA0+w=;
        b=Nrc81z5IGgQhgkRdMKSfrVBXjqVJKnWfuaicGg6NDFCMtgjyGsK3L2IpPr2HlAQILs
         maG9UKsco7S9qFb/0Pp8YAZPhpK6gBLF+KOWH3/hYnnqAcUuFRz0Nuk+nB+ltKyoPxvk
         ca7kXMc6gIgg0rBTvBEk4dTsg2nh7qU4m5gfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694169467; x=1694774267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80krzZRowgddWNJtnNp7zFc+ghk0VyfSZBn4jNSA0+w=;
        b=T3ZJsJdSTbldKYxnwVRmLSoqKbpjuNbPvZjk9QIMIls6o6lTqlGwNgThqanKgCUcnO
         ng6FXLppDzNdl9DPO2sinGBfYWE/vNMZ/m+eJADivE7Q8pS5rdXfIwrvoLbmMRK3k5wO
         qHDnbmzdiTpQXjcRil9I/OihmHjPKAdspEVe7i+jN//wAfELevlrc8fnHxD6G/Tt4cpk
         7Raz/YDXNxxPciSXBDQw/Y3iaWaMEMi3BG3hSMGetVwgobQh4wDSUyeX1BhCsb4MK2Ph
         /M0Bva/MykL3thhTH5tmIAHlzHgvshuesCFdsa7nxSjkWz2FlwLl1RJ5i/rUgA4M7C3d
         tP+g==
X-Gm-Message-State: AOJu0YxnOnMybDZ4fr3IL0lX3+YQAIyKpkp4bXwvK9yMakKFP5pR5oEq
        +mPd11cbCZplq963xCwLThefzTX1luga5JDAHvBCDQ==
X-Google-Smtp-Source: AGHT+IFdRKFwiGzVlzSdlYLWipQaRrS6Epqikt0gjNp2AgniwAJNtdyojzLjTBMnvYyhFtmU4skh7IC4Y0aDgdaOxfk=
X-Received: by 2002:a05:6e02:1a42:b0:345:a201:82b7 with SMTP id
 u2-20020a056e021a4200b00345a20182b7mr2940148ilv.26.1694169467753; Fri, 08 Sep
 2023 03:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230907093927.400634-1-treapking@chromium.org> <CABRiz0q9TjryfNs8m6czuExWRCpXiVYw0K7kW62r+jstBAm2Lw@mail.gmail.com>
In-Reply-To: <CABRiz0q9TjryfNs8m6czuExWRCpXiVYw0K7kW62r+jstBAm2Lw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 8 Sep 2023 18:37:36 +0800
Message-ID: <CAEXTbpeiHjPqjkQaRbMcGeL-zPNM4+zo6Qwi1rDcEvmSKYGPkw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Matthew Wang <matthewmwang@chromium.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 8, 2023 at 6:23=E2=80=AFPM Matthew Wang <matthewmwang@chromium.=
org> wrote:
>
> > +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <=3D skb->len &&
>
> Not fixed. Did you accidentally resend the same patch?

... yes I think I messed up again. I'll send out a v3 for this.

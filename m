Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286C67EEB50
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 04:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbjKQDJd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 22:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjKQDJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 22:09:33 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF63B7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 19:09:28 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7af52ee31so17645047b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 19:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1700190568; x=1700795368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dvQwYX0AbNUKYJxhYB7mWucZ5NqgiQwNSXvYRsaqmw=;
        b=dutC8bD8mQK8tgXHdN5KNauYD/bua0EKP0PDeN+0bf4V2L9nsVFkokRjRb65i0t7Ao
         0F6x2LhX5atOdi2OXOhKCZeXuvdz4UPl+hy3HWCVZZSu2HDD1o+x6qUPEW0JS4Pc1G2Q
         OKUkFwYSONg94vm5GRVpLMUTx2unnhuCYVZ0/GO9hD1/BMymKEia0zNTLMi8Vcin0lUH
         6JjvbcDPKIKY5uDmI5ZfFPYcF/fF+K+8Phmn7G7dr+RaZqScv2OeftoPGhO8528x8Dit
         m39YsV0U/IkUjEbZZTrcOfNJv7y8YZXVV/m+K15VDxjqn54kkcBx64l85lXbxClyojP7
         hrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700190568; x=1700795368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dvQwYX0AbNUKYJxhYB7mWucZ5NqgiQwNSXvYRsaqmw=;
        b=QtRqW64Aq9/aoGmopn1oUnM783LCfamJhLKfzDLL9CHP+kCumy+JlMudVZYHD3JuFj
         pO9YrOjYVxIHtf+pmmmc3aDQSDtn4WRG3FxsVperV2LSJZFuFJGuHXZhAVAv1uYPcmoG
         ZvU3XGMWHmJskrZKXjGIWPOnqAHBhHr5f7DholIxzow+tEAMUetQhucHcXTx3KRvP2Sv
         BQl0L3iQMFR0BD5b5EA54CiYhEqOD90aas2XBR5zJjyJBHR/G6ypmDD45Ui4mif6dY/T
         h4Lyrd6UwLlq4bXva6bdwsXkhgnt86fv46nQdoC2ZhWBEtZGzVi6p3VTWtjER5cg+cq/
         AAPA==
X-Gm-Message-State: AOJu0YxlpqRxD2jrfwjOMBNyZ+9NLs6s8KE+l7Vr1NajhaV3RbdVCHkK
        UxsjG8eznwnRLbOsASiIqQVxCMjALIudUQSZi7EP7w==
X-Google-Smtp-Source: AGHT+IEANNmauSZaHaRuZAmzlWQ3y1H8cwhOolm2HJqw4V3xT3mjgn17Nn7CLJc1kr+gi3L9i7oZUIGg/GMyL5hW1VE=
X-Received: by 2002:a81:7142:0:b0:59b:61c2:e8db with SMTP id
 m63-20020a817142000000b0059b61c2e8dbmr16510473ywc.49.1700190567894; Thu, 16
 Nov 2023 19:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20231116180529.52752-1-helgaas@kernel.org> <d370746955d347a88cccc953caa87551@realtek.com>
In-Reply-To: <d370746955d347a88cccc953caa87551@realtek.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Fri, 17 Nov 2023 11:08:51 +0800
Message-ID: <CAPpJ_edhtr_mHD5bZj-bj8j33-9BXia5US-KnkgT56iJY+Dszg@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Bither <jonbither@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> =E6=96=BC 2023=E5=B9=B411=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:58=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Friday, November 17, 2023 2:05 AM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Kalle Valo <kvalo@kernel.org>; Jian-Hong Pan <jhp@endlessos.org>; L=
arry Finger
> > <Larry.Finger@lwfinger.net>; Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.in=
tel.com>; Jonathan Bither
> > <jonbither@gmail.com>; linux-wireless@vger.kernel.org; linux-kernel@vge=
r.kernel.org; Bjorn Helgaas
> > <bhelgaas@google.com>
> > Subject: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Remove the unused "const_amdpci_aspm" member of struct rtl_pci and
> > struct rtl_ps_ctl.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>

Acked-by: Jian-Hong Pan <jhp@endlessos.org>

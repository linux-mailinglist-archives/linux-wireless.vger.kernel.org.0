Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F9E1D25A2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 06:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgENECa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 00:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENECa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 00:02:30 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92BCC061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 21:02:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e18so887676iog.9
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PCt2ho3KG+JP7MaFlADsSScz0pKYM6DAu3MGoigHqEQ=;
        b=BA4NH2T7ziVaFF/ao2osSDokan0aEsgLaVUTUQ3181cwIDrmIPwgtSg8I/Lh3C/CgQ
         mUXwndJKJabAn7LOz4KSOoyGheQIWaZC5g0+sLRoR90+0JfrXwANqC+LOags3fKxcMDH
         v/MNnleMwif22IOl0rjuaD7/fNchpuPaZ/00AX8m0c8N0Mp5JjZERt8wk34iSbQHRDnS
         sJc5URVButvP7WMVYcn/14tjH2SyUzmKAP7MwjwrYSRZiJWlqHU5bXk2XBXBIK/DGxBl
         ZjZcX+HPyzIE1TN6EltGLQYxhXo0L1wlEgK/IIinvQpDUQQaYbMl2+/9r11s5DGbh+qp
         azLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=PCt2ho3KG+JP7MaFlADsSScz0pKYM6DAu3MGoigHqEQ=;
        b=iNWzVCOM4NptCAVxWHMD+pe8bh3XUUhE0YA9HhFeiTX0oy4sXAtLD8ZsRC7xnZjURp
         8f23W7nMYm/aWhKBwGYRKrngQphTv5Qx/LHkBxb0oKP8vfm2+lb6X3Y3hDWMbwKEV344
         lDXtc5prgai6UD0LMTQ848BxsriliXevKIAantnVyK6J7IDojJetcAdXZ4OcWq4gwlzA
         abgeEx9wlc2BP5YXTM4jiS9lB9JCPwrlODF5TEafWWQtJz4IHTHxglDTpDPrgoA/b21y
         vESq8pZ5MfDB+WRmm6YVwAjZ5KnDBLJh1KzdE9HIm+jijKB6sDq3f+akoEvp4QjBvJ3i
         N/Dg==
X-Gm-Message-State: AGi0PuYyMYyZRIr7+UzJHeYzxSfOvrJqpQGoVWkE64fhzZYkc2K209Tk
        NnG9ilTrgtFW61F22Vv1XrvJczXR+xYt+dJEBhVTpw==
X-Google-Smtp-Source: ABdhPJwM7cM/2jhdlnz7kAeBHUaPDeQpEoPWQ4EXWvaaKaIdRXjK1Y0Wpz6AFy/WsSTFiSqGIl1dxtOiwE8x2yyVbNY=
X-Received: by 2002:a02:cb59:: with SMTP id k25mr2577588jap.41.1589428949027;
 Wed, 13 May 2020 21:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSR4cvhDYCYAKqvwe0Gr0St=X=8woZ=vve0-ZEPVXj9=1DwVA@mail.gmail.com>
In-Reply-To: <CAFSR4cvhDYCYAKqvwe0Gr0St=X=8woZ=vve0-ZEPVXj9=1DwVA@mail.gmail.com>
From:   Dongyang Zhan <zdyzztq@gmail.com>
Date:   Thu, 14 May 2020 12:02:21 +0800
Message-ID: <CAFSR4cuoYoM4vN-dhte=Sr56NqkL3X-sCmUDX91z689d1SrQpA@mail.gmail.com>
Subject: Fwd: Potential memory leak bug in mwifiex_init_rxq_ring()
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongyang Zhan <zdyzztq@gmail.com>
Date: 2020=E5=B9=B45=E6=9C=883=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=
=882:16
Subject: Potential memory leak bug in mwifiex_init_rxq_ring()
To: <akarwar@marvell.com>
Cc: <linux-wireless@vger.kernel.org>


Hi,

I am a security researcher. I found a potential bug in
/drivers/net/wireless/marvell/mwifiex/pcie.c. I hope you can help me
to confirm it.

Potential memory leak in mwifiex_init_rxq_ring()
(/drivers/net/wireless/marvell/mwifiex/pcie.c) when triggering
mwifiex_map_pci_memory() fails.

Source Code:
skb =3D mwifiex_alloc_dma_align_buf(MWIFIEX_RX_DATA_BUF_SIZE,
 GFP_KERNEL);
if (!skb) {
mwifiex_dbg(adapter, ERROR,
   "Unable to allocate skb for RX ring.\n");
kfree(card->rxbd_ring_vbase);
return -ENOMEM;
}

if (mwifiex_map_pci_memory(adapter, skb,
  MWIFIEX_RX_DATA_BUF_SIZE,
  PCI_DMA_FROMDEVICE))
return -1;//skb is not released

...
}

Thank you.

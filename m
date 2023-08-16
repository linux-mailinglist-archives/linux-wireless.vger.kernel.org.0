Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945377EBAA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbjHPVXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbjHPVWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 17:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACEE271E
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 14:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0102963DF6
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 21:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C332C433CA
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692220924;
        bh=3Bvp22ELU8nW3j1fp0s4i/sN9z5ZKJBspasKela5NhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FxUoroUCUDcJgv65sZTpxDJ3g7K+m3CvLM7Z096Hq8JyZYn7jK5KrGzklLDGUXTgh
         S1IISiynyWEDHSxY8BZKCizCibGQaXYjxLu4lqZLlD2kfRLZBl74tfBRX+pOrsAeC5
         R7yrnXqni8kX+3QFwoblJeMjEFeRCuQ1m9y1PYgBtkS8FVDmtxYGh1IdtSf8ojwgfS
         uXRxtP2BWMUkDalm/fBH7UOdHJN0mzgkxhaiTN7/uxNbEQBGA3qukhAid/jJssFJ79
         6bg/qrsLwiUoiAL1PomOivwrlEEwBR2cfXxpLbD7b3iRhJ4MZ3mSrchpaVBBzhbPx6
         ISRnpfcQN69wQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99bcf3c8524so159233366b.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 14:22:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz+tfFODeghIR8CZwAjl5vJZoBgNLhciXELRnaZv5vTSwIVMqC0
        Y72biWfIrU+FEC6ox6tpDA4+gSHbvpIbGxj5G3w=
X-Google-Smtp-Source: AGHT+IHqWODBc+h3tM2wS4K19wUprvx5pfsDx8ZnoT5mBofV6pD/AUeaQUn/R6py3UHYuEJvOD2B4YnZuHIkJNX+/dQ=
X-Received: by 2002:a17:906:51c5:b0:99d:e629:6cc1 with SMTP id
 v5-20020a17090651c500b0099de6296cc1mr2035501ejk.5.1692220922611; Wed, 16 Aug
 2023 14:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690863143.git.deren.wu@mediatek.com>
In-Reply-To: <cover.1690863143.git.deren.wu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 16 Aug 2023 14:21:50 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzr1Q48GnvWE1zCGqa0r33u8VQAbaQ7-xBsXxej=gF-xHQ@mail.gmail.com>
Message-ID: <CAGp9Lzr1Q48GnvWE1zCGqa0r33u8VQAbaQ7-xBsXxej=gF-xHQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] wifi: mt76: mt792x: add mt7925 support
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

For the whole series, Reviewed-by: Sean Wang <sean.wang@mediatek.com>

On Tue, Aug 1, 2023 at 7:38=E2=80=AFAM Deren Wu <deren.wu@mediatek.com> wro=
te:
>
> This patch set adds more functionalities for mt7925 to reuse common layer=
,
> connac and mt792x. This is a preliminary patch to add mt7925 chipset supp=
ort.
>
> Deren Wu (8):
>   wifi: mt76: connac: introduce helper for mt7925 chipset
>   wifi: mt76: mt792x: support mt7925 chip init
>   wifi: mt76: connac: export functions for mt7925
>   wifi: mt76: connac: add eht support for phy mode config
>   wifi: mt76: connac: add eht support for tx power
>   wifi: mt76: connac: add data field in struct tlv
>   wifi: mt76: connac: add more unified command IDs
>   wifi: mt76: connac: add more unified event IDs
>
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |  6 ++
>  .../wireless/mediatek/mt76/mt76_connac_mac.c  |  4 +-
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 60 +++++++++++++------
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 33 +++++++++-
>  drivers/net/wireless/mediatek/mt76/mt792x.h   |  6 ++
>  .../net/wireless/mediatek/mt76/mt792x_dma.c   | 49 ++++++++++-----
>  7 files changed, 123 insertions(+), 36 deletions(-)
>
> --
> 2.18.0
>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A886653301
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 16:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLUPM5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 10:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiLUPM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 10:12:56 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D12295
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
        Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JpPdxS7HiOoDJNdiv8R8Y64fgKbS8lj3lJjc7zmtKM4=; b=R6gyhcmCxqScr4Nw7fBtKffY4/
        ngk90atnnkWBtIGVmt3lQ9Av4psV48AA5S1TxW4avTEpYl54rQgBD8MrPZetdIQ65x6yQYcPnFYbD
        fRuEL4uPKXo+/Xh2XDBx7sbObz5cAXEluhsciW51xsZBmmI40ZMVJu5YooLg78QUe59Q=;
Received: from [2a01:598:b1a1:36a1:31bb:caaa:f244:59d0] (helo=smtpclient.apple)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p80m3-00Abzx-3z; Wed, 21 Dec 2022 16:12:51 +0100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Felix Fietkau <nbd@nbd.name>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Date:   Wed, 21 Dec 2022 16:12:40 +0100
Message-Id: <B2689D6F-E04E-4E9B-9244-4E5069DC464D@nbd.name>
References: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
Cc:     lorenzo@kernel.org, linux-wireless@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
To:     Sujuan Chen <sujuan.chen@mediatek.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sujuan,

> Yes, it is so expensive, but if no memcopy, it will casue memory
> fragmentation (we hit this issue in internal SQC).
>=20
> as we know, wed needs to exchange rx pkt(belongs to wed rx buffer
> manager) with wifi driver(dma rx data queue) by exchanging wfdma dmad
> to ensure the free wed rx buffer.
>=20
> it is possiable that a large number of buffer has been exchanged to wed
> and can not come back to wlan driver. So, the memory from the same 32K
> page cache is unable to be released, and it will be failed at
> page_frag_alloc in mt76_dma_rx_fill.
>=20
> Any ideas but memcopy?
A simple solution would be to simply allocate single pages, or half-page fra=
gments.

- Felix


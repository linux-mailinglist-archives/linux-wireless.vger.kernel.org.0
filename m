Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8777CB2A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjHOKcL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbjHOKb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 06:31:58 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D44EBB
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 03:31:53 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1692095509; bh=MUdjV6J79fKYFgANNORt493//jwG2i8g6wxyujv+cpI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R9juFHvAqDMlZIM96gqfpXSSPKFjCx8sx1r8Gh+EDR6ZEyu0CQAF3FWZ8NF9TPcJC
         ptoZncALDLg16cLVJ3tFfzT13Px1SeE9gM8/n8bt45ENOt6oniDQRTCm4OGMFq0OSh
         ncv7Wt+dMzPmvqrQ7kPRq5UFdXA84ozikj6g4KjHtvoaqtFB8lYdw21CPI8hRDRbgS
         ZipnDxeStzvH82Are+dj2IbzyF0i1D1u18e13nkmipmBUqtzm+1xVJH7jgDW8efXJq
         uCXyRd5iNnqU+s15B425IAz85pR/NQ5PEMS/EjSmzFsiOD0ecjzsNLiAwHOv9sM7h9
         oUl3a+F5EPBZQ==
To:     Yue Haibing <yuehaibing@huawei.com>, kvalo@kernel.org,
        christophe.jaillet@wanadoo.fr, yuehaibing@huawei.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: Remove unused declarations
In-Reply-To: <20230810145222.34364-1-yuehaibing@huawei.com>
References: <20230810145222.34364-1-yuehaibing@huawei.com>
Date:   Tue, 15 Aug 2023 12:31:48 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jztwegvf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yue Haibing <yuehaibing@huawei.com> writes:

> Commit b57ba3b2f7b0 ("ath9k: move ath9k_reload_chainmask_settings to comm=
on")
> removed the implementation ath9k_reload_chainmask_settings() but not the =
declaration.
> Also commit 978f78bf7137 ("ath9k_hw: Move bt_stomp to hw from common.") l=
eft behind
> ath9k_cmn_btcoex_bt_stomp() declaration.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

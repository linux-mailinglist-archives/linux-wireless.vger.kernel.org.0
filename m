Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3FC6F5079
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 08:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjECG7u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 02:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjECG7r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 02:59:47 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56574269D
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 23:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
        Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Ud10I9QH30yujz8K6yD5XYqbX91jt7QZdP60HLLstg=; b=At+qB5WMmglqv9EsXRIHXeNZd/
        ArYO030AKv8zqiz3qam6VFMMigyHhle2HD1H56BsZizINiJ+SrjN8nFeJ7LJqDocwG4bYXqL+Pow2
        3SQBc4poLDFS4mruZy856S1CogjbQOy/bHgnnPoSeaJoSynsXDjrivGymKFtRlwai7VU=;
Received: from [2a01:598:b033:9122:dd82:5eea:5cea:e4d7] (helo=smtpclient.apple)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pu6Sl-0051y7-T3; Wed, 03 May 2023 08:59:43 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Felix Fietkau <nbd@nbd.name>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH wireless-next] wifi: mt76: mt76x02: remove WEP support
Date:   Wed, 3 May 2023 08:59:32 +0200
Message-Id: <793AA6D3-0F75-4B8E-B6BA-9F864B103FC9@nbd.name>
References: <871qjyosnd.fsf@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
In-Reply-To: <871qjyosnd.fsf@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
X-Mailer: iPhone Mail (20E252)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 3. May 2023, at 08:06, Kalle Valo <kvalo@kernel.org> wrote:
>=20
> =EF=BB=BFLorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
>> Get rid of WEP support in mt76x02_set_key routine since it is not longer
>> supported upstream.
>>=20
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> You marked this for wireless-next so should I take this directly?
>=20
> Does this fix something or is just cleanup? It would be good to mention
> that in the commit log.
Not a fix, just cleanup. I will take this for the next cycle.

- Felix=

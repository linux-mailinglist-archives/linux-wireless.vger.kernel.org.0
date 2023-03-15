Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0516BACD5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCOJ7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCOJ6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 05:58:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34579B3D
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=95yfwrs7cwTHTJyhdBEndquZDdnynLTpS5h9w6xUWIE=;
        t=1678874245; x=1680083845; b=jFYkCQM7rzKEqhy0pPQ6LUGmPvVEeSKTffHrhe+lEQi/i8P
        uOSmCPDYPcb6Bqwoq/hrlM9lwiPcTtVgyvMejYeRPLTOJlo39JbG+EFfG9SFmxBgXwe5K2LmV0xo8
        qNWDx4xh3u89fvFLmwOVo98Db7/xFp4j2dRI/uVYh+En6+f7GQ4RMfcJ+3fjbdjkqChU33E+lRXJZ
        mYs/C+C35KW3n67/Z8tjbPLka7houk8M4RsTtkbqNqzB28pJP/KiKqjnq+reQv2E1oRqkFctFjWHh
        ZhwYBGNPqaAfdnOBv95qI5x9ulSRQEGdwdoohNqEvLoDiQzqpXFTGK6mlV2YPWQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pcNsl-0042mY-2x;
        Wed, 15 Mar 2023 10:57:20 +0100
Message-ID: <a459b9adc5eb7b67a432bd947d47d1df08718762.camel@sipsolutions.net>
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 15 Mar 2023 10:57:18 +0100
In-Reply-To: <89262772-7358-77e8-8913-c459819d544a@broadcom.com>
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
         <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
         <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
         <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
         <89262772-7358-77e8-8913-c459819d544a@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-15 at 10:12 +0100, Arend van Spriel wrote:
>=20
> I think it works pretty similar to firmware loading. These days firmware=
=20
> loading does not rely on a user-space helper and I assumed the same is=
=20
> true for module loading. Will look into it.
>=20

As far as I know you still need the modprobe helper in

/proc/sys/kernel/modprobe

johannes

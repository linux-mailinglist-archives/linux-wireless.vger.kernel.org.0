Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0D55337A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351687AbiFUNT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 09:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351571AbiFUNTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 09:19:36 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77BA275DC
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 06:18:49 -0700 (PDT)
Date:   Tue, 21 Jun 2022 13:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1655817527; x=1656076727;
        bh=+/i0606VmOQY03C5NCSYudMHML0SszctPgEJ4XpmawQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=dmqSQa2UBpGV88Yg7/RwZr7vV2nFb0JM5kFAiA2EIi9+QeHF23DFewgL4fEM+I0cM
         6sarq04Su/WcR61Sc06Z4W1JBm6lbikjKr+YDPQ4xWpCAwCbseckpnEQsk497yMiFI
         2tAi8Cu6rx2PQm1h0R20P++W3dCKCxP6q2SAdR1+5ZtZ26TMQ2/uFtkuI+4CR1wZTk
         rn4jNBI0B+/iRMHXQqZnYYQU+Hgi5EC/bJ1qc+/MzeU/oHMZeYDtXNdHtqADD9KThz
         vGQnldVGpj+MhxAkVrlb4SL+uO9YCVbvTt8Zmwy3Q3SBozIO7zusyK37Hji4FVuOtD
         Kb2g//cAtihPg==
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <VJRRELjxfxQK1fFLbnYr2IZVHdPU-0YotbBIG2-ycUA2OCppqr4TrzsbXHC_wpS0ZA7HNLJxZNA6-Bzy0BOAuV16DR6wqT9TPDLjQwYcp7w=@dannyvanheumen.nl>
In-Reply-To: <45d90d65-cd0e-e65f-edcf-d55802a4a6bd@broadcom.com>
References: =?us-ascii?Q?<UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=3D@dannyvanheumen.nl>_<B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>_<EbyrCYK=5FmR6ppJYbSc5JfGGG=5FQZEZb2Zp8Htx9f-orZ=5FwX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=3D@dannyvanheumen.nl>_<1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>_<kB9OdQYlBnucF05VoKxTvsT8eUrPGJc=5Fwe9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=3D@dannyvanheumen.nl>_<MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=3D@dannyvanheumen.nl>_<1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>_<PDYrcmiOE8drECietqr7SILEQI8DpX6gL8pbVCR6IbqNrKjyXTLYPhgsWfHL-s9FuElU5v84HUUWaFntR5RZJG5EBABE2XilCP=5F2O9ZipMk=3D@dannyvanheumen.nl>_<Ct5-sN=5FCGLyGf5qHNiakimNNG33Yb=5F7toxutmv8ELxgBqGZQXM6DkaIJg2cctTqSFyawKx8XeU3ySO2Ce6idBXv-ZWrT6Wy5=5Fa9nFr4svy4=3D@dannyvanheumen.nl>_<45d90d65-c?=
 =?us-ascii?Q?d0e-e65f-edcf-d55802a4a6bd@broadcom.com>?=
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

------- Original Message -------
On Tuesday, June 21st, 2022 at 09:41, Arend van Spriel <arend.vanspriel@bro=
adcom.com> wrote:

> [..]
>
> Maybe overlooked, but I have not seen a patch from you on the
> linux-wireless list. Do you have reference, ie. URL or Message-ID?

I'm not sure what's most convenient here, but here's an archive link:
https://marc.info/?l=3Dlinux-wireless&m=3D165547582612979

Message-ID: ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-
kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo=3D () dannyvanheumen ! nl

You haven't commented yet on my question regarding definition macro for the=
 clm_blob.
I intend to send a patch for it, because I believe _at the very least_ some=
 parts of distribution
processes rely on these firmware entries. It would be good if you can confi=
rm.

> Regards,
> Arend

Regards,
Danny

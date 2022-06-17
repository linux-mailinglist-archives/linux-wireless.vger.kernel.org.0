Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0F54F932
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381599AbiFQOba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiFQOb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 10:31:29 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F555348
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 07:31:28 -0700 (PDT)
Date:   Fri, 17 Jun 2022 14:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1655476283; x=1655735483;
        bh=nxFlsSqiLytB2oybbWxLH4i+nQ3KDMGZZv8tlLCQtE4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=bEbir5DiqJP9JPAl284xnMtIO3tD0PCd8/9KeKGuSrtDnencUL5xc0CuqLZTa38ew
         +9POkrqb7WMhp0K+8kHHYqlcNNLoSqtQmVjbluN7aZGPrhY03qjYa5Nt1VzyLg7CuE
         3030j7trjcdGJDx7qj+kfBKjjhe0ka5yyCSOXQOTDDfWGf+Wsfdwcq/oG4wZ1m0Agm
         NC6s/h7S85blT098szIdIL+Hw75FN2PALTxK6jWUvz5mi7pSl7fBXrS7979VAPfp+p
         F7uNOOueJBfiWXmXbD14FP+X4e12KZQcQZKgtMvCbKWiUwVdSkQXXte/BsxW12TRrp
         tCwslzrB3hQDg==
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <Ct5-sN_CGLyGf5qHNiakimNNG33Yb_7toxutmv8ELxgBqGZQXM6DkaIJg2cctTqSFyawKx8XeU3ySO2Ce6idBXv-ZWrT6Wy5_a9nFr4svy4=@dannyvanheumen.nl>
In-Reply-To: <PDYrcmiOE8drECietqr7SILEQI8DpX6gL8pbVCR6IbqNrKjyXTLYPhgsWfHL-s9FuElU5v84HUUWaFntR5RZJG5EBABE2XilCP_2O9ZipMk=@dannyvanheumen.nl>
References: =?us-ascii?Q?<UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=3D@dannyvanheumen.nl>_<51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>_<jJuvC2YezD=5Fe1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts=5F5bEXZSV7dMNi0s=3D@dannyvanheumen.nl>_<B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>_<EbyrCYK=5FmR6ppJYbSc5JfGGG=5FQZEZb2Zp8Htx9f-orZ=5FwX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=3D@dannyvanheumen.nl>_<1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>_<kB9OdQYlBnucF05VoKxTvsT8eUrPGJc=5Fwe9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=3D@dannyvanheumen.nl>_<MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=3D@dannyvanheumen.nl>_<1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>_<PDYrcmiOE8drECietqr7SILEQI8DpX6gL8pbVCR6IbqNrKjyXTLYPhgsWfHL-s9FuElU5v84HUUWaFntR5RZJG5EBABE2?=
 =?us-ascii?Q?XilCP=5F2O9ZipMk=3D@dannyvanheumen.nl>?=
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend, others,

------- Original Message -------
On Monday, June 13th, 2022 at 20:50, Danny van Heumen <danny@dannyvanheumen=
.nl> wrote:

> [..]
> >
> > You should send a proper patch to the linux-wireless list, ie. not in a=
n
> > attachment but the commit message and patch diff in plain text email
> > message. Please refer to [1] for guidelines.

Done. (Sent as separate email not part of this thread.)

> [..]
> I have tried to reduce/remove the probe-logic in `.reset`, but I can simp=
ly not reach that logic reliably (or at all atm), so I cannot test even bas=
ic simplifications of the hardware-reset logic.

I have not made progress concerning the reduced logic in '.reset'.
I will not attempt this any further as I do not have the right circumstance=
s
to test this properly.

>
> > Regards,
> > Arend
> >
> > [1]
> > https://wireless.wiki.kernel.org/en/developers/documentation/submitting=
patches
>

>
> Another question:
>
> `BRCMF_FW_DEF(43456, "brcmfmac43456-sdio");`
>
> This line defines IIUC that a firmware-binary exists. However, there is a=
nother macro that defines both the firmware-binary and the clm_blob binary.=
 AFAIK, BCM4345/9 (brcmfmac43456-sdio) supports loading a *.clm_blob file. =
So I suppose the line should be:
>
> `BRCMF_FW_CLM_DEF(43456, "brcmfmac43456-sdio");`
>
> Does this really matter? Should I also submit a patch for this?

This is still an open question to me: from what I can tell,
'brcmfmac43456-sdio.clm_blob' loads correctly even though the macro
does not define it. So this may concern certain specific use cases.

Regards,
Danny

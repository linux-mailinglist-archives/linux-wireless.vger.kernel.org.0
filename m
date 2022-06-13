Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE02549EB5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbiFMUPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiFMUP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 16:15:28 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17791BC10
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 11:51:06 -0700 (PDT)
Date:   Mon, 13 Jun 2022 18:50:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1655146264; x=1655405464;
        bh=k/A5E+7ARJ/sHkIngRT1u7vG7uuzBLZuLrkFI/eXrY4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=Yq77ZG0M4duLrWuYx2XkU+C6R+GaWB2P/ew0KaNrJ2o1egHPTtwU6bP2XzhqPewNW
         GCgh8amuQ2XqtWIERDa+KBZK57Z2ktyHF1bMt0808nFqSeYlfKQGZEaMrYBT3e0iVg
         AZJMF9FXKOCA9hDX/i/1K629srhE14nm7Bl2fwa14SnkOpEjGgSOpcvkqP9GKKz70W
         NG3IVS8fjj8h9ZRRCk4z2RM4ZJKg7ypJRIW8eWnLWxOxCWSq86/Ct+9SPHEDxwbrSz
         bRl4kGKM6IFkJroRm0X9JKNHEtJ1GjIGNhdonnHpmGJ9xfh5D7xxYj+YYx7t/zvbHm
         KXRw4L287Glhg==
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
Message-ID: <PDYrcmiOE8drECietqr7SILEQI8DpX6gL8pbVCR6IbqNrKjyXTLYPhgsWfHL-s9FuElU5v84HUUWaFntR5RZJG5EBABE2XilCP_2O9ZipMk=@dannyvanheumen.nl>
In-Reply-To: <1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl> <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com> <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl> <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com> <EbyrCYK_mR6ppJYbSc5JfGGG_QZEZb2Zp8Htx9f-orZ_wX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=@dannyvanheumen.nl> <1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com> <kB9OdQYlBnucF05VoKxTvsT8eUrPGJc_we9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=@dannyvanheumen.nl> <MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=@dannyvanheumen.nl> <1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
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
On Monday, June 13th, 2022 at 19:32, Arend Van Spriel <arend.vanspriel@broa=
dcom.com> wrote:

> [..]
> > What would be the next steps?
>
>
> You should send a proper patch to the linux-wireless list, ie. not in an
> attachment but the commit message and patch diff in plain text email
> message. Please refer to [1] for guidelines.

Thanks. Will do.

> I reinstated SDIO card in my test setup so I can test your patch.

That's great!

I have tried to reduce/remove the probe-logic in `.reset`, but I can simply=
 not reach that logic reliably (or at all atm), so I cannot test even basic=
 simplifications of the hardware-reset logic.


> Regards,
> Arend
>
> [1]
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches



Another question:

`BRCMF_FW_DEF(43456, "brcmfmac43456-sdio");`

This line defines IIUC that a firmware-binary exists. However, there is ano=
ther macro that defines both the firmware-binary and the clm_blob binary. A=
FAIK, BCM4345/9 (brcmfmac43456-sdio) supports loading a *.clm_blob file. So=
 I suppose the line should be:

`BRCMF_FW_CLM_DEF(43456, "brcmfmac43456-sdio");`

Does this really matter? Should I also submit a patch for this?

Thanks so far,
Danny


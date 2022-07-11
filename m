Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6933570E3E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGKXZh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGKXZd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:25:33 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E38AB0A
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:25:32 -0700 (PDT)
Date:   Mon, 11 Jul 2022 23:24:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1657581930; x=1657841130;
        bh=dJ7XzW9JR+iR7w3Orjx2VNxD5Zp98I27EpmQYwWURhE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=tUGSepESaZCFMuuJis/hrTnwlh1rUqWLVaadlYQ+XSio/obCfcXvqT/S6k6uMknJ5
         tJxwnb9GkEVqep9Fr6F6h+VzQ/kBQETeY9aEhGErQ9xn48tkQiuEXCPcisovnyG7aQ
         R9ukfCWtw7YCUMWC2hhsrnvrxhdMH+kec+kaMrMqpKjAG1mGwnysjDoVoENKXjbBKr
         61HCbce2+W5/4ng00C7s408CKq7ekTnULW614Jf+Ht47S/V3VtVF8h8wSyJt36kiZG
         +wSnwXD3V686b7lGmlmxYbvkSnHwdX9ywRSdhY0MlL7ry4V/MjdV4thgmrAa+8H99B
         9Us9ywsA/DkFg==
To:     Arend Van Spriel <aspriel@gmail.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Message-ID: <LjavNS7FQVriCInc6oiPjdmmCyQgXWVsmHv_kiDNEJ1UXiSKuOpLVLEIbzhOPFY1eEza2BePSqwe7k59rNTgDPihwOdb9Kx77yb0ly0weQw=@dannyvanheumen.nl>
In-Reply-To: <768ee7d7-bbc1-b466-480d-de6390d26051@gmail.com>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl> <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com> <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl> <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com> <aK4oYk4CE84W9CQcWokt10umUlVCVt4DUEHbuT1e6euFshQ5CC4Hu5svEL0qhPF6W-LYeu8-EUNMfc4odaYa-LyxofrBZt_6KhkiE0sfwp8=@dannyvanheumen.nl> <48f31e63-f4de-faf9-3c8c-eb2bdd8a2b04@broadcom.com> <Ev2sGFWgWlkty5T3AbZMd-KmLY_PJiasOdrKka6OuNmLFBSOet2lSDVUj8_x3lKuJ-lNLkAdDKwzkeS9rEIGLXb3RwDhrkBMyESbuTRcu90=@dannyvanheumen.nl> <768ee7d7-bbc1-b466-480d-de6390d26051@gmail.com>
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

Hi,

------- Original Message -------
On Thursday, July 7th, 2022 at 22:25, Arend Van Spriel <aspriel@gmail.com> =
wrote:

> [..]
>
> Right. I prefer dropping the interrupt clean-up and rest of the patch is
> fine by me.

Please find patch v5 submitted. Subject: [PATCH v5] brcmfmac: prevent doubl=
e-free on hardware-reset

I have reverted the split, in-order freeing of func irqs, as discussed. No =
further changes.

During my time running with the various patches, I have not had any issues.=
 As mentioned before, repeated resets did not result in any issues. (I didn=
't count exactly, maybe 30+ resets in a scripted run.)

IIUC this should be ready for integration.

Regards,
Danny

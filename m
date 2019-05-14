Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437621C98D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfENNo1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 09:44:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENNo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 09:44:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so19256602wrs.11
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=U7t9OWgDul1DXrcWJKRj2Op8WI9SAhOi5TTLWWgd0Ys=;
        b=riajmBb6Emk4JTr9q69MjIzkxUOdEaAp7VRcJ8c80SjV4zRTs57VBGRr2mnajcmHP7
         iZAwzufMiZl5bkPznW4IGTE41NrCu8HJf8FbiMSJu9X98PJsW9al4uVyz4eQguewEztv
         dFx/oCuGuDZeGeWx6K+jUVlIH0R7gf/uQszzMudQZuRNOsG52QkpQS80TLlrc+6x3kQY
         GxOb2GYiYfbMDmv2yJgRpoqdwtADG5jgZ127KPYjh/8ivOqh4lUR2O3guFeyR3PTz6is
         moDFqu5jEPETxXSmTObdFYEwCfMCptehsn7r2xio7H5y1SNhGLU3sB4E8fpocmVFUoIF
         3Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=U7t9OWgDul1DXrcWJKRj2Op8WI9SAhOi5TTLWWgd0Ys=;
        b=FlKKrGnqiy2GflBJjzMDYPoLDoYTdGH4C54Ay7XaaRxnG+yt3aoa45ClxBQ//OApDw
         C9/Jx85rsp26QcBcTAfRBGhiggdrj19wwbdPPNEaGnQIl2sflTKhuCU0t1Z/SyqtjhNt
         EmsztKEH9g1MYDmHyOhozi25lCR1AuQ09GnFFuyD9XGB56IgtVnIqvQI4cE7SAkDvkSv
         2hwzgW2mOdfCbBbdg648ctklKrrDkNv9xNLykLGOXKWKHb9uaxFSfeM6vLHdBf78Ozp6
         zNqmpfgXtIFsMhyjxoQ6mMA5p4hjC3hphkfK8ifPlQ+8LQUE7XA6e3oNmpNZBB2N1LkH
         bblA==
X-Gm-Message-State: APjAAAUhlTktpjK1oEs5hD2M297EaVs2BOnyyH6gyXYuEWStV2Eqund2
        levmUuIN164BNYUfngJGF3QzYkcEOCrke9jVUmM=
X-Google-Smtp-Source: APXvYqzdXf3G0V0OCkWiEoKao4toPiFThaoWMWknZbPGTQfpmDOZ/acvD+TPVLujU/sD+FnZpbdscLu0/zmfAANurOU=
X-Received: by 2002:adf:9e46:: with SMTP id v6mr10216280wre.141.1557841465392;
 Tue, 14 May 2019 06:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
 <20190513123751.GS9224@smile.fi.intel.com> <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com> <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
 <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com>
In-Reply-To: <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 15:44:13 +0200
Message-ID: <CA+icZUWZH-JS=JHLieVd2ga=Zutac2BXd4tk0tSXs+izQ5txOQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 3:30 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> OK, thanks!
>
> On 5/14/19 3:03 PM, Sedat Dilek wrote:
>
> > It's good to keep both informations - preferable put them into the
> > Kconfig help text?
>
> Sure, it's best to keep them both.
>

While looking at the Kconfig help text; I wonder why...

config NFC_NXP_NCI_I2C
        tristate "NXP-NCI I2C support"
        depends on NFC_NXP_NCI && I2C
        ---help---
          This module adds support for an I2C interface to the NXP NCI
          chips.
          Select this if your platform is using the I2C bus.

          To compile this driver as a module, choose m here. The module will
          be called nxp_nci_i2c.
          Say Y if unsure.

Shouldn't that be "Say N if unsure"?
Or Say Yes If Sure :-).

- Sedat -

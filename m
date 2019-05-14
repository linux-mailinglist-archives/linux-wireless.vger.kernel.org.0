Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4341C83F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENMMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 08:12:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33726 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENMMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 08:12:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so10577912wrx.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LU/y2PLG6rVuITKR4Wa/pGlYz/fiYSoIqXWFjQFGsvM=;
        b=MGK5RXrU+bPs8RahQSCBCWyWmiTRMj5W36Vss6v8eMXEeGPh8vooAjouUVsTTShgqW
         /D6KI8iXfBMp5Pkb/HF5BSMQKVvNH2A1Xo1vDgPvG3HqoULDLmlcEHL6VFpBgNppUpGx
         313TizLO2n3yz29rb6TQs3H+OMjQoCYdSlVIRPuiD7892pQSrlVNFZiDeVNWrDFU6vRZ
         pCsgQKBhUxqDckCSZqdsbhzFZ1VXjWv8quBjHM/29NLe8TbxX4Ne3W+YHFTlS3a104F6
         JoOci2GVwadh92DnuKOJzXRffotkB2hOBNY0HVVuaV5TvclYT9MaRmhYigIDUETTO6od
         RgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LU/y2PLG6rVuITKR4Wa/pGlYz/fiYSoIqXWFjQFGsvM=;
        b=VbNOI/CnLqS///mkcVhjoSDP3SYINO/NOvi5nN3VvfL7xE6Jroay6dQHPTHw+tj1qx
         ogbQ7cJ2O8erZAnS2ggNbcQLzXE03L6WNNuZAWzDKn2YhzWmeicZWq/ZZLGgjHuL5TRU
         304a/ILTzZd/NXPlu1E5P7S2LKZADyetjPS/vDVdH7cIRZJAZe6mR0dBWwA9rNygcWXU
         IUaFY/fTsjN5wwWdf7VB6hdHKiT9F4rBJOMbVcmnA+OQvVmAMe2Fj7DrP5lxZUDXAXjR
         VGTfG/6LLo6MEuTwhfbWAdAy8DcgF66FcAy0kVnfoBPFo/6FDFRNugFFWqSHrI4ullPE
         LW/g==
X-Gm-Message-State: APjAAAW9l3EKMnXz3fzd9GnuMpTDwcdwJJkrkpFQjTkNfujE1+OEEvxA
        sjOOeDN/LTE74/lryOciwYPIaZjPy8RDj8EiZhc=
X-Google-Smtp-Source: APXvYqy7ZnnsvJB/JkNl3MLE2nsysLUbcMDHOyT+lseiBsAIqoDUZpxZ4XadbtMObROThQhixq00rJqkn3dxMhaC/PM=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr9628728wrq.285.1557835931138;
 Tue, 14 May 2019 05:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUVn9tHQ3Zug0u2scbvGFfrLag_WYdzs9FCBJsGJ4bhuzw@mail.gmail.com> <20190514100328.GB9224@smile.fi.intel.com>
In-Reply-To: <20190514100328.GB9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 14:12:00 +0200
Message-ID: <CA+icZUXS1eLAndPD=Fk=HwW+P3YrZq+enFO5aEvyixotXdrTvg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 12:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 13, 2019 at 09:48:15PM +0200, Sedat Dilek wrote:
> > On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> > Is it possible to have an info in dmesg log when nxp-nci_i2c kernel
> > module is loaded?
>
> We have 'initcall_debug' for such purposes.
>

Thanks.

That's nice for retrieving helpful informations, especially the proble
line (see below).

Unload nxp_nci_i2c module...

[  277.362813] NET: Unregistered protocol family 39

...and reload nxp_nci_i2c module...

[  291.640491] calling  nfc_init+0x0/0x8e [nfc] @ 2998
[  291.640499] nfc: nfc_init: NFC Core ver 0.1
[  291.640603] NET: Registered protocol family 39
[  291.640651] initcall nfc_init+0x0/0x8e [nfc] returned 0 after 111 usecs
[  291.653179] calling  nxp_nci_i2c_driver_init+0x0/0x1000 [nxp_nci_i2c] @ 2998
[  291.669584] probe of i2c-NXP1001:00 returned 1 after 16364 usecs
[  291.669841] initcall nxp_nci_i2c_driver_init+0x0/0x1000
[nxp_nci_i2c] returned 0 after 16244 usecs

What I mean is (here: btrfs and vboxdrv built as modules)...

[   21.285569] Btrfs loaded, crc32c=crc32c-intel
[   28.823902] vboxdrv: Successfully loaded version 6.0.6_Debian
(interface 0x00290008)

- Sedat -

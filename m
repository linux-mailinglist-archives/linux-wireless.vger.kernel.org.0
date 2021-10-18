Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77B43170B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhJRLT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRLT0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:19:26 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037FCC06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:17:16 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id q13so2907617uaq.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWH8YVux/QavvU6Dp1ZfovmWJCA6P79W9xtuXn1tCVU=;
        b=dGxmEissoZ0GSMCfqKHAiCfgRVimFGSK6FgGVhcCSmg5lowfesWipAqFNWbsnmGLuV
         mCRwiyjopaPx8+UcJLGugH+TXD0YCHr0xv/N6VNOviJ1SYqKW+GtsY0yDiQZMBZ+MZtM
         BI99Jytrn+mOQPf2Eo2ppyO8sSwBbH1Iq++gIMFpnZmYo2hhYKKQ0Aiu7yTfntHB3tsv
         PW+Fx8hVXLq4WuUuMQIRhhM/Gu2dZHtpii/pcMAPV7ZLR4G7013BjKtfpJJ4kvhAFNDB
         PVqZq1B1MUDAmlPooNfiH6Y/X4+csPU4a7PJL7iSABfmAjN5rkJH88K9iDHS1k+lfwPd
         xxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWH8YVux/QavvU6Dp1ZfovmWJCA6P79W9xtuXn1tCVU=;
        b=FY5PyGPpHHg4OBoX6K0VoArNQibEqaog4Pzf75jmhXFtKQRWQdWhpoVaoRmK/LoYb/
         0Fzs74/Ohf1aCa/9VVITYL4mjfWBLGmBHpCsa3PS58jZyvM0Z6BIYz5lRMBCE635KZ6h
         PLLqcDAEY9b4vTgbR0bkhBn2gelHYBeFa/qd9V29Bik3A3Q5p0MpEedOxTqmlP87tA26
         tGzInmM+LqFzbyhhO2RHgATSFZQPQbX00b195uFKXVsJkBHMWBBAey/iMn2k2Dw3Ltly
         Nl8vX7e4SCb82BGBqg165rR/Qf/WmHaaWC43rDGqrMa9+aK3RtIWRbZdnX+2fSo+autS
         D47Q==
X-Gm-Message-State: AOAM533DPlMGBw15YbrrodWyBIp1h2STsj/n+TkpcoIGBCW8phYUQTfK
        Ii/Cgj6QvNDZK6S3c9/rbYAVjjbzoYWXYe7NTPg=
X-Google-Smtp-Source: ABdhPJxmMKWDLhhokyA2VgH/pGs1GMBwdLNR1G9R/kHeU+T+q+y2ObJQfisPlMjwd1vVe9aToglnQj/uzz8twMFiNJA=
X-Received: by 2002:a05:6102:c0f:: with SMTP id x15mr26818957vss.57.1634555835191;
 Mon, 18 Oct 2021 04:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-2-emmanuel.grumbach@intel.com> <87y26qvg05.fsf@codeaurora.org>
 <CANUX_P0CxotNk1omOELgFWWDTzJXMmzSBPKg6k1f_kbBookWuQ@mail.gmail.com>
In-Reply-To: <CANUX_P0CxotNk1omOELgFWWDTzJXMmzSBPKg6k1f_kbBookWuQ@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 18 Oct 2021 14:17:04 +0300
Message-ID: <CANUX_P25aQuih=ZnAsVchiWqQdO7G1aHyReZ2yxUAc29GH=bog@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > > +
> > > +/*
> > > + * Do not export the device table because this module is loaded by
> > > + * iwlwifi's dependency.
> > > + */
> > > +
> > > +static struct mei_cl_driver iwl_mei_cl_driver = {
> > > +     .id_table = iwl_mei_tbl,
> > > +     .name = KBUILD_MODNAME,
> > > +     .probe = iwl_mei_probe,
> > > +     .remove = iwl_mei_remove,
> > > +};
> > > +
> > > +module_mei_cl_driver(iwl_mei_cl_driver);
> >
> > Not sure iwl_mei_cl_driver can be const or not, most probably not. But
> > please do check.
>
> I will.

I can't :(

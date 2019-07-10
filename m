Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFEB640EC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfGJGKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jul 2019 02:10:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfGJGKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jul 2019 02:10:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so1254628qtq.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 23:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kgh0eNzFgIe5eaGiUDxMKa3pFZFr3SED3dNfTsGvaUI=;
        b=EiwBNTiVnAfs8J4Fg825K6u1OWTQl44dsaJ8dvAxEPhMEr7DdoHVSoA18H1TACkXia
         6KEMvV2UYkj283ZBHS33j0B41nRyuZc6NlTyVwPzqPaLkchtmvBPKgimD4A4CNf4ljU4
         6g0WGYgiWRbzM5yi8E2Aa/aa5EORLckO+7LNKyEd/niD76NHFnn7G9Ba5iFgRtaZGohz
         gtwkzLmJYmiYhhOY5CIDJcbbsBNe34JRzFVlwq7yYxesJ5kvxGojse4mk0Xsyt5gdDp+
         8hv9vUQN9k1CYxvTr76wAEycqSrRXslOIrAp+xD3KKqJF+frOUD5DKMnTxc18sQ06Tjt
         MW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kgh0eNzFgIe5eaGiUDxMKa3pFZFr3SED3dNfTsGvaUI=;
        b=VHVtxIPJFP8x3/SokPdtrGk1EoefBKdoi5L2ZQCeabgQs5okPjP00/gq1UJVaKK1RA
         VBCRShNfvo2UWf5tXL/ewQkBDveHRmli0SyIf6y6qHsz6lQKl4F6fgyg10ftHDXPc54s
         z5Hrc6hRhydJ/5TUjRoKpEB5ZP56CarLU7++LE3UcIsjP5LAywEq0jw/O43aQU77VUSS
         RCREHNV+jBV+TjL4PKdn/JkCa7BU5ThTMcEbBAYTI6jSJ85hEittZ9BwG78Igf8kn35F
         FAJeLnCbBUEuTT1eY7wNOOTd2MWMOKwgc22nEi52lv4B6a+UxBjyHbRBCAEGfWW6d6Ub
         pVwg==
X-Gm-Message-State: APjAAAVpIBHnGLJndB2plwaFAXkpg8rugUD3u0xBr/2C0KT88j+WYXrJ
        hAL7y7loJYUZs85RCn8fTDayaFRW4JtxUvc/+a8=
X-Google-Smtp-Source: APXvYqxhNrzJhmOPJYoXktGsnd98m9uDV0i/my+7jaQfqrXBUVuSWomCaGSdQcOCDXVwqTEBjJYEo3muf7F4nm24+UA=
X-Received: by 2002:ac8:7654:: with SMTP id i20mr18589841qtr.67.1562739004452;
 Tue, 09 Jul 2019 23:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+K+NcRWLeE3-vah=urveMVxcgXYO0yFHYD=WNeuX_TdZ9+8-A@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D1864503@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1864503@RTITMBSVM04.realtek.com.tw>
From:   =?UTF-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>
Date:   Wed, 10 Jul 2019 02:09:53 -0400
Message-ID: <CA+K+NcTsxsZ9LGbmSZ55xL-CTxruKta81WbCJXCWQCiMNNz4Qg@mail.gmail.com>
Subject: Re: [5.2 regression] rtwpci + amd iommu
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

thanks for a prompt reply.
the patch applies with minor changes (the LPS mod param message and -2
lines offsets), but it works.
The system now lists available wi-fi networks and connects to known
networks all while the iommu is enabled.

feel free to add my tested-by,
regards,
Jan

On Wed, Jul 10, 2019 at 1:12 AM Tony Chuang <yhchuang@realtek.com> wrote:
>
> > Hi,
> >
> > after updating to 5.2 the wi-fi driver stopped working when the iommu
> > is enabled.
> > It fails to list the available wi-fi networks or connect to a known one.
> > booting with amd_iommu=off works around the problem.
> > The staging version in 5.1 and older worked OK with the iommu enabled
> >
> > The device is:
> > 04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822BE
> > 802.11a/b/g/n/ac WiFi adapter
> >
> > I do see an IOMMU error in dmesg, but the originating device does not
> > match the nics pci location:
> > Jul 08 15:03:14 host kernel: rtw_pci 0000:04:00.0: start vif
> > xx:xx:xx:xx:xx:xx on port 0
> > Jul 08 15:03:14 host kernel: iommu ivhd0: AMD-Vi: Event logged
> > [INVALID_DEVICE_REQUEST device=00:00.1 pasid=0x00000
> > address=0xfffffffdf8140200 flags=0x0a00]
> > Jul 08 15:03:14 host kernel: rtw_pci 0000:04:00.0: stop vif
> > xx:xx:xx:xx:xx:xx on port 0
> > Jul 08 15:03:14 host NetworkManager[790]: <info>  [1562612594.8992]
> > device (wlp4s0): set-hw-addr: set MAC address to yy:yy:yy:yy:yy:yy
> > (scanning)
> > Jul 08 15:03:15 host kernel: rtw_pci 0000:04:00.0: start vif
> > yy:yy:yy:yy:yy:yy on port 0
> >
> > let me know if I should provide any further info.
> > thanks,
> > Jan
> >
>
>
> Hi,
>
> I am not sure if enabling MSI interrupt is going to help.
> You can try the patch attached, if it works, I will send it to upstream.
> Thanks
>
> Yan-Hsuan

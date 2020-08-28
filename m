Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87966255516
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH1H1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgH1H1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 03:27:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD57C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 00:27:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r8so45265ota.6
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vtnqos8GqK6sG4Enz6PIEvXXv+f/wNSZahlXtHMy8Qk=;
        b=NI04o/aMfTAFEtfJDdHdtMtTww9mZfVNfgwbdxyl0tkJi53z13JMEhYm2rFjNMlBhK
         HSPVJH5kp11QOiyomJP/CWqEw0ijB5B/VaETrCPkKRvYLCb2N/9ff2RScGBixKv3OmxF
         s9loBtmxaEgX4DPhk7Uyr60OB8+/236BCxxezJBnsxMddPZSxsvyPyqsXxllv4Hchw/e
         w/4ZwGBHDcq2xDm18C5JOeXTg5A6ckPDhugqHLd7pCS1xtdfXUSex/eiEAqSiQ8QtNN+
         VHjbmeDzRUHEaYZWV1ekpeRksi0rbG2b36OMrPMWX6qTfTJaoqco83OhvuPpZ/H14aBs
         32QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vtnqos8GqK6sG4Enz6PIEvXXv+f/wNSZahlXtHMy8Qk=;
        b=QAvw2dgqJ2GS1hnqfHYMjvTmp+GRKPJ4x/epJoWR1Au7Bcq6Yd9gKPU2c92T4ViS6R
         ZHdc5GDyOielfi8LQ7dSsAC2HyiZD26j/xvteK8P4rlRKIWVYO0r5iXLz5CAMEOsQ850
         6vsxqt1gYYhm00ejcbOs0iit/JUDvd7/XqBjD+nF1jPcnb0ry7op81C14DxGRtlNB6Vi
         7ncXffBnlVQQd9bJCkx+1bb7cuATfKDNjs6R1caGtqW1s2MmNvhQz1vpzVBHG/DuKuZL
         g/7w843HCB2jzkacog7wPc/3rikkZNxJOEx+YZ4gWQoDSZ7bRF6F1t/rj5zh4aKYW5aS
         LSsg==
X-Gm-Message-State: AOAM533Q3UVlVhPjuFj8CcaEYNg4E316cJPzVVLgTywx+mMj3RuQZ6XY
        +j5NOy8s+YMAW0WfLDQT+Lqj6uP13pHlehcDANw=
X-Google-Smtp-Source: ABdhPJzSn93bIx/sG6jKXZKz0yd3B60QWPZnX5YXJLD5lva5EMIRH3Z+0gE6gIQ/r/Al8CA5WY3Oaqmsip7WY+R8hMQ=
X-Received: by 2002:a9d:774d:: with SMTP id t13mr180654otl.108.1598599624828;
 Fri, 28 Aug 2020 00:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <202008280240.Op3fNc1d%lkp@intel.com>
In-Reply-To: <202008280240.Op3fNc1d%lkp@intel.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Fri, 28 Aug 2020 12:56:53 +0530
Message-ID: <CAOMdWS+yS6sL19R5RECWyruMMNM2Fgm8M3Gc3FP0kU6SdPO1og@mail.gmail.com>
Subject: Re: [wireless-drivers-next:master 53/53] drivers/net/wireless/zydas/zd1211rw/zd_usb.c:1181:33:
 warning: cast between incompatible function types from 'void tasklet_struct
 to 'void unsigned int)'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> head:   26721b02466e396efaca6807b52916478c4f9197
> commit: 26721b02466e396efaca6807b52916478c4f9197 [53/53] zd1211rw: convert tasklets to use new tasklet_setup() API
> config: arm-randconfig-r012-20200827 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 26721b02466e396efaca6807b52916478c4f9197
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):

 I have it fixed for this as well as patch 52(realtek) Shall I send out V2.

Thanks.
>
>    drivers/net/wireless/zydas/zd1211rw/zd_usb.c: In function 'init_usb_rx':
> >> drivers/net/wireless/zydas/zd1211rw/zd_usb.c:1181:33: warning: cast between incompatible function types from 'void (*)(struct tasklet_struct *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
>     1181 |  rx->reset_timer_tasklet.func = (void (*)(unsigned long))
>          |                                 ^
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=26721b02466e396efaca6807b52916478c4f9197
> git remote add wireless-drivers-next https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git
> git fetch --no-tags wireless-drivers-next master
> git checkout 26721b02466e396efaca6807b52916478c4f9197
> vim +1181 drivers/net/wireless/zydas/zd1211rw/zd_usb.c
>
>   1167
>   1168  static inline void init_usb_rx(struct zd_usb *usb)
>   1169  {
>   1170          struct zd_usb_rx *rx = &usb->rx;
>   1171
>   1172          spin_lock_init(&rx->lock);
>   1173          mutex_init(&rx->setup_mutex);
>   1174          if (interface_to_usbdev(usb->intf)->speed == USB_SPEED_HIGH) {
>   1175                  rx->usb_packet_size = 512;
>   1176          } else {
>   1177                  rx->usb_packet_size = 64;
>   1178          }
>   1179          ZD_ASSERT(rx->fragment_length == 0);
>   1180          INIT_DELAYED_WORK(&rx->idle_work, zd_rx_idle_timer_handler);
> > 1181          rx->reset_timer_tasklet.func = (void (*)(unsigned long))
>   1182                                          zd_usb_reset_rx_idle_timer_tasklet;
>   1183  }
>   1184
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
       - Allen

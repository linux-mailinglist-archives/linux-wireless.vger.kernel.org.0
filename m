Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525B12E025
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2OvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 10:51:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34344 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2OvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 10:51:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id u64so2292149oib.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2019 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VjEJ+tMyAswlGztA5Z6mZMtZFFM3bOY63kGz/8Vm+0A=;
        b=n+3LIU46w7UtfzSFx+l4eyr6anLrNz2v6OAagHp2b7tU82J9OMzoOwfkB+EQaHZUFU
         RCGRpR//9dDaZw5fApNremdPbC4AhTy6/e0T4fEJZ4G87CJ8nxnM0puNVKNh7CvZW9pY
         BAA7EdN4Mq3h3LVK8MlyyrnBJsZnexxQc/hEG9EBzNiPspgwC/AMT9eGEi7QfAUy7JcB
         pmOf7TAx4f4IBi77s1LSzPYWPKq76MUeowoPXcm7Fp7IaoLFvd1TSXsy3ZiWjPG7KKO2
         /08WPy1xJCMcFvN27UVCKgtKeFURitFxM5Ue57t2Xbuc1HYLSr43RWlMMi0gJ1UoI+pF
         fgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VjEJ+tMyAswlGztA5Z6mZMtZFFM3bOY63kGz/8Vm+0A=;
        b=QykEGLiRXHRmZYKbVS5cEJeagpmlLkDyqF6rt15krwT8gFA3NzZJNXtYZS1vyBVIbx
         o/OuyQNcyT8GjaXWQE63iC+GMy9HMdpUrBo2Uiy9y8IZ1jN/fzwmwptU4Bwz/FNW2qyC
         AlAY7kofq+xK+HUgHQYUOIsYqXpuaTODm3BIujVSMeZLMEmAyNvhhpioFyMFYFclXNox
         Ut96eN+mGmWKI4E5Gu1VCXHpFeNiLV8qqk/PEwDUGJuNC2/f1XPLkh1QN36mExA+MK/J
         0JS1Z0R509yrcfAa4ZaEdVK/YngnVNeeXkpfuzkrkIIYLoSHjjjDBmhA0qTbKDlSL43e
         udxA==
X-Gm-Message-State: APjAAAVr/t65Tr9PQibeY7mSfm/cM0pdLtf37nPskcOIm9MX8mmzK0zR
        SLiJLdv6DhNHrf01Ue/e5TDVDrl8
X-Google-Smtp-Source: APXvYqwS94NXLbGyZZittLj5oYCqUzFS3KDgyukSyGaKn8XVgxpESZsZA9zwMrq8qyEgXZdz+1UFBw==
X-Received: by 2002:aca:cd12:: with SMTP id d18mr6141966oig.146.1559141478412;
        Wed, 29 May 2019 07:51:18 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 59sm6776068otq.8.2019.05.29.07.51.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 07:51:17 -0700 (PDT)
Subject: Re: [PATCH] rtlwifi: rtl8192cu: fix error handle when usb probe
 failed
To:     pkshih@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, andreyknvl@google.com
References: <20190529065730.25951-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d9e2fb45-ecfc-2b63-da93-8dd8630ccf28@lwfinger.net>
Date:   Wed, 29 May 2019 09:51:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529065730.25951-1-pkshih@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/29/19 1:57 AM, pkshih@realtek.com wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> rtl_usb_probe() must do error handle rtl_deinit_core() only if
> rtl_init_core() is done, otherwise goto error_out2.
> 
> | usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> | rtl_usb: reg 0xf0, usbctrl_vendorreq TimeOut! status:0xffffffb9 value=0x0
> | rtl8192cu: Chip version 0x10
> | rtl_usb: reg 0xa, usbctrl_vendorreq TimeOut! status:0xffffffb9 value=0x0
> | rtl_usb: Too few input end points found
> | INFO: trying to register non-static key.
> | the code is fine but needs lockdep annotation.
> | turning off the locking correctness validator.
> | CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
> | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> | Google 01/01/2011
> | Workqueue: usb_hub_wq hub_event
> | Call Trace:
> |   __dump_stack lib/dump_stack.c:77 [inline]
> |   dump_stack+0xe8/0x16e lib/dump_stack.c:113
> |   assign_lock_key kernel/locking/lockdep.c:786 [inline]
> |   register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
> |   __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
> |   lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
> |   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> |   _raw_spin_lock_irqsave+0x44/0x60 kernel/locking/spinlock.c:152
> |   rtl_c2hcmd_launcher+0xd1/0x390
> | drivers/net/wireless/realtek/rtlwifi/base.c:2344
> |   rtl_deinit_core+0x25/0x2d0 drivers/net/wireless/realtek/rtlwifi/base.c:574
> |   rtl_usb_probe.cold+0x861/0xa70
> | drivers/net/wireless/realtek/rtlwifi/usb.c:1093
> |   usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
> |   really_probe+0x2da/0xb10 drivers/base/dd.c:509
> |   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
> |   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
> |   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
> |   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
> |   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
> |   device_add+0xad2/0x16e0 drivers/base/core.c:2106
> |   usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
> |   generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
> |   usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
> |   really_probe+0x2da/0xb10 drivers/base/dd.c:509
> |   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
> |   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
> |   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
> |   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
> |   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
> |   device_add+0xad2/0x16e0 drivers/base/core.c:2106
> |   usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
> |   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
> |   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
> |   port_event drivers/usb/core/hub.c:5350 [inline]
> |   hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
> |   process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
> |   worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
> |   kthread+0x313/0x420 kernel/kthread.c:253
> |   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> 
> Reported-by: syzbot+1fcc5ef45175fc774231@syzkaller.appspotmail.com
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I agree that this is a good fix.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

> ---
>   drivers/net/wireless/realtek/rtlwifi/usb.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
> index e24fda5e9087..34d68dbf4b4c 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> @@ -1064,13 +1064,13 @@ int rtl_usb_probe(struct usb_interface *intf,
>   	rtlpriv->cfg->ops->read_eeprom_info(hw);
>   	err = _rtl_usb_init(hw);
>   	if (err)
> -		goto error_out;
> +		goto error_out2;
>   	rtl_usb_init_sw(hw);
>   	/* Init mac80211 sw */
>   	err = rtl_init_core(hw);
>   	if (err) {
>   		pr_err("Can't allocate sw for mac80211\n");
> -		goto error_out;
> +		goto error_out2;
>   	}
>   	if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
>   		pr_err("Can't init_sw_vars\n");
> @@ -1091,6 +1091,7 @@ int rtl_usb_probe(struct usb_interface *intf,
>   
>   error_out:
>   	rtl_deinit_core(hw);
> +error_out2:
>   	_rtl_usb_io_handler_release(hw);
>   	usb_put_dev(udev);
>   	complete(&rtlpriv->firmware_loading_complete);
> 


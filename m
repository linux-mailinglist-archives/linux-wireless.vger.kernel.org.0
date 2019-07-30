Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477507B3A8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfG3T5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 15:57:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfG3T5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 15:57:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so11559621pgk.13
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F2DU5DMKUZvGyJqOn79XxhkaTdq5kQhonvbhHRRuVM4=;
        b=oS3A7LObFWkriyWh08OU0eo7F0wC9dLTq4LmJJl5tUMWdEVm5oFeqEQB+702s9lZwT
         rvina0kaW0daTDHsCUT+zPnSS/O/u4scd7wLcIWUSWIbTeu1/lwxHVVxmJDozJ84mGSp
         V225+ah8HGeyRSCHEYbHXHjfQjoA6cq4n1McY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F2DU5DMKUZvGyJqOn79XxhkaTdq5kQhonvbhHRRuVM4=;
        b=b+iG3qtkly9RcR6YYquurv15o6Z0cvVKzjluDVscK6XkDcO2YGx/3e0Ef+EEQYlPvL
         DK1CqYjYVu/1xndvRM2TSOzkCRYNVluH/J12Cjx5PPuC4aI2Wc0r94in9yQy5QicCwqt
         Boe0kpM9vmZOqbU4B47oZeL5rYqzlCtNTpRKr/rhpIxxVqspeUZFUA6Lv/aUkeuTSNv6
         gN6WPzQTjdCIGiFQPTsnulG6NYV4eKUL5XJm1+1KdfRelC6D6ibyO+75SWk/+9XHfg/S
         bR77StZj3fKGRwRyGixbmxW6Yx666p7VdXrjxnsCz8nqpn6/DLwrA9BLh2iUJ28R1qp2
         wVAA==
X-Gm-Message-State: APjAAAW78osV9oF+e/5gghAbVS6DiKkCYNGv9C8swJMogbm6LE9/iHUa
        CupS2ZZhIrN3rNPofPYdP/VzTA==
X-Google-Smtp-Source: APXvYqx8rs/WiOxmaHqJW1mXJdMwJzNmf8groUW515MAFxLehbEhH/CusG2+g8t4efA+DK+MquMIuA==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr62200996pgk.297.1564516629005;
        Tue, 30 Jul 2019 12:57:09 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id s11sm38173773pgc.78.2019.07.30.12.57.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:57:07 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:57:05 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        jano.vesely@gmail.com
Subject: Re: [PATCH] rtw88: pci: enable MSI interrupt
Message-ID: <20190730195703.GA224792@google.com>
References: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jul 30, 2019 at 07:50:14PM +0800, yhchuang@realtek.com wrote:
> From: Yu-Yen Ting <steventing@realtek.com>
> 
> MSI interrupt should be enabled on certain platform.
> 
> Add a module parameter disable_msi to disable MSI interrupt,
> driver will then use legacy interrupt instead.
> And the interrupt mode is not able to change at run-time, so
> the module parameter is read only.

Well, if we unbind/rebind the device, probe() will pick up the new
value. e.g.:

  echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/unbind
  echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/bind

So is it really necessary to mark read-only? I think there's a general
understanding that module parameters are not always "immediately
effective."

> Tested-by: Ján Veselý <jano.vesely@gmail.com>
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 51 ++++++++++++++++++++++++++++++--
>  drivers/net/wireless/realtek/rtw88/pci.h |  1 +
>  2 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index 23dd06a..25410f6 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -10,6 +10,10 @@
>  #include "rx.h"
>  #include "debug.h"
>  
> +static bool rtw_disable_msi;
> +module_param_named(disable_msi, rtw_disable_msi, bool, 0444);
> +MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
> +
>  static u32 rtw_pci_tx_queue_idx_addr[] = {
>  	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
>  	[RTW_TX_QUEUE_BE]	= RTK_PCI_TXBD_IDX_BEQ,
> @@ -874,6 +878,7 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
>  	if (!rtwpci->irq_enabled)
>  		goto out;
>  
> +	rtw_pci_disable_interrupt(rtwdev, rtwpci);

Why exactly do you have to mask interrupts during the ISR? Is there a
race in rtw_pci_irq_recognized() or something?

>  	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
>  
>  	if (irq_status[0] & IMR_MGNTDOK)

...

> @@ -1103,6 +1110,45 @@ static struct rtw_hci_ops rtw_pci_ops = {
>  	.write_data_h2c = rtw_pci_write_data_h2c,
>  };
>  
> +static int rtw_pci_request_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
> +{
> +	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
> +	int ret;
> +
> +	if (!rtw_disable_msi) {
> +		ret = pci_enable_msi(pdev);
> +		if (ret) {
> +			rtw_warn(rtwdev, "failed to enable msi, using legacy irq\n");
> +		} else {
> +			rtw_warn(rtwdev, "pci msi enabled\n");
> +			rtwpci->msi_enabled = true;
> +		}
> +	}
> +
> +	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler, IRQF_SHARED,
> +			  KBUILD_MODNAME, rtwdev);
> +	if (ret) {
> +		rtw_err(rtwdev, "failed to request irq\n");

Print out 'ret' here?

> +		if (rtwpci->msi_enabled) {
> +			pci_disable_msi(pdev);
> +			rtwpci->msi_enabled = false;
> +		}
> +	}
> +
> +	return ret;
> +}

Otherwise, looks fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>

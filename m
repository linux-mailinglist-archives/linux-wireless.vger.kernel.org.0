Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA7101115
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 03:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKSCDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 21:03:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42110 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSCDW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 21:03:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id i3so4463828qkk.9
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 18:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK8V8yv32v6kArLu67SDK9bLTVzTeLbveTCQcyUMPcA=;
        b=A5I9OwqkE/6RBmkr8A8vHele/HE9DThJ1e9dW4PjotvebPQNL5EfzkQxhDbfaRYXM5
         zz/EsswI+dUgv225A6Q3oOHq6ECPFLdOBfRmNe5Y9vgA5v+WaFWqZOkiMmpdUC3MMueC
         Hi/XZndU9OLtGy+qdrXFpPTNhNvlV8JeDuUxeJA41w8SYbpgdBdOzHwYFhFAz7uQ8OtT
         sDK/Pl/QDGdkj7gCxkxbeGSqGMsU/xaqpVwLmg5ScsAfQFJSpvcQrOjOZ/W6N1wzHXfV
         RtTXMdosl0BC9x7Hq8e9TWLCAnMbpIuAbb0wB2bd98DX3iXJGrH6owJuS/N1lh7jsmNi
         8xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK8V8yv32v6kArLu67SDK9bLTVzTeLbveTCQcyUMPcA=;
        b=NOzRY0ShVPqxDGfTNo+LnPeQvsDTdGE4AZGlT5oUcCQTxTtFyC0JHKmuDeiZPoZz2o
         Mh6gedZ0xLY7fpgFV0L6Q9uddiHotf/zvHiyAGhZBRxGoUz0uhWL3/DxDW6rN/isKiTG
         rsu4Q+6Qzp2VbcOJE0eSgaSsstbZaS5ucOF6Zo7kQU8jzjFYV82csSUeIGj/+nxs2eBU
         8OUU8AfYd7H/XMQdfn+/65rszl2P8PnpP3nt5KDqP+mUbmRzsoBG5OZ2oXaahvW2hEdp
         7S4udfhTL7f2qZpvPhxEsDGke6y4jlMZqOOk9Acp51hJEzXbQyWhs49cX94/SHUrBFVV
         yaaQ==
X-Gm-Message-State: APjAAAXT1zXqxq1SueZC5Zkvwp7V8qu6SCvx1OO+d+ALGFmGuUtUC2Yc
        l0ro3UDVNt7W67nUtAaTI0H4q7DgPWQa22vvYSq9pg==
X-Google-Smtp-Source: APXvYqxBNUe46+73r3f6k1gyYQ2wRj/aEclsZQ06JZ9leq2b86k49XIvBrNyitL7uqdgDQEQWzPYDCVfP0+tOpN86Ic=
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr28014538qkk.250.1574129000189;
 Mon, 18 Nov 2019 18:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20191118095432.4507-1-yhchuang@realtek.com> <20191118095432.4507-4-yhchuang@realtek.com>
In-Reply-To: <20191118095432.4507-4-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 19 Nov 2019 10:03:09 +0800
Message-ID: <CAB4CAwcJyCbpx1tj2k61v-uq8VUuNDnX95L8u3ReEyV49wH0pA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rtw88: pci: enable CLKREQ function if host
 supports it
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 18, 2019 at 5:54 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> By Realtek's design, there are two HW modules associated for CLKREQ,
> one is responsible to follow the PCIE host settings, and another
> is to actually working on it. But the module that is actually working
> on it is default disabled, and driver should enable that module if
> host and device have successfully sync'ed with each other.
>
> The module is default disabled because sometimes the host does not
> support it, and if there is any incorrect settings (ex. CLKREQ# is
> not Bi-Direction), device can be lost and disconnected to the host.
>
> So driver should first check after host and device are sync'ed, and
> the host does support the function and set it in configuration
> space, then driver can turn on the HW module to working on it.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>


>
> v1 -> v2
>  * slightly modify code flow of rtw_dbi_read8() to look cleaner
>
>  drivers/net/wireless/realtek/rtw88/pci.c | 80 ++++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/pci.h |  5 ++
>  2 files changed, 85 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index 6d1aa6f41e84..6e99aad39487 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -1081,6 +1081,30 @@ static void rtw_dbi_write8(struct rtw_dev *rtwdev, u16 addr, u8 data)
>         WARN(flag, "failed to write to DBI register, addr=0x%04x\n", addr);
>  }
>
> +static int rtw_dbi_read8(struct rtw_dev *rtwdev, u16 addr, u8 *value)
> +{
> +       u16 read_addr = addr & BITS_DBI_ADDR_MASK;
> +       u8 flag;
> +       u8 cnt;
> +
> +       rtw_write16(rtwdev, REG_DBI_FLAG_V1, read_addr);
> +       rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, BIT_DBI_RFLAG >> 16);
> +
> +       for (cnt = 0; cnt < RTW_PCI_WR_RETRY_CNT; cnt++) {
> +               flag = rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
> +               if (flag == 0) {
> +                       read_addr = REG_DBI_RDATA_V1 + (addr & 3);
> +                       *value = rtw_read8(rtwdev, read_addr);
> +                       return 0;
> +               }
> +
> +               udelay(10);
> +       }
> +
> +       WARN(1, "failed to read DBI register, addr=0x%04x\n", addr);
> +       return -EIO;
> +}
> +
>  static void rtw_mdio_write(struct rtw_dev *rtwdev, u8 addr, u16 data, bool g1)
>  {
>         u8 page;

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F555F9678
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 03:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJJBLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJJBLS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 21:11:18 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAEC19C24
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 18:11:16 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so7104125oom.1
        for <linux-wireless@vger.kernel.org>; Sun, 09 Oct 2022 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WuTDhOoKSUF6ASCrvTob0h6LWV+8ENwHyegd1+7REnw=;
        b=JBPDC8zGSPGQSvvh7iJmR6H5lGv/Gofioub8+gpkQWb6drS4e1fiirMWDbENGaHPEQ
         YHfS/RYR/yyF5MuWvsDXBd4cNSDDuHdL9xmWP9+kpu3NJFcthyJ7g5tAs36XhXWD5Ime
         caJUHLAYRGQ5/eGlEjJKn5zTkMBRijiBrm7qT/PYEQI+v9BKjmi8rlCph4dXtnue4G9X
         Orw8Jf4IBCdDLE20c3WonkT0J3Nb3Pu6tvRMn/2KcVpySghh2N+FNV9dQ6tdBY2IgUtv
         pzerk8F5BDcLPPd0H+6pFemhQwm+ulzTb6P3vJ1h7RRZen88RGYrmJLqkWr/ajGvfB+Q
         C4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuTDhOoKSUF6ASCrvTob0h6LWV+8ENwHyegd1+7REnw=;
        b=7UpWqMieNyBpLzvcsR5SF9DsK5O0BtM3fWUnrkWWi4Hw3KT56dvPXgzWLSUtqc90j2
         tllLwSv7jA4UAilsu9NxegKjO7p5XzTVhiJBhzJRld/eoweDwWd13hKD7H7LEGfTlNdr
         WNjs/pIQVl1H+wx6rIOPJ2NNQLtqKSDZBLs6DKWTP74S4NgQJhAvb9cKLf27/uN3ePYb
         vqPxLs3Re7BnTCTj0bwR2OcLdXxFaANsi2SsOfzJluIyyqr6NNiBihTDHKRmz88keSw4
         lLqcJTnS1YA3uTtOsuqBSR8B9omg4HI0MhZqnL8JmUrBridhpRXc/DweSuSkkSJpQ3UV
         wrxA==
X-Gm-Message-State: ACrzQf1VuOODix+wzzmXUJxVu6PtjOXOVgS9+VcYj2b0QPmJ/ZxdhREB
        v2KRNYp/borb7pA//yPZwRBy4ym5t6U=
X-Google-Smtp-Source: AMsMyM5+acEUSlr0+w0hi29/CNdsMu9NKlxAXrGsOy1rRnObWlK/dCshnA18ZiVUGMd6LhhhzjJ3GA==
X-Received: by 2002:a05:6830:448c:b0:659:d97c:cfab with SMTP id r12-20020a056830448c00b00659d97ccfabmr6868282otv.256.1665364275930;
        Sun, 09 Oct 2022 18:11:15 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id h4-20020a9d7984000000b00661948e6119sm1418278otm.47.2022.10.09.18.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 18:11:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <dddc4967-18f8-7d61-a991-264d618dda40@lwfinger.net>
Date:   Sun, 9 Oct 2022 20:11:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: rtl8187 triggers usb device reset on kernel driver disconnect
To:     David Tomaschik <david@systemoverlord.com>,
        linux-wireless@vger.kernel.org, herton@canonical.com,
        htl10@users.sourceforge.net
References: <CAOy4VzfHRD0cw2jdL=pzukc1QFuXgaC55Zst7uc-dMFPrHr7Yw@mail.gmail.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAOy4VzfHRD0cw2jdL=pzukc1QFuXgaC55Zst7uc-dMFPrHr7Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/7/22 23:33, David Tomaschik wrote:
> Hi all,
> 
> It seems that any time the rtl8187 driver is detached from an rtl8187
> interface, a USB device reset is triggered.  This is not a problem in
> the general case, but when working with libusb, calling
> libusb_detach_kernel_driver
> (https://libusb.sourceforge.io/api-1.0/group__libusb__dev.html#ga5e0cc1d666097e915748593effdc634a)
> results in the device reset, which then causes the kernel driver to
> re-attach to the device.  This prevents, for example, forwarding the
> device into a VM using QEMU/KVM.  This seems to be due to
> rtl8187_disconnect calling usb_reset_device.
> 
> The 8187 driver seems to be the only realtek driver unconditionally
> resetting on disconnect -- is this technically necessary?  I'm not
> sure I would call this a bug, but it's definitely behavior that was
> very puzzling to me and I only understood after enough debugging to
> start reading kernel source.

David,

This behavior certainly is a bug. If one tries to attach the RTL8187 to a VM, it 
crashes. I will be looking into this issue.

Larry


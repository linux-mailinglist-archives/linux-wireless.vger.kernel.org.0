Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D237F1987
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjKTRPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 12:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjKTRPf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 12:15:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134AED
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 09:15:32 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2e73a17a0so3067135b6e.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700500531; x=1701105331; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql0g3tzh+gqE/f9mnzNJDTzWt5oirUW3agwQcz0Uqj8=;
        b=cHmgS9DMcqguA83cEP6A8u/j0kG1XNpjYPSJ4efBTnwSEWebZ2sDxsAj8Za6pYfmMr
         kNh3kL2sXs++5t1SnfqFZRB6bAPri7TVftYYXgd/fODUCkXU3WGXx7jkUwyN2zNJAcIq
         BZI0eRU/vxuKuJ56D9EO2SqwNZBbKcGtgOY2AVgYy1WZN5Xoa14Xy8B4gOCSYzjTFpKS
         y90alluSfcQx7zZ8NhGk/QukS8OkUFL/eru9TYCTblLFEIWL26TaxAY2W6NcAMiC39Hq
         1YXSIDP+IY5clls9UyxheVYZTW1DEQVzn5juCBEYy43Gr/Xz5pB0qLIXkkJmvC9msQl4
         juwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500531; x=1701105331;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ql0g3tzh+gqE/f9mnzNJDTzWt5oirUW3agwQcz0Uqj8=;
        b=t64MA5hiS4TN3S1zHtYXDG+MmOZ18/hW5WJh+Nmss+ReDnrVMSaNGYXrpUa5yZ4+Ir
         81sVz467/KKeBRZTRA0a3+p0NvCWaIOHCONohsIpLhL5Y3KXdEXHWE6nQEo/Wwh28K/t
         Sm4dNkFhIllrwM3ed51aOdiGcGenegxGwFDhCLhKWawksgImgactjpHnkEvgQwn4Dnfh
         +qD8v9vsb2pWq/rX8H8hBExpC3Lgkxk0VUOOueEk4TtPAGVoGr3WaTSMGtNl2VjImno5
         RBIjnRi3H33CQq7lgjWN0O0/9/vuVt17eUYqY3zCrukJjICMqDBJnYI+TQ9EpIe+4K4Y
         Ub8w==
X-Gm-Message-State: AOJu0Yy4Hbhy0WnoXmJ9ME2m3o4IzgVfbe+G3brLPard8KzvEKxtW4J6
        n4vnB2PP9iB5I82CGKn/kG+mMlYqu68=
X-Google-Smtp-Source: AGHT+IEFMyChMtM4klEjCNMbFimxh5/PdhKrcJEqKBRt5zRU8b+XiodB67OGO+kwN/5uLCYe6pS/og==
X-Received: by 2002:a05:6808:de7:b0:3a9:bb08:d468 with SMTP id g39-20020a0568080de700b003a9bb08d468mr8982453oic.55.1700500530928;
        Mon, 20 Nov 2023 09:15:30 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ka8-20020a05622a440800b0041b7f007546sm2762384qtb.82.2023.11.20.09.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:15:30 -0800 (PST)
Message-ID: <304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com>
Date:   Mon, 20 Nov 2023 09:15:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org
From:   James Prestwood <prestwoj@gmail.com>
Subject: Power save setting while interface is down
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've noticed a somewhat rare behavior (<1% of the time) where bringing 
an interface up fails after disabling power save. This is done by IWD 
when a user-option is enabled, and follows an interface 
removal/creation. The sequence is:

1. Remove default interface

2. Create new interface

3. Disable power save on new interface

4. Bring up new interface (rarely fails with -110).

iwd[1286641]: src/netdev.c:netdev_disable_ps_cb() Disabled power save 
for ifindex 54
kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
iwd[1286641]: Error bringing interface 54 up: Connection timed out
kernel: ath10k_pci 0000:02:00.0: Could not init core: -110

I'm thinking maybe there is a race between creating the fresh interface 
and disabling PS, then bringing the interface back up?

Setting PS after the interface is up (so far) seems to be 100% reliable 
and have not yet seen this behavior. Regardless of any kernel fixes I'll 
need to reorder the command sequence in IWD to support existing kernels, 
but before I work around this issue I wanted to point it out so its not 
hidden from view.

Thanks,

James


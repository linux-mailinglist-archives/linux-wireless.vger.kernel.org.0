Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2145D7BF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354367AbhKYJ5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 04:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351759AbhKYJzn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 04:55:43 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4548C06175C
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 01:52:31 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 13so11343832ljj.11
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Szrqz9P+dt9sVGFiSoPelkYacT5d0NeogTG3nDY8S1w=;
        b=XORrXAs7yJcgbFEo6HIc9T4/qMyIznOPju41fI7yg0+OoJwfHsOE4KU3KWCxVjlVYh
         kuiKtQrPMZwi/vxGnCrvbywMhPwUJJVMMVcG+D+FaKutB13I5rQIdx3zYViZtIC27XVo
         lHOkIluPN7q91VL87r4k61Hnh4npHckEh6h/VgJTAlQ41dJ6MOpi8Kqc3X1sFe//Io7n
         HnavY3ntjj35aHfMHNUMxW49UZn4IGWjIw+2WiwDfqUvtpiLQuda40wqxCYThso1j+43
         djzhe6xYEDgfvQvkHkMSqCv7/keKbtHBnmtFgcPIMxkqAc8MBExYfEHj9CndWrPeVmfX
         C/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Szrqz9P+dt9sVGFiSoPelkYacT5d0NeogTG3nDY8S1w=;
        b=DwSEgq0o1xRBfWmzX19cSsZR0cFHDkbxps3BNfjF99W8TaWv+z7b1R+wJRNKZSKjCR
         iJd/WaYGmw1VRRQwpxn570FKz0t3sqezTb3SKQPTmN7zT7oXrxRo28jZ64oLLWTIznot
         Oy0hXf0fujYmhewlblVw4HEjkKpjvSFh3VhyKltH5y3N1MEPyAl+Xnrgrx1Bdux/SkNp
         3Wq+MpzZxxIqT/Domc5CsUw/5AILFgqK0Xpx+wLuKWQstLvmS9+bMIYuIaZOU1fb99Ka
         shRM99KA/ASTUbLIfp3TyVhHiDXwCnRS60F/vjXqyyYRP6j6b+mo8myHPwM8HhcKyoFw
         //2Q==
X-Gm-Message-State: AOAM530eCEoc4JFx/6ZTeK2xjoDaK5F8ZIcGriWndDpcusbJzJRLrFB9
        3M4qZ/1dasy+ZsSamQ0xrw8N71SLoPaZfxFw
X-Google-Smtp-Source: ABdhPJwbQ6uucyLdeNXvpvD2Zh/kpv+3edb8XMiUW3ZzdPWCZ8fnS48J6yK+cpdRvwxHb/2l8lo/dQ==
X-Received: by 2002:a2e:bc1c:: with SMTP id b28mr24264339ljf.500.1637833949871;
        Thu, 25 Nov 2021 01:52:29 -0800 (PST)
Received: from ?IPv6:2a02:2168:88a0:5e00:a4c7:4ba3:4116:5? ([2a02:2168:88a0:5e00:a4c7:4ba3:4116:5])
        by smtp.gmail.com with ESMTPSA id z5sm223553lfj.8.2021.11.25.01.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 01:52:29 -0800 (PST)
Subject: Re: [PATCH v3 0/2] ath11k: add handler for board-2.bin without
 variant and read SMBIOS
To:     Wen Gong <quic_wgong@quicinc.com>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20211125084458.16352-1-quic_wgong@quicinc.com>
From:   Mark Herbert <mark.herbert42@gmail.com>
Message-ID: <e4edd060-8dcb-e1f9-27f4-3ba8c94404ea@gmail.com>
Date:   Thu, 25 Nov 2021 12:52:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125084458.16352-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tried on my Dell 9310. It works now.

Gives the warning that SMBIOS recommended firmware not found but 
succesfuly fallback to generic mode and starts.

[  118.422601] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb 
board_id 0xff soc_id 0xffffffff
[  118.422616] ath11k_pci 0000:72:00.0: fw_version 0x10110341 
fw_build_timestamp 2021-05-02 15:16 fw_build_id
[  118.422778] ath11k_pci 0000:72:00.0: failed to fetch board data for 
bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from 
ath11k/QCA6390/hw2.0/board-2.bin

On 25.11.2021 11:44, Wen Gong wrote:
> v3:
>     1. add patch "ath11k: add fallback board name without variant while searching board-2.bin"
>     2. reabsed to latest ath.git master ath-202111221436
>
> v2: rebased to latest ath.git master ath-202111170737
>
> When it does not have matched board name with variant in board-2.bin,
> ath11k will fallback to search without variant.
>
> Also read the variant from SMBIOS.
>
> Wen Gong (2):
>    ath11k: add fallback board name without variant while searching
>      board-2.bin
>    ath11k: add read variant from SMBIOS for download board data
>
>   drivers/net/wireless/ath/ath11k/core.c | 93 ++++++++++++++++++++++++--
>   drivers/net/wireless/ath/ath11k/core.h | 11 +++
>   drivers/net/wireless/ath/ath11k/qmi.c  |  4 ++
>   3 files changed, 104 insertions(+), 4 deletions(-)
>

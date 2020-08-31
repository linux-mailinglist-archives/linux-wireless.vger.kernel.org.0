Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A025814E
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgHaSrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgHaSrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 14:47:12 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129BC061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 11:47:12 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e23so6255741otk.7
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aBccLzXC9rSMX+ESOOtEEaezBUg1+RE0+B2TlTmRawc=;
        b=pzygCV1ELyDxGFHbngrmLSy9D7pKvN6oeuTLkBdDV/Sb8kt5L9iofubm/bX4swP/Xy
         B0mmE72mnM8FNH8MXq6n6F6Dv/WqU7T/5HNArFwXc+Bakj8fByEG51s+GqNB+rUcLkLv
         hOR95OhZyvD9l0t9MdvxbY+eyxcpDaAKOB9Qx5MoHWuoLIyG23+dWAGp8pjS5rkkJTz2
         fvc+bHSNuhrItd/X6JIH3hGkqPUb+zUWut9G8+VywTQnpHDq5e87lDBLZSUfCtOIM84u
         Lc6JzK4UdX/tn8h9Yksoxk7hGM5FGIh1wh/mWJ4N9a+6z5WZI9dVGGYTmftpZnA5oEWR
         o3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBccLzXC9rSMX+ESOOtEEaezBUg1+RE0+B2TlTmRawc=;
        b=A/an9H532YT74hSiLEpZlB6g1keibAtIGPEEeCA1ByX9kVBT6GsnHbEI/dc5Mm/oq+
         bDKWYW+LbzF553n10sMi1tdqJqudfDzu8XVjg1PVAAI3cFTyV+oyoc3CZEx54oNSJoQE
         Bz9E6RPBDqgcTNdMeosrsd28uw9zm9LRHt2NumcgfSL3utj89mwlyvBllLZZYYnLftiG
         dJfA+pwoMzLBpmi6w5K5gbw39cPQ4U+MqvBGtpVx6nGgzUrvrsz6Kl+A2+Xa+ti9n5/P
         NdnAJRNWBuxMb8bhXyMhV0t9Yzl/FuJ14CXS2KFJzR+Aw8ujdq5eTFwmU78aZF6uzf92
         dMfQ==
X-Gm-Message-State: AOAM5306qbNQoeIKwHj5Hd5bpYQnhQnp2BIa55n5J6P/qGaiSSSCeG/a
        NSNsOMHF/MMxuGWTGDDbOHESMAxcKx4=
X-Google-Smtp-Source: ABdhPJyAlJzc4tPlXpCOp7UWIOBe/YXL2BQRjHznhaYBseQx51XU02J5MDCh1UiaOd6mrhtBtbRf7g==
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr1356481otb.107.1598899630782;
        Mon, 31 Aug 2020 11:47:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 63sm1938171ooj.32.2020.08.31.11.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:47:10 -0700 (PDT)
Subject: Re: [PATCH v3 14/15] rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20200829005442.32318-2-Larry.Finger@lwfinger.net>
 <20200831153219.B779FC433AF@smtp.codeaurora.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3744205c-6e33-33ef-68f6-03bd8c2155f2@lwfinger.net>
Date:   Mon, 31 Aug 2020 13:47:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831153219.B779FC433AF@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/31/20 10:32 AM, Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> wrote:
> 
>> Change the misleading macro name to one that is more descriptive for
>> rtl8821ae. Changes suggested by ckeckpatch.pl have been made.
>>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> Fails to link:
> 
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rtl8192ee.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rtl8821ae.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8723com/rtl8723-common.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/btcoexist/btcoexist.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rtl8188ee.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8723be/rtl8723be.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rtl8723ae.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192de/rtl8192de.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192se/rtl8192se.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rtl8192ce.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl_usb.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl_pci.ko] undefined!
> ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtlwifi.ko] undefined!
> make[1]: *** [Module.symvers] Error 1
> make[1]: *** Deleting file 'Module.symvers'
> make: *** [modules] Error 2
> 
> 2 patches set to Changes Requested.
> 
> 11743855 [v3,14/15] rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
> 11743853 [v3,15/15] rtlwifi: Remove temporary definition of RT_TRACE

Kalle,

I missed adding one change to patch 15/15. v4 should be the charm.

Larry

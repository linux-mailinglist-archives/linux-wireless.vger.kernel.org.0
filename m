Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7847361189
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhDOR5e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOR5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 13:57:33 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95BCC061574
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 10:57:08 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id t14-20020a4ad0ae0000b02901e65c173a4bso2143899oor.11
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCQoGcVcofHXVT1xKdundIRKr1S21JLwbaqAfA6JDXU=;
        b=I4Q8VBJ/9KS2jgVF5G1L7lbFtCbnSyNOfgZTs/X1SsW80TAN0okdLY54dN7I9neh4A
         SqDV5prfo3OMoIoBRa7FQ6XAOv83aPhkAYFXEWE4TdLBh2UBJ532NwBZSYcvtvmr9jpc
         Kxd5bL45nhqnn1e5YgN2dwH9dAFsIASbucwDJLpGfjZWiK2Lz4Yb7iZlmOFXHdEirQ20
         Fl04uhBu8i7AlBr1h0HVYG4l50rNXyTduH0lyNNoKKzK3sZXmh4bolluqdiNPTGNdGFt
         RNdHM8LhRDoquqLaheqj1zErWM8yD552lxGBSn56kVN+Jj5mEQ1jAGohasUDM1/78EPU
         b/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCQoGcVcofHXVT1xKdundIRKr1S21JLwbaqAfA6JDXU=;
        b=ndNn4yvrS3IktHuBHbB6u7QyDJHl4KAp25uxQAifzWsIRQzaEAqeERdNIAGeJFH0SE
         /E3g8OFMzFaL3dr6QtP5fOaCmxA1HeiEE9V3kcb2DdiNr1XxmOyyPwDL+sx5T1+9y1f9
         1PfLFX3RiQu1Z6bS2PuXOankKizPmvuyJMm615r4ukXUqZ8D0IV20f3ZZ/33oSWnqTY8
         fvA1L3Lf5PkIlaqLJ9tyd/H1nitnhopvFFJaPad5OHgQUzNCtyIj6cVgEhWE4Ei2Bspq
         c5+Vwq23+Q73SCVY+x0lAMy5wMjvX9UawuiYosOY63YfR1aFl2KWVzFCRWMZ1h0YP86v
         aURw==
X-Gm-Message-State: AOAM530kQqvJ38pTXcejLOPb5t8FJLXoTUohc0L3fxILYgDUr9GWYFxe
        pmDu+QJVAEAupjzZCRFL+seGo59SdwM=
X-Google-Smtp-Source: ABdhPJwtx+HYd9Jbx5pSPCULWjMEbXYbfTIAgi4snOtFIEDuXLH37RXomPBJlhBu2o4EmurskiJpKg==
X-Received: by 2002:a4a:8247:: with SMTP id t7mr281799oog.53.1618509427847;
        Thu, 15 Apr 2021 10:57:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id r63sm750976oia.43.2021.04.15.10.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:57:07 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [Bug report] - RTL8821CE 802.11ac PCIe Wireless Network Adapter -
 Not handled properly by the rtw_8821ce dirver on Kernel 5.11.11
To:     michaltoma <michaltoma@sicoop.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <2562248.KvEgbkE9EU@linux-9g0r.site>
 <c0afc587-b8f8-8bae-5589-92ebac536c9e@lwfinger.net>
 <fdab8de052c14b0ea1ed746bed9fcb8b@sicoop.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <50708085-c669-a8c1-62ad-60a66da4ad9d@lwfinger.net>
Date:   Thu, 15 Apr 2021 12:57:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <fdab8de052c14b0ea1ed746bed9fcb8b@sicoop.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/15/21 5:09 AM, michaltoma wrote:
> Hello Larry,
> 
> 
> Here is the full dmesg:
> 
> https://pastebin.com/ZUXQeKAt <https://pastebin.com/ZUXQeKAt>

On this list, please do not top post.

Thanks for the upload. Those 80 BIOS Errors do not lend much confidence in the 
quality of your BIOS! Have you checked for updates?

Have you tried when setting the options disable_msi=y and disable_aspm=y for 
module rtw88_pci if you use the kernel driver, or module rtw_pci if you use my 
GitHub repo. That fixes a lot of strange errors.

Larry



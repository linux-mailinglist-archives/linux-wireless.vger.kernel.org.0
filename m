Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C644135B6C8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhDKTff (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 15:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhDKTfe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 15:35:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BF4C061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 12:35:18 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x2so11393260oiv.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zow92hNG5VnUdImY7rj3mO0X0lKv0hJ1sXtgR0PoU6M=;
        b=iU3rXe9VSR7EHK5j8RGvYyBxNamWDP4Q7zOylGOE21yseEOaX01u8UdQxnkE0x2a5z
         +RA7jlbMCJGN3U88s8/ymSz3pyItm7XsdqFSExGkm1wCmZoRIZHYrbUet74a2cqjUXzr
         U0ll09l2k2gZsUb74y/GHeZBh3N/YY3p4b31nGDWO/vlHkDOo9vaIlALZFu3ZrzoXcTJ
         bGsoMdp/2U2XdRl0S1u0DqUKs9hUEc6UboM4/IQdWXLU5B9BMyIFniEcR2FfqL/TQlo5
         ZVhqNL9NiuCRBvhfVHwKvHWrEyawvm947GSFpOPr1mh2Ql72/6/HHtnkqocVxgjIOQJ1
         dTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zow92hNG5VnUdImY7rj3mO0X0lKv0hJ1sXtgR0PoU6M=;
        b=bQK83copwFqn5N0AByKIcAbuo5aM38BJC1weFEgD8ReooBSXSB6HDWHcTP95G/AVcu
         wYuKolj3v5WcL1nsBQzjZ713vks2bP1zwloR7HPiOZQRo4omXUDcoQBDq9YAtboUzyxH
         y5SKOGPDJ8H3IwzoY8e8BNbmwssXN6B5572J7Qh1xj3r6LjRwFwagmMYKvOZz3yP6rRB
         TeQ2R6zFhAIB5W1WI6ONg8EdCuDEI1e8icv8yg1JBFXeVVMFTVCw6pcvRk122evdv1Ar
         GBx8L2Q/ZmsoZ8/xNLxOTQ0ebcUP7tvB6KgqswYJBMBdi07YTBnQuGLGGizuE4rgXCno
         9uXA==
X-Gm-Message-State: AOAM530JV/Nb/cgcPi4FZik22rbmauyxbJdw3bUJ/cXx2mcttzj3m+Jd
        7EUwLxPceEFL3XLzW2+217om7oQz70U=
X-Google-Smtp-Source: ABdhPJwHaYc6KASFDa4qPVY83krexM15dCXVlMuQRMNoEV/r054ix9g2so+dvhQIUotafyIbuGbyPg==
X-Received: by 2002:a54:4010:: with SMTP id x16mr16769996oie.151.1618169717073;
        Sun, 11 Apr 2021 12:35:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l22sm87304oib.15.2021.04.11.12.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 12:35:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory leak in rtw88-pci
To:     =?UTF-8?Q?Klaus_M=c3=bcller?= <kmueller@justmail.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
 <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
Date:   Sun, 11 Apr 2021 14:35:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/8/21 11:12 PM, Klaus Müller wrote:
> May I kindly bring up this reported problem again? Is there anybody working on 
> this problem? Or did I miss the already existing fix?

A fix has been found. The patched code is available at 
https://GitHub.com/lwfinger/rtw88.git. Patches are being prepared for 
wireless-next. From there, they will propagate into the Linux distributions.

Thanks for your patience,
Larry

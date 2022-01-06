Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB9648694E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 19:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiAFSAL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 13:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbiAFSAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 13:00:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA2DC061245
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jan 2022 10:00:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j6so12399538edw.12
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jan 2022 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2PgRoxCtv9qdbY4kSqNqkLfjaX/8ZiAucAGuwYGFduE=;
        b=Nc++vwXbq0JPVnUBzJYVdISYnoQwhUxFjB+iJ7IE5IgbMyRXh/2YrU1aBknGDQXQ82
         JTxDxP/RRFMocguUYbke4k0HTr4oT5Aphzojrcic4RJdkcQ2Nc3OjOYFIn6nHCKfVRmG
         cF/MaoZTQnRpkWHVdih+Xh7jyPy9bJVY1gcWgE5oJfJcYGbtIzlMIMzKPdrrb9yjcI3X
         UrwEzU9/AbndWFdZZagTVRDNeX8gjNlgEmp8trm/Jyif50kO35/GbF436of9c5K2Gr4k
         iaNYFUTekXd90DnZYhXSkTgsSRuoMRMgP52+BdsUk56vhgQFNPrVDVjtHlAiJZ+nXjEQ
         f+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2PgRoxCtv9qdbY4kSqNqkLfjaX/8ZiAucAGuwYGFduE=;
        b=xlIvfmm0AMT7VwFdB0V5sBuu2WWordXAmPBxDJCEDHeqFkrEXBNLghMMmu3/z5FU1b
         mnittF0V1Sl2Hkz7igmUOUDTVrPDAv7Q79UN+exfDZ35Lxm3L1EFp/LROhLSA5r/VGtD
         xFkBRO2mbgrIXxu4KTFojwba3cQ2dQbQNyG1TWXWe16MDteY8XO2iVyky3dCdqVX+L/c
         nxfOiuJsVdF2wds5nB/FHlOwaRkBoRfk1b/2IoulZjbzBYmRfDgp0WyrvHm6HnJ2d5X/
         RIVxdbpmErwsKnrjZ546qx9+pcrp4kO+t3daQwuyb671cxKTu1m0HlJYX9Tr/2HZMCCx
         Gxpg==
X-Gm-Message-State: AOAM5311isYfwwkAYLwOOtZSMbnAKDj/iHuI4BotkRzQUWZvIoBcNzlf
        7W0BUN8OYZSvPHQ9VXpVWWIxQNHdq64=
X-Google-Smtp-Source: ABdhPJyhNNGHe4cssHSBASc0CMY8sT0QTbe1M8Q5PcI1RGY2JJi3v0+oPo6Pl9/ssrkU4lD91sC8kg==
X-Received: by 2002:a17:907:b05:: with SMTP id h5mr46201673ejl.687.1641492004090;
        Thu, 06 Jan 2022 10:00:04 -0800 (PST)
Received: from [192.168.0.74] ([178.233.26.119])
        by smtp.gmail.com with ESMTPSA id o6sm982735eds.35.2022.01.06.10.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 10:00:03 -0800 (PST)
Message-ID: <00a8fc90-a70e-7d53-609a-2b1db5b7590b@gmail.com>
Date:   Thu, 6 Jan 2022 20:59:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: rtw88: EDCCA makes Wi-Fi unusable with a USB 3.0 SSD connected
Content-Language: en-US
To:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kevin Yang <kevin_yang@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
References: <994addcb-a203-d718-fc92-c7f1d9ef05fb@gmail.com>
 <c1a47f94d9a7408e9891dd15ba177992@realtek.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <c1a47f94d9a7408e9891dd15ba177992@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/01/2022 08:53, Pkshih wrote:
> I think you have sorted the problem that USB 3.0 is the interference source.
> Since the clock of USB 3.0 is 2.5G, so please try to connect a 5G AP to see if the 
> problem is still existing.

I don't have a standalone modem/router that can use 5GHz, but I managed
to create an AP from another laptop and connect to it. Pinging the
second laptop works fine at 5GHz (but pings are still late/dropped at
2.4GHz as expected).

> The adaptivity patch is to detect signal energy and stop to transmit if the 
> energy is over a threshold, and I think the USB 3.0 interference does.
> I will discuss internally how we can debug this symptom.

Thanks, feel free to ask for more information or testing if you need it.

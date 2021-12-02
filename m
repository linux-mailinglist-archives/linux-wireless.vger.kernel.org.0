Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72A46656C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 15:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhLBOly (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 09:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347266AbhLBOlx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 09:41:53 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CDC06174A
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 06:38:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id j18so28882ljc.12
        for <linux-wireless@vger.kernel.org>; Thu, 02 Dec 2021 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=S0YVlAP4NSFQ0qi3W2CMMBLw+haGgippcL2rDNKayt0=;
        b=CgmTGieUUcB+Bl9/QXMeh0DmcjGDylUQ1tE/Lczyr9c2VuLXNyqiMNUS3T2lb1+CEI
         3YcwYD206BaG6Sb5RQ8HdSkLUV3NLQ9Xjhca1aP48sbJqMxzRg2udi99lLhe/W5s2+vw
         hskck8p+mmk4oJ4Ii1dXaFWE4oRFAMeG+0Uh38lXI+jEpfXnE+OO4muIAn61CbOoXQ53
         y0qS/3nuu9MLme1WqEANW7f3px5swqo+Tov7BREP7Uf2ovju75cxM+GlnAiJ7N5dBQ2v
         iASAjNgqeoRbohzi9kHZg+cB2JS7Cc3wZWjN3uZJRmj6o9jz4jO294lJJSCVeir2bvDz
         ylYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=S0YVlAP4NSFQ0qi3W2CMMBLw+haGgippcL2rDNKayt0=;
        b=7JZf9h4VZpTO+DN97lScsfGJHlolyWbqRf/5o86X7A9bIe1xlk6YItM/fP78RjXLIu
         bC1zCkf+Th31xRgWZLkgUY5lHi+kXKtwtDMcgIBiPMKcUxaCZqkD55Rz0r5P7q8XDzA6
         nUMBEAeUf8jslHTyK6xsYDr6Ps3tT2FWnfyINO3pT4wTxhtrmrI3xQGKdXi7RkJ5zfIQ
         chD6nCeWnH+Mbv15WIB2NKjfbDWjIVmNDS89aju8pah4SdOqpgfK8GO+jd4kM6WlyMHc
         ZqW3MWuxe2nqzLI4SNMSVYAjxebVaZraYjsj33Woptdtoc35dq8LaaSvRJ2gjkZBoBro
         48Ww==
X-Gm-Message-State: AOAM533g2R+HtJmnjpg8vQssydAEaKdfgZxd6lK5z74JqlUB/40CYKEL
        Yc9lkDPvbffV4ufM+exYR5SZCNK+DZ4=
X-Google-Smtp-Source: ABdhPJygIXZadKTnerkuTOwLX4iGUSAcyxKpt4b4f/pCWnCpxHpuMKlibbOrrMr3BxZKIg7OSR8hJw==
X-Received: by 2002:a2e:83c4:: with SMTP id s4mr11576968ljh.445.1638455908513;
        Thu, 02 Dec 2021 06:38:28 -0800 (PST)
Received: from [192.168.130.183] ([217.12.124.26])
        by smtp.gmail.com with ESMTPSA id j15sm369006lfe.157.2021.12.02.06.38.26
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 06:38:27 -0800 (PST)
Message-ID: <4ac5c6f8-c5c6-dcc6-89e0-557c5dc0a27f@gmail.com>
Date:   Thu, 2 Dec 2021 16:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
From:   Ion Cebotari <cebotari.ion.v@gmail.com>
Subject: Realtek wireless 8822CE fails to work after laptop discharges in
 sleep
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

Following the recommendation from https://github.com/lwfinger/rtw88, I 
kindly ask you to check out the following bug report:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1952403

If you don't work with the Ubuntu bugtracker, where I can submit a full 
bug report about my problem?
I can attach all the required files for you here in this email, if 
necessary.



Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D80319F46
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfEJOee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 10:34:34 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39898 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfEJOed (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 10:34:33 -0400
Received: by mail-lf1-f54.google.com with SMTP id f1so4308504lfl.6
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2019 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=FSvmskLf5GBVtS5ttSj3/IPhe6ZWfD/DXpP9Pb8ZXTc=;
        b=ibFzl7qEHgzJMy/rW8QjaV8zrCRiER/L1MgLHFaf9iJh3P2CGkdwsL4pnLGfl7Ro6l
         zmG/EQCzWbEBmQiOgju+8jCO9dNDwANKg0y8MJVIq8Ks/34gmyWItqyqBy/uhswZzWpM
         x2yhncbZFGork6ApCZo2DSfyEilw3BqPOD+E2A7HbKhlc/B9WEaEFKeT2ICjZ+DzLXev
         qfXk3n9L4YfcPUGKEq0oAiwRCFRS28/7ayv+OfX7DA76e7uPqhUlxu7uMKQygoXIfLnl
         wVC3SeUR+kbX2cXS0cPO3Z9Fvtb8BtayM9AMXaFDb4/MH6RyM1VCK09y5emiiERQk5fK
         1xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=FSvmskLf5GBVtS5ttSj3/IPhe6ZWfD/DXpP9Pb8ZXTc=;
        b=M3QkE03lIfX49G9gMsOLT1w8YNHdX+7rN3VOBEtBaa4tcFrE3qVn9qany+QsQRW8VP
         WxVONNkk1ygbxB5ZLQBJu001os6XCshIl5xutl8zXUrv1QDn98OQDBzSNDDJ0WGqlhCR
         f/u2IjWNK0GemVgG88ZvBOX+2A6w0E/wNY98S9Di0zRk8osUBAifDoaa7dH8oTjG2HTN
         qB29usrv6wzHBYhpb87XpEuIyqint+wAvbCyVvQA7z529fCSGwbwmZH0sOMDuNHdDU37
         P9P/eLrWvmx/iTwec7sFAdi9+NhpNCDeRnXKYFi2RUFnJzzgjbcWT08hbUVlZnwtbxc3
         I9Ug==
X-Gm-Message-State: APjAAAWE8IOQ11cn0A1jxcnvhUOEf8++jJOBOMuPmmNrlVUfFq7qY0pQ
        0CQWM/FJdeuG6iU1k16rnxmvBbgd
X-Google-Smtp-Source: APXvYqxqF0mZT+/yXKpUlpxuNMG60/Ba/NTIALyogKPdF7LRpflXn6IolHJ/Csniv1f5Kuta5+XWuQ==
X-Received: by 2002:ac2:4205:: with SMTP id y5mr6111439lfh.15.1557498871354;
        Fri, 10 May 2019 07:34:31 -0700 (PDT)
Received: from [192.168.1.120] (host-176-36-255-241.la.net.ua. [176.36.255.241])
        by smtp.gmail.com with ESMTPSA id o7sm1403336lfl.13.2019.05.10.07.34.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 07:34:30 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
From:   Andy Lavr <andy.lavr@gmail.com>
Subject: mainline kernel brcmfmac regression
Message-ID: <6ba17e5c-0afc-ef53-8869-907bea1cc1c4@gmail.com>
Date:   Fri, 10 May 2019 17:34:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru-RU
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,


*Kernel 5.1 WiFi work fine:*

[   20.659502] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac43340-sdio for chip BCM43340/2

[   20.664444] usbcore: registered new interface driver brcmfmac

[   21.089209] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac43340-sdio for chip BCM43340/2

[   21.094169] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available 
(err=-2), device may have limited channels available

[   21.099805] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43340/2 
wl0: Oct 23 2017 08:41:23 version 6.10.190.70 (r674464) FWID 01-98d71006


*Kernel mainline* 
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/) 
*WiFi dont work:*


[   21.120466] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac43340-sdio for chip BCM43340/2

[   21.125156] usbcore: registered new interface driver brcmfmac


Same device and system.


Best regards, Andy Lavr.

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC43477968
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhLPQkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 11:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhLPQkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 11:40:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8523AC061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 08:40:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso5601229wme.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=O213G8tA2rgP9YzFngr5KkM5rXv39EiiltzJe+1Bi50=;
        b=pJDVOfPbzVZpRnOhjNwBX77QDgvAijOoGD6/8rKIIv5Zo4RajQOZQv7lDf9uhIhxwM
         Iayr8nkGJWCIxkoS7RnC4mX6g9HaMfTcZpMaUmaEEyrtg8HVYp/pznQAyAViKKPMYtlP
         He5ljU9j7igpdTgTWWu7cVooQgGZ8VFoSjH/dusugh2Q/EUbdqPTUKeLVYWr02iOW2iX
         4ZALtxoXZI/edsyebdK3BfpxpZ9JXtt/OM2fg+8N/ZFi7ajhyal7ligqibd5tsn3TVWx
         BEBtwJ/dPOwTNj7paxXg0Qde6fEUGuvheMgxcIUGcLRFjqxfEGD2206EiZt4swr7ebCp
         6m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=O213G8tA2rgP9YzFngr5KkM5rXv39EiiltzJe+1Bi50=;
        b=qTWo0VmgQBc3nNeF89++ET3Kks6/OrtnMIFhrza8MnW7UhFXWodbMgp9LuUC+05UFH
         XmrjlHnyxOcIdA6X8Ab90ESftz2BacKy8Fm7EXBMLNhXDEuW8tuNvSuLKd/ycJ2zUZAl
         Dd2VWD3TqhYcAA7ImfAStRu98ve9LW1fILp/5MrBnH3ZBnnHyGll4ttAu6vx3imjTTPq
         axi8FwRhfqAao4tXKtubR2eMTreFviCwXscrAg/gNiSbL0ZP9Dz65hArsSBIaCvWEdBq
         CYt9iAyVcahMrEsLaepA2LPSAq+lQfZdaJSh2q0DcgWBjOl+0wr7LUS4BcAEENVYkBgD
         fkyQ==
X-Gm-Message-State: AOAM530uk7hlOgIZp/M9V4zciQYGvvuWTYJrELu9Jqab+9Rwe2ndyx4X
        uAnlWSnHp3S8JZQwJvfDqA==
X-Google-Smtp-Source: ABdhPJzVWCVo4tbUlmZhR9qgTJiVauL5NeFEKno9/DBc1ikOCrEizsO+1660OqDdEmCe3nm2/r6vKQ==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr5731401wme.157.1639672823118;
        Thu, 16 Dec 2021 08:40:23 -0800 (PST)
Received: from [192.168.25.160] (ip-176-198-222-94.hsi05.unitymediagroup.de. [176.198.222.94])
        by smtp.googlemail.com with ESMTPSA id bg34sm9025764wmb.47.2021.12.16.08.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:40:22 -0800 (PST)
Message-ID: <8a737c14-8d76-3a7c-a2d2-13742963463a@googlemail.com>
Date:   Thu, 16 Dec 2021 17:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: de-DE
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Subject: Problems with RTL8821CE device
To:     tony0620emma@gmail.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

the RTL8821CE (rfe 2) device in my HP notebook (AMD Ryzen 5500) is more 
or less unusable.
Association with the AP usually takes a long time (but finally succeeds) 
and I'm very often getting site loading errors when surfing the internet.
After having successfully started a large download (which may require 
multiple attempts), it usually "gets running" and the performance isn't 
too bad.

I've tested kernels 5.14 to 5.16-rc5, but there is no difference.
However, since 5.16-rc dmesg shows some

    rtw_8821ce 0000:02:00.0: failed to get tx report from firmware

messages.
Apart from that, there are no errors in the log.

I also tried module parameter disable_aspm=1 without success.

Please let me know what you need.

Regards,
Frank


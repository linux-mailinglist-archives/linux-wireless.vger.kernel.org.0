Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06121D0A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEQSEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 14:04:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34642 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfEQSEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 14:04:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so11831252eda.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2019 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ValCeoI/W4Lu5SHsLwRVyZA9aQ8FRAo5kQwhXjV+Tj8=;
        b=VsFt6eBjNZcpheueBUCNWV+WYPieiDAmr7QyKruBVwOjtrjdbZ8a0ytVlD6SNW4V0F
         LTMfDuAvRaQMf0DiacFUxdfYTrXfw03CAKL58g0HZyNB3ryycNgPmmIKMNQldEmas1r/
         GPRSOJdgkZ6EQQLtlsg+482br88rjX7/ZaMEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ValCeoI/W4Lu5SHsLwRVyZA9aQ8FRAo5kQwhXjV+Tj8=;
        b=uE2GdCc73I5mGNOD1m+kf4gaIulGVSMMcpP7RyZwFTi4gHq7KNUSxN+tA91kQWUzRe
         VMu+RUDZeFkx8MsNhHHJG5ZwO/FR3kUOnWSnP3YeFXqK/zSHtssH2U1VJEAg0/g5HCA2
         1j+vFq7rUuwEmxdkCn10/Bn8u2S1cYl+HEdOgaa/r1rd329XdApqe5Qd/+dZk7nZBbe1
         VMNLHBdEf+rDp5SE0VTyVr12tt/YaLkEOP1lAru+LfQhdeyDUYEwysiW1AgJmIsjQGes
         musmT59WlKlbCllmgU9hs5KtrWR00qqBkY4EEHIX8qihO1jMf8cJx1oX2SMZb1vaEFAT
         SaHw==
X-Gm-Message-State: APjAAAU/h2h94t1ORoo8v43NWD416gyOuMT4PejW8ry79bg6rGAdX8NE
        RLnyKBJjLxrkPYtRp4OVHhrpRv/H4a3wHWf6qWbsLVEnGUVuJYKvzzleBYfISDH+BX/IbC3oamU
        1iTnL0LLyyvcqaMBd0ENX7+s4c3AKfJJqP2yyE+3O19Wy1f7S82hJLiYGHSnPQthK9GOnKAbPxN
        uIivbvVGRRIr6bjQ==
X-Google-Smtp-Source: APXvYqyAXwxgDway+evC2H/8urpFE/xKiHjMx910KQGidKBSaTIqXVEDg90HCzuoXiRmAh1eNt1xTw==
X-Received: by 2002:a50:95af:: with SMTP id w44mr59036645eda.95.1558116285034;
        Fri, 17 May 2019 11:04:45 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id y46sm2922971edd.29.2019.05.17.11.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:04:44 -0700 (PDT)
Subject: Re: [PATCH 1/7] brcm80211: switch common header files to using SPDX
 license identifier
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
 <3dcbfbab-a1f0-bdc6-909a-d9ed225e060a@broadcom.com>
Message-ID: <f35219bc-88c2-cc8d-530e-516fb7a4ce80@broadcom.com>
Date:   Fri, 17 May 2019 20:04:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3dcbfbab-a1f0-bdc6-909a-d9ed225e060a@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2019 10:57 PM, Arend Van Spriel wrote:
> On 5/16/2019 2:04 PM, Arend van Spriel wrote:
>> With ISC license text in place under the LICENSES folder switch
>> to using the SPDX license identifier to refer to the ISC license.
> 
> Hi Kalle,
> 
> Given the feedback on checkpatch (or spdxcheck) failures let me respin 
> this series.

Actually let's *NOT* respin and leave this series as is and ignore the 
warning for the header files as Thomas wrote in his response: " So we 
can fixup the documentation and allow // style for headers as well.".

Regards,
Arend

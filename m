Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F5E0A61
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 19:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfJVRRB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 13:17:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41096 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387932AbfJVRRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 13:17:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so10324508pga.8
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GHvPOx7Y78ZeJ1Yw7axrjUXLhpN94yYCRzl4dJi2nWk=;
        b=GWDcpvx1auFIYbVdNJw/pgsS8e50PuTC5qQeUDHNMtTqYF4Fv6cxLdYzH++VXfVIbn
         soNeQcRZUdPA5eLLQaUzK9KWs5Q0cJ38puY+sRZHWW9ORrwQZ2A7syR3PAX8ZjI71Ft/
         AH5ieJ6+gf8vayXNyG3DJrDuUbWxQTtIA8P7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GHvPOx7Y78ZeJ1Yw7axrjUXLhpN94yYCRzl4dJi2nWk=;
        b=L9g45pwAXjn/W9Mv9/UlRlcysrmBxpG5H0qNm3xRxlxehlrqLJbheR1cD/lei+DK8N
         t3zypbtWG8khD11wwLBfw43xan03MBNEzo/qqRhRr/2TgtnqNwHT5ZhC2Q0OIZzqsL9j
         br0SdaFKuY0C+BahRmilTwLUb6ZQo0f/kKQ8iObjPrZWrn48/ioiyqfkgbEMoN8L4wbJ
         Z2QuU0mSjKm3P80n8SLRib3V9B0Y/0yf9S0Vj6U4Mzhn6i6l0bcUDkpUwTwesGyuUEp3
         ZyyNGBu1+/uMY5Z9ZQWIGIuUKigIDEtvsm1mf7iJpAnyWvmAgIJ28pTl5GDwovzrFcVo
         1CyQ==
X-Gm-Message-State: APjAAAVVUwsCrI6LRjt6lOmPDna/WLq+2dx3rk2tO5ivJeQcokDjXx1E
        z6kNX0lywwBvp+kBLJnqBRAuz4cqZZU=
X-Google-Smtp-Source: APXvYqwJqI342gzP2JTytRol266Tw3+AT8qsdYN7EYE+D2Ueg/APyfQxpWsXua5mUhI9fzRUZtUgeA==
X-Received: by 2002:a63:f750:: with SMTP id f16mr4977771pgk.206.1571764618980;
        Tue, 22 Oct 2019 10:16:58 -0700 (PDT)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id u3sm18761515pfn.134.2019.10.22.10.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 10:16:57 -0700 (PDT)
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     Zhi Chen <zhichen@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
Date:   Tue, 22 Oct 2019 10:16:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/22/19 1:57 AM, Zhi Chen wrote:
> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
> PCIe hung issue was observed on multiple platforms. The issue was reproduced
> when DUT was configured as AP and associated with 50+ STAs.
>
> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
> issue happened. It broke PCIe spec and caused PCIe stuck.

How can you say value 0 (I believe it's 64 bytes) DMA burst size causes 
the symptom and 1 fixes it?

Peter


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC72B1717
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKMIR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 03:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMIR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 03:17:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852F7C0613D1;
        Fri, 13 Nov 2020 00:17:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id me8so12077563ejb.10;
        Fri, 13 Nov 2020 00:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bnWA7NJaIVcB2g0tlFOVRFKjNpLzobGBPKUYXGrrkP4=;
        b=WKGolVX0vOUYOcn2S2IdwfAy7H0LC7GcCdmFWO7bhPMFgftLeB8Zai8yg1mRAIzxpf
         4sQ9sESDke9/PQRdeuA4zJxX5TqUaodkFSorp22udFofmUg0wm6M33fUBCyja0DOdQMp
         foZ8X1g5hyLH9sfx4wi5khEERvL6ovL/woiGgMs6b8nd/oL0I50m8RIiEzegP3Hf2u4I
         So7T/HXA2332yQKYkHtKYzmhMgpS5nSoJiBw7dxffDY31vFJAkKP6aAWbj+J5cAkOuEK
         C3A5sZdg3Bft0pN4/QQQ5Ovw9efTcUVS7npumUr0Cc3Uj/JiXAvhaMbpeYbJLdDneDFa
         vXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnWA7NJaIVcB2g0tlFOVRFKjNpLzobGBPKUYXGrrkP4=;
        b=qy7HjRas6Q7bwWrN/ciWunp2xgpBuxvPX09PcTxv/sGna6COp6iNgEXYz6adpYX8FJ
         U36S4eRb4rpDylaKyZUd9DPGyVyUQfck9GLsaDhF5cyBqLUPC9Eg7dhx6xslgaIWwACx
         kN3e8qfpPkrc4bHXeslL91c4JRBWar8HQjCGFdbOzWx0Pskao37EppsTYsGpC7GeGGCw
         eCvCws67jPnqthlYlhPd/L93TetEjjgcz4iGh78ulCausnuxaPE5IJoKFMwiG4fiq6Tt
         7ieFfIvW8At57Msoj4IpqudxBG4LduTLhQszwd8mAxx3gPifIlGTanaqEzUy9pDdwpW+
         sNuw==
X-Gm-Message-State: AOAM530l70k7II6q7wA4/3sVqll6lXDXeGG0SQLwilfB4aS4RzJOrvtS
        J80XHO21OrO67ez8LieHk2g=
X-Google-Smtp-Source: ABdhPJyiPs0awLn6dH6rvyw3cd8X3RzIPjMBgDHEhTcLFynuIIYzK0FaqeS9tlCjlHWH4edQH+TUMg==
X-Received: by 2002:a17:906:26c2:: with SMTP id u2mr807496ejc.529.1605255477227;
        Fri, 13 Nov 2020 00:17:57 -0800 (PST)
Received: from ?IPv6:2a02:a44f:d2f0:0:56ce:b296:68ac:ee9c? (2a02-a44f-d2f0-0-56ce-b296-68ac-ee9c.fixed6.kpn.net. [2a02:a44f:d2f0:0:56ce:b296:68ac:ee9c])
        by smtp.gmail.com with ESMTPSA id a1sm3402973edk.52.2020.11.13.00.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 00:17:56 -0800 (PST)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     David Hildenbrand <david@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, ath11k@lists.infradead.org
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
 <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org>
 <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
 <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com>
From:   Pavel Procopiuc <pavel.procopiuc@gmail.com>
Message-ID: <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
Date:   Fri, 13 Nov 2020 09:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Op 12.11.2020 om 11:48 schreef David Hildenbrand:
> Trying to understand the code, it looks like there are always two rounds of reqests. The first one always fails 
> ("requesting one big chunk of DMA memory"), the second one (providing multiple chunks of DMA memory) is supposed to work 
> - and we do allocate memory.
> 
> 
> In the *working* cases we have
> 
> Respond mem req failed, result: 1, err: 0
> qmi failed to respond fw mem req:-22
> ...
> chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> 
> We don't fail in qmi_txn_wait() - second request w
> 
> 
> In the *non-working* cases we have
> 
> Respond mem req failed, result: 1, err: 0
> qmi failed to respond fw mem req:-22
> ...
> qmi failed memory request, err = -110
> qmi failed to respond fw mem req:-110
> 
> We fail in qmi_txn_wait(). We run into a timeout (ETIMEDOUT).
> 
> Can we bump up the timeout limit and see if things change? Maybe FW needs more time with other addresses.

I tried increasing ATH11K_QMI_WLANFW_TIMEOUT_MS 20 times to 100000 (i.e. 100 seconds) and it didn't have any positive 
effect, the second error (-110) just came 100 seconds later and not 5.

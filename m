Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C487EA772
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 00:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfJ3XBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 19:01:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33670 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfJ3XBr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 19:01:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so2576927pgo.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2019 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8Lz1NNvigcKa6eRoeOWl2YolOALtlfrxF/EmT63uI+Y=;
        b=uB3dyAzVlNxnwlYOYXWGhK20MKllXL+uJTuMZvZmsbLUF1gCbFXi9F5YLP8hC5fnNS
         8n6XmP1sYzPDz7ZDkFYyOWGjrUyZQlaZCaKyizbMv4rsKBxkjBZuh+UZjgvUurCfRIso
         NLw4dAaATcnd39sEP3itAjI5dS4f/G0ZQIUWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8Lz1NNvigcKa6eRoeOWl2YolOALtlfrxF/EmT63uI+Y=;
        b=PVHz19HezB/MNDvgpCL+y9GavcdvBwHnuqaRohmIrsvbNBiOPRvw5PWRhamnL4nrp8
         6w7ELeV/F30qB7vU023IewhY9CrNEAq9BftvTxddT/t8oAHyjTrZI/4nwIn5aa+5eNPG
         83oYP0+D1q+3nGI8wjnDqVimblaDIU3xQelRyPI5/+zF2Qi5YDsmYebFxfiu9MY5VBxM
         /N+lepeerHaCOlR1Tcxj0NM04+bboGPQZOedb0Z2U6nj39uVDl5Przdk9t10snRjXuFg
         IktMTKRRqxSBHBZqQxUuF4IwH3qOY3IEr++BTLB1Yp32Ot/rREEpZ04WR78tdyNRlppl
         i7Hw==
X-Gm-Message-State: APjAAAV4fIizxRtCcalvTh2bMCIr4zQO9+JX7CQSfwFzczEcPV7WfEwo
        TkTERfxfZmziyhymJiUfAll9u2NpbOlqHw==
X-Google-Smtp-Source: APXvYqwuydGy/fwcla17q99240a+6A7gF6qG3YHcI8hCejGE9jNRoVUcp9RAlNVwFfQWkWyiNjrwNA==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr2076498pgk.255.1572476506100;
        Wed, 30 Oct 2019 16:01:46 -0700 (PDT)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id c12sm1028271pfp.178.2019.10.30.16.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 16:01:45 -0700 (PDT)
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     zhichen@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
 <8c6d531f6474faf4df55f90185466774@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <3f108a96-3ea5-79c0-54d5-b2f26a3e0a9a@eero.com>
Date:   Wed, 30 Oct 2019 16:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8c6d531f6474faf4df55f90185466774@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/29/19 11:16 PM, zhichen@codeaurora.org wrote:
> On 2019-10-23 01:16, Peter Oh wrote:
>>
>> How can you say value 0 (I believe it's 64 bytes) DMA burst size
>> causes the symptom and 1 fixes it?
>>
>> Peter
>
> Confirmed from HW team that the configuration controls AXI burst size 
> of the RD/WR access to the HOST MEM.
> 0-    No split , RAW read/write transfer size from MAC is put out on 
> bus as burst length.
> 1-    Split at 256 byte boundary
> 2,3- Reserved
>
I would ACK to this change. Although QCA4019 host mem max AXI read/write 
registers have different descriptions from above, they say 1 (256-byte) 
is default and the values, 0, 2, and 3 are reserved. So changing it back 
to 1 is reasonable to me.


Thanks,

Peter


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71A520DAA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfEPRCu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 13:02:50 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40582 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfEPRCt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 13:02:49 -0400
Received: by mail-ed1-f49.google.com with SMTP id j12so6229533eds.7
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=eE+O3tb2VNruD5TOpyau7erVGvA5qvz0VYUdwqShPHY=;
        b=YZeQQrLXCsEk7mn12NxjbExXeXOAxN1sXsvja1Y6pexS5NR6L5hcPFIG1ygjmxwabI
         jT620YlHxGBRyINzezBiSBKk66k+CkCzER8DOurE3vs8O/3W5JiFwKKYf6LUaQ19cJNH
         3tQi+kw8nbbF11GZ9KowdMCCpId3/UiRbBYnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=eE+O3tb2VNruD5TOpyau7erVGvA5qvz0VYUdwqShPHY=;
        b=dokl/VqMUjCSXtzShbBrE7jKB6ZSJp5rMte33SLlVu2rRSiHK+M9ie9zOg7S6+QnDM
         1LnvkwEjDDGa+pWzvqdK42v8RpqjfByaCHn9zEh1QUr5rQoWqwHRvSl7JXQ4oT5ScaEp
         hSSiU33IHjmw6J5VVgQk/OCPKqeVCtnh81/3Fo+th6C0bULX0CVpnmI0kKzWx2Ga+xuO
         RB/CYvgz88j94MC/X8xGa9p8EM2mojVVQNy9/UWqXippVH4AJHY9BfuH0Z2vWNK7dl4R
         izARgEb/l+ZIPdL6AZ7N4U2Nj0N6omgV39mhoEZvub1yc7/2Fy7UZy+Mlq0/48uqLw3t
         J9zQ==
X-Gm-Message-State: APjAAAXH5DL58hU5njLv5/B8qudd8zWs7OGIpmCHRQ24E6uMjiO7BOBy
        GzE2e0WU90oUvcwSjATxPpDaLgjgpIa2mw==
X-Google-Smtp-Source: APXvYqwZckzKN9bbUeMqfE9++GgU7gb++j4p4YrRZeJ5kMcNzOS30a1ja9qqanQ3pbwqZRewbdjF8g==
X-Received: by 2002:a17:906:f848:: with SMTP id ks8mr33581238ejb.165.1558026167939;
        Thu, 16 May 2019 10:02:47 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id j55sm2103169ede.27.2019.05.16.10.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 May 2019 10:02:47 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     James Hughes <james.hughes@raspberrypi.org>
CC:     "linux-wireless" <linux-wireless@vger.kernel.org>
Date:   Thu, 16 May 2019 19:02:45 +0200
Message-ID: <16ac1989b08.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAE_XsMKM5Q2obuKoVCBcpVtxGdhuEOp8a7nq=YP9ivNBOUz9Fg@mail.gmail.com>
References: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
 <CAE_XsMKM5Q2obuKoVCBcpVtxGdhuEOp8a7nq=YP9ivNBOUz9Fg@mail.gmail.com>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: SPDX identifier
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On May 16, 2019 4:17:55 PM James Hughes <james.hughes@raspberrypi.org> wrote:
> On Thu, 16 May 2019 at 12:36, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> Hi Kalle, Thomas,
>>
>> I added SPDX tags in brcm80211 driver sources. Although it is a
>> no-brainer I decided to run checkpatch for the changes and quirky stuff
>> started to happen. For all files I added:
>>
>> // SPDX-License-Identifier
>>
>> but checkpatch started complaining I should use /* ... */ instead of //.
>>
>> WARNING: Improper SPDX comment style for
>> 'drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h', please
>> use '/*' instead
>> #29: FILE: drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h:1:
>> +// SPDX-License-Identifier: ISC
>>
>> So I edited all patches and ran again. And again it started complaining.
>>
>> WARNING: Improper SPDX comment style for
>> 'drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c', please use
>> '//' instead
>>
>> So now I am in a bonkers state. It seems for header files we want /* */
>> and for c files we want //. For real?
>
> https://www.kernel.org/doc/html/v4.17/process/license-rules.html
> explains why the comment style differs between .c and .h

Thanks, James

It explains why header files can not use //. Just wish the same comment 
style was chosen for the c files if only just to be consistent.

Regards,
Arend



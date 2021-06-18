Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C203AC461
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhFRHCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 03:02:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8270 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFRHCY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 03:02:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5qRw3s2Nz1BG5V;
        Fri, 18 Jun 2021 14:55:08 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:00:12 +0800
Received: from [10.69.38.207] (10.69.38.207) by dggema704-chm.china.huawei.com
 (10.3.20.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 18
 Jun 2021 15:00:11 +0800
Subject: Re: [05/11] ipw2x00: Fix wrong function name in comments
To:     Kalle Valo <kvalo@codeaurora.org>
References: <20210517050141.61488-6-shenyang39@huawei.com>
 <20210615131210.1599EC4338A@smtp.codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
From:   Yang Shen <shenyang39@huawei.com>
Message-ID: <6f3782fe-1e84-d700-c902-26921a93f41b@huawei.com>
Date:   Fri, 18 Jun 2021 15:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210615131210.1599EC4338A@smtp.codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.207]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Got it, I'll rebase on the latest branch.

On 2021/6/15 21:12, Kalle Valo wrote:
> Yang Shen <shenyang39@huawei.com> wrote:
>
>> Fixes the following W=1 kernel build warning(s):
>>
>>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:5359: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:6533: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  drivers/net/wireless/intel/ipw2x00/ipw2100.c:6565: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>
>> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
>> Signed-off-by: Yang Shen <shenyang39@huawei.com>
>
> Failed to apply, please rebase:
>
> Recorded preimage for 'drivers/net/wireless/intel/ipw2x00/ipw2100.c'
> error: Failed to merge in the changes.
> hint: Use 'git am --show-current-patch' to see the failed patch
> Applying: ipw2x00: Fix wrong function name in comments
> Using index info to reconstruct a base tree...
> M	drivers/net/wireless/intel/ipw2x00/ipw2100.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/intel/ipw2x00/ipw2100.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/intel/ipw2x00/ipw2100.c
> Patch failed at 0001 ipw2x00: Fix wrong function name in comments
>
> Patch set to Changes Requested.
>

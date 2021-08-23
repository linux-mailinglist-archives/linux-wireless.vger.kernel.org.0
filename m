Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A43F4405
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 05:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhHWD5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 23:57:21 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15202 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhHWD5V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 23:57:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GtJLt6YFzz1CZdD;
        Mon, 23 Aug 2021 11:56:06 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 11:56:35 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 23 Aug 2021 11:56:34 +0800
Subject: Re: [PATCH 1/2] bcma: Fix memory leak for internally-handled cores
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zajec5@gmail.com>, <hauke@hauke-m.de>, <linville@tuxdriver.com>,
        <wanghaibin.wang@huawei.com>
References: <20210727025232.663-1-yuzenghui@huawei.com>
 <20210727025232.663-2-yuzenghui@huawei.com>
 <8943a493-aee8-3fe5-e63a-f3b61eaead14@huawei.com>
 <877dgfun7t.fsf@codeaurora.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <2b218922-45b2-38cc-2a80-4d339949deed@huawei.com>
Date:   Mon, 23 Aug 2021 11:56:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <877dgfun7t.fsf@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021/8/21 18:05, Kalle Valo wrote:
> Zenghui Yu <yuzenghui@huawei.com> writes:
> 
>> On 2021/7/27 10:52, Zenghui Yu wrote:
>>> kmemleak reported that dev_name() of internally-handled cores were leaked
>>> on driver unbinding. Let's use device_initialize() to take refcounts for
>>> them and put_device() to properly free the related stuff.
>>
>> Could this be picked as a fix for v5.14 (_if_ it does fix something)?
> 
> Why should this go to v5.14? Most probably it's too late for v5.14
> anyway.

No worries. It's not urgent and just that I didn't realize we're
already at rc7 now.

The patch has been on the list for about 4 weeks and I'd appreciate
any review comments from maintainers.

Zenghui

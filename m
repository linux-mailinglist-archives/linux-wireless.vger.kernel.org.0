Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226F03F384F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 05:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhHUD25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 23:28:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18023 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUD2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 23:28:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gs3lH4DdVzbgCh;
        Sat, 21 Aug 2021 11:24:27 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 11:28:12 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 21 Aug 2021 11:28:09 +0800
Subject: Re: [PATCH 1/2] bcma: Fix memory leak for internally-handled cores
To:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zajec5@gmail.com>, <kvalo@codeaurora.org>, <hauke@hauke-m.de>,
        <linville@tuxdriver.com>, <wanghaibin.wang@huawei.com>
References: <20210727025232.663-1-yuzenghui@huawei.com>
 <20210727025232.663-2-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8943a493-aee8-3fe5-e63a-f3b61eaead14@huawei.com>
Date:   Sat, 21 Aug 2021 11:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210727025232.663-2-yuzenghui@huawei.com>
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

On 2021/7/27 10:52, Zenghui Yu wrote:
> kmemleak reported that dev_name() of internally-handled cores were leaked
> on driver unbinding. Let's use device_initialize() to take refcounts for
> them and put_device() to properly free the related stuff.

Could this be picked as a fix for v5.14 (_if_ it does fix something)?

Thanks,
Zenghui

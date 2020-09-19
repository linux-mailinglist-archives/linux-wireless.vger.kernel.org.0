Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876B92709B0
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Sep 2020 03:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISBcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 21:32:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13267 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISBcW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 21:32:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4206FC7D97D4CB39568B;
        Sat, 19 Sep 2020 09:32:21 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 09:32:20 +0800
Subject: Re: [PATCH -next] mt76: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Felix Fietkau <nbd@nbd.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200716085801.11220-1-miaoqinglang@huawei.com>
 <b522f546-148f-2348-a627-2b19e1013d11@nbd.name>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <68e17ef2-6749-5ac4-3b84-b338e91e40fa@huawei.com>
Date:   Sat, 19 Sep 2020 09:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b522f546-148f-2348-a627-2b19e1013d11@nbd.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



在 2020/9/9 5:22, Felix Fietkau 写道:
> On 2020-07-16 10:58, Qinglang Miao wrote:
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> This does not seem to apply to the current tree, please rebase.
> 
> Thanks,
> 
> - Felix
> .
> 
Hi Felix,

I resent a new patch against linux-next(20200917), and it can
be applied to mainline cleanly now.

Thanks.

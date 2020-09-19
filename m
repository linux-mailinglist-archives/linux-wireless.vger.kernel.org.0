Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C875C270A28
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Sep 2020 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgISCtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 22:49:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCtv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 22:49:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C40DFE7537945C569EAD;
        Sat, 19 Sep 2020 10:49:49 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:49:47 +0800
Subject: Re: [PATCH -next] mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Jakub Kicinski <kubakici@wp.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200716085749.11105-1-miaoqinglang@huawei.com>
 <20200716082036.76f47d2f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <d0817369-c884-981a-6dd7-2fef0f361e9e@huawei.com>
Date:   Sat, 19 Sep 2020 10:49:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200716082036.76f47d2f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



ÔÚ 2020/7/16 23:20, Jakub Kicinski Ð´µÀ:
> On Thu, 16 Jul 2020 16:57:49 +0800 Qinglang Miao wrote:
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> 
> Acked-by: Jakub Kicinski <kubakici@wp.pl>
> 
Hi Jakub,

I noticed that this patch has been acked by you and not patched into 
linux-next. There's little difference now so resent a new patch against 
linux-next(20200917), and it can be applied to mainline cleanly now.

Thanks.

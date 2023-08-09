Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE62775051
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 03:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHIB0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHIB03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 21:26:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CCC19A8
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 18:26:28 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLC4T1GDPz1hwLH;
        Wed,  9 Aug 2023 09:23:37 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 09:26:26 +0800
Message-ID: <0d3642cb-e455-dfdf-d0a3-235f3182a22e@huawei.com>
Date:   Wed, 9 Aug 2023 09:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next RESEND] wifi: mwifiex: use is_zero_ether_addr()
 instead of ether_addr_equal()
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
CC:     <kvalo@kernel.org>, <christophe.jaillet@wanadoo.fr>,
        <simon.horman@corigine.com>, <linux-wireless@vger.kernel.org>
References: <20230808081023.2303423-1-ruanjinjie@huawei.com>
 <ZNKiBE3GIi/wQXLB@google.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZNKiBE3GIi/wQXLB@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2023/8/9 4:13, Brian Norris wrote:
> On Tue, Aug 08, 2023 at 04:10:23PM +0800, Ruan Jinjie wrote:
>> Use is_zero_ether_addr() instead of ether_addr_equal()
>> to check if the ethernet address is all zeros.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> Usually you should provide some explanation for a RESEND of a
> seemingly-identical patch. Seemingly you just updated the address list?

Sorry, the git email tocmd has a problem, the original address lists
which parsed from get_maintainer.pl cmd is incomplete, so I resend it.

> 
> Anyway, looks fine:
> 
> Acked-by: Brian Norris <briannorris@chromium.org>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9149075C5B2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGULNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjGULNf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 07:13:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87326A2;
        Fri, 21 Jul 2023 04:13:07 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6n1l6J6rz18Lq6;
        Fri, 21 Jul 2023 19:11:39 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 19:12:26 +0800
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
 <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
 <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
 <20230720092247.279d65f3@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
Date:   Fri, 21 Jul 2023 19:12:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230720092247.279d65f3@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023/7/21 0:22, Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 19:07:31 +0800 Yunsheng Lin wrote:
>>> BTW, what do you think: is it better to have those two includes in the
>>> root include/net/ folder or do something like
>>>
>>> include/net/page_pool/
>>>   * types.h
>>>   * <some meaningful name>.h (let's say driver.h)
>>>
>>> like it's done e.g. for GPIO (see include/linux/gpio/)?  
>>
>> It make more sense to add a new dir for page pool if there are
>> more new headers added. As we are still keeping the page_pool.h
>> mirroring include/linux/gpio.h, adding a new dir for only one
>> header file only add another level of dir without abvious benefit.
>> We can add a new dir for it if we turn out to be needing more header
>> file for page pool in the future, does it make sense?
> 
> It doesn't matter all that much so I think to have some uniformity 
> in networking please go with Olek's suggestion which is also my
> preference.

Just to be clear, include/net/page_pool.h is still there, we are not
putting page_pool.h in include/net/page_pool/ and renaming it to
something else, right? As there is no that kind of uniformity in
include/net/* as far as I can see.

More specificly, yon means the below, right?
include/net/page_pool.h
include/net/page_pool/types.h

> .
> 

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69024791CAC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjIDSRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjIDSRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 14:17:05 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61E19B
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 11:16:58 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTP
        id dCvnqr10VQFHRdE8AqNXgE; Mon, 04 Sep 2023 18:16:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id dE89qt63si7GOdE89qPLYg; Mon, 04 Sep 2023 18:16:57 +0000
X-Authority-Analysis: v=2.4 cv=fonP2X0f c=1 sm=1 tr=0 ts=64f61f19
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10
 a=bRdHEh57seZ_zvvW85sA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fp0gGJutDvvqPrc/IeMPV4i3FiQlzr/L5X+L2PJVi7w=; b=H6Q6IGMbDMnt49NLKY5YKcW6++
        1ab9OGOS1JbVE/fi8YpVaRUuw3eCsKZBQuEdRZjrTlakRvNL9dmkQUuZkFhHgsSdciwPkqy85xKUI
        prO5X2m9wutCplPjC3gW9D4hnn5ZK+n0+I9G4byNnuCkNBipgSc+SA7iOGKNM1qmY6ZOszQDXolcQ
        2HL0Pk0lfDTeu7MNYHsJywJSvHk49XA42toIAaCePkQryejmj4/nLlUKwhLSVHaUGoVX7abThZ0Vs
        9gsruAGt87y+SX/IkMvDM2ItzBQfrJtbwAxLHj75l9aWMhKzYR6gvTW0KUtCb0NuGBtFXIgWHcRpZ
        t2t1jt2A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50842 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qdE88-001uk4-1P;
        Mon, 04 Sep 2023 13:16:56 -0500
Message-ID: <16805a62-8c8d-2a83-2ea0-da0f1a33a625@embeddedor.com>
Date:   Mon, 4 Sep 2023 12:17:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] wifi: mwifiex: Fix tlv_buf_left calculation
To:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org>
 <169384778670.3420994.16227760665746324390.kvalo@kernel.org>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <169384778670.3420994.16227760665746324390.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qdE88-001uk4-1P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:50842
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDLRlYAelGq8y/Qpz2zZ+LkGNaHoOyuKUz4PIYIDxcZva2L63pdd60xl3O+t5PJErL/4QV9ltj22loGkP4tDiLuiukqCkUPnyRUkAEiDYc4gW+BR53s3
 igRVvx43yhCXitng0tCTZZT2ZjiNqWd/S0dA/WHma/ysxHV2G7haNWNTmzQMe6RkQ2dvZrcLmiRNxh8/dS0mGz2rVRhx/lbBv7inmHqzqmiMsZVaArtgJB3Y
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> 3 patches applied to wireless.git, thanks.

Awesome. :)

> 
> eec679e4ac5f wifi: mwifiex: Fix tlv_buf_left calculation
> c7847241de28 wifi: mwifiex: Replace one-element array with flexible-array member in struct mwifiex_ie_types_rxba_sync
> d5a93b7d2877 wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
> 

Thanks!
--
Gustavo

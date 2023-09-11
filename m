Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA279BB52
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjIKVs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbjIKQXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 12:23:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595ECCA
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 09:23:29 -0700 (PDT)
Received: from [192.168.151.20] ([217.224.116.76]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWRZt-1q7v733c43-00XqTb; Mon, 11 Sep 2023 18:23:22 +0200
Message-ID: <e1dd75d4-a7f5-6aa1-556e-1d288e46c55b@online.de>
Date:   Mon, 11 Sep 2023 18:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Max Schulze <max.schulze@online.de>
Subject: Re: [RFC PATCH v4 6.1] wifi: cfg80211: fix cqm_config access race
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <20230816153803.b53dd297eacc.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Language: en-US
In-Reply-To: <20230816153803.b53dd297eacc.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lEpyrNpzpO0YErxdKTxgaB7e0m8m+Bjqq21ndAd6xSzWcbK3jEH
 MLJz50aHyI4L50AFyR38xUTHQnUXOeZOHTu4CpUQRE7kn+5gDUu6DUWRHZZESZSY7d/pqdG
 e0MCGfnwpGOCfQaGxtAQJ8v9AP9ldfEo6em68LgMwMqZFDkaF2HT7zT27bMnPQ8ZGgxoNfr
 BVfuAFphtzQJOxXKYieRg==
UI-OutboundReport: notjunk:1;M01:P0:OGPp+lkkUB4=;WzflhvCPTUp2i5r9AgC840858X3
 qHZrZ+bYDrPC2dYwHa/iQcuxN8GZraQBDEpmtscyvZ9aswiWOYDEpXJM7bUp3NK55mS50QBya
 skgh04Ee6H0nH2FnlDz3yUWYhSsSkwj145KyZUC6by8qdmoLSuzUFq+BnUIedY65CodOoXme5
 e0Vb7twMdibA+F/pF5PKVGBhcMAv6R/vm0xkSKAckhSfeFNAeqq2MW82p5SWEPyd/rnC+klyr
 OX8op4cXb6PBHKBpbytX2aZtGdkowZv2p5IF09gXbeVXETMrvlIF/364hkY4pGgZD5kpv3qQb
 NncZckqqccAt3y2+UiDiu33Yd/PxmiJs3+BGxwGcsBtKD7+EBNphmXue8dE9i5Ruiohith8ue
 m111e8qJYEa0KW/IujuyRaj65TJvWTsknsMXjuzWZSnLWNrWUzRLk6AJB3+crPkH8pTlzF3VA
 ch6l819HH4+8ZKpBk9vOtVJCRproyvdPEh0a6QKQ6n7A+ntOj1TcjTienkQwZRT1Xqv69pV9b
 Q7rnAM3sFErH7C7qK4MCjN9iHLzGbsM89FwR+vKnMtNwQZ9Nr5casCY/nt2U8VO9aGJ0IMtXr
 QQcaQ1jxsNyYHKQQ2UKbwqGpuFnM6qGEgc840qkL5Nzi3ZkrMhcEea79nDDA5gGXdAFDi1d9c
 JmT7XewYHQZdR3kwHfFvDb0mGQ0Dmjk6AhnMoCyAbetKWjtJEE82QAccJ+GecypELG63NjcF9
 uVmxwVZPWjzCWZrXIu5yaojVydSXOkGby5lY7ACCA2chTM+uitJzbHYWsMr2mhOR8eAe3bGwz
 YnDZl7b+wPjA4nENfjQMX5anVoQVuoyIxD4ZX2s+gOaqeb53M9Z5wVigkZ4OTEgBMmCrZXJkW
 nPLJvIjLOAGRK2VnumsprRW+Zamvy5+hg79w=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This has been running for two weeks on multiple systems.
It fixes the bug and does not show any other effects.

So, offering a

Tested-by: Max Schulze <max.schulze@online.de>


Thanks!


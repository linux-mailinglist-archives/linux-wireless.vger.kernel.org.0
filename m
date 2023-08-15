Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE96D77CD56
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjHON3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbjHON3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 09:29:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D046127
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 06:29:20 -0700 (PDT)
Received: from [192.168.179.5] ([37.24.11.236]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7QM9-1pi8Vo08ab-017ot2; Tue, 15 Aug 2023 15:24:09 +0200
Message-ID: <c8b69649-ab22-a984-1767-527b73c88c7e@online.de>
Date:   Tue, 15 Aug 2023 15:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2] wifi: cfg80211: fix cqm_config access race
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
From:   Max Schulze <max.schulze@online.de>
In-Reply-To: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jvczfRL0GG4tfFUmWu5lmZH4QQobQXdbv914UFtVHoJ/3dgdSz+
 Qp5cBXk2Rwe+QliTDRZ0H8rjtmcLorR+J38B/rl1OZqebpXUyGhhOxmBdrBx0xVesUAPgNb
 yUCrNDo6vHfloP+E6ddg3S9azOdn4mooUFzUaBPFa8xZPF4kRwAkxkMxIVj4vSCjLNdTSfk
 2HWhknowA9bX1eB6H3n4g==
UI-OutboundReport: notjunk:1;M01:P0:oCmCBN3bdCU=;n1z91fk451mqU+vrLuHYqGD+IHK
 Ebfx0tjwVqZyoLZB9GGhTD0mHVXqTYCttwuRmAxg2+DFtTnQe60r9WILAg1/Zy7cdwSxNyW5J
 /ej808f5CKqP0oIHco0ZBWXb1rrUa+IEly4kNXEU3fae32Days90+BXJOzXkxvCbSObfpoBDe
 622xQLcJtPkPY327zGPn5o3gff5Z4r5ALPsfCYelQ0XZsiLI0aseVqdQh5W2bRU0zhgs6L2Su
 U9/mJ6JkkO7SswVz1RATkgUgpq3T/q71hzN5bqsAEDLb3GtZzNogmyUPatm7ZfzT2dhROfGDw
 1pgRBJI3dAAC9T4B65iERkV11KU/k6Hdxn9lBTiOcrQEYnevCoeb6Qec+Uzo5/QxHyXUuGkIZ
 aLDIdFsh+V9/wOQHqZxV7ZXK0NrLV84cVThHDBYFRkVAsOU2r2rvgRXHCPf3mqcG3gyvobla2
 CRlvcbnJ2nYbq+1qOEtOUuefKaJ5phodJgGNFkYf6p4BuOQ+ezibS94xKhOLkt/OE06//3gN1
 9Ijkd+UdCzW9Ina8x+ce+bVEflV/k00QtV8QX6JEB67JiHa7y80HbWjYpbCLCYLNcqXrGsLoJ
 cfv+MgGKARP2g0VTOXCmEm0wKq6L5feMSwWajQxMMLFq3M7X5hVVYt42u6y7A79oj4jeIOcnU
 Ak+6vlKZBbouQF9Hip4J9v9kCM2bDn2ELkd8czEGRmhlbxm/b+MT4xxazZHmNQWze9HA+RzzB
 ds8+rsDh40pCQnOIWu+BoJrNHmFvXg/a0hp05h9n76kBH/vqov2UZjfUdjTH+J443Dd+/iVvp
 ndz+4O0oQnKs58xFGqnQPiDiHSE67BgumdtYGzTB7SLnyOY8q9fIMfc+FG9p7iGmYk1P7AVZ7
 bRPH54AF0NqMyfw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks again. I have to back-port it to 6.1.45 manually and will do testing.

The buildscript reports 2 things,


a)


Am 15.08.23 um 13:42 schrieb Johannes Berg:

> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..c0250c81973e 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -6014,7 +6014,8 @@ struct wireless_dev {
>  	} wext;
>  #endif
>  
> -	struct cfg80211_cqm_config *cqm_config;
> +	struct wiphy_work cqm_rssi_work;
> +	struct cfg80211_cqm_config __rcu *cqm_config;

would *cqm_rssi_work be ok?


and b)


/root/linux-rpi/net/wireless/core.c: In function ‘_cfg80211_unregister_wdev’:
/root/linux-rpi/net/wireless/core.c:1167:9: error: implicit declaration of function ‘wiphy_work_cancel’ [-Werror=implicit-function-declaration]
 1167 |         wiphy_work_cancel(wdev->wiphy, &wdev->cqm_rssi_work);
      |         ^~~~~~~~~~~~~~~~~
/root/linux-rpi/net/wireless/core.c: In function ‘cfg80211_init_wdev’:
/root/linux-rpi/net/wireless/core.c:1319:2: error: implicit declaration of function ‘wiphy_work_init’; did you mean ‘wiphy_sysfs_init’? [-Werror=implicit-function-declaration]
 1319 |  wiphy_work_init(&wdev->cqm_rssi_work, cfg80211_cqm_rssi_notify_work);
      |  ^~~~~~~~~~~~~~~
      |  wiphy_sysfs_init


Is that something to worry about? (Building with warnings as error, I just disabled that for now)

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081B779BD54
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352593AbjIKVtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbjIKNVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 09:21:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C8193
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 06:21:33 -0700 (PDT)
Received: from [192.168.151.20] ([217.224.116.76]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M1ZQT-1qcfZV0NZr-0036bN; Mon, 11 Sep 2023 15:16:22 +0200
Message-ID: <1a57ba21-1c15-8341-24a3-938d94a08ea8@online.de>
Date:   Mon, 11 Sep 2023 15:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v4 6.1] wifi: cfg80211: fix cqm_config access race
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <20230816153803.b53dd297eacc.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
From:   Max Schulze <max.schulze@online.de>
In-Reply-To: <20230816153803.b53dd297eacc.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9UXZL7ysTYY2SbWoLNvsc9lGFY5+KOYf/lbyklKeEeAngnWii/K
 Rqx2JBbmDWYCnr/wTDIHyglWolXDJQ5P68pe6VDj5FsCSJbwpbdgDQ7HJRtdMkTnAkkCZRb
 zZ3SQ7z+bwjzZwVMZiTVFPl6RrwUd5v5SfhKWfv/Oh5eJbN2Gg9K2fxuFROsuyMYl5tGPVr
 mJGyPynlb+k2SsOPsuOeg==
UI-OutboundReport: notjunk:1;M01:P0:aZgDVeFWKtY=;97rS+pKGOCqRf7UfOH8bOlxj1D4
 l4xUPSiV8voD2o9NdGlv6pOO7uP3FYlVrIcJN0vlZkhtn4/akLyLEPaK9O+wu9nz4OWWWhkOA
 PSi0cj93udyzpVIsBjWlztKEWoFIHWUN1AR2fpwFabQOHXi7GrYscqFVAPKqmfSu64+ARiP+6
 T+7LRyJZVEC4me/80NehdzYq6a+HCOaUis/C/lWREKLuQZdqzZD/TcfIMcSdsYPNtPzSNiSUe
 hVasvgjDMvlWx9pYrKFtib399NsD8z33p0unAuKMufITcA07LzAh13GrW7ILNOOQu74BEuF58
 09EJxSLylpl12SinDwm7eKIsvhs2NWiOIg/avftOiDuGFUcBj6xnFPjkEyc1wf/D/Koe7mYnk
 9zyJuG5xGqug5JttEJq/V1RITVfyIKY+ReNrW5FebXL8s7l+k9NqaVCeC5Rp19wzxfiFM0nBE
 Z4TUN03OmnG3WzoZQzXLdS4wCrt+8cBSlt96NUyaZ32FLMOhebaY6YTIi7EDn9dvV07lH7mZG
 Tl6lLrMiEK9mPZPTFo2AhRdbXoVkoNfnxgcvfeI5UJf2Kv77PTwzJq0KrpCRML19lmaXoVwe/
 zuKJCykdiFPlAOA7ieFeMIY2YbzCgEmRMZgmTy9Itw6ghTP4HUMPuYmx+azsVGoN5BYsXIpR7
 9LbZvEyIQ4v4j/VMVya/G8MBOUOuJW4+2RQhyS06KonAP/7efLDvma0ZFM0ifaLpuZVQibt44
 5l2ELWrcbECPqtfuhxpdh/fGLyUPy1sqJYVtIqd/LFgnURLmVYVRDpJz+7Pd8zyOMaKXul5jM
 7KSKVlQzqZNJyil14u9XkHc+YBkU3c/x9+LJ1GqSyRL/hbQdUjpfOWbW7Tr1MPWjshgMgbYkJ
 LvaE7U/rg1zSQ4w==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8F63295E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiKUQ1h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 11:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKUQ1e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 11:27:34 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DD2700
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:27:32 -0800 (PST)
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MxYT3-1p7pu93MN7-00xwMo; Mon, 21 Nov 2022 17:27:16 +0100
Message-ID: <daf6b5bc-fde6-d0a8-84eb-61e16a3fe69c@green-communications.fr>
Date:   Mon, 21 Nov 2022 17:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
References: <20221116163902.24996-1-kvalo@kernel.org>
 <20221116163902.24996-42-kvalo@kernel.org>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH v2 41/50] wifi: ath12k: add reg.c
In-Reply-To: <20221116163902.24996-42-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nQn9gpfcW5AQeiFw39JfTVAYYfZPpyII66MLrA78IZfMQ4aKIxr
 9Z37Sks4Wzcm99lyCilXiAe+X0n+MZo8obfNlJSTCrc/tTkVJYfUMLvi/G3WWA1KuTiWw/P
 ShzgEHQfYE4meLrIqFsWvJzMYV2SO08ptsW63bfC+Giwx5FnkemmOhKcd6C0JIAh4W+eneh
 9DT10SVMCp0ok72pEWbsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pu0v6hIDJ14=:05Ojmu/x0ASu1M8qRtMmoc
 QcBsQ5yqfkOlq6HsLk3Xa1TbuqG7DYDDBdko0InQrqfDodMamz0j9WVu13W0QubnRiX97WOmu
 lWfK3RNfIc9iFaCl9WkEtqq1E9PqhEXyNXPVlZhdAoUw8EHl44ta8wSTVAuU2br4xoh65to/W
 J2Wy/6ZEk8143Wcvk/5SRAmAAuH+5tZH1vF0oUSn3ZeJKKtX5gMKeY1KPruycKA4odmYY2oo3
 eLg3u1yK2Ls3LoTJczTyxsosGzhNYO81BCG4llhT5Lhs3tWDQbfZZ++u444uyIPD87X03yqdx
 GNFDuigT04lfrvySdGc/cIrqOOjGnWKXbnUXE3UruRO8Dv6ihs4G6Vl0cL6NhLl1giqr+xdQy
 eLqjCctRbAJjy4dsnRKClKgXCNEe2X+C/SOsxEGltoWQGlqgoF+K1xiJDBmpgV65tlSkFjSN/
 e/KGbZ2aw4wyBI1RfL6qTUqiQgAeEJN2kmtMgZ05TBAms6gwJjphpun1tnGhITHz+J85m4hWj
 JqdyA0oRW/vs0p/PF6nIi2GYIknOTfMLmoRvScKnAnWhrmzaOHJ7H76xkojzFhtAg2UCuDGIx
 qKU6iGeT0ER3L1YYPuUozs9kRrQ3gP2Q3wZu1ZyNrPE1XZDNxVjslbUOkNheDL+czrxY+I8Sj
 ikIaJM11dcmDTAbC/UXE4hgR5scZTL02Wu6Oaa+pPfEq5YxZWq1tVaojQx8BP5fPbvoopsLzC
 0INjy2C03x7wXIHcQps08Whid3GhQUkJU3rVVEDrQJNIiGa+LSvMaqXwMTjd38uRWh5iR4lH0
 qE+f6DLe/w1BH2bzt1C2pYehlEMYfxtSglKTXQDs+0Hkb3K4As=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/11/2022 17:38, Kalle Valo wrote:
> +#define ETSI_WEATHER_RADAR_BAND_LOW		5590
> +#define ETSI_WEATHER_RADAR_BAND_HIGH		5650
> +#define ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT	600000

OT, but maybe cfg80211 should be taught these rules ? it is apparently unaware 
of the harsh ETSI rules in 5600-5650 MHz and this affects all drivers.

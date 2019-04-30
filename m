Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64CF0CC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 08:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfD3G6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 02:58:46 -0400
Received: from nbd.name ([46.4.11.11]:60606 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3G6q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 02:58:46 -0400
Received: from p548c87b5.dip0.t-ipconnect.de ([84.140.135.181] helo=[192.168.45.69])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hLMis-0007u4-ME; Tue, 30 Apr 2019 08:58:38 +0200
Subject: Re: [PATCH V2 2/3] mac80211: dynamically turn TWT requester support
 on and off
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        Srini Kode <skode@qti.qualcomm.com>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>
References: <20190426094150.18078-1-john@phrozen.org>
 <20190426094150.18078-3-john@phrozen.org>
 <a580242a242ec6126928bba5227f1e2d@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <0af51f01-eeb0-f9f4-0fa4-56b64ceceb7a@phrozen.org>
Date:   Tue, 30 Apr 2019 08:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a580242a242ec6126928bba5227f1e2d@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 30/04/2019 08:45, Rajkumar Manoharan wrote:
> On 2019-04-26 02:41, John Crispin wrote:
>> Turn TWT on/off for STA interfaces when they associate and/or receive a
>> beacon where the twt_responder bit has changed.
>>
>
> Does it mean that TWT responder can be turn on/off when AP is UP and 
> running?
> I thought any change in beacon needs AP restart. no?
>
> -Rajkumar
>
> _______________________________________________
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k

Hi Rajkumar,

I am about to send a V2 that already addresses allthose comments, Thanks 
for the review

     John


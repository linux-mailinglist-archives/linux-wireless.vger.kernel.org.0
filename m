Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1AA24AE54
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 07:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgHTFQI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTFQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 01:16:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE80C061757
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 22:16:06 -0700 (PDT)
Received: from [2a04:4540:1403:2e00:31a9:2b49:2694:f8ad]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k8cvi-0005db-Ek; Thu, 20 Aug 2020 07:16:02 +0200
Subject: Re: [PATCH V6 1/2] ath11k: switch to using ieee80211_tx_status_ext()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20200803145444.473810-1-john@phrozen.org>
 <87d03milp7.fsf@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <fb192822-935e-9886-38b0-288ca34b43c2@phrozen.org>
Date:   Thu, 20 Aug 2020 07:16:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87d03milp7.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 19.08.20 19:34, Kalle Valo wrote:
> John Crispin <john@phrozen.org> writes:
>
>> This allows us to pass HE rates down into the stack.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
> On what hardware and firmware was this tested?
>
Miles can give more insight, the patch was written by him, I just 
rebased it, removed the checkpatch warnings and did some basic testing.

     John


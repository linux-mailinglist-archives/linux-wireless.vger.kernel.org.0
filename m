Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305370DFA9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjEWOu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 10:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjEWOu0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 10:50:26 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83EDFA
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 07:50:25 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DE1F1100081;
        Tue, 23 May 2023 14:50:23 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.34.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2EEAD13C2B0;
        Tue, 23 May 2023 07:50:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2EEAD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684853423;
        bh=+SorzLhpXWInbWLa8bxDTJvLV8FwBoLKmmxV9TKds3Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NDu9QbcuZDVCsulAEawdyRuF8hVtAYR751pWCvk+5/bc10dT1hCZn21DZsWFCpWy4
         Pb0yeFhxPq/b4nKR/p0qGdHdN10UV+hPRU/AWraSqOu+POTHr5QjBj51xgV5L1SjXQ
         4Ga6xx0LwEhh83xt3mEtowtyjKZik+QaGij//trg=
Subject: Re: [PATCH v3] wifi: iwlwifi: add ethtool tx and rx stats.
To:     Simon Horman <simon.horman@corigine.com>
Cc:     linux-wireless@vger.kernel.org
References: <20230522233743.3058844-1-greearb@candelatech.com>
 <ZGyWQpFs9DDAlsx6@corigine.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <adf58b64-f1dc-82a0-ae37-4dbe8b53f3bc@candelatech.com>
Date:   Tue, 23 May 2023 07:50:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZGyWQpFs9DDAlsx6@corigine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1684853424-62Ko2f9vYKje
X-MDID-O: us5;ut7;1684853424;62Ko2f9vYKje;<greearb@candelatech.com>;49bee47f74cdb6ff280383f8e23073c8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/23/23 3:32 AM, Simon Horman wrote:
> On Mon, May 22, 2023 at 04:37:43PM -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Report tx/rx error codes, nss, mcs, bandwidth, mode, he types,
>> tx ampdu length histogram.
>>
>> To provide some clues about how transmit and receive path is
>> actually working.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>
>> v3:  Combine tx and rx ethtool patches into single patch.
>> Fix some stats calculations, especially the path that consumes
>> tx frames based on block-ack receipt.
>>
>> Comparing the stats with expected values now matches better, but
>> hard to verify everything exactly.
> 
> Hi Ben,
> 
> I am a little (lot) confused about what tree/branch this patch applies to.
> 

It is against upstream iwlwifi-backports driver.  I need to use that to use latest Intel
radio, and in general flow of patches seems to be iwlwif-backports -> kernel, so
I was hoping the patch had a chance that way.  I'm sure it could also be patched into
the kernel with a bit of work, and I'll be happy to do that work if that will make
patch acceptable.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A34622105
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKIAzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKIAzw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:55:52 -0500
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 16:55:51 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B722B13
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:55:51 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 735FF24DEFD
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 00:48:56 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id ED20A1A006C;
        Wed,  9 Nov 2022 00:48:54 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A8946680075;
        Wed,  9 Nov 2022 00:48:54 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.36.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CEEEB13C2B0;
        Tue,  8 Nov 2022 16:48:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CEEEB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1667954934;
        bh=/YKtmyf67uBBT1wyKRPMYuMDdGVVu9Y+aTzkSqXpLMg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CTwR8YAr+ywChomBa5wH4zb24dwT/h6ZRMFuaxFK4jSvE85fNbosActoo5yVMvQSU
         EXD3iPFLNEpjhm6px/X/2eiFKxETQxtCbH4zb2mKh246UivG9VX2NZL5VBVaWpskPA
         M48kgKpbyRQs6fCZQXFQ55ciZSQF9qtTdcOyRwgw=
Subject: Re: [PATCH] wifi: iwlwifi: fix double free on tx path.
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "amol.jawale@candelatech.com" <amol.jawale@candelatech.com>
References: <20220928193057.16132-1-greearb@candelatech.com>
 <5fc4f28a5fc079d0368f6047db0d2c5fa1ed3ad4.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <62c83e6f-3d41-ab0b-fbbe-db1c2e618d5c@candelatech.com>
Date:   Tue, 8 Nov 2022 16:48:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5fc4f28a5fc079d0368f6047db0d2c5fa1ed3ad4.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1667954935-doedpoVqVk2E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/22 7:17 AM, Greenman, Gregory wrote:
> On Wed, 2022-09-28 at 12:30 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> We see kernel crashes and lockups and KASAN errors related to ax210
>> firmware crashes.  One of the KASAN dumps pointed at the tx path,
>> and it appears there is indeed a way to double-free an skb.

While rebasing on top of 6.1-rc4, I notice this patch is not in the
tree yet.  I think it is worth adding it to 6.1 since it is a pretty
nasty kernel crash...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

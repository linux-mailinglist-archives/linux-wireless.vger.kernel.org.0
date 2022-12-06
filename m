Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F795644AB4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLFR7g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 12:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFR7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 12:59:34 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A82873F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 09:59:33 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.124])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D45691A0083;
        Tue,  6 Dec 2022 17:59:26 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A6BE3940084;
        Tue,  6 Dec 2022 17:59:26 +0000 (UTC)
Received: from [10.0.0.50] (cpe-98-151-114-119.hawaii.res.rr.com [98.151.114.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EF54B13C2B0;
        Tue,  6 Dec 2022 09:59:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EF54B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1670349566;
        bh=8HOIkMGH1VwRGYr3vsQkOV2Swe7y0a7QrZwb2O72FSo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=nt30aMaLSCkvr84T4yume3CVImzokcLSjp3QMPnxSytasc7iDQ1A6vCU5bIdo3y1L
         JWNvX+R1KmoqWlIgBIyRKLCz4Kf4rzzQuxzbXQ9HYWatwOU0LJmXEKeDDLLxlrhjPl
         4e28NJfGbF3Ev7w+vkdXFUrxHWxDc0xc1URr0OxM=
Message-ID: <413cbc75-14e8-f80d-e536-e1d72c5d1605@candelatech.com>
Date:   Tue, 6 Dec 2022 09:59:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: ax210: Ability to report noise floor?
Content-Language: en-MW
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <a8a2c506-96c8-1850-0585-cda09d4b31f0@candelatech.com>
 <00a4d194f70c4f4c7b7df38b79c0df40ba87f0aa.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <00a4d194f70c4f4c7b7df38b79c0df40ba87f0aa.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1670349567-inZfQFBNVo0Y
X-MDID-O: us5-ut7-1670349567-inZfQFBNVo0Y
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/6/22 06:10, Greenman, Gregory wrote:
> Hi Ben,
> 
> On Mon, 2022-12-05 at 07:49 -0800, Ben Greear wrote:
>> Hello,
>>
>> Is there any way to get Intel ax210 to report the noise floor?
>>
>> Thanks,
>> Ben
>>
> 
> No, unfortunately we don't have this information in the driver.
> 
> Regards,
> Gregory
> 

Someone told me the Windows driver had support for noise floor...so maybe just need some new
API to be implemented to the firmware?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

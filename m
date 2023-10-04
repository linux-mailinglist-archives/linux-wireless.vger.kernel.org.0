Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736507B80A9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbjJDNT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbjJDNT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 09:19:58 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BB4BD
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 06:19:54 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9715DC40078;
        Wed,  4 Oct 2023 13:19:52 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D139D13C2B0;
        Wed,  4 Oct 2023 06:19:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D139D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696425592;
        bh=HC0GAFCZ+v2kYnaSWkha5J20bITVP6ag0FMiQmONu3s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q5udTm5yDD04y/O6Xa2rZsq2CGIJhCMIBqqeiJI0awNo1Mdv57X/HhRaG3YOylO1x
         /KjYfWFbFuQsaoemRIe7pL1SDFmQIPcwDQhAcW4yqBDjgLC1Nq+bS4JpuXz8BZ/Dem
         Ft1qFosjEmzy6MnSYVZ6duiw9jyYFQTeIYtpGBuA=
Subject: Re: wifi-7 + MLO: wlan is not seen in /proc/net/wireless
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <db9ef851-5784-c6a5-d3d5-5747ef21e0b6@candelatech.com>
 <87zg0zgemy.fsf@kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <3e684eea-147b-ca03-1c40-291ece4d1ebb@candelatech.com>
Date:   Wed, 4 Oct 2023 06:19:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87zg0zgemy.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1696425593-AKYixWhFqbkg
X-MDID-O: us5;ut7;1696425593;AKYixWhFqbkg;<greearb@candelatech.com>;bd4b609eaf65fb42f4d2136609b7cb93
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/3/23 10:06 PM, Kalle Valo wrote:
> Ben Greear <greearb@candelatech.com> writes:
> 
>> I'm testing a wifi-7 radio against MLO AP.  I notice the link-0 debugfgs links
>> show up and STA is associated and acquired DHCP, but wlan is not in /proc/net/wireless.
>> I'm in 6.5.5+ kernel.
>>
>> Is this expected?
> 
> wext doesn't support Wi-Fi 7, see:
> 
> https://git.kernel.org/linus/52fd90638a72

For somewhat similar reasons, ethtool stats are broken for MLO
too (see my patches from yesterday).

To keep at least some backwards compatibility, would it be worth
reporting the 'best' link's information?  To me best is highest
band that is connected.  It could also just be the first link that is
connected.

Any suggestions for how to do ethtool stats better for MLO?

Maybe the original values would be for the first, or maybe best link,
and then add new stats fields for second and third links?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

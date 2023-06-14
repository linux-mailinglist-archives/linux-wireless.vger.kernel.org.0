Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3973052A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjFNQkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjFNQjz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 12:39:55 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8300C199
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 09:39:54 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8936C800075;
        Wed, 14 Jun 2023 16:39:52 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9FBA313C2B0;
        Wed, 14 Jun 2023 09:39:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9FBA313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1686760791;
        bh=hJ1pBCFYi87UINei2Oetyqy70bgFxjj2VLM8OcnKqLQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AFmqlIAvii4tsgDBOlPTRaRKEm7GtUgtpF8D2fg0KguSwnnkdMd55+FCUH0PezTle
         EABBgYtH7bWceBuqFpRjB91QqDoEiEYuK+EaQSlkjBm+z4CXf8mVEGC1hipVfQ/kSb
         vg7iANke2yoHoMcyRmOMi6gSCoEI9iXthlaqJpBg=
Message-ID: <e81d4d8d-8076-00cc-cb72-8417dc8203ce@candelatech.com>
Date:   Wed, 14 Jun 2023 09:39:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] wifi: mac80211: add eht_capa debugfs field.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230519162324.1633120-1-greearb@candelatech.com>
 <1038a5fd7d658cc29d11a6eb8776255c50e8226c.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <1038a5fd7d658cc29d11a6eb8776255c50e8226c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1686760793-5vacIcWQM9Nn
X-MDID-O: us5;at1;1686760793;5vacIcWQM9Nn;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/23 01:29, Johannes Berg wrote:
> 
>> +	/* TODO:  Fix and re-add this.  It compiles in 6.4 but not against 'next'
>> +	 * according to the kernel build bot.
>> +	 * PFLAG(PHY, 5, SUPP_EXTRA_EHT_LTF, "SUPP-EXTRA-EHT-LTF");
>> +	 */
>>
> 
> Well that's because the spec version was updated in wireless-next :)
> 
> So please adjust according to the new fields there.

It will be some time before I get a chance to revisit this.  If you can
accept as is, I'll fix the remaining bits when I move to 6.5 or whatever
mainline kernel has the updated spec.

Or I can re-submit the full revised patch at that time.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



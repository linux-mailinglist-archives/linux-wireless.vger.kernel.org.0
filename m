Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD0703EAB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbjEOUeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 16:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOUeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 16:34:14 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B052DC78
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 13:34:06 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 07800940071
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 20:34:03 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 79DC013C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 13:34:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 79DC013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684182843;
        bh=vKc7p5kYU4O7bwk4NlVkEqJNSZbTuua6+7ivmdsCfX0=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=gJUfPhAe9HbkS6PwQoBxwvaWoYUF1hcAUozKteQTRpJ3QUtpbNVgkXLd5ilgR2pWK
         O1/+yKfNRp6T1uNfqyEUSY1m32enCs3mMetk9UU0K3A8Y0Us/IZcsIddCwOlIfg4mf
         J6FGPT43aRMo/Dj3QekGM9rIvi9Bl6nZtdq1o6Ks=
Message-ID: <805e47b8-568d-8f86-d5cd-b521040ab60e@candelatech.com>
Date:   Mon, 15 May 2023 13:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Plan to update 'iw' for wifi-7?
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
References: <3c897080-aea5-82cb-2136-7d36201cc976@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <3c897080-aea5-82cb-2136-7d36201cc976@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1684182844-vWVt55kR1Zo1
X-MDID-O: us5;at1;1684182844;vWVt55kR1Zo1;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/15/23 12:43, Ben Greear wrote:
> Hello,
> 
>  From what I can tell, iw doesn't how any wifi-7 capabilities.  What is the plan to add this?
> 
> Thanks,
> Ben
> 

Nevermind, I had some screwup on my system, I see the EHT stuff now in iw.

Thanks,
Ben

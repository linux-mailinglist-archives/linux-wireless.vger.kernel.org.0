Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8994DA69D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 01:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbiCPAEN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 20:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352727AbiCPAEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 20:04:12 -0400
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A6E42
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZMpLIkgoEDx2SHZn50+hpMB31o8omq0ksuncCWRJRFs=; b=l9RNbCgDqgaZ0+u2nVff3Ffn3Y
        mgUYBf57CgacuSGfECbg/0+qwhoK38gDJiXCJ6tuwGtSWYJSzD7lQklxiHV1JNntJP5rVvTXfFL7f
        DJq76tbmShDNlz+Mcj+ydektSrefXRqwa7dv2VZ2zP9cL2Majp5Lbs+PDIswdq/URHDa4ICuu8hcJ
        fngSKFEOaNKxFpw+7GjItdHtju81G9AvjM6pt84e5SaDJFmdmWOBFmeeGC/e0ge+UR1ewetnR3DsA
        870mW7DdVzmhf/2uQvfAxGpEEl2A0JpFdz3qNgKGDupunDfDFv/rFrtRX3BsO51KjqbLEPOjwPIW6
        VCUgsGjg==;
Received: from [216.168.124.37] (port=34104 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nUH7y-0003l7-7T; Wed, 16 Mar 2022 11:02:57 +1100
Message-ID: <059ad139-9cf8-cc66-e41c-42b12b1103a9@lockie.ca>
Date:   Tue, 15 Mar 2022 20:02:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: WiFi 6 certified location service
Content-Language: en-US
To:     Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc:     linux-wireless@vger.kernel.org
References: <764F6734-F6E0-45F1-A4A7-6372F108573C@redfish-solutions.com>
 <afd90d3a-4c39-b609-18f2-9505600e7ef1@lockie.ca>
 <EEEB9832-9E95-4E4C-9529-29462D7F9EC5@redfish-solutions.com>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <EEEB9832-9E95-4E4C-9529-29462D7F9EC5@redfish-solutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> The Wi-Fi CERTIFIED™ seal of approval designates products with proven 
> interoperability, backward compatibility, and the highest 
> industry-standard security protections in place.
My guess is if the Windows driver is Wifi certified and the Linux driver 
supports everything in the hardware then it'll support anything that a 
location service needs.
I would only rely on in-kernel drivers (or Intel).
So I have no answer for you. :-)

On 2022-03-15 19:51, Philip Prindeville wrote:
> Have a look at:
>
> https://www.wi-fi.org/discover-wi-fi/wi-fi-location
>
>
>> On Mar 15, 2022, at 5:49 PM, James <bjlockie@lockie.ca> wrote:
>>
>>
>> What is that?
>> Searching wasn't clear.
>>
>> On 2022-03-14 12:36, Philip Prindeville wrote:
>>> Hi,
>>>
>>> I was wondering what's involved in getting Linux to support WiFi-6 certified location service?
>>>
>>> Does that require timestamping in the drivers?  Or is the service provided in user-space like hostapd?
>>>
>>> Is anyone working on it?
>>>
>>> Thanks,
>>>
>>> -Philip
>>>


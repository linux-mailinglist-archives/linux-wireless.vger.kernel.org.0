Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BB5E86C2
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIXAYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 20:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIXAYg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 20:24:36 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82A389B
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 17:24:32 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.124])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D66B91A0073;
        Sat, 24 Sep 2022 00:24:30 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AB5DB940068;
        Sat, 24 Sep 2022 00:24:30 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 35E6913C2B0;
        Fri, 23 Sep 2022 17:24:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 35E6913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1663979070;
        bh=x89TF8XAFwx6ls3jyjW9Zls45vPros82QHqiL8XYJWU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZWCJPImNo/BokmLTcqCuSoyhRfqQcMjTB1ehU6MSt/vIPE0wH6upRkccDMKl0hj+P
         U7rFcgrnNiElEswAS9ydSOxIpF3S0pS36UuQK3z3o2mh/xUXjVZSZEGptoFYUVndxn
         UH7696mjqk+3fB2OwU6VctuCcwlZfjM4ACSX7i34=
Subject: Re: what MediaTek chipset do I have?
To:     James <bjlockie@lockie.ca>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <71575c7b-8487-3b12-fe33-3e5e8b2ff9a2@lockie.ca>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <02402e49-653f-509b-a841-b360fd1a62b1@candelatech.com>
Date:   Fri, 23 Sep 2022 17:24:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <71575c7b-8487-3b12-fe33-3e5e8b2ff9a2@lockie.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1663979071-XdKt_nCEua8u
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/23/22 4:18 PM, James wrote:
> I bought a MediaTek PCI card on Amazon that is supposed to be a 7921k chip.
> I don't have a 6GHz router and the seller says if I did then it will work in 6GHz.
> The Windows driver is for an AMD RZ608 Wi-Fi 6E 80MHz but the properties there don't say 6GHz.
> The seller says I can't see 6GHz there unless I have a 6GHz router.
> I don't believe that  but you guys know better.
> I bought it for Linux. :-)
> The only reason I mention Windows is because that is the seller's language.
> 
> Here is Linux info:
> 5.15.0-48-generic #54-Ubuntu SMP x86_64
> 
> # lspci -k
> 04:00.0 Network controller: MEDIATEK Corp. Device 0608
>          Subsystem: MEDIATEK Corp. Device 0608
>          Kernel driver in use: mt7921e
>          Kernel modules: mt7921e
> 
> Would I say 7921k if it was?
> 

That looks like 7921k to me, and it will do 6E, though you might need newer kernel and/or regulatory domain
to get it working properly.  We've tested it successfully on 6E, on Linux of course.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


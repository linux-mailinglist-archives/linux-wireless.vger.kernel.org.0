Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87A4D3B6A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiCIUyt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 15:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiCIUys (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 15:54:48 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE37E0AE5
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 12:53:49 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F07831A007E;
        Wed,  9 Mar 2022 20:53:47 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BF0CC940077;
        Wed,  9 Mar 2022 20:53:47 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5D19E13C2B0;
        Wed,  9 Mar 2022 12:53:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5D19E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1646859227;
        bh=OuWrubQHZVM2jSvWvIlIWjVx6s+TXO/N2Ji9p+/HTes=;
        h=To:Cc:From:Subject:Date:From;
        b=ZbyusAd5cwh+s0bp/u02bl+zejrhFzV7MJczQHvFpv4E9gpFvCyBF2zwftT852CLC
         dhsC/olb6GpXHWm9MGh2P7CxQ/TxHMu6vhEAPBD6gWjmykOQtIggmeVJrVht7LSb6f
         ZodNEvEOh7I9Oa0nE43LBW1FHk/FYbkeKjtqxlts=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     David Ahern <dsahern@gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Subject: vrf and multicast problem
Organization: Candela Technologies
Message-ID: <209a0c1d-20d0-fa99-35b6-654b86c44696@candelatech.com>
Date:   Wed, 9 Mar 2022 12:53:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1646859228-eLffivyScHhr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

We recently found a somewhat weird problem, and before I go digging into
the kernel source, I wanted to see if someone had an answer already...

I am binding (SO_BINDTODEVICE) a socket to an Ethernet port that is in a VRF with a second
interface.  When I try to send mcast traffic out that eth port, nothing is
seen on the wire.

But, if I set up a similar situation with a single network port in
a vrf and send multicast, then it does appear to work as I expected.

I am not actually trying to do any mcast routing here, I simply want to send
out mcast frames from a port that resides inside a vrf.

Any idea what might be the issue?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


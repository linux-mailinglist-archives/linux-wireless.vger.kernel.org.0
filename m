Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA457B718C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjJCTJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbjJCTJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 15:09:26 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D835A6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 12:09:23 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 62D3FAC006E
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 19:09:21 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0E1A913C2B0
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 12:09:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0E1A913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696360161;
        bh=sn9WH8cs5zvBYokL/Qk+qSMRv76PazLo+xOP+Z3jaCA=;
        h=Date:To:From:Subject:From;
        b=Y4kVXXjng4iLYd0XEILJ1VjWZN5B4ufUV5UmOygZ5jW1c2EaSz2zJ7SOJfAlwXlyv
         rKT9nnPkwsqATLNiRyqafDSTSyn94T0tx7l1zd1x76u0if65MH4/1qF1JSAx8YqpRE
         42jI1NjhTm1KBJEVKdP5gP93XKvrRUL84eBUjFfI=
Message-ID: <db9ef851-5784-c6a5-d3d5-5747ef21e0b6@candelatech.com>
Date:   Tue, 3 Oct 2023 12:09:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: wifi-7 + MLO: wlan is not seen in /proc/net/wireless
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1696360162-0JrH7hTueJp3
X-MDID-O: us5;ut7;1696360162;0JrH7hTueJp3;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I'm testing a wifi-7 radio against MLO AP.  I notice the link-0 debugfgs links
show up and STA is associated and acquired DHCP, but wlan is not in /proc/net/wireless.
I'm in 6.5.5+ kernel.

Is this expected?

# cat /proc/net/wireless
Inter-| sta-|   Quality        |   Discarded packets               | Missed | WE
  face | tus | link level noise |  nwid  crypt   frag  retry   misc | beacon | 22

# iw dev wlan0 info
Interface wlan0
	ifindex 65
	wdev 0xc00000006
	addr [removed]
	ssid NETGEAR69-6G
	type managed
	wiphy 12
	txpower 0.00 dBm
	multicast TXQ:
		qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
		0	0	0	0	0	0	0	0		0

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


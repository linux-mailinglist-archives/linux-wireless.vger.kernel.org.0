Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C91677E67
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjAWOwG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 09:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAWOwF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 09:52:05 -0500
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 06:52:04 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DED31027A
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 06:52:04 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0EDE3353A0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 14:43:13 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7CED6500090;
        Mon, 23 Jan 2023 14:43:10 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.43.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7E45013C2B0;
        Mon, 23 Jan 2023 06:43:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7E45013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1674484990;
        bh=p2JZvDv+P9tF4FgfBh85Rs0fin2p3rcXYGA87qvpHKc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kJPyLlaAYgcYcBSmHMrF4edP2djLIiwzRq8j6MbbvKKS7l/JUH84g5EVZNe6Nn/fe
         pCEyqsfi1bkYBful5ChODoiBwAWyMbOQYgASMVjxnZ7bj0kE1AAXTXCyB1te7KyAmS
         MiEB96unwPy1Qlr/Ubff7w0F9jWvkAtzYc4LcJys=
Subject: Re: wifi: mt76: mt7915e: mt7916 5GHz and 6GHz stopped working
To:     Florian Schmidt <florian@fls.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <519290aa-3b88-2c21-7ca3-10186d9e807a@candelatech.com>
Date:   Mon, 23 Jan 2023 06:43:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1674484991-BvmAhqJEYMYu
X-MDID-O: us5-ut7-1674484991-BvmAhqJEYMYu
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 1/23/23 5:32 AM, Florian Schmidt wrote:
> Hi all,
> 
> Using current firmware and kernel 6.1 (or 6.2-rc4 from wireless-testing), the 5 and 6GHz stopped working on MT7916  (from AsiaRF). It used to work with older firmware and kernel.
> 
> As a workaround, reverting to the older firmware seems to work. I can also get the 5GHz (but not the 6GHz!) to work building the driver using the workaround described on this dd-wrt bug report: https://github.com/openwrt/mt76/issues/720
> 
> How can I be of any assist investigating and fixing this issue?
> 
> Thanks,
> Florian
> 

We have a patch to hack the driver to allow one or the other with new
firmware.  Can post a version for 5.19 kernel soon, and we'll rebase on
something newer at some point soon.

Looks like root cause is that the mtk firmware added restrictions and cannot
be made to properly calibrate on both bands without a reboot.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

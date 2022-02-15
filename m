Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1194C4B7878
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiBOS3I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 13:29:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiBOS3H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 13:29:07 -0500
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 10:28:57 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A3E0D1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 10:28:57 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 594C522E11E
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 18:22:31 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.168])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9888CA0075;
        Tue, 15 Feb 2022 18:22:29 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5DEFD880077;
        Tue, 15 Feb 2022 18:22:29 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CF92913C2B1;
        Tue, 15 Feb 2022 10:22:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CF92913C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1644949348;
        bh=xukAeKiIiy7xKmN5tSmEFO3RjasO7/qn5qu3f1W8b98=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZjDtXOveuZxCFFpBsOeJtcMMEh7X9GVXqc69mrBClGSV5pR0rB0ClR+k/FVIHrCcu
         70ZiIgEm0/lM9Zd4NAMIiCvwqYhujBPsHFK0wRzuP9j5UTV77+vT1WcHg0RQVU9TmY
         dD6SLjo1W/ikfr/VO80pzVyHXYgXHt18VtVvyO9I=
Subject: Re: [PATCH] mt76: improve signal strength reporting
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20220215125808.72378-1-nbd@nbd.name>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <9bb8329d-b2c7-139a-9f0d-a10bba3f4d8b@candelatech.com>
Date:   Tue, 15 Feb 2022 10:22:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220215125808.72378-1-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1644949350-FfkK2nRImbKK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/15/22 4:58 AM, Felix Fietkau wrote:
> Instead of just taking the maximum per-chain signal strength values,
> add an approximation for the sum of the combined signal.
> This should more accurately reflect the real signal strength, especially
> if the per-chain signal strength values are close to each other

My concern with this patch is that many of the mtk radios do not provide enough
info to know how many RX chains are used when receiving a frame.  I think we should not
be summing more chains than the number of spatial streams received.

That said, this code may still be a closer estimate than existing code, and some
radios, like 7921 appear to report enough info by default to properly determine
the NSS count on a per frame basis.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


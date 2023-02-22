Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CEE69EE3E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 06:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBVFQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 00:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBVFQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 00:16:54 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CDD311F5
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 21:16:53 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BE0BB60005F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 05:16:51 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.113.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1E5D713C2B0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 21:16:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1E5D713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1677043011;
        bh=Q4oNFIyKlF+vRNupc7B7pKPEBdqtqU/CiaBtCaJpXcQ=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=CcME4aEcyvKsMeM/catQejEx5B4XkclryNdsoMCBuLHrNwsuyvP1pEWEu337yQu/O
         3jSIB1wK0+qDRb0ASLW4miMK1kXGuQcaESkOQsPKJDPN3c3Mm8HyvVL36PD9ceRZF1
         hRpAoCg56WRos13cv9YlF878Jmt5iW5IEivL/ysY=
Subject: Re: Potential issue in ieee80211_rx_handlers_result related to
 link_sta?
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <88c16925-225c-c68c-6121-c3a2c08535a0@candelatech.com>
Organization: Candela Technologies
Message-ID: <995cf1cc-2cb1-92a5-19c4-b7ef40c37ff9@candelatech.com>
Date:   Tue, 21 Feb 2023 21:16:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <88c16925-225c-c68c-6121-c3a2c08535a0@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1677043012-nb8JpQph3nES
X-MDID-O: us5;ut7;1677043012;nb8JpQph3nES;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/21/23 4:10 PM, Ben Greear wrote:
> I'm working to rebase my patches on the 6.2 kernel.
> 
> I am currently tracking down something I did that causes the code to crash in the code below
> right above 'fallthrough'.  I'm wondering why it is checking for rx->sta but then access
> ing rx->link_sta?
> 
> static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
>                       ieee80211_rx_result res)
> {
>      switch (res) {
>      case RX_DROP_MONITOR:
>          I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
>          if (rx->sta)
>              rx->link_sta->rx_stats.dropped++;
>          fallthrough;

I found my bug, hash fast path wasn't setting up the link_sta.

Still, the checks might be better changed?

Thanks,
Ben

> 
> Thanks,
> Ben
> 


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5A6D2A12
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjCaVgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCaVgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 17:36:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDD721AAC
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 14:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD96EB83255
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 21:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E48BC433D2;
        Fri, 31 Mar 2023 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680298571;
        bh=W/MKwEVbnvkhNgMQungYqA/saSpihEpxVu6JYyl2oqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFbjJ4DeMAG6uu5XcLKdEtMK0Aix/KD+2Kv5EHkOEIpz2X0bekojgVpgws/5MrrEY
         xOes7cuwm7Fb4Lb303cvS5WuQxKiJ0mJKazXHrINYemEJayyP52PEyujUhDMSD6Tg5
         Ik06sQcVVSAEdFWl2SqOSMabcUYXN3Vw1RGa/O6SkOdp117ohB4iiRE+0mVmVI1Jl1
         bUPv6QRryT/LIgA/JsjdqYX6VFCzTBvl9BHlrVt9aMocrnPA4MhpKkWFEowmcWfi1j
         xcTiWB6eTpEDwP7VbXrR6r/8Eu7dkjtMQa4kNtGjJUaMl+N2Rd/xiCmxfK1uqsZ974
         Yd6bcixADE7kg==
Date:   Fri, 31 Mar 2023 16:36:10 -0500
From:   "sforshee@kernel.org" <sforshee@kernel.org>
To:     Eric Sellman <GAK_ACTION@live.com>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for USA on 5GHz
Message-ID: <ZCdSShqbJQ43gZZR@do-x1extreme>
References: <SJ0PR22MB249552E61991E3B2FAC911978F8F9@SJ0PR22MB2495.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR22MB249552E61991E3B2FAC911978F8F9@SJ0PR22MB2495.namprd22.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 31, 2023 at 08:30:09PM +0000, Eric Sellman wrote:
> First, I would like to state that I live in the USA And that this is my first time submitting a correction to the wireless-regdb.
> 
> According to this list here >> https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt#n1727
> 
> I only see VHT160 allowed to be utilized for 5500mhz to 5640mhz but there is no mention of VH160 being allowed for use with 5180 to 5320mhz.
> 
> And according to this presentation here > https://transition.fcc.gov/oet/ea/presentations/files/may17/31-Part-15-Panel-UNII-UpdatesDT.pdf
> 
> And this paragraph from this FCC document here > https://www.federalregister.gov/d/2014-09279/p-65
> 
> "Band Straddling" is allowed with U-NII-1 and U-NII-2A. 5150mhz to 5330mhz
> 
> Therefore, I would like you to add to the db that 5180 to 5320 can be used with vht160.

You are correct, however the kernel rejects the database if the max
bandwidth for a range exceeds the size of the range for a given rule. So
unfortunately we can't set the max bandwidth to 160 MHz.

Thanks,
Seth

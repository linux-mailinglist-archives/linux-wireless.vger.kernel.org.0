Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A24DB860
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiCPTG7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiCPTG6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 15:06:58 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282A6E372
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 12:05:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4C1F11A006C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 19:05:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 203D53C0092
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 19:05:42 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9A18A13C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 12:05:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9A18A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1647457541;
        bh=eO1tUtBxVhKTwo+pws3oCGKZlwK1b/sFkXlFM4BrfpY=;
        h=To:From:Subject:Date:From;
        b=lrdMhjL/tpsHQcbxAVx/1CTGccxDqghN+kMq2mEt3D7SW4e+qG6y2vTLdTjTqeXue
         kkujzLt5FDDJJFBLqsM/pOquLu1bo4HMI6IDovMZv8GidZKohOeLFoaYVn6HyPyLyK
         aCWNvC7vu6Cct+1h46JLjUulo0mOyoTVJ17QOqs0=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax210 txpower settings issue.
Organization: Candela Technologies
Message-ID: <0cdac27e-5beb-51d4-4f27-9cd84cd1f7dd@candelatech.com>
Date:   Wed, 16 Mar 2022 12:05:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1647457542-LdeQNxxzcVyT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I notice that when I try to set txpower on ax210 to 20 in a particular setup, then
the peer RSSI reports -51.  If I change txpower to 15, peer reports about -53.  If I change
txpower to 10, peer reports about -57.

I am wondering if ax210 somewhere might be using 1/2 db units when it should be using full db units
or vice versa?

I'm using firmware version 71 and 5.17+ kernel (with the 5.18 iwlwifi patches backported).

Anyone tried similar?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


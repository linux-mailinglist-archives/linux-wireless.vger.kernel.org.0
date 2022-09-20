Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D165BE171
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiITJKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiITJKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 05:10:17 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1708024BD0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MAt8DlfItQPPDigxzUxuAKqlyfjbrWk/N7yj7HEs4eE=; b=VlNTe0RI/LuihogRdubY0Mv2/m
        BN9308GdrbnJy/Xd8AdPuUAYFr48znGZEBHYEB90Osp0YzICAXBPg+ppsCJazBfuAReGHI1jRs93g
        TqZ6ik2bHMaZUnblK0Mp1+/Gu2Jakqff5auN+YDAsP4jjdhrkkcJtPR01UCx42LkV98g=;
Received: from p200300daa7301d00c12bff90dd0eb021.dip0.t-ipconnect.de ([2003:da:a730:1d00:c12b:ff90:dd0e:b021] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oaZGf-006GSf-M9; Tue, 20 Sep 2022 11:10:13 +0200
Message-ID: <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name>
Date:   Tue, 20 Sep 2022 11:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock
Content-Language: en-US
To:     Venkat Ch <venkatch@gmail.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Venkat Chimata <venkata@shasta.cloud>
References: <20220915043527.737133-1-venkatch@gmail.com>
 <238a21a8-c97b-5a38-6c08-9057055bf73f@nbd.name>
 <CABHL29H75U-0dBP14d-6ds-xMPt1eqrvQPuMp3oY8qQS8Y3Dbw@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CABHL29H75U-0dBP14d-6ds-xMPt1eqrvQPuMp3oY8qQS8Y3Dbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20.09.22 11:05, Venkat Ch wrote:
> Hi Felix,
> Thanks for the comments. What part of  drv_sta_statistics could make it 
> sleep? I might be missing something. Please explain.
It's just a wrapper around the driver .sta_statistics op.
The documentation in include/net/mac80211.h states that this callback is 
allowed to sleep, and it does so in a few drivers.

- Felix

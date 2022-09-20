Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B15BED2C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiITSwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiITSwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 14:52:24 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702374E14
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8aD/DyiSa3ilEFgbcJKBty9ZIOEhe6c18+eXv6Y9kCE=; b=swKu7MYkXEYRdWgS6wqBUmHypm
        2Oi5vb9TmAWeMKdezO8WhLLoJ9B58F5c5X0qhv1+dkQGoti9DaVAESilecUD5TttNrIuMMbnT2rv3
        X/yqKvCzQt+g0xuMAdE18cbhgbyH8qI7H0KWTJibR+x6r0pAvlCHbFlEEyEPSX1d/HzU=;
Received: from p200300daa7301d00a986799c2cf5dafb.dip0.t-ipconnect.de ([2003:da:a730:1d00:a986:799c:2cf5:dafb] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oaiKw-006Lvd-Vu; Tue, 20 Sep 2022 20:51:15 +0200
Message-ID: <f75ad975-8b76-f3e6-151b-6eda552c0431@nbd.name>
Date:   Tue, 20 Sep 2022 20:51:14 +0200
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
 <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name>
 <CABHL29GB6DCrdu4FzRfBDSj9A7pwqnWE+wgH2xfkBMLjT3bAxA@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CABHL29GB6DCrdu4FzRfBDSj9A7pwqnWE+wgH2xfkBMLjT3bAxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20.09.22 20:27, Venkat Ch wrote:
> Hi Felix,
> 
>   Thank you. I browsed through the code. There seems to be sleep
> operations wcn36xx platform.ath11k  does n't seem to have the sleep
> operations in sta_statistics. We are using ath11k based chipset. Will
> it impact things if we apply this patch for ath11k boards only as a
> platform specific patch?
I think it's a bad idea to keep this hack without understanding why it 
helps at all.

- Felix

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E495BFC76
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiIUKiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIUKit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 06:38:49 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF308E4D8
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fXVNVPjkRy6nV2YL28Jo3KA41s6U1PojjlV+/uomvR8=; b=F6hor1hr/Nbtl112dYgxteES+E
        Xba+pgfiqn063qm/wF8hzFIXEMyBsYra9/w9DSNO5w9HVsC7RLf1Q8ozAlP3exg8A5KIK70XnRaIB
        0XW4LOmeZpiuWCu5llmGK9Yg8E08Ch6adi77LSY8+vdqP9WVNKQFUa93rnuq5lEWUjyY=;
Received: from p200300daa7301d00a986799c2cf5dafb.dip0.t-ipconnect.de ([2003:da:a730:1d00:a986:799c:2cf5:dafb] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oax7t-006WK0-S7; Wed, 21 Sep 2022 12:38:45 +0200
Message-ID: <a159fe51-5324-cafe-1977-4604f58de247@nbd.name>
Date:   Wed, 21 Sep 2022 12:38:45 +0200
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
 <f75ad975-8b76-f3e6-151b-6eda552c0431@nbd.name>
 <CABHL29GUgta4Ke3sxbongMSK__cruTaDYCXe1-yEDL3WA3mO9Q@mail.gmail.com>
 <4040f674-8430-69ba-1b6f-f9fd92da413d@nbd.name>
 <CABHL29FkAKk7=MJ6J=wUzXkuYJ=M5DYE0nk5sHWxwz26FuYjrg@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CABHL29FkAKk7=MJ6J=wUzXkuYJ=M5DYE0nk5sHWxwz26FuYjrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21.09.22 10:31, Venkat Ch wrote:
> Hi Felix,
> 
>   Thanks again for patiently discussing things. I clearly understand
> what you said about locks. Now that we know the background of the
> problem, do you suggest any potential solution or any potential
> direction that I should start investigating? Please let me know.

Maybe try enabling lockdep and see if anything shows up.

- Felix

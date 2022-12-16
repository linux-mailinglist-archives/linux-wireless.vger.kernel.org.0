Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6664E9C6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 11:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLPKu2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 05:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPKu1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 05:50:27 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF963C8
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3sQktB/k3UsirYS1fs7WfS5u4qObJftXkM3ux4Mudrg=; b=SrfcXFPrvkNE6G3OSEUtl5Oy9V
        4ik1cljdvOUbuzpMkhJ4Y8JQm1/khlBnR8IIwZj3uc/zALpm9M+w4ER9C8xPupbQBg9kWxGiM6kQ6
        IxjZVKk7u0fK3fdvlgQeB8+mB+ZkZ0uVnoopUrwpDMvLGsYEnG7zEuIk9cE8lT/yQz5A=;
Received: from p200300daa7420a02090f62f75c4aa0ce.dip0.t-ipconnect.de ([2003:da:a742:a02:90f:62f7:5c4a:a0ce] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p68IK-009IlG-LO; Fri, 16 Dec 2022 11:50:24 +0100
Message-ID: <184255f9-426d-1718-5216-3eb44d21c7e3@nbd.name>
Date:   Fri, 16 Dec 2022 11:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: mac80211: fix initialization of rx->link and
 rx->link_sta
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
References: <20221215190503.79904-1-nbd@nbd.name> <877cyrljnp.fsf@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <877cyrljnp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.12.22 11:36, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> There are some codepaths that do not initialize rx->link_sta properly. This
>> causes a crash in places which assume that rx->link_sta is valid if rx->sta
>> is valid.
>> One known instance is triggered by __ieee80211_rx_h_amsdu being called from
>> fast-rx.
> 
> An example crash log would be nice to include, it would make it easier
> to find this fix.
Sure. Will add the one that was sent to the list yesterday to v3.

- Felix

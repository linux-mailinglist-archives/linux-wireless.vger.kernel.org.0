Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF85FD678
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJMIvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJMIvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 04:51:11 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391D10567C
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LERii1Z9tFuYM6Oh78p3qSFBhsrbSl9mSkNFw7tyc0I=; b=NF2X5xfhfPE9VNWqkq6WZHlF/T
        pi3LUiWk8pJvnioMk92NH//h7KntKXhpmB5+mesgg+zFQX4wVZ99lTlpqeT7+IUQZuV6gz+CWTSlK
        2FE1hGjR7LSkmY164nJ2j+onOpcEqkohgVSDOBPsNgOdd4vHOxhdFM+Rqn2J6nFa3DtY=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oitvV-00CO5w-Uo; Thu, 13 Oct 2022 10:50:50 +0200
Message-ID: <3b029dc7-054b-3510-f159-de6622d8ce01@nbd.name>
Date:   Thu, 13 Oct 2022 10:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <cover.1664356281.git.lorenzo@kernel.org>
 <87r0zd4mxw.fsf@kernel.org> <Y0aH8T8pTARNWcPE@lore-desk>
 <87zge0memc.fsf@kernel.org> <Y0fQ0f3uy5p9f2mP@lore-desk>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <Y0fQ0f3uy5p9f2mP@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13.10.22 10:48, Lorenzo Bianconi wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> >> 
>> >> > Enable WED TX support for mt7915 and mt7986-wmac drivers running on MT7986 SoC.
>> >> 
>> >> What's WED TX?
>> >
>> > It is the same as we did for MT7622. It is the capability to offload traffic
>> > from lan/wan to wlan. I specified "TX" since MT7986 supports even RX
>> > offloading (I am working on it at the moment).
>> 
>> It would be nice to mention in the commit log that the feature is about
>> offloading traffic from lan/wan to wlan. That way it's stored to to git
>> history and people like me have some clue what the patch is about,
>> otherwise we are totally in dark.
> 
> I think Felix has already applied them.
> @Felix: are you taking care of it or do I need to repost?
No need to repost - just send me the description that you want to put in 
there, and I'll update the commit.

- Felix


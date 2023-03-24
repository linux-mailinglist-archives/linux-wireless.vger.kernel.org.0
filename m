Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8346C7C6E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 11:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCXKTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjCXKTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 06:19:43 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F635132E4
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TGpbCRl1WSOCJVs+79IUG4QHP2Bbm6sFU1OBtSjF7Eg=; b=Bo8yYusM30LhhdqhFWvRr5ge8G
        rhwEzh7yCr5tUJUN38YJjoozCclIP1s1cKlrhk4FuIeSm9oP3hUK2tH1rZq3BmDOsKVejNIIvsvpX
        i89Z3Ip3JScc6AfnRx8dhOT4mc/3EeIOb+YEzlq/xK8YiJzlNgKSeu9nzM5DC2E31zFs=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pfeWA-006JKI-WB; Fri, 24 Mar 2023 11:19:31 +0100
Message-ID: <829a59bc-dc57-9cda-7da9-8033ca419fd2@nbd.name>
Date:   Fri, 24 Mar 2023 11:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Ben Greear <greearb@candelatech.com>
References: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
 <ff4c3a89-f3dc-2ae6-1b11-f2c46944e376@nbd.name> <87zg82ty8b.fsf@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <87zg82ty8b.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 24.03.23 08:17, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 22.03.23 17:37, Lorenzo Bianconi wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> Stop referencing 'features' memory after release_firmware is called.
>>>
>>> Fixes this crash:
>>>
>>> RIP: 0010:mt7921_check_offload_capability+0x17d
>>> mt7921_pci_probe+0xca/0x4b0
>>> ...
>>>
>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> The title should have "wifi:", not "wireless:".
> 
>> Acked-by: Felix Fietkau <nbd@nbd.name>
> 
> Felix, do you mean I should take this to wireless tree?
Sure

- Felix


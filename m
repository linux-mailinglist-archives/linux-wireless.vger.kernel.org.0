Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFB6B7328
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 10:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCMJuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCMJuu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 05:50:50 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA5A255
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VB3SBpary9pJE1xkfc09rFdSb8qSjhVT9IVGuWIxpUw=; b=mbSh5l8onxZKPD3d3wjlkr3w3d
        jfOob9hVn75FFXsmnKUyj6tefPDXPd0sxUpSlOdFi84l++rz/OPJldQwqf7q8P0bGzs8eTl4y4w9G
        /iAng3m4Ow9X6bbMYgahonKodji4ggDV0p8VAN3hRBHy7JJF2VOJRKzHSsk+YVyhZZGU=;
Received: from [217.114.218.21] (helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pbeoz-001MDn-DA; Mon, 13 Mar 2023 10:50:25 +0100
Message-ID: <d0f4ac42-caf5-dd6e-65c0-762c72575872@nbd.name>
Date:   Mon, 13 Mar 2023 10:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH wireless] wifi: mt76: connac: do not check WED status for
 non-mmio devices
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
References: <c42168429453474213fa8244bf4b069de4531f40.1678124335.git.lorenzo@kernel.org>
 <ZA7r+a0J7LBsbDX+@lore-desk>
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <ZA7r+a0J7LBsbDX+@lore-desk>
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

On 13.03.23 10:25, Lorenzo Bianconi wrote:
>> WED is supported just for mmio devices, so do not check it for usb or
>> sdio devices. This patch fixes the crash reported below:
> 
> I would say this one can be applied to wireless tree.
> 
> @Felix: do you agree?

Yes.
Acked-by: Felix Fietkau <nbd@nbd.name>

- Felix

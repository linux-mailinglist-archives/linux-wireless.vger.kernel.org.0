Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3018D1E2572
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEZP3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 11:29:42 -0400
Received: from mail.as201155.net ([185.84.6.188]:31896 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgEZP3m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 11:29:42 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:56601 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jdbWM-0002NG-29; Tue, 26 May 2020 17:29:38 +0200
X-CTCH-RefID: str=0001.0A782F22.5ECD3577.0088,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=cInslgAG713xdV9rybY08rJ1f7kTEVLI4lae2PtRNvo=;
        b=j19kiLOhbFSRnckgFrHtF8Tp2IAMG7RzzEjFB7U5DL2BVijAy4xvhS/L8x9dlbvhRJ1rxVAnh2hNGAUlJNxjGqaQEmNfesAil888ZoWMH4V1AHYxKjWZhgl4YajYHwvcuS5PwYchCtdkjB3T+Z7CV7WyonfiUi85YmRY7uldIms=;
Subject: Re: [PATCH] ath10k: Avoid override CE5 configuration for QCA99X0
 chipsets
To:     Kalle Valo <kvalo@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <1587649759-14381-1-git-send-email-mkenna@codeaurora.org>
 <20200505073422.BFA51C433BA@smtp.codeaurora.org>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <63ec6f30-ee3b-c412-7c56-46d447b17c8e@dd-wrt.com>
Date:   Tue, 26 May 2020 17:29:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200505073422.BFA51C433BA@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2a01:7700:8040:4000:8d02:4687:f16b:dbd1]
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jdbSC-0002Fd-90; Tue, 26 May 2020 17:25:20 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 05.05.2020 um 09:34 schrieb Kalle Valo:

> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
>
>> As the exisiting CE configurations are defined in global, there
>> are the chances of QCA99X0 family chipsets CE configurations
>> are getting changed by the ath10k_pci_override_ce_config()
>> function.
>>
>> The override will be hit and CE5 configurations will be changed,
>> when the user bring up the QCA99X0 chipsets along with QCA6174
>> or QCA9377 chipset. (Bring up QCA99X0 family chipsets after
>> QCA6174 or QCA9377).
>>
>> Hence, fixing this issue by moving the global CE configuration
>> to radio specific CE configuration.
>>
>> Tested hardware: QCA9888 & QCA6174
>> Tested firmware: 10.4-3.10-00047 & WLAN.RM.4.4.1.c3-00058
>>
>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Patch applied to ath-next branch of ath.git, thanks.
>
> 521fc37be3d8 ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
this patch will crash on ipq4019 devices. i reverted it and it worked again

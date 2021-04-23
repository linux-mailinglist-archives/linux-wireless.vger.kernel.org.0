Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C1369500
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhDWOo3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDWOo2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 10:44:28 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58628C061574
        for <linux-wireless@vger.kernel.org>; Fri, 23 Apr 2021 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x1K+R8W7mFXfM33PaaEcvft7s812V1Uevcu481NnfqY=; b=h+st9hi+CR+50qDqOhZP5/lCF5
        7Z07nsfI6GmNWSAvZXvXpdI6qfHbzcQzTwuZiM3TLI8CYoRuAv81qvbWtDvKYSzfOK46h5dJx5DBe
        VoKz1WECkrZLyZ7UONPYLIe/p2uXAXY13yP3SD0jvh3nOvuyWdbkevGuL6Mz7o1ZOtWk=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lZx20-0006Rx-HG; Fri, 23 Apr 2021 16:43:44 +0200
Subject: Re: [PATCH 0/3] mt7921 runtime-pm fixes
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, kvalo@codeaurora.org
References: <cover.1619187875.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <af4e6186-9c40-26c4-42bf-4b247d1befaa@nbd.name>
Date:   Fri, 23 Apr 2021 16:43:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1619187875.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-23 16:27, Lorenzo Bianconi wrote:
> This series contains three mt7921 fixes introduce with new runtime-pm rework
> 
> Lorenzo Bianconi (3):
>   mt76: mt7921: fix possible AOOB issue in mt7921_mcu_tx_rate_report
>   mt76: connac: do not schedule wake_work if the runtime-pm is disabled
>   mt76: connac: do not schedule mac_work if the device is not running
For the series:
Reviewed-by: Felix Fietkau <nbd@nbd.name>

Kalle, could you please take these patches directly, they're all
regression fixes.

- Felix

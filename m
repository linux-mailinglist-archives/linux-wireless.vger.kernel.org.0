Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301BA3ABB10
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhFQSBz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhFQSBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 14:01:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B359C0613A2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v40nMHwOtRaKTUDeGhfNF5508cHey0NmopoGXvvxr+M=; b=JKxqz9SXxD33n/K1sgphRSadPB
        fE858ogNbnGN0OVdQW496blpRWNjehYrVn3ZlOspz6yzDdXBLTUUG4CYijZyJQCSdxdBvXqscPSC0
        shF61mpsnBmNabjZyjM69ZNPozPMWN0YAUL4C2vX74JL8SGxp1Co1ppfawLzJmUKLPxM=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ltwIZ-0007zT-1t; Thu, 17 Jun 2021 19:59:27 +0200
Subject: Re: [PATCH v2 1/4] mac80211: call ieee80211_tx_h_rate_ctrl() when
 dequeue
From:   Felix Fietkau <nbd@nbd.name>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <2176023d8f13d82d093452e1c105609396c30622.1622164961.git.ryder.lee@mediatek.com>
 <a89137bf-401b-c9d0-8848-d79ea9e2a9c3@nbd.name>
Message-ID: <4d652f4a-c258-f248-911f-28238531ae4d@nbd.name>
Date:   Thu, 17 Jun 2021 19:59:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a89137bf-401b-c9d0-8848-d79ea9e2a9c3@nbd.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-17 12:50, Felix Fietkau wrote:
> 
> On 2021-05-28 08:05, Ryder Lee wrote:
>> Make ieee80211_tx_h_rate_ctrl() get called on dequeue to improve
>> performance since it reduces the turnaround time for rate control.
>> 
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> ---
>> change since v2 - roll ieee80211_tx_h_rate_ctrl checks into one condition
> There were some OpenWrt crash reported which appear to be related to
> this patch. I was able to reproduce a deadlock with ath9k, and I'm
> currently looking into it.
Some more information about the crash:
- ath9k calls ieee80211_tx_dequeue with the tx queue lock held
- ieee80211_tx_dequeue calls minstrel get_rate
- get_rate calls minstrel_aggr_check
- minstrel_aggr check calls ieee80211_start_tx_ba_session
- ieee80211_start_tx_ba_session tries to send a frame
- ath9k tries to acquire the tx lock it already holds

I've fixed this in v3 by moving the logic of minstrel_aggr_check into
mac80211

- Felix

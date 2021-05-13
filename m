Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01037F3AD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhEMHrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhEMHqT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 03:46:19 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A90C06138B
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lNEUtw5bU1JO7VvgHu3zGuBvfkdBpiuaW5V2tZWQnM4=; b=FRV1RT5lwxRiKLOfL07frigQn4
        1dHKTUg/T6SUEBPKs0N84Nu+Y0qS9CdLniZv9hDruuCpjbDKYtXh5VZdDUrfFWDPWmflOqVcuZgwC
        DKh9HNeMSC9ESKpDVcFeqN/WfzByauOGvMSyOYbbVudNFjm/pRYfU9WsuxsTcURK8XmA=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lh61r-00055r-61; Thu, 13 May 2021 09:45:07 +0200
Subject: Re: [PATCH 9/9] mt76: mt7921: add back connection monitor support
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
 <1620659697-12048-9-git-send-email-sean.wang@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <79633d77-a326-fb46-6356-65dddea9da44@nbd.name>
Date:   Thu, 13 May 2021 09:45:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620659697-12048-9-git-send-email-sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-05-10 17:14, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Hw beacon cmd to the mt7921 firmware doesn't only filter out the beacon,
> but also performs its own connection monitoring, including periodic
> keep-alives to the AP and probing the AP on beacon loss. Will indicate
> the host with the event when the firmware detects the connection is lost.
> 
> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: YN Chen <yn.chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
What happened to Patch 8?
I don't see it on the list or patchwork.

- Felix

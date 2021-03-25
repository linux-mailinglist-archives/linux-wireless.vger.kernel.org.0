Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC5349C6F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 23:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCYWmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCYWls (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 18:41:48 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C615C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 25 Mar 2021 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VtXEnQZ9olnrM7GqKQU9RM4wafpJF+GH3/7KLt07cUU=; b=ZUvmrPBMEQDy9W+QUjc9igwsjV
        HT4WRoWw7U3cglpsCDqbnsNnlE9AYG2P6hB9UFr8rOW/QQ+mjqmw0xpid52Jn7dv4w27biTJhozL7
        dHkWl3eaTkrpCF3HqiJLBmmNz3hGW4N7Dgsd3aWAObnEfwgACEKxt6rqaOJBP3ieRFSE=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lPYfe-0004gJ-LN; Thu, 25 Mar 2021 23:41:42 +0100
Subject: Re: [PATCH v2 1/2] mt76: mt7615: cleanup mcu tx queue in
 mt7615_dma_reset()
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <fdde0eb8c6dea0e81b5f5ae528085f1ccf53fef3.1616696376.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <750b96aa-f26a-5c2a-7040-4bb84a7aa6a7@nbd.name>
Date:   Thu, 25 Mar 2021 23:41:42 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <fdde0eb8c6dea0e81b5f5ae528085f1ccf53fef3.1616696376.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-03-25 19:28, Ryder Lee wrote:
> Cleanup ext_phy and mcu tx queue so that mt7615_mac_reset_work() can
> recover mt7615 normally.
> 
> Fixes: mt76: e637763b606 ("move mcu queues to mt76_dev q_mcu array")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> change since v2 - cleanup mphy_ext->q_tx
I like v1 better, since ext-phy tx queues are the same as primary phy tx
queues. Or am I missing something?

- Felix

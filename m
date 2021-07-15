Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6330A3CA4F5
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhGOSMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhGOSML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 14:12:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C815C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KSx2asI5pX+mS3gCmaVT617vwX5KrFoBd1JmsZKmIHg=; b=NuON8Nz2WdXWPVA/dMdLz/x1j/
        wnV+X7HVQjZ7p4V5R7osU17F4HsGxCdqXhDIKlgw9UEOvUypR0+lI66SNXOO3VbYWZz6oTZThavzP
        0tkyNn9dxyqgO0EEX5XuTck6B17+C05QzdLfNOAGy5++N9NY9pdzYU7tZ15A9BKE+JpI=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1m45nO-0007Qh-7H; Thu, 15 Jul 2021 20:09:14 +0200
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v3 1/4] mt76: fix mt76_rates for the multiple devices
Message-ID: <f5b69f1b-cd52-9b30-0301-4454fc825a8c@nbd.name>
Date:   Thu, 15 Jul 2021 20:09:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <92a8ecfdf198b34f98d5c1489a83adf151657760.1626207204.git.objelf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-07-13 22:15, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> PHY offset in either .hw_value or .hw_value_short for mt7615, mt7663,
> mt7915 and mt7921 device all start at bit 6, not 8.
> 
> Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Unfortunately this patch causes a few regressions.
Since tx and rx handling is different in their use of the PHY mode bits,
the PHY part should of hw_value should be masked out when filling the tx
rateval. There are a few places in the code that rely on the fixed shift
of 8, including the generic function mt76_get_rate.
This patch should be dropped, and the bit offset differences dealt with
in the other patches of this series.
I will send an updated version

- Felix

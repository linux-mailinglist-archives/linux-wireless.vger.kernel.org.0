Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309A23EB415
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhHMKeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbhHMKd7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 06:33:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5620C0617AE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JFELaOrc4/QFqYmVPpsvH4IhzGuMZEqR40eN7dP8G1s=; b=pWhozETI3zBxWz582CC/MN3/aR
        Z8JrxkI7Ai9gYgxVNsmRI6KZu8O3/UktQLU+Jv3Pl0ZCpD4rvtc+BxLbxlQvBzwxFHAXn+P+qiuJg
        YLrL4GHuvJkSmjSf4OyG43tMH3Q+l44CyeTPCERAyvI7Dn6kBp750myKk0ibrCLlOkJc=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEUVF-0007Cd-35; Fri, 13 Aug 2021 12:33:29 +0200
Subject: Re: [PATCH] mt76: fix determining multicast frame in sta mode
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <fbc5d3da47b6a5e99ae255560279268f580e7b22.1628543190.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <6c6ba2fd-3952-3c44-6c6d-51f77eb66828@nbd.name>
Date:   Fri, 13 Aug 2021 12:33:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fbc5d3da47b6a5e99ae255560279268f580e7b22.1628543190.git.objelf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-08-09 23:13, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> We should use hdr->addr3 as the destination address to determine the frame
> is multicast frame or not when the device is running in sta mode.
> 
> We can simply use ieee80211_get_DA for ap mode and sta mode both cases.
That does not make any sense to me. When a sta sends a packet with DA
set to a multicast address, it will be sent as unicast to the AP. Why
should it be treated as multicast by the driver?

- Felix

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4CF44EDAB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhKLUIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 15:08:09 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:46440 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232474AbhKLUII (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 15:08:08 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.120])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1B82F1C0085;
        Fri, 12 Nov 2021 20:05:15 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 89BEF34007D;
        Fri, 12 Nov 2021 20:05:14 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E9D4E13C2B0;
        Fri, 12 Nov 2021 12:05:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E9D4E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1636747514;
        bh=XGlTOe8h47eDgp5pmwvtG6/41tLvJLctvUBvj+ENyXo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JiKW9PSloP2I88/0MqcizcCd/z8v1/MAFWBdwpt4CBjMykUm677ysVt04WvFUKfUR
         hZYEoi+vebtuvu9jz3T3fYARiDUDstUFk1Bvz9mR7koFUTjIwrmoiSKCbfoOO+oOhX
         nYFd50rz9WUmN4XvPy8CxQt3+TBT4kvDvqIZkkYA=
Subject: Re: [PATCH v2 02/11] mt76: mt7915: refine register definition
To:     Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <cover.1636105953.git.Bo.Jiao@mediatek.com>
 <3ba42e47ae9cc7630e1f9b82955871fb90349f94.1636105953.git.Bo.Jiao@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <a11f6064-6886-1cfc-38e3-6fe9bf6ea2d7@candelatech.com>
Date:   Fri, 12 Nov 2021 12:05:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3ba42e47ae9cc7630e1f9b82955871fb90349f94.1636105953.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1636747515-9_5RKMg9bbMM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/5/21 3:02 AM, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> Add mt7915_reg_desc to differentiate chip generations.
> This is an intermediate patch to introduce mt7916 support.

While merging this into my patched tree, I noticed this discrepency,
it seems this patch is changing the value for SDR32/33 and/or confusing
SDR32 with SDR33.

Is this on purpose?

[greearb@ben-dt4 linux-5.16.dev.y]$ git am --show-current-patch|grep 088
+	[MIB_SDR32]		= { INVALID_BASE, 0x088 },
-#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x088)
[greearb@ben-dt4 linux-5.16.dev.y]$ git am --show-current-patch|grep SDR32
  	cnt = mt76_rr(dev, MT_MIB_SDR32(ext_phy));
  	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK, cnt);
+	[MIB_SDR32]		= { INVALID_BASE, 0x088 },
+	[MIB_SDR32]		= { INVALID_BASE, 0x7a8 },
+	MIB_SDR32,
-#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR32))
  #define MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK	__MASK(dev, MIB_BF_TX_CNT)
[greearb@ben-dt4 linux-5.16.dev.y]$ git am --show-current-patch|grep SDR33
-	cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
-	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK, cnt);
+		cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
-#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x08c)
-#define MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x088)

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


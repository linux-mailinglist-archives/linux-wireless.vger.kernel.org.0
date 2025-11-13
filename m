Return-Path: <linux-wireless+bounces-28904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BCC56A76
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B99D2347CF2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2C72D7DC4;
	Thu, 13 Nov 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nhOVfDiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACF1F5EA;
	Thu, 13 Nov 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026903; cv=none; b=pkvUFxba97s4UEKmM16tSyFLeKVOWq+a2PyTxhW6CulcXyFmtoHg+03jOcB2dc0HQkZefVcpysOdkFTfq1eCRCSCECshFxcsfRBvSHVpDYverNeBgmo4THmwNpZ/gR3c3412h39IQi+6HUhckCOfchUc5eZvpwtAez3rqdiC+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026903; c=relaxed/simple;
	bh=4/HgFDDTpu2npjbrzB0GRmhS1pfjB3miPWO/zGNOkrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCSHRA0eATYJHBwDmvNelPqX+tQoju2jNHW0tja7Y2akxBylJ3ot/bfsDzKiMEoCrhHNTUzehQ9Ka2kJKkZpnZuGwxuQ9RlImdm682ggt5Ztz3iBZ5nuDflFsyKVHW+qmIbUQDrsF9YHfKq4bE04HczdRCK/Q7QaOm543vB0x/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=nhOVfDiJ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29764e94b;
	Thu, 13 Nov 2025 17:41:36 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: lorenzo@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	jianhao.xu@seu.edu.cn,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()
Date: Thu, 13 Nov 2025 09:41:35 +0000
Message-Id: <20251113094135.348383-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aRWF9QJuwGaDlUvT@lore-desk>
References: <aRWF9QJuwGaDlUvT@lore-desk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7c97843b03a1kunmfac98f0512a188
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0sYVhhCT09CGEkeGEsYGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJQk1LSlVKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=nhOVfDiJ74Sdt0UEx5n9Ip6yX8XSqzU+2fWTnIGT8VBL20byL0rS6xZPJ3l/1QuZdmq9EZLxOIibIuTUmkj/5RbIq557HJaTkbxduMlb3wNgk9noAImuQPqNi1xGQr9pyZDkcpFZ/m7pURVRnmENiuq3g29ZsmS/JWKvmjZLiJ8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Tz39zWUgWe6lz3NHfDSC8mIp9EXHb7gxRBAo7zC/Js4=;
	h=date:mime-version:subject:message-id:from;

On Thu, Nov 13, 2025 at 08:17:09AM +0100, Lorenzo Bianconi wrote:
> [-- Attachment #1: Type: text/plain, Size: 1475 bytes --]
> 
> > In mt7615_mcu_wtbl_sta_add(), an skb sskb is allocated. If the
> > subsequent call to mt76_connac_mcu_alloc_wtbl_req() fails, the function
> > returns an error without freeing sskb, leading to a memory leak.
> > 
> > Fix this by calling dev_kfree_skb() on sskb in the error handling path
> > to ensure it is properly released.
> > 
> > Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > index 4064e193d4de..08ee2e861c4e 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > @@ -874,8 +874,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
> >  	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
> >  						  WTBL_RESET_AND_SET, NULL,
> >  						  &wskb);
> > -	if (IS_ERR(wtbl_hdr))
> > +	if (IS_ERR(wtbl_hdr)) {
> > +		dev_kfree_skb(sskb);
> 
> Hi Zilin,
> 
> I can't see how this is useful since if mt76_connac_mcu_alloc_wtbl_req returns
> an error, wskb will not be allocated.
> 
> Regards,
> Lorenzo

Hi Lorenzo,

Thanks for your review.

You are correct that 'wskb' is not allocated in this error path. 
However, my patch is intended to free 'sskb', which was allocated 
earlier in the function. Without this change, 'sskb' is leaked if
mt76_connac_mcu_alloc_wtbl_req() fails.

This approach is similar to the error handling logic later in the
function, where a failure in sending one skb results in the other one
being freed.

Hope this clarifies.

> >  		return PTR_ERR(wtbl_hdr);
> > +	}
> >  
> >  	if (enable) {
> >  		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
> > -- 
> > 2.34.1
> > 

Best Regards,
Zilin Guan


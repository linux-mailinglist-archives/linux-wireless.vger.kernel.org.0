Return-Path: <linux-wireless+bounces-30906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB90D30EAA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 13:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F583036AC9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF619376BCF;
	Fri, 16 Jan 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="F6qxXBkF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079E3612EA;
	Fri, 16 Jan 2026 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565514; cv=none; b=PQ6h11un0rlD5IQ/E/14nTOuOY7feuFiF1ipAueGmGFgKOdyr3xh82X+yHLQRWgRDHYbjlvUwhUdCTIK2xgiCbHmLHT/rO4EUWc8G1qFcyizlu2XAxnrNCYLwe5msRsizRj71hI5jkZg3wPyfwce97YFAdW9W8LTElsK7jy07l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565514; c=relaxed/simple;
	bh=etTqRaHVDUZ14AB+4vLTJLPcIzWTlA6qH/Ib3+O86GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AY0BnuEi2BUUiUjKnvCwrUYxjv5FiiLMmSvCNO1l2KhhNDH5vdLZBWPhVqVlPW7dxTWjjvt4IkcqGR5OMszefeWMXFf7IHMiVgekBW1w6+2WhnJqhhQmktBO8IlJFs22DG0MP5Vx5p6tAKu/LbBpjslwbQuoMHbSsYFHUwny9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=F6qxXBkF; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ebc62ca;
	Fri, 16 Jan 2026 20:11:46 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: kevin_yang@realtek.com
Cc: jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	zilin@seu.edu.cn
Subject: RE: [PATCH] wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
Date: Fri, 16 Jan 2026 12:11:45 +0000
Message-Id: <20260116121145.1370320-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2df4d692f5804c8ca87d3cd26b37081e@realtek.com>
References: <2df4d692f5804c8ca87d3cd26b37081e@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc6b802dc03a1kunm2f79aef4114acd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx5OVhlPHUtKGkMZTx4dHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=F6qxXBkFUFhcUsyO6S4HkWWTSP7boK2hoihMHoBuo/qOYNx7L9GKcwlyg92ITfD99rKjq7uAbKnJ1zbrLLJWYWlt5a4H7oi43cGcwmt1+aqdcX85j8TT9+ag/hzxeHiNJDJzndq6daroYJ7AlRerSaRRw/wqKGf/Tz5MpAHW2yI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=TJ/sb3BxQG97jazvDMNcgO0XChyUuu9hlSh2MM8frZg=;
	h=date:mime-version:subject:message-id:from;

On Fri, Jan 16, 2026 at 08:23:57AM +0000, Zong-Zhe Yang wrote:
> > @@ -834,8 +834,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char
> > *buf, size_t buf
> >         else
> >                 max_valid_addr = map->addr_to;
> > 
> > -       if (max_valid_addr == 0)
> > +       if (max_valid_addr == 0) {
> > +               vfree(bufp);
> >                 return -EOPNOTSUPP;
> > +       }
> 
> Thank you for catching this.
> Since the decision for max_valid_addr doesn't depend on bufp,
> how about moving vzalloc down here ?
> 
> > 
> >         for (addr = map->addr_from; addr <= max_valid_addr; addr += 4) {
> >                 ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr, &val);
> > --
> > 2.34.1
> > 

Thanks for your suggestion. I agree that moving vzalloc() after the check 
is a cleaner solution. I will send a v2 patch to address this.

Best Regards,
Zilin Guan


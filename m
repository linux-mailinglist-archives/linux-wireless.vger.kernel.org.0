Return-Path: <linux-wireless+bounces-9626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E6919D02
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7907428314C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDF2139B0;
	Thu, 27 Jun 2024 01:40:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BF17FE
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719452430; cv=none; b=nejdBeOET3Rtw+cnU3bc4I6WEna+nXGbkpXcH6yfOSplg5rkknaR54XWDBG4V8J9++YK4Ier3CItRtaEHjVygNpOn7CeOvKQlbmFkA9ADH2uuPdm3drRPe28uB3Ug4Mn+bEg6Xriu2bt7muUHnik+++fNKgPl9oMvi1yJt5h5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719452430; c=relaxed/simple;
	bh=BgxJV9AvHmfxWIEfl3MFPe+auAYfI4o7U4Mn15/NBto=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=GBcle3x4iW2SQN5gqVJDRyFIDi3Nddl6+xRpRa1Ijd+A/B8+LKdySdd4qneCt+cNOAqOSjQRnzlsdScvuZNqf1QTE9QhwwAZ6RWxNZfCZyVUa6C+QzBWBAmG9qpzR4ZkvkV2p74hiJ+UknQd6BuQ4/N4YSsd0sddMztNR6RK+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R1eNUi92488996, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R1eNUi92488996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 09:40:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 09:40:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 09:40:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH 1/7] wifi: rtw89: wow: append security header offset for different cipher
In-Reply-To: <20240620055825.17592-2-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com> <20240620055825.17592-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8a153bfe-b214-49f4-94a2-ae4ba31348a7@RTEXMBS04.realtek.com.tw>
Date: Thu, 27 Jun 2024 09:40:22 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> When creating EAPOL_KEY, SA_QUERY and ARP_RSP packet offload, we need
> to append security header offset for different cipher as required by
> the firmware. Only 8852A, 8852B, 8852BT and 8851B need it.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

0065199f4303 wifi: rtw89: wow: append security header offset for different cipher
0e5210217768 wifi: rtw89: wow: update WoWLAN reason register for different FW
6a03a349be1b wifi: rtw89: wow: update config mac for 802.11ax chip
dda364c34591 wifi: rtw89: wow: fix GTK offload H2C skbuff issue
60757f28408b wifi: rtw89: wow: prevent to send unexpected H2C during download Firmware
2e2564877f57 wifi: rtw89: wow: enable beacon filter after swapping firmware
792586591f44 wifi: rtw89: add polling for LPS H2C to ensure FW received

---
https://github.com/pkshih/rtw.git



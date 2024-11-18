Return-Path: <linux-wireless+bounces-15436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262009D0847
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 05:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76691F218BA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7813B7B3;
	Mon, 18 Nov 2024 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="esgzDVqw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7B13B780
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902634; cv=none; b=R92k5paVml+RrJHTUss+pYAiBnrqrT2S5w7NM9X8wVLIhnX4V6CI8krHe2tSvfDo3u0RxGby2dReDkSbhw+TICqTTVZCqcdSmp94cYGrzLUQlyJsSFB/nxUkI3IOanNRz8kUKZT3AWhKgNarNt8qIAM7nH1sFF5CLwUEibAtEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902634; c=relaxed/simple;
	bh=SsYeDS7SChyEtPfYjnDHIo4hrqyItu9Qf94o6G3pfrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GD35tYXUjYxjbSX/TE2gbF9LLaNBXJR79T9CTudyvtB30oFoRNSnVKGEI8dJYqSfeVVNd/uMS+i5eSAm4KHGebMpGmkhMR3R8MVLMKgqQUnNkz4nwtEricPRjqifPC25c70WM+j12FXl5IUtY1Pv92AhOAeTeC9pImiloQ+bsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=esgzDVqw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI43lBpA099073, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902627; bh=SsYeDS7SChyEtPfYjnDHIo4hrqyItu9Qf94o6G3pfrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=esgzDVqw9+q547OP6WYlcbj3IaTrtTTO9YSZX8CTWRrVr3j85uQgXibbpJWDRQqip
	 CLD/dJMPkbbYlmWzSRYhCpc80elfdxNm+mlgpd+FjmXQUF3mpjD23dsuTilZUGG9G4
	 ohqGKPOsKnji4Cm8yOi611sGEpPx4+D8+5l/sa663iYWdyrhgXiVZSlwDZqADxNa61
	 ObtUzXy3Y+tRHtH+T1yFdaZesohdiFqnTtwrjHd1kkaLEzv9yyVqix3Un4xvH/UmKk
	 oBk75QwPte4aExbVe/nB77CknacBfTOC34WEfHwhlkV1ML0YvmpyYpGn1xOzODmyqP
	 Zelt7lpc+QV7w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI43lBpA099073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:03:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:03:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:03:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 0/6] wifi: rtw89: preparation for MLO including AP_LINK_PS feature, ieee80211_ops and links
Date: Mon, 18 Nov 2024 12:02:49 +0800
Message-ID: <20241118040255.40854-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add more materials for MLO. First one is AP_LINK_PS feature. Then
implement ieee80211_ops related to links. The last two are to consider
link_id instead of -1.

v2:
  - rebase on top of tree. no other changes.

Zong-Zhe Yang (6):
  wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
  wifi: rtw89: register ops of can_activate_links
  wifi: rtw89: implement ops of change vif/sta links
  wifi: rtw89: apply MLD pairwise key to dynamically active links
  wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
  wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()

 drivers/net/wireless/realtek/rtw89/cam.c      |  32 +-
 drivers/net/wireless/realtek/rtw89/cam.h      |   5 +
 drivers/net/wireless/realtek/rtw89/core.c     |  45 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  59 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  71 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  19 ++
 drivers/net/wireless/realtek/rtw89/mac.c      |  50 ++++
 drivers/net/wireless/realtek/rtw89/mac.h      |   7 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 280 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ser.c      |   1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   5 +-
 11 files changed, 560 insertions(+), 14 deletions(-)

-- 
2.25.1



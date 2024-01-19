Return-Path: <linux-wireless+bounces-2224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776283257F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2BD1F21718
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03EC24B44;
	Fri, 19 Jan 2024 08:15:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637224B2F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652139; cv=none; b=moT/9KZjFQKOsBj7vKMLqT4p0uJd23ifZtxz+G8ISSwpPe8ovzYjltKrxbS7NAEsulp6slXqoIfzfr9rahPHHvvawxExw05TfPAgbaJ09YwBVuTmjTL1CCywqIqW1P2LxCPkKWYO1HXZHu1X/s/VDdi671y+Uy+Q8LQRPQcJViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652139; c=relaxed/simple;
	bh=AF7rBnYDFObYUggWbJazgythpr5RrX5Kir3nm7pr1RY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJSNvtRS7YgYDb0H+1HUL0G78Ue4nvff5RQtcfQdvR6VVBNF5zhvlg3sQ1xIX1YuafxVBX+fBHlv5X+KjP5+Ml785qAooWsYkmvPv4smBUpa4Vl7omO87pXv/SDN7VsV+Hm4Yor+L4rThFfiD4hEB/wUzUc/SqTTuYqESJlisls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FOXo82212399, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FOXo82212399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 19 Jan 2024 16:15:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: refine hardware scan and concurrent
Date: Fri, 19 Jan 2024 16:14:53 +0800
Message-ID: <20240119081501.25223-1-pkshih@realtek.com>
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

First two patches are to use struct to access H2C/C2H command formats
related to hardware scan, and patches 5/8 and 6/8 are to refine scan abort
to make abort operation safely stop. Patch 7/8 to stop hardware TSF
function during scanning to make hardware scan smooth.

Patches 3/8 and 4/8 are two problems we found during testing as their
commit messages.

The last patch is to correct mistakes that uses wrong delay unit, so
hardware work improperly.

Chih-Kang Chang (2):
  wifi: rtw89: fix HW scan timeout due to TSF sync issue
  wifi: rtw89: fix disabling concurrent mode TX hang issue

Po-Hao Huang (6):
  wifi: rtw89: refine add_chan H2C command to encode_bits
  wifi: rtw89: refine hardware scan C2H events
  wifi: rtw89: Set default CQM config if not present
  wifi: rtw89: disable RTS when broadcast/multicast
  wifi: rtw89: fix null pointer access when abort scan
  wifi: rtw89: add wait/completion for abort scan

 drivers/net/wireless/realtek/rtw89/core.c     |   8 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 108 +++++----
 drivers/net/wireless/realtek/rtw89/fw.h       | 221 +++++++-----------
 drivers/net/wireless/realtek/rtw89/mac.c      |  64 +++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 7 files changed, 205 insertions(+), 206 deletions(-)

-- 
2.25.1



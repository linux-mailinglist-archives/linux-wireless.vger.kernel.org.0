Return-Path: <linux-wireless+bounces-8399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79258D7B54
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 08:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DEA1F213CE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBFD20DF7;
	Mon,  3 Jun 2024 06:06:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881D182DA
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394809; cv=none; b=RSObeZlPXWDXhlDE+ypmD6MQ6/yUBdu0oZOC8T/0Q/VsL0lkH+wfOz4awv4ummZx/CpWJnSjV08jheNALyew8k1TTxqVHYJm2LvSOQltX/WwqvZGWqKGZ2ptRQPcb9pmvGHpg2iwRurh3Id9Cow0/lyVpxsNBwoPKevYtztFUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394809; c=relaxed/simple;
	bh=OxbtoffuGu2miaY9udvalPqG9jwXX+T2W8Y3HofJdX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MnEj8VldKapVI9RbwmUcbMOTcFOGlWcAaVPA4SiP3eGR7Za5qKue2URHdooAvMmNTS6CyO2Cq3FR5gb21oyYj2jiV7hpHoqAeCmCH3EdalvRqeAHnx47TRaBBgRkCVLyNK/j1SfkMmmn5ZGyamYOvBGKrj+FI99/lD7psf4HcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 453667nmC2473690, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 453667nmC2473690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 14:06:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 14:06:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Jun
 2024 14:06:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 1/4] wireless-regdb: Update regulatory info for Malaysia (MY) on 6GHz
Date: Mon, 3 Jun 2024 14:05:55 +0800
Message-ID: <20240603060558.98791-1-pkshih@realtek.com>
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

Malaysia Communications and Multimedia Commission announced CLASS
ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and outdoor
use and 200 mW EIRP for indoor use only.

[1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index f27dd5214630..adfcce15e3a7 100644
--- a/db.txt
+++ b/db.txt
@@ -1294,12 +1294,15 @@ country MX: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
 country MY: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (24), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5650 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (24)
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 country NG: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1



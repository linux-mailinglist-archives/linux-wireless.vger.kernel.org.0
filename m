Return-Path: <linux-wireless+bounces-23686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C9ACDABE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08BF18981FF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081941E3772;
	Wed,  4 Jun 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="lKxVZ47t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1051804A
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028647; cv=none; b=RA3DuCuN9v2vuOekHniTxc0qG4Ad2/H4g8cmEpcuz5xuSWiQBDuVlw7g6K+gC/CV8sbW0PcVyFnvRaScFY8tslz/PqrAGy6y07MD58KE89Sit/lH4bSDrZY7l42ohfGMVAq7bbC4BejS2wVoND5OAoURWxohIjq7VbWHVCA9Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028647; c=relaxed/simple;
	bh=O8lJPUI/cBAyxXijz5mL0cKZR47jmsuqQZ8wc8quxYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ts3ieMcyymuLaU/VyCenBJJGgpuy4fflUhPigIX7dvsuwK+jp5V9A2UbiwzinGB+Xcka/Rp1OC1/tYkvbNgUk+oHHwI1gCrVvNoVm2R4mEMjQXAOXPdZn885Xq9PKkobR2EEU1BDugI7KGeK/kHFPiGOzxZ+PdZIzOLIQ0AfWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=lKxVZ47t; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749028645; x=1780564645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O8lJPUI/cBAyxXijz5mL0cKZR47jmsuqQZ8wc8quxYY=;
  b=lKxVZ47tBFSPBAcKphUgc0rKK6ttHb8HmEc2kV0EvGSTZXYZM+h8zHjx
   Jsm8H6PSt+1cmoLWcLJf6yH8Fh2kTHp4D7O6YAQ0jdPAKV7oe9m823KLN
   n+k4ABwgf+mPe0FQAkmvr2amSgcvPeahKz1szAW3bHNvF0YosSJU3EQwG
   k=;
X-CSE-ConnectionGUID: E6ymYNy+QI2vn6yn8gcblQ==
X-CSE-MsgGUID: rB9uuzvASNiJGLk70sT3VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53598462"
X-IronPort-AV: E=Sophos;i="6.16,208,1744063200"; 
   d="scan'208";a="53598462"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:17:22 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 11:17:22 +0200
Received: from iot-wlan-dev-u03.aus.cypress.com (10.161.6.196) by
 MUCSE835.infineon.com (172.23.7.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 11:17:20 +0200
From: Ian Lin <ian.lin@infineon.com>
To: <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>,
	<ian.lin@infineon.com>
Subject: [PATCH wireless-next 0/4] wifi: brcmfmac: apmode related fix
Date: Wed, 4 Jun 2025 04:16:25 -0500
Message-ID: <20250604091629.3943-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE835.infineon.com (172.23.7.107)

Propose several apmode related patches for better performance and 
fixing issues in certain scenario.

Ian Lin (1):
  wifi: brcmfmac: prevent disable controller in apmode stop

Kurt Lee (1):
  wifi: brcmfmac: Improve the delay during scan

Ting-Ying Li (2):
  wifi: brcmfmac: don't allow arp/nd offload to be enabled if ap mode
    exists
  wifi: brcmfmac: revise SoftAP channel setting

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 45 ++++++++++++-------
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  1 +
 .../broadcom/brcm80211/brcmfmac/core.c        |  5 +++
 3 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.25.0



Return-Path: <linux-wireless+bounces-15803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5029DE6CC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D86AB22390
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B51A00E7;
	Fri, 29 Nov 2024 12:58:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5F19D8A2;
	Fri, 29 Nov 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885106; cv=none; b=NdB4/8QK2vDVPd6G8CQrIKWeUfZa0MJGEwE2PfydrGSpZr8heYub+YiW3A5QwCzfRuTcVL3mHHSsn/Quy6vOvDEAYVqQQD6qmLMl32WZdlCno3SAsZ63Cv8wUemEzPzERjCYCIWq6/tTui//4SVkRmbb+/08ptBKAL8MM3+7Fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885106; c=relaxed/simple;
	bh=Vk6T5ntq83lK1TB+cG9bfXykiD9dvIdJrl3RbTb89Yc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogJOv70EEMj614d3xp35M4TA9XZhod2G28axHyy7F/R/uHYV13hqFPkHKX419rW2elunqf2yc7J0wzkO/8IvZ7DOwS+mFkLFounSp8Jlk7xrAH87RaGrahP+4O8IJCALrIi+fzdstHpD4bEDIO11zNn/u0Ey8+uE/qNx+980WfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 Nov
 2024 15:58:18 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 29 Nov
 2024 15:58:18 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Luca Coelho
	<luciano.coelho@intel.com>, Kalle Valo <kvalo@codeaurora.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Johannes
 Berg" <johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.4/5.10 0/1] Backport fix for CVE-2023-52531
Date: Fri, 29 Nov 2024 04:58:12 -0800
Message-ID: <20241129125813.25555-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This patch fixes CVE-2023-52531 [1] present in 5.4 and 5.10 stable
kernels. The vulnerability concerns flawed pointer arithmetic in
iwlwifi driver caused by use of spurious casting to (u8 *). Original
upstream commit [3] removed that cast but kept a change to increment
a pointer first and only then cast it to (void *) or other type.

However, as older branches did not receive commit 3827cb59b3b8
("iwlwifi: avoid void pointer arithmetic") [2], the aforementioned
kept change is also missing, which should be corrected and applied
to other vulnerable versions. This backport ensures that correction
and keeps away from dangerous void pointer arithmetic.

[PATCH 5.4/5.10 1/1] wifi: iwlwifi: mvm: Fix a memory corruption issue
Change 'channels' pointer before casting it to (void *).
Fixes [1].

[1] https://nvd.nist.gov/vuln/detail/cve-2023-52531
[2] https://github.com/torvalds/linux/commit/3827cb59b3b8ce4b1687385d35034dadcd90d7ce
[3] https://github.com/torvalds/linux/commit/8ba438ef3cacc4808a63ed0ce24d4f0942cfe55d


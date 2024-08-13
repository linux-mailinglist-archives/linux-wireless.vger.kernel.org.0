Return-Path: <linux-wireless+bounces-11376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F0950D44
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D4F1F22E92
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181B319CD13;
	Tue, 13 Aug 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="CyJCNmmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRJFsJWA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300E43AB0
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578005; cv=none; b=mtmYxBQAy2/F/epRe4OaqVx3a77NGQ1O8AvjCh/yLj7Gv2UGvhMJoUyAzv2tmIuYRC4N1ZD0X/95kGcAdDJM9RTuim2gq+ME/61UKnMlkLL2jpCma48xMdMYo2sXRKmd2nOjqHCxC9MW3pB/0LqRPl0YFSOIm2cTrZY2tjiBaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578005; c=relaxed/simple;
	bh=6FMkLcJgd4R3Of9SC8fwtAlhSNaCakdLaQa3MK25a4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kT8PErrF2z7LDG88RcAr2FH8Uy02XXoQhVHSm4dBIxS2Mj8uVfXaoYTzC4HZ2shYJ/Y1K3XquVA7BJDo1oKZSVtQSklShCoo+uBqNHqI5MIeE9MO5CdbsRR6wP9qV/n4p5B+qo7oGnukVDypPlL0eD6hC7MhG7/U1OZJKk2fZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=CyJCNmmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRJFsJWA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2D8EC138FCD2;
	Tue, 13 Aug 2024 15:40:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 15:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1723578002; x=1723664402; bh=EO
	9Tqzsuwl3wxc931KiR+Wfse5DDcRMICDxmR2dliRA=; b=CyJCNmmk72cnm64tdF
	aBdqCwEbJ5KEUuZwJK8NA7jV9M+Guy6h1mV2FQ7w4Em5ozWned2ng57Q6Xp+plb3
	M1/rg/Ix3no8fG7MjfqCBaI3nQJeIj4Q06/w6GYmeTrVT86ckAj6OCUcNzv0saMZ
	6CHKBDf9zIM5EAWWlcyOh2tys6pC3Jucy2K8i346d5huHm+FYRoK441tPqMly06c
	Nf03kQUUtXOdO6vVj0ooH+qKflnsJQT2+zeHLJRxkOx3lC49yhJU1YVnc0SMz2aM
	VhkNq0hkrHh5l2aUaQ3d6K6oivIRsLdlUN4w0MrYcJKw5DQ/PbdtOIQAEOoBkCt2
	mMcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723578002; x=1723664402; bh=EO9Tqzsuwl3wx
	c931KiR+Wfse5DDcRMICDxmR2dliRA=; b=eRJFsJWAe3tmgpRmb/Z3a6Lll4H/l
	U04zqPZ2qLUNTTQq/Z/CGKPRh8+AmU5/B7Qmrm1T7RHHnLWFBIBK2dhgPB1VpJj2
	trgTEqSQ3/LxrYgFKJm/KVY0AqErQ1MofXplL1JtCZ6xVREMMUMnp0N2iU+PgBAJ
	/XdBXpI6c4VrdW+EH6urhVZ6MbO6+nRvN3kflx3V/9D2kT/t5Vk3lOFYrwa2hHdl
	aowjzs0NtDIvQXQpjzRZytMs0cHXIvWM0hGrWWkDPT5x8M8VpvxeWc1OH6Vx/wIv
	qVeNtfmeO8f9l2hMJ9WbkZAxaFq8AiMIkYHOn9Rywe7PYkBs9oAt4DHDw==
X-ME-Sender: <xms:kra7ZpOyJjHTJ69EUbtC16SrkTxZthGQCjU7qog0oCeJJeYv7VIQuA>
    <xme:kra7Zr82ZBOCm9sb-X-F-D2tl-ybAkAzVs2QHYePBKGczBf_Ud2dDROqvLUyXyVpc
    C7urnnVH3CZuoYpFmU>
X-ME-Received: <xmr:kra7ZoRBT1yWYGJLXk6Ik0wDvjfERXsX6XA-LMKYrl7PhDc-Kgatj3ZeqCUZz-wLXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhmqeenucggtffrrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefh
    uefggedvueeujeekjeetkeekvdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
    rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohephedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomhdprhgtphhtthhopeifvghnsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepqhhuihgtpghjjhhohhhnshhonhesqhhuihgtihhntgdrtghomhdprhgtph
    htthhopeifihhrvghlvghsshdqrhgvghgusgeslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrgh
X-ME-Proxy: <xmx:kra7ZlvpLqUIHZ5f00IUZu1JGmgpwjKHG_Fc8GIhSo-WjImgXHrzRA>
    <xmx:kra7ZhfiyMD7OSIHgHr0t7zrj46MzKqnEAuFRDrE6KZ7xHSZr-ZZuA>
    <xmx:kra7Zh2Kw3CnxIccyEPQ-odUWJWC-aDtDrVoqTiiILgTupGqluG2Yg>
    <xmx:kra7Zt9tsZwmPuq5X3tfhIb3Um0YEZtaKQ-3F5HCa_K-Ja_NB7bfFQ>
    <xmx:kra7ZqELFKnzwIVwaTN1Bhu7au8z4mTlg3z9RvokXExfVm3gC5yMGM2P>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 15:39:59 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/2] wireless-regdb: Workflow updates
Date: Tue, 13 Aug 2024 20:39:38 +0100
Message-Id: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHq2u2YC/23MQQ6CMBCF4auQWVszbdGAK+9hWDR0BhqRmpYUC
 endraxd/i8v3w6RgqMIt2qHQMlF5+cS6lRBP5p5IOFsaVCoamykFqsPT578KlppySJjY2sJ5f4
 OxO5zUI+u9Oji4sN2yEn+1j9IkgKF5qtmJNPaC9952gZvlnPvX9DlnL/1Lv8NogAAAA==
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=750;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6FMkLcJgd4R3Of9SC8fwtAlhSNaCakdLaQa3MK25a4w=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTd2/pXOs95c/jdl1UyeWWn9E7dentQRjlnjt7zMNH3t
 2zWLON901HKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQAT0bVlZJh6wTnwRcKPytg6
 vprwGxvLDuhuXC2y/xdD9oqHz5btW7OD4b/DiZ/FK70NfmQurigr3B3sseAgx/H0I5pbPaS+hE7
 ews4JAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series updated some workflow components to streamline
wireless-regdb contributor experiences.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- v2: Swap Cc and to, Cc wireless-regdb@lists.infradead.org (Jeff)
- Link to v1: https://lore.kernel.org/r/20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com

---
Jiaxun Yang (2):
      wireless-regdb: Update .gitignore
      wireless-regdb: Add .b4-config

 .b4-config |  5 +++++
 .gitignore | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)
---
base-commit: 003c282a297f8cec06a576fe1434c94353d14610
change-id: 20240813-workflow-91ded0f08d41

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>



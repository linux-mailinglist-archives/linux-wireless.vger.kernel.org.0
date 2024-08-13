Return-Path: <linux-wireless+bounces-11355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC9B95093D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17939283F4E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D81A0724;
	Tue, 13 Aug 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="N/aSA1ph";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qnb/zW2X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40051991BE
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563495; cv=none; b=MPkDvw9Ozc1w51sRjxdYBmDHxHxqRKo8vqDR4YgjVggGpkAtvRnJrjlucO3m0KeVtm5KwqsMEU+Z3gWqGSUTGL9j5LAtdr77LQ1wELY4VrOnTpRrWeaGXzbs2GL98iufJl3CqPooZD4szkYx/wqWPhhEBkSXQMEoa5rRVKXh7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563495; c=relaxed/simple;
	bh=UEM/gz1F+o1KOzYKkxQhch5syqQHI7YpP6usD3piCrQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u3IV1BUaB6mvQgvkmx71J861LN3C50EHSPmU4x8eUawdQN31J1xRUSya0UeNv6LCiwK9gg8/x2GxyS1PRpYV/OylrDh7Z33920IQIuKuIQILNiVXVR/pBeIYZTkzkP2Qx6Ph8cfufZFuMVcaO3PNNG+b6NGHp+hom9Vza3QlvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=N/aSA1ph; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qnb/zW2X; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CC980114AB33;
	Tue, 13 Aug 2024 11:38:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 11:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1723563492; x=1723649892; bh=1S
	0e44igYOdcuL37Pr3PBkUYmsfefCgIcRPPtJJJ4h8=; b=N/aSA1ph8xIoSOasZd
	olrK7vQJbNTof9cZSzw6763zYMfHkroYg8aXS+PmWb2Pjj9PdH30HMbOjUcNx1l9
	lJn00OL5ZvCXNST0qRP42GWk6iwH/2sKgHNlMbV0h8kYu53f/Dq3B25QZKTTV+NC
	5BrMnzbt/p2808OXKZDyJyklUgnQvRWFBlvx36vgYczT4kOEvpXzBV8AxsNqvhWM
	bY4sIHKmTLlEqDuLMFdtL2qM8nyRsOYjNInXrRM7ecAImINDWnF/FL5oxr/Ym44U
	oZox/CNx/c3oa9MzRmm1cpHzesoGcLDa4RPseLTNypcKRasuTsE++d2iyoiixCsV
	JfoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723563492; x=1723649892; bh=1S0e44igYOdcu
	L37Pr3PBkUYmsfefCgIcRPPtJJJ4h8=; b=qnb/zW2XSjgXeTHxWx/8+g4KLuovR
	t2i6AWXVLOndPMMjEln5oyassnn7Qdku2Wq6rZy0Oq6B0bdWAX3Rorp2GYKr2nAD
	dHGoMJQra5uDsk9jVt2ZlyQcUIRX2EqM+rr43Uda7lXUwoPgR1yyQduGtbmsGI0x
	ZZ8yZ/6UxhGXw10mBkKqovndPG44HJHyWntMRYooKS04VcY66JNXYSse0N/3zIcK
	96S9dA+UKqBmyMrSRc1cOFFtJNzKH3uWQB5vdFfPRmClnvAlG6lcOXy6qopKbvgG
	fbx2nHbFgVS1v95M+RrJOvUWA5ddZqzWUuqpwJoWWw1ckireOwkDKdfXw==
X-ME-Sender: <xms:5H27ZrhDddsxiJQJZXZlLpDgsRQL-Vd5L1ekJFnD2yiS5krh7q9c0A>
    <xme:5H27ZoBBWxGhGFI9kBAx9Xf0uIVQoqh0XPjHJ7d7UndOMah1aQ4wYZddb0SCNwhuK
    qeGBFOv5p-IIFgpZhU>
X-ME-Received: <xmr:5H27ZrE7FLr1apIC3gl2sbtOP8UF5VV8nhH14qGiPf9pmULs0fF2QoD6JinANELbKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehj
    ihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dufffffffhueehvefhgfelveekueegteefgeeiieejheefkeehkeevudevieegueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunh
    drhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghnsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:5H27ZoTcTTLAYkkFewMI09vLDoNitUJIgiph8qWc5z8JBOb_vcq4ag>
    <xmx:5H27ZoxAOV2halkN7XU-cLC3JU3bxHKVjEoKihOuVCx67UJbF9wDQg>
    <xmx:5H27Zu7fVIv0frdlgWOzI61zFKk8jN1aDkeZxktHX-ORq-S7Pn5QCQ>
    <xmx:5H27Zty9WNrGKIe-NPvQN3XQfpsdV0qR8HVuVBdoO6NQM-_fDPTaFw>
    <xmx:5H27Zk8VFMJxK6xEnalPNemkiUb2AtZVJB5pwsfd83_tjqfeAVwSJj7u>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:38:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] wireless-regdb: Workflow updates
Date: Tue, 13 Aug 2024 16:38:07 +0100
Message-Id: <20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN99u2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Nj3fL8ouy0nPxyXUvDlNQUgzQDixQTQyWg8oKi1LTMCrBR0bG1tQA
 lhA8LWgAAAA==
To: linux-wireless@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=570;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=UEM/gz1F+o1KOzYKkxQhch5syqQHI7YpP6usD3piCrQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTdtU/Ctq/zDXd/dd/+6OLW6V0H4twvMeUmT1od+sIiT
 2jenZJdHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARjnOMDCtYj17PipbMC69m
 CHu2IvJCo3d95B7jOkWjb7XH3+w+68HIsMHK9uAy4YJHya9bfrC+bml5bHmI7egm5Tq25VeubK7
 9ywcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series updated some workflow components to streamline
wireless-regdb contributor experiences.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
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



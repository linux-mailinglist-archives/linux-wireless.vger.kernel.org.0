Return-Path: <linux-wireless+bounces-11377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D1950D45
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204192845AB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26C43AB0;
	Tue, 13 Aug 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="H0fs40DD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBc/6Y/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA01A01CA
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578006; cv=none; b=lvYhvCLhgS9yguwQgA73Zko64u9biGNtZzvc+aI7cybzZf3vgPyp1KjQFnKe/Q7G70yonKri9bwCQg23rIaWfKJ8/iTl38rjLOsR1mRsiZVScutt3Vhx+xIUAi2aEa6lCb35mh+0I4rGVNSbzJuogAGMwwyL68C3Jyn221p+D5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578006; c=relaxed/simple;
	bh=WFEja1uNIEQQnHxNCRa/a5OW659QANnd9J89AeXwSxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAymHrMO4Wt6l/6Vxz1rpZk3psmgizj1hH8ouq3OeoD3Lnwv6/nttsnYV8IPRrJYmGqNlaLmZDuosV/MWngPG8UNPAssjaEBkoN2fo1M1yQwxYvMpAo7tJoLyhWvvlGMX9SwwnO+aK7atZghExvMuHXeBuz72Ny7dmH0/yixWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=H0fs40DD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBc/6Y/q; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 898D3138FBA9;
	Tue, 13 Aug 2024 15:40:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 15:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723578004;
	 x=1723664404; bh=A1fA0wCHKHB4VAu8A0xNIa0V/GUCD3lKKomB1JL3bD0=; b=
	H0fs40DDslqqxv4EcFfv5KpGezsLAEUV9o4h83Qg7yeFheeETAEa6xLtJb4yQ/I7
	oJmqzqbliG+coS+2KTk1fH+EzFneexpvWEiFvMOGOygo4Cc1lLc63AVHWHLGQI2K
	czQBFS4/Ujmv9ZugHz5JxFqXjluIlbLjgr2z+QRVGDHx6Y5yLHO39TnuAcSsFNGN
	BQod5bGXRhRj9yJZkvhlNEdvPge1CKZfg+yhiHj0WjfouXXweJygJ+e4VbL4O63Z
	FJYKTkKFP6tSPhkzTHQIqb/EScyoEqnecLvLzRfFM0VxWfZXOG/FWeSO3WYyrkpZ
	KgxkcBQ5XdOY5pum6qEUWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723578004; x=
	1723664404; bh=A1fA0wCHKHB4VAu8A0xNIa0V/GUCD3lKKomB1JL3bD0=; b=e
	Bc/6Y/qRo/Oh90B9MdiXR8c71UlGbqFPgW3GWF/ZoB8Giav3mUF327EwQVwRVcs8
	d7fLwhJnJUIHRG2Q6imghxrM0fm2jTBRaXwMGQusS8ED0sopYEZXh149MI3iXT99
	t6ryRQ926cktdlNvQOJwa6UoqVoaURWEL3Qzy4XQyixkOO3e8/St3h7EMpBwpJ/k
	h/X2+aljA7aWaTx0EGBwyNWQ0zUvKYY9GqM97t6FqzoeDpxl32F7BD6Rz9l8re0+
	7/ie685sAI9L3slhZrEvVl7dKMnSUWqI/NnNXqGgIMm9y17t6ssB9LCBWDztv9EF
	uhSIFN/Mo9bNMYcI/1BkQ==
X-ME-Sender: <xms:lLa7ZjjVJxqLs-gI8nCi3Ulrdss_cMR4Qt0Foh16Pioas0qRC1An-g>
    <xme:lLa7ZgA1HFSoUi3KSpMtq9oTPXAa6ynaxgsPbLdAnvVKfcWlE_jUFgQPs63eg_zW4
    DIHmFurNMpyI3FTU3o>
X-ME-Received: <xmr:lLa7ZjHpAPso6LorXWc76t5igxS95tY8kPwHd0aGHqKuQQRyPI39lvBeWfU2khUYkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejleeluefhjeelteeggeelteev
    gffffeetiedttedvvdekhffggeeftddukedtheenucffohhmrghinhepkhgvhidrphhusg
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
    gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmpdhrtghpthhtohepfigvnhhssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehquhhitggpjhhjohhhnhhsohhnsehquhhitghinhgtrdgtohhmpdhrtghpth
    htohepfihirhgvlhgvshhsqdhrvghguggssehlihhsthhsrdhinhhfrhgruggvrggurdho
    rhhg
X-ME-Proxy: <xmx:lLa7ZgS89GzBmVcDfVrtGw-7Fc7zI_IJ7HfYx3qh1cJO_DQrYPinzQ>
    <xmx:lLa7ZgxqE02QG0nA1qQHhXeQULmqEkmUozfJD8DHLAh_uKSfg2ii2g>
    <xmx:lLa7Zm6Lge51ogsExtxhRNq2tonGcSdNviby4h8MTecGiaPhOpGWlw>
    <xmx:lLa7ZlzDclCpNX8VzW-6AtLpwkBRMtKgswr4PrqQ0tjdHVxaZhV_Hg>
    <xmx:lLa7ZvqtEq5Z9mqGTeaCmb270h99ELjeQdWN1rmoS8fmpBaO81Xzy1wg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 15:40:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 13 Aug 2024 20:39:39 +0100
Subject: [PATCH v2 1/2] wireless-regdb: Update .gitignore
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-workflow-v2-1-6d8039283d45@flygoat.com>
References: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
In-Reply-To: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=506;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=WFEja1uNIEQQnHxNCRa/a5OW659QANnd9J89AeXwSxs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTd2/odfh5/HjPjVr/Q+1UcabqR+3+6vS2ZNWH7ZePzs
 +Ly4lLaOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiuwUZGRbXnRB5xcralfA8
 jrV4+5cN379Zl9dKvml05bXZJSRp2M/IcDPcXV3y1CVHTs+ZfUIiq8SObfOVerkwYnr8Lac9fWk
 6jAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Update .gitignore to ignore Python cache files and other
intermediate files.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .gitignore | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index a59d40833aa0..496247bfdbd1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,9 @@
-key.priv.pem
-dbparse.pyc
+__pycache__/
+*.py[cod]
+*$py.class
+
+.custom
+!wens.key.pub.pem
+!wens.x509.pem
+*.pem
+*.patch

-- 
2.46.0



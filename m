Return-Path: <linux-wireless+bounces-21442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A297BA85A24
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 12:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7151BA4969
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6B1EA7F1;
	Fri, 11 Apr 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c4BJ1PAt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o0KdoMZV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752331E8356
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367792; cv=none; b=nSEbZhUiu1wlgRzk8dDWJ7ewMu8BalKxx15pQmy1xuvpeo0me/2N3T0V3qpb1vc+dcqG9uGuXmOp2Zcv9gOUqSSPxfyqIOsZ3AGNq4j7keEJ4fVKmiNNw/2Rms6iYm5aTwtqp0mpU0t1HptZH7+VBytHHFuB6pgdxi1nNGA/hlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367792; c=relaxed/simple;
	bh=KDac7aDBmqsxIwXbDbYL0E8gp2Dr9UPsHDuYrUvuwP0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KsCE2ncSZoVRz6gkzYHAZ+yNyn3yX7v8bT4lIdiEeB2jo/zyKo5o2EhgThqmuELmkIqPSUrwQPlclwPvYDJA1/CLzcBhJjUtz8+IaxdGfDA83EGR6Y9hN/8XxfyM6E1gnv30Zt82Klhp24Zhj4x6atcuJfeFK1mVmCGGckmuzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c4BJ1PAt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o0KdoMZV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E2FC138029E;
	Fri, 11 Apr 2025 06:36:28 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Fri, 11 Apr 2025 06:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744367788;
	 x=1744454188; bh=w6jcXGwJdlsmQMTJ+Qf/4O1sk4HbATpIUFxuCTK5oYE=; b=
	c4BJ1PAtNKiPhV+lLd6ViCYmdgV+OzfiU8Cb3RFu2hnNusbP7K4H6SSQ/9WbRwbk
	u8P8tzK2Xux6e74MU8ul5nVLTCW5kLSVnaVyKp6shTZOxs/ngQfQGAJY37DswKN/
	tB4PEHqq2sJOidwacgu8P0++XVNGr6aXbxdY6R0k+lMbtG3PxpfhGnqUcUCx9IJa
	dMLodLAgDxo5LhtdDM+v7PS/99vZM/IuyxgYTigNVZnkdPXAtB19D3igTU+F38rP
	rj8Ejj+/vavhdrKjxfHFiYIck+TMrZaTMoOT0YaV+XZgHif0urU7KHYW/foGPsnj
	otJs5SRRtFwR5V5ERu6jkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744367788; x=
	1744454188; bh=w6jcXGwJdlsmQMTJ+Qf/4O1sk4HbATpIUFxuCTK5oYE=; b=o
	0KdoMZVN5U/N3MGRJiWDUtBoaUxVnlqynJqzIoWA4c3nHAcKGbDyI/eyZGB6wDUi
	hd4F7IRX7Qqa8bwolWBiuOxy1PaFZhsT6ZxmrYB1Ma+mh6Ugo+++nyaNtDPFrqEW
	gOTviTxlVMUAenvEmdhvnzSJEzEARFVGlI79fB4Sa233DDOQBqmvl8ehd5/bgyrB
	VlOWXpfnnRqRsrQGs+tWxhlmZkACQ4ga4y8iX0E/hP7ysiskqWo4goscrbmTTWiH
	8xrpn/KXGZld3ozkTtUZCLXlegH8ZS+yqPBFaxD+Vis+HYyESAVb0T9pzWBCZ9A1
	eQk9WPXEOnFvW/Gx3oWqg==
X-ME-Sender: <xms:rPD4Z_bC7ykH4_3U9BEA-N5DaR7GH6QgJY_YuttQX82PRvNW9RJlKQ>
    <xme:rPD4Z-Yi_ZrdLtWbNwGU4JdZiybSbylOAoZarlpiZRw1i1ZkhYipl0R7RCDL2UWgN
    oRT39bHuNpz78cAiUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheprghvrhgrhhgrmhdrshhtvghrnhesihhnthgvlhdrtghomhdprhgtphht
    thhopegsvghnjhgrmhhinhdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepug
    grnhhivghlrdhgrggsrgihsehinhhtvghlrdgtohhmpdhrtghpthhtohepvghmmhgrnhhu
    vghlrdhgrhhumhgsrggthhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhirhhirghmrdhrrggt
    hhgvlhdrkhhorhgvnhgslhhithesihhnthgvlhdrtghomhdprhgtphhtthhopehprghgrg
    gurghlrgdrhigvshhurdgrnhhjrghnvgihuhhluhesihhnthgvlhdrtghomhdprhgtphht
    thhopehshhgruhhlrdhtrhhivggsihhtiiesihhnthgvlhdrtghomhdprhgtphhtthhope
    ihvgguihguhigrrdgsvghnrdhshhhimhholhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:rPD4Zx_YigKXbyJgu-J5nz4SJ9qozcNBjeDD7CGElbUT2E0fRQeo6A>
    <xmx:rPD4Z1pLwTaNCPEEblxChkekW5RxoEAz7_ui6wW_hdo_kikBXwQMCA>
    <xmx:rPD4Z6q1O7lEDJyfCf_mqdzrM2iHCIEFIqIR0f8pO48g6gAnYTU2hA>
    <xmx:rPD4Z7SxQelDVh0bVGNPJoabdinbTQmnKBsnMkxogEoMA-UUmFWI-g>
    <xmx:rPD4Z1Gwf5SH51NrJK5FpE9onFwUZ7ag6_WDRlCcAuQmzClAv-bvHYXo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F39D12220074; Fri, 11 Apr 2025 06:36:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T56def0bf1130cc2a
Date: Fri, 11 Apr 2025 12:36:07 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Wunner" <lukas@wunner.de>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Johannes Berg" <johannes.berg@intel.com>,
 "Emmanuel Grumbach" <emmanuel.grumbach@intel.com>,
 "Benjamin Berg" <benjamin.berg@intel.com>,
 "Yedidya Benshimol" <yedidya.ben.shimol@intel.com>,
 "Avraham Stern" <avraham.stern@intel.com>,
 "Daniel Gabay" <daniel.gabay@intel.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 "Shaul Triebitz" <shaul.triebitz@intel.com>
Cc: linux-wireless@vger.kernel.org
Message-Id: <f20993d9-642c-4904-b231-5ec671a24cab@app.fastmail.com>
In-Reply-To: 
 <d3ba1006a1b72ceb58c593fa62b9bd7c73e2e4ed.1744366815.git.lukas@wunner.de>
References: 
 <d3ba1006a1b72ceb58c593fa62b9bd7c73e2e4ed.1744366815.git.lukas@wunner.de>
Subject: Re: [PATCH] wifi: iwlwifi: mld: Restart firmware on iwl_mld_no_wowlan_resume()
 error
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 11, 2025, at 12:21, Lukas Wunner wrote:
> Commit 44605365f935 ("iwlwifi: mld: fix building with CONFIG_PM_SLEEP
> disabled") sought to fix build breakage, but inadvertently introduced
> a new issue:
>
> iwl_mld_mac80211_start() no longer calls iwl_mld_start_fw() after having
> called iwl_mld_stop_fw() in the error path of iwl_mld_no_wowlan_resume().
>
> Fix it.
>
> Fixes: 44605365f935 ("iwlwifi: mld: fix building with CONFIG_PM_SLEEP 
> disabled")
> Reported-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Closes: 
> https://lore.kernel.org/r/MW5PR11MB58106D6BC6403845C330C7AAA3A22@MW5PR11MB5810.namprd11.prod.outlook.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sorry I messed this up.

    Arnd


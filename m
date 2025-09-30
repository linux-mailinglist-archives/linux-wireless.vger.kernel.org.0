Return-Path: <linux-wireless+bounces-27756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2CBAE3DD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 19:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCAF1C705B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36211F5851;
	Tue, 30 Sep 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tYXMtc5m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315811AB6F1;
	Tue, 30 Sep 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254379; cv=none; b=XttIB1xwJvKaJ0x4Oly10GwpPy1nCoyKwIq1wj9TXjvxGqlVKo+WhNP677A8liLcKgbeDyvFMA+bkJJC8Kcwcyq4zZujdv7LJSi4BACubD6p34ImiuLx73Xy2YLM1CGdba7/Sw6fQtZvJ+j292mUEX12MGUpUi2hXD4qyhWj0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254379; c=relaxed/simple;
	bh=zz03I6x3SZ1c5shpdJBPG+orEiB1cBdPqgBG2innHec=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjVXhdg1yfcGedfvn9pKsz7/lvVnasgZyjBjIVv2yMjLXiHjxTLvhRp1mhPIB23AN3Gh982lUveDUIC/cfppIkJZtlmwwFcCznldPVf3VFMBshuLo9VLVIGbDHqUvrCq2mEAVdQiHrVXh49CWA+k57VS06rPbooymVH4Mz2F8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tYXMtc5m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zz03I6x3SZ1c5shpdJBPG+orEiB1cBdPqgBG2innHec=;
	t=1759254378; x=1760463978; b=tYXMtc5mmYpg2Ii8cdWp1Qu2fbUsv9JMOUhFxT3FDs9ZpCH
	FT2VxVJXCf5swszG5ValMxBxeFNZzjXkoVMIjO1AIlb43hO0pCNaihcgO1AYBeLAne2u1DqnLTrzF
	ahR5A+XfiZafEOcrofVJcMuy817gxkjpiM7UWdFFNSObGEZkdY8tk2TmyfjU5NOPgNeiOWR+qVUee
	qBsuNsZIaQA9wS4zgHS9VZYR5hPddyZp2habUj9DFkZR0fCp2wwxw3zCK8uY8aqoCumGUEm6EqgSY
	UZhI3NJkzmptWMJufQ+RzZbmSSPKnIBEquj1zdMJUuaW61wQxBsJomqAG3RM8ZyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v3eQZ-00000004FSS-1IyP;
	Tue, 30 Sep 2025 19:46:15 +0200
Message-ID: <84ae297189da94d306b59c6c518cfceaf0176bae.camel@sipsolutions.net>
Subject: Re: Module param requested for module mac80211 to disable frame
 80211h (txpower and country)
From: Johannes Berg <johannes@sipsolutions.net>
To: cybersnow_2001@tutamail.com, Linux Wireless
 <linux-wireless@vger.kernel.org>,  Netdev <netdev@vger.kernel.org>
Date: Tue, 30 Sep 2025 19:46:14 +0200
In-Reply-To: <OaQhzY6--F-9@tutamail.com>
References: <OaQhzY6--F-9@tutamail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-09-30 at 19:42 +0200, cybersnow_2001@tutamail.com wrote:
> I request a module param requested for module mac80211 to disable frame 8=
0211h.

No. We're not adding module parameters any more.

johannes


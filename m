Return-Path: <linux-wireless+bounces-19073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58346A38D50
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 21:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42753188F60B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3F22688A;
	Mon, 17 Feb 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b="X9q3tq6+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mobintestserver.ir (mobintestserver.ir [138.199.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9219048F
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.199.196.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824266; cv=none; b=lKKfU1YdENdTcckPt8WyUwev7qYLcgzwS8cLaLJ5jQa9aPiq0ycUosF8G5RqX9pNVZ6+AB4RMVeX7CHDsvAAusEXmQHAbM3LoCAVSo+KKegzVl21n9b0rdQbPH4tlgybdv2XG1t8h8OJ3I6uuZJXiCK5hT3hUTmBOHR4v2QELFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824266; c=relaxed/simple;
	bh=6TFSCyZPa9K3TSAtbvQ0bWAA1mUMGmPtjART2Y+XAk0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UUulKSnw+R2CYMRR5PMPqe+rA9ipaaCFOlCLUtX5KzF3jv0tFo3YVdha+IkhaQDtSR2s8uLwNBSqJQ5uu6O/Uk/kA413CS2lUn1TU/jDoIMaL+EBu0cdoOS6rSt303Qp26+lfOv+l5FAlvhrk1fCQ04HI73XHGqdGvLS3MhPtqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir; spf=pass smtp.mailfrom=mobintestserver.ir; dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b=X9q3tq6+; arc=none smtp.client-ip=138.199.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobintestserver.ir
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=dkim; bh=6TFSCyZPa9K3TSA
	tbvQ0bWAA1mUMGmPtjART2Y+XAk0=; h=subject:from:cc:to:date;
	d=mobintestserver.ir; b=X9q3tq6+EhfufyB7cyOR1fIjnsO1oULcZtREr64ojG5Npw
	3Q8oMQnliaS04tzOhwnrejGyqUqE8gInXASqxMUZ5I87UrghwUilapJlXq0S58atmymlXq
	tEFCMahedyfVmZIDJ8P6B9xaTjdY0x1gQ22A2HT+GUU9MoVbZC3IJ8NcfH6HnIn7nTA1A6
	2EfJ4I9tU3mPjbl1tvleMFEeVyVhnRLQS7NUuTN+IJo5qD8y6r4uA2bWWRI7YAChtpwdnS
	9EKxXDRqiHzq5RiiIkUNOeFtpafFHWjEGR+bJsSL6qsc7YKzR+ZnbFHIRQdH2c2Ol1a0AX
	VPaiB2StwBBclxIw==
Received: 
	by mobintestserver.ir (OpenSMTPD) with ESMTPSA id b183fba8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 20:24:20 +0000 (UTC)
Message-ID: <c9ccf5ba-c091-45c4-9283-970bfa4f1afe@mobintestserver.ir>
Date: Mon, 17 Feb 2025 23:54:14 +0330
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
From: Mobin Aydinfar <mobin@mobintestserver.ir>
Subject: wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and
 5Ghz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi. I checked the wireless-regdb for Iran Wi-Fi frequencies and It 
doesn't have any source. I checked the local regulatory docs about WAS 
and looks like the regdb doesn't comply to it.

The official link is 
https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899 
which is inaccessible from outside of Iran.

A mirror version is hosted by me: 
https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
(The relevant table is in Page 8, The document is in Persian).

A translated version of mentioned table is here: 
https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods

I'm looking to update the regdb but I don't know much about Wi-Fi 
frequencies, So I sent this message as a call for help.

Best Regards


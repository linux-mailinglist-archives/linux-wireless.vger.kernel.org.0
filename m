Return-Path: <linux-wireless+bounces-35280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJHwOO+H62lBNwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 17:10:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94300460884
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A74E3009F95
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523882C027C;
	Fri, 24 Apr 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="pjAdZdoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9A2BDC13;
	Fri, 24 Apr 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043436; cv=none; b=nJCKoiPVSGIxuftkFFqx6F1JumNs+mhlr/cuWpS1BtfkNtQDEkiM9/DQYBx0J2LovR/b4qc383/KZTz7Q0DScbwhWV2FTC6V6nTPf5fGlKMTi5hYpHU4tcsaOqgFjsubrL5dIsaNltSEaPepb0bBQ/MqLEiW2r/ozDv0mLlJiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043436; c=relaxed/simple;
	bh=5MYXW1uttoTu1vXousTNqjD13y7aH/MxxWO2uDBrEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJsl8hJ8bJ4vnPWyZjYiE+1op+krw7jWw+c3SZsln4h3OEL4UGFg1aaU6Geryj2Qdx8ICCmn46JYVtIIBYNTnCa80VH+B0eOvOmkBN46UClTRysxrXRf0XNjiuC5XbXhNOqblGcxB0TtuHI5Llk2ukMvN9M6fhENl1NOMsP8o2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=pjAdZdoT; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4g2Gc82pqGzDq6T;
	Fri, 24 Apr 2026 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1777043432; bh=SB+7sytiJrz+IBEYLdZpkqol/yi+0XTJuxrciQQ6nB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjAdZdoTdOhAUZ8PWypgg8rv2AMA8YH+m0vc+/CYhXexg3q/Syh/KFxbGqHTna9EF
	 K7arQ3yrHPpRlqUotJ8ZgAa2S6cTRVgCi3JGksPVDO109oGTBm2vAMpMAiYI/HVAm/
	 z9JDlBYEZjQB2nggNoFPrMMg/y+SnPJ9zkwIJEF8=
X-Riseup-User-ID: 7B37399610335E7FAE1B027EA79580CEA696040A5320EB4D035349338FC95F65
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4g2Gbw21nbz23Qn;
	Fri, 24 Apr 2026 15:10:20 +0000 (UTC)
Date: Fri, 24 Apr 2026 12:10:17 -0300
From: Santiago Ruano =?iso-8859-1?Q?Rinc=F3n?= <santiagorr@riseup.net>
To: Kyle Farnung <kfarnung@outlook.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"koike@igalia.com" <koike@igalia.com>,
	Kyle Farnung <kfarnung@gmail.com>, 1132343@bugs.debian.org
Subject: Re: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk
 table
Message-ID: <aeuH2chCSi57RYVU@voleno>
References: <20260423211458.458911-1-santiagorr@riseup.net>
 <IA2P223MB1199153665E2AFF709BD2F52D02B2@IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA2P223MB1199153665E2AFF709BD2F52D02B2@IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 94300460884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35280-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,squebb.ca,igalia.com,gmail.com,bugs.debian.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[santiagorr@riseup.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[riseup.net:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,infradead.org:email,outlook.com:email,lenovo.com:url,riseup.net:dkim,riseup.net:email]

El 24/04/26 a las 02:07, Kyle Farnung escribió:
> > From: Santiago Ruano Rincón <santiagorr@riseup.net>
> > Sent: Thursday, April 23, 2026 2:14 PM
> > To: Jeff Johnson; linux-wireless@vger.kernel.org; ath11k@lists.infradead.org; linux-kernel@vger.kernel.org
> > Cc: Mark Pearson; kfarnung@outlook.com; koike@igalia.com
> > Subject: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk table
> > 
> > Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
> > table") added some Lenovo platform IDs to the quirk table to address a
> > wakeup from suspend issue [1].  However, at least two more platform ID
> > are missing in that table: P14s Gen 5 AMD, as reported by Kyle Farnung [2]
> > and P14s Gen 3 AMD.  This commit adds one ID for each.
> > 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=219196#c23
> > 
> > Tested-on: P14s G3 AMD.
> 
> Lenovo products have a pair of IDs, you'll want 21J6 [3] and 21MF [4] as
> well. I submitted a patch myself [5], but I've been investigating another
> symptom.

Thanks for the notice. I will adapt my patch to remove the conflict with yours.

> 
> I have the same "wake on power removed" issue, but I have another issue
> that's more annoying where the wifi just dies randomly. I only have the
> wake issue when power is disconnected, not when power is connected again.
> I mostly leave my device connected, so I only realized the behavior while
> doing the regression testing requested in the other patch.

I've also been hit by a similar annoying wifi randomly dying issue that
you describe [deb#1132343].  With the patch that I attached applied to
7.0.0, my P14s G3 AMD laptop has been running for more that 3 days, with
several suspends / weak ups, either with power connected or
disconnected.  And I haven't encountered that problem since it booted so
I concluded that the patch fixed it.  But chances are that I am wrong.

[deb#1132343] https://bugs.debian.org/1132343

The latest bad version I tested where the wifi died was 6.9.11.  I plan
test the patch on top of it.

> 
> [3] https://pcsupport.lenovo.com/jm/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-3-type-21j5-21j6/21j5
> [4] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/21me/21me000pge
> [5] https://lore.kernel.org/all/ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com/

[snip]


Return-Path: <linux-wireless+bounces-2349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8B837511
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71768288866
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9047F70;
	Mon, 22 Jan 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="S4QMVzRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAD47F71
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958026; cv=none; b=O4laK0kE1AqR5APgGvWsdBeK55AVrP0V49x49xvFKzSR8PNvc8JceWbeRhJm4f8QIHdnvNI2IqLIdMtsSTpPLoPyIcxQ6vDB0cWFtueSAjlhnQHPFEvkrhBVCywOGVeevCpcAhwxGxn/LAnKXI7MB8/yzovLghRxGfb5cb2+fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958026; c=relaxed/simple;
	bh=r7CGgSo5ObfcEo2qSIcjyW2N8YDENbfyTS1FB0v1VNg=;
	h=From:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=G4OWeHFB95cQsWQYTaZoMPRrZ/RTXgQlPuRHojvlph9lJYqFjU86wzPuCnKSeWdbBOL6Zz3bkeKucHJVQbQKxl7K8UgrOkkTU4pnq1A1K1oteKiLOgY1MmVDmZtF8NEGWt7PVvZvngqtco63e8Q0PQm+j0Hh5A4ihiX7/tYQ/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=S4QMVzRh; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=sgd; bh=fXAtio/37FxIxTMOzQi0Ec/EtHyJTKOAvAuxfbcO6AU=;
	b=S4QMVzRh5G4N2DviO+rQUIWK5ywJPRibziWZXKLPOJT0Urh6eKcz1HVtM2RRMCG3sjsf
	LmkJgK2yKbOezhRMBcK7ggB/mOlh4HEisZLduP7CNS7fCJG9Jt8+mgq92VjK7+LGRzCYkY
	jWHlPSs2udnGJt3xGs2gt8f5EMeEbW3iQIt8VA4tWKnZ6mTZ0UIt/wP3f3WWCbxkOXfxV8
	TpHag8jL2LSq2KSNQU6B5sWr+CRFPU7yTqtqK5SLfvADEj/adsanZd5giS91QF/yiok7Hg
	CU0yFUr4E3EAwuCHZmy95sKxRhFN9qlYMR4z6d0OIR0eV3ahFXA5ZyYvKJcglG/w==
Received: by filterdrecv-6b68c9f446-z285k with SMTP id filterdrecv-6b68c9f446-z285k-1-65AEDA87-6
        2024-01-22 21:13:43.471905582 +0000 UTC m=+8389972.045549197
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-0 (SG) with ESMTP
	id wZT15jPeQSaGE0Ypag1d7A
	Mon, 22 Jan 2024 21:13:43.330 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id 66FC7700494; Mon, 22 Jan 2024 14:13:42 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
Date: Mon, 22 Jan 2024 21:13:43 +0000 (UTC)
Message-Id: <20240122211315.1444880-1-davidm@egauge.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5ff15ae65ccb7c144ba8e0f07dc2ac25bd8b2b42.camel@egauge.net>
References: <5ff15ae65ccb7c144ba8e0f07dc2ac25bd8b2b42.camel@egauge.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvIxBYR1oGS8q0gFS0?=
 =?us-ascii?Q?FUVQZ2gFb=2F8Rw5Tf0Ov35EXTE+IEHKPNivu6+LT?=
 =?us-ascii?Q?qriE6utSTDoFyf=2FlnN3h1F4VDU7gdC+ogP8yL7B?=
 =?us-ascii?Q?Zl87zJqcJIF5wE57ffu+kpPw2DNWOp7nUCfXlI9?=
 =?us-ascii?Q?cQIPDcfEGvA=2FaMUILndBSjdtAbsATJKLQ3NSmSr?=
 =?us-ascii?Q?1HR5hMdYTGKh6SDKM19ag=3D=3D?=
To: linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii


This is an updated version of the patch to check for WILCxxxx presence
during bus probe time.  Compared to the earlier proposed patch, this
one:

	- Is relative to linux-next.

	- Breaks out chip id validation into its own function.
	  The function also checks to ensure that an expected
	  id is detected (WILC1000 or WILC3000).

One caveat: we're still at v5.15 of the kernel, so I wasn't
actually able to test the patch with the linux-next kernel but I
reviewed the differences between the 5.15.147 version of spi.c
against the linux-next version and didn't see anything that
looked to me like it would cause trouble.

  --david



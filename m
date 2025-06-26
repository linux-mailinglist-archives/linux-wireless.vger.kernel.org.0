Return-Path: <linux-wireless+bounces-24552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B14AEA009
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0053AF138
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E752E92A2;
	Thu, 26 Jun 2025 14:12:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198B2E8E1A;
	Thu, 26 Jun 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947167; cv=none; b=Sz22M4Qjznvb58YCn+RtDpueAZjXcMqI3iZxU5KPKGTtNQ8iORa85ByobPdF3KWdSBf0q53AnjoBcGp9ObvMHNkNbEJvJk6boRoDAjYBWfRBolkhVNbVVm0bs3hSNAyHrhnN5JXd364Vt050NxDEN1lCIrHh+H+SihzSOGsRl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947167; c=relaxed/simple;
	bh=3MeOySdcRKJUoBvoyqKyt6Vs9WU0brnzVpnrqO+bWM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOgFDuph/b2BVjcjXG57g9hXuX88qnbkMTWHP3rWDJGmTfyvb+xgAepCJcqB1zeZTuYJ9m2SROwYnVegfBkkToecTxhPseoDT5ZMUe5KlY6NSHcg4P6LCBGb0naub6cQAJkTjF8KPb2J8JTfP97aMklQOogqJticvzmf3ZoPcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 16:12:42 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Thu, 26 Jun 2025 16:12:42 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uUnLG-00Fqtl-2r;
	Thu, 26 Jun 2025 16:12:42 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mgreer@animalcreek.com>, <krzk@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: [PATCH v3 0/2] NFC: trf7970a: Add option to reduce antenna gain
Date: Thu, 26 Jun 2025 16:12:40 +0200
Message-ID: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The TRF7970a device is sensitive to RF disturbances, which can make it
hard to pass some EMC immunity tests. By reducing the RX antenna gain,
the device becomes less sensitive to EMC disturbances, as a trade-off
against antenna performance.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
v2 -> v3:
- User SI units for the DT property, instead of the direct register
  value
v1 -> v2:
- Added vendor prefix
- Added units




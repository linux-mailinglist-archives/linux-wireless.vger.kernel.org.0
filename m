Return-Path: <linux-wireless+bounces-24424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C192AE655D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEFA7AC108
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419BB290D83;
	Tue, 24 Jun 2025 12:48:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46621765E;
	Tue, 24 Jun 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769292; cv=none; b=B1/0dlHF0OfaZ72N7/iKMK84kjCp102LqxxVFN47ImsIUtpD4EebPCC8ntCnE2YuXh72W22kX0/XVLBdpSDjkHijm+OYAOnSGfDczdJPFPg6/PupgwYdffc5LtAyvhn3eP9Ozv6S6Rwoypw7w09ZaMMJNpZKi61PBG/aWetAOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769292; c=relaxed/simple;
	bh=Hilcgacb5T6lcTk4xUKS+2QL0eNiJ3t+yrbfo/oLiPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kTTk04aJ3XL7a+nfuSiOPL4IQenDVjYmooO0aJTUv+vhHUkkCM4Tn7lJuu9y1dDy+PPNknzcxlajzQ6pQtbnhQznctD2Vwd6W1ebixUQv0z351B4qPIgKFkiX5c4FeDsVpIKhhi8kNeYPhr77Rdhi048OmKOCUW4fZ8jn6mFVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 14:42:59 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Tue, 24 Jun 2025 14:42:59 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uU2zL-00Bg0N-0d;
	Tue, 24 Jun 2025 14:42:59 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mgreer@animalcreek.com>, <krzk@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: [PATCH v2 0/2] NFC: trf7970a: Add option to reduce antenna gain
Date: Tue, 24 Jun 2025 14:42:45 +0200
Message-ID: <20250624124247.2763864-1-paul.geurts@prodrive-technologies.com>
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
v1 -> v2:
- Added vendor prefix
- Added units




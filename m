Return-Path: <linux-wireless+bounces-4003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD768671B2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 11:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BAF293E72
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1C13AC5;
	Mon, 26 Feb 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gORStT6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9B101C4
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944095; cv=none; b=OLApQbmGJIkhV+tYK0I9yMrvtFHRQ1BdG7WQ10r18ZsVroOTKRD+87elSZ4XZ+ff/SNdfAjgVgx/QA/oo4BRWeEOncvke5F2Vqc3UMCJC2MRX0RWJnCIz9QSObeY3dKZLx448xcY441XX+9QYAdhZ29xSL2A0WfHcvaXb7nF1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944095; c=relaxed/simple;
	bh=+cTUOHb2xpPzLdsUcDEU8GaXmkqKrlz3w1CfWfW4AIc=;
	h=Message-Id:From:Date:Cc:To:Subject; b=Pe3Uqu7qtpSz0z7ZYmfAX9zRxv4PDhTKWJDafRWrTO/3kxHMGhtOJCLm6ZuH1pg/jptScE0dMIDdeoWKe1ax4QaSEUqaLzftvhPuTD0cYl/paSw6HpA5tD1dvjfuncENribhwID7Oavt8Y7p8m1QPzJYtaAESdO1rEvD8Rru5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gORStT6L; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id B0D3C60AFC
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 13:41:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KfUK6CqvTmI0-QVsvMrVn;
	Mon, 26 Feb 2024 13:41:21 +0300
Message-Id: <20240226134122.QVsvMrVn@mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net>
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1708944082; bh=R6Hd910zBDwMKMkCExB6cSnOb7afaDRXQ2kI/+IQx2M=;
	h=Subject:To:From:Cc:Date;
	b=gORStT6L8AnxujsdSM5SGkxbYt8QB8RczKI5qEJKz6uRc4euxjedxs953SPHtuQUM
	 3URCGz4F8BB3Dhi9KLQDGVhscpHB7NgLAyA9JpZ97X+VLMPtKCp94ZdDa9IexHDX+b
	 Tw5IyLbNmvyJbQe7vTHwFky4+t6CRLsnIlsOXr2E=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by localhost (sSMTP sendmail emulation); Mon, 26 Feb 2024 17:41:20 +0700
From: "Serge Vasilugin" <vasilugin@yandex.ru>
Date: Mon, 26 Feb 2024 17:41:20 +0700
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: rt2x00: don't overwrite SoC specific bbp init
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

SoCs rt305x have the same MAC version but SoC specific bbp init function
called above already. So don't overwrite SoC specific bbp init results.
When changing SoC bbp init I break my head before undestanding why
results were overwritten.

Signed-off-by: Serge Vasilugin <vasilugin@yandex.ru>
---
v2 more complete explain in message

--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -7257,7 +7257,8 @@ static void rt2800_init_bbp(struct rt2x00_dev *rt2x00dev)
 	case RT2860:
 	case RT2872:
 	case RT2883:
-		rt2800_init_bbp_28xx(rt2x00dev);
+		if (!rt2800_is_305x_soc(rt2x00dev))
+		    rt2800_init_bbp_28xx(rt2x00dev);
 		break;
 	case RT3070:
 	case RT3071:
--


Return-Path: <linux-wireless+bounces-4868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1502A87F189
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E531C20DD0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FF2747F;
	Mon, 18 Mar 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="sm4axs9n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F126AC7
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794946; cv=none; b=msldErdR4r7/asMQnW//cwTJupe7n236g68wIIUD5KZA6Hy6huEKvJiT5x+/NU1urL8rNVBf6oQa+Y63G4AI8fUVn9bVARce59mLuMf4Q9rEzZVanLepxaLMh/lMLglt8TsaATzAtOt/9Ok43Ejocws/SVdZqyFtm4ZgdvU3mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794946; c=relaxed/simple;
	bh=NkqIG0DslenTwsCmKw7R1yMh4Ru34IfPFs1Krh4WiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sM5/Rk86rglpyiUMy2z9p/4QGIwngdizTc1jy/+ph0WVUPI+LA5GxP6p8LpOmXVX9hKfg0cJnFgTAHX/xkjf7vltZ7oQ+0jvmQa7xCnJ4ybMRu2tKOUprrPzZNOpRAOPzvDUdJCICeu7AwPeTaayVEIMy/mlPtsHYTsX36csMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=sm4axs9n; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 47AB4501E99
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 20:49:04 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3D8488C0077;
	Mon, 18 Mar 2024 20:48:55 +0000 (UTC)
Received: from ct-eskewd.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPS id 4973813C2B0;
	Mon, 18 Mar 2024 13:48:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4973813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1710794935;
	bh=NkqIG0DslenTwsCmKw7R1yMh4Ru34IfPFs1Krh4WiiI=;
	h=From:To:Cc:Subject:Date:From;
	b=sm4axs9nTr/gBA07ghoi5B31ucjCa8Fxmo/gPbLC/+UKqyZQrxhSWT9kQdY4SsOUq
	 Q9t6xGBlDBBtn8rbPt+T/DhpXOVCNjMuFNsqSsc01BCrMqgK60R+uNfT+sdpV7z7ej
	 7All/xr9miIg+Vqgcs9TQtoiV9yS0mJHmcb6RT2Q=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] iw: scan: add EHT beacon info support
Date: Mon, 18 Mar 2024 13:46:39 -0700
Message-ID: <20240318204849.73681-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1710794937-cvpKfnXS2Uc5
X-MDID-O:
 us5;at1;1710794937;cvpKfnXS2Uc5;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

iw wasn't processing WiFi 7 EHT beacon frames during a scan.

Update and add to the old EHT processing to support determination of
MAC, PHY, and MCS/NSS capabilities of a WiFi 7 beacon and add to scan
logic.



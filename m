Return-Path: <linux-wireless+bounces-18771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB3A30CE5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A61882FAD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553101F2361;
	Tue, 11 Feb 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EfP4R8XJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AF1D514B;
	Tue, 11 Feb 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280670; cv=none; b=RKN76zof7DOzBtFJeeT50/xZDMer8dNkHLkVP5oxFid6YaM6RN8vDHFKKLBlFZ/DHO8ozoMsDiV3n9i88nR8DX3jOGBu8C1PVsTHN7TXr18aFq559YEQMAPzStsIj7NQXLC4k8sDfQj+n7Lwerz5jmBB8YzVhlo8Ti+LWyJ/P9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280670; c=relaxed/simple;
	bh=XI9EvM0citVKIw8nQm5gy9BLsuDlEcHVVR/1TYMiOs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NCMyMWT1VRPCxkZkkmiePG+oPOyzg/4zhvWe3RGgtltYKtAimTfjnErV9pC8t3/zofqpuzu11KBVnartWybN3laznwBBEckqgQKewO4AmeA+PG3uuiNsObxvY63/qEIn3v9HOUsX2hoac7nUHwvgH/4f6PKYMBeI4JRulQuMWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EfP4R8XJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XI9EvM0citVKIw8nQm5gy9BLsuDlEcHVVR/1TYMiOs0=;
	t=1739280668; x=1740490268; b=EfP4R8XJ5nA43QNgOu39rp0V5iJbou01zd4i/Ew1NN4A69n
	Ji0rEdIyEMFwvbsgGsHGs3HZ+6cBfUm47RkScuqXSjPHZ2BaJeBxGcDqyTXlEB5n/UrZwBtLaa6OW
	hYDui3IwMiCC6QDewoKEffToQHx6WKBplkaAb5dwx1S6UmU/IFy2EXIE20nCXd9tSjQB9MEs6qgoW
	lseKBbhExTzHu57vi/yLveQ5IeDrwhV+cemY670jdmbAbTvVJlTAb/3TJ/Vv3IL3PZRwfmWEVuSx8
	+S/tMKaqd3J5UL6u/b8opuEMeNOXuSIsfZQexhGrQAn+MYZwALWDRU6b7z6c+j8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1thqLx-0000000B0n9-30V0;
	Tue, 11 Feb 2025 14:31:06 +0100
Message-ID: <dec73760f1fb159005504fb9d2c83e2f189a2963.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: mwifiex: Resolve the failure in
 downloading calibration data.
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
 kvalo@kernel.org, 	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 s.hauer@pengutronix.de
Date: Tue, 11 Feb 2025 14:31:04 +0100
In-Reply-To: <20250205012843.758714-1-jeff.chen_1@nxp.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-02-05 at 09:28 +0800, Jeff Chen wrote:
> This patch corrects the command format used for downloading RF
> calibration data to the firmware. Additionally, this patch resolves
> an issue where calibration data was being released before the
> download process.

Sounds like that should be two separate patches then.

johannes


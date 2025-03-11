Return-Path: <linux-wireless+bounces-20147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F2A5BA46
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 08:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5500F7A96A3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 07:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D61EE02A;
	Tue, 11 Mar 2025 07:55:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE81386DA
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679701; cv=none; b=iJqbdiFky/pbdS7pIVE3WdJ0IsDz3ClWc3jcJyLHTiqzwvj8/XZLcrWTCCsczefk29SOjkUq/zJQQWQfVSF2P+/bHeW4RBDyS6izDJKXhiGosVLQZHWc0fADf9jzwk+WvVzoFvU3aO3c7tmz3Pwam/hj74rE4nNtswpU/oeGeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679701; c=relaxed/simple;
	bh=6eNz3aUj514kRVoHnE40M3YwtuEL8LJehUeuymyk6gQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCTzGBPvC+bTR9P6qwS/22wTJloXlCETAtV2ilcUxxXWu9geNtRyW1ciznHkZqKM6Mnmpg5VQWJPAhhvQFaQx9JTiTgPfhG/uLWH+/ipEAb7lZ3GDcrun5yTDXPRFCg2Me1tInUTZ57oAwNnmhWg/nqqekJyc6QcE0r8JdvOm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 3E911206DF;
	Tue, 11 Mar 2025 08:54:55 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 25AAB200F9;
	Tue, 11 Mar 2025 08:54:55 +0100 (CET)
Message-ID: <041375dcdb6fd3afacd297f85036d4f3ca73cc6f.camel@freebox.fr>
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Date: Tue, 11 Mar 2025 08:54:55 +0100
In-Reply-To: <809bd94d-66d5-4621-9475-b9a8a9370b62@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
	 <edcaf289872243a7a5a794ebccdc39094e130d3e.camel@freebox.fr>
	 <809bd94d-66d5-4621-9475-b9a8a9370b62@quicinc.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Tue, 2025-03-11 at 09:38 +0530, Roopni Devanathan wrote:
>=20

> I hope this will resolve the said problems. Thanks for pointing it
> out.


No problem is at registration time, not un-registration:


CPU0                                   CPU1
wiphy_register()
                                       wiphy_dump()
                                       rcfg->rts_threshold deref
wiphy->radio_cfg allocation


--=20
Maxime





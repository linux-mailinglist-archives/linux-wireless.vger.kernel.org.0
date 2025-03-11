Return-Path: <linux-wireless+bounces-20164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA11A5BE13
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF013B2236
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4923F373;
	Tue, 11 Mar 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Tn6Ij1Te"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7B23F295;
	Tue, 11 Mar 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689668; cv=none; b=P0eAQOnlWmN7Mvwb3QMScebC8eSMs/78dTadFTfu5dvev9NYyIqWqcicoORMCdjMHTyNT4yDhFv9551IHmkM1JzxN2l3ut/uh3ImBvv6xNNYtauMsbrMTCqvoCQb2UoWjdpHlEkY21JVUfo8SY1g0FQGcaXyHZ8RC5v+WrHRtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689668; c=relaxed/simple;
	bh=nAUHNp2kBBjvtejugRrFk/HNYaC7Gw17aenNxh8GKss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2+FBTItgR2SRbMRRwEXgsWZI6rw4hISqWjLTuGl+uyo3tKcnwYqW1JHnBJW8GWQzaFF3bAKnzNEqGV2Ux2Au+yT70PkzYSGM7NdUTMSI8WanDtPhbfSPigJb8ifJ0SAiEeqsroaPCXO2fIrEcxhB+UHGAItqtqa4JNFVh/4aR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Tn6Ij1Te; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nAUHNp2kBBjvtejugRrFk/HNYaC7Gw17aenNxh8GKss=;
	t=1741689663; x=1742899263; b=Tn6Ij1TeyZEJfLOSewYC1IF5ej+SBOxxntlHLJefrQjcjGV
	yHYvw0wFy0XsBhAXRfXTwUWjLNnVgM139QpBqbD/cxuMACiKoQ6G3hvO/Bzn6aKkJJpYIaxAMH190
	gKi5jqF1Wto+2rf+J/+UXJ+aDAsh+eNSW9A8v2T6FsQz1olRQYac1pU2mdpEQ04MSi0U+YyuA+DLL
	fQTbkWhrTvFlfpzMjuH4PifTIx5xPOKHOtcG/MCSb1jwgGPu5HbOtNQtLZLuAP4fB1SBEAEQ2gj2O
	ZaejAInwTp8M5dCt7s0xwkmcDEoIziHVjFFP0Xx/YUHksjmOxBuU5caUoqsrSNPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trx2h-00000007nwb-1OIV;
	Tue, 11 Mar 2025 11:40:59 +0100
Message-ID: <af8e60b46567a0612b71d4cd198b07dc93b046e4.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: iwlwifi: dvm: Avoid
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"	
 <gustavoars@kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Tue, 11 Mar 2025 11:40:57 +0100
In-Reply-To: <75551003-17c7-450a-89b0-818b6a01051c@embeddedor.com>
References: <Zr5QR03+wyw571zd@elsanto>
	 <b0f25000-396c-4a83-abc1-1a07b3065c10@embeddedor.com>
	 <75551003-17c7-450a-89b0-818b6a01051c@embeddedor.com>
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

On Mon, 2025-03-10 at 14:17 +1030, Gustavo A. R. Silva wrote:
> Hi all,
>=20
> I wonder who can take this patch, please. :)
>=20

At the very least you're going to have to resend, I don't have the patch
in patchwork any more.

johannes


Return-Path: <linux-wireless+bounces-25680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F069B0B0C6
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5108718925C7
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698F1A8F97;
	Sat, 19 Jul 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rav3X5Sn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440DAD5E;
	Sat, 19 Jul 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752940460; cv=none; b=pwpSq6iBj7JDXaImTm87K0gSArTtfjd+THth4Sw3tAPqlWMcFLo6bH7e5o7CSwRBjCPRaqD99K/ALRGWN81h9N6N0mZkpWnfoNyV9Yj5Q311JYTlbJXn3FiBcyUYm+ZalPB6H6k2Qu0LHGaoH100FbNcufoSBUaoSSxWr0gZICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752940460; c=relaxed/simple;
	bh=VnMe8wj9U/jdJ79QZ3dT9GaN3uP1LA3gcAZHCaGupeA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hE553ffld+CO2vKlwQB+IJghIRh9kZQ5Vxef+mI7g8JP2UJscP80llanofacGu6oLqO63dr/TADOzr4v3sz9UwYmTruFa/NX3fc7uqkjHCbQ2+SmdaIg56A2OsaTKGRgroYEOfUA3etJp2Pn7HW+iH7rPpoO/+6G7o4ZOvIke6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rav3X5Sn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VnMe8wj9U/jdJ79QZ3dT9GaN3uP1LA3gcAZHCaGupeA=;
	t=1752940458; x=1754150058; b=Rav3X5SnWgConemJhBiO/aMaL6DDJKrkx6tSzsImfzeLOTL
	LE4PSwfd/yHBPFbnlzYmTBr7VUIrfmleYdJ2hcSE7cD/XuWtSDBgmKmp6g5DBbihMq0gRiC5i+oeH
	jKcTBaRzMWib77qttiknXDW4fiG+RhCPbLbKniLqE+4KjP2mDRmRxMgXeTolzA3wIPtijc/E+FoDz
	QXtzFsXDCMc5Zpc4E7G98Ju0UdRAAb2svaT4xZmgvvFEBF72IqyF46kh0ycuDKOOE3JvzB2HiE/oy
	ZJEXjOCGS9goTjp0qSaYaSOErTo2m2RJ1woaqJW2LI1/WRILuKYGvSzNgKQSfJPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ud9t1-0000000EXup-0m8t;
	Sat, 19 Jul 2025 17:54:07 +0200
Message-ID: <40f027d2a957ac3d035f8a81f2dd6dd20a5a6207.camel@sipsolutions.net>
Subject: Re: [PATCH v2] bcma: Use managed APIs
From: Johannes Berg <johannes@sipsolutions.net>
To: Salah Triki <salah.triki@gmail.com>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
	 <zajec5@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 19 Jul 2025 17:54:06 +0200
In-Reply-To: <aHu_MHDYB7-Vuua_@pc>
References: <aHu_MHDYB7-Vuua_@pc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-07-19 at 16:52 +0100, Salah Triki wrote:
> Replace pci_* with pcim_* and kzalloc() with devm_kzalloc() so that no
> need to worry about freeing resources and disabling the device.
>=20

Please mention how you tested this? :)

johannes


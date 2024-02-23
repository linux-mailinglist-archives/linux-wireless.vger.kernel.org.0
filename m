Return-Path: <linux-wireless+bounces-3951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EC8860EF6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA47D1C21A8C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69413ADB;
	Fri, 23 Feb 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ubxcarjS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53F5C8E2
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683170; cv=none; b=ZK0+AV6M4CZ9zVtpxKTZ74ETFBrRshvzyMyZlyTVgsG4j6c5Li4r9SF8l4cZ5DRuFWDujF4ndneLRJHGIW9DtPFVVR/2JUEGnK9CtQnx58B3MTWc9+p1DQK2ShQVyMKogdG5Gv7fIYJl4zOwO5LEAfeuv1fk6VPAK4LAx9eZQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683170; c=relaxed/simple;
	bh=ogcQoY66C756q22nDieFDvpFLSNsdeGHaenjVRH9nbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cylfg/EVeKwtZrTXUB6sA2QIb/nL5CeMIqyZ97TPQlYZ+cjdEx0ScVnfCsHJ7jyjRx4tJSoa16d+yN4wONVu6GL9bbfFzzHjC6LCrM5/PacKDSVHDgSlJk18G6RkZTi7i2xPWAm3ltPUR0kJ4xHdxxtAs4bE4fd1ak3rUQQ5Y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ubxcarjS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hhz6Uk9mvC9Cqa+1Yf4sGTst8YnYtPd1wG+9BtB5Gzk=;
	t=1708683168; x=1709892768; b=ubxcarjSW2rm1GqeQ8lXBUEqG9nvdLpKeFbMCl0o5WVoQAD
	DgnA/bVZXlDsDlB7h3e0/YivP7K6BoxZHsP77AJfQQsXsQp8KmSXb7mO5q5inbTsEV+8Diwhu2Bg4
	K29dnF1RRBrfShKEZx+bdycXHFnrNnSNpH/YxQeM1AbVzDecl1egYUVbHCr3kdolyMHIfmecKWLef
	r1wgC9yRXctSxm4xnF4dB7MTuaK0KDrbsqN4DJCSjA0d4LhMdq0Fxg6xRmCLYaFggu6Vpu6XAABlZ
	7OQUZhKAWg22y1ST6rW2dgpWxzBs1VORuxVqPT6fGLRcapNvYyq6FjAYv96IewCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSXo-000000050oL-4BZK;
	Fri, 23 Feb 2024 11:12:41 +0100
Message-ID: <b46afa718261fa956ad5e730bd9a8a25cf22c12b.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/3] wifi: mt76: mt7921: fix country count limitation
 for CLC
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, nbd@nbd.name, 
	lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, 
	Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, 
	robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com, 
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Fri, 23 Feb 2024 11:12:39 +0100
In-Reply-To: <20231122030646.31784-2-mingyen.hsieh@mediatek.com>
References: <20231122030646.31784-1-mingyen.hsieh@mediatek.com>
	 <20231122030646.31784-2-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-11-22 at 11:06 +0800, Mingyen Hsieh wrote:=20
> +	buf_len =3D le16_to_cpu(clc->len) - sizeof(*clc);

clc->len is defined as __le32, so this rightfullyu introduced a sparse
warning. Please check which is correct (should len be __le16 + padding?
should it be le32_to_cpu() here?) and send a fix.

johannes


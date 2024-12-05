Return-Path: <linux-wireless+bounces-15924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBEB9E5441
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 12:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD80A16789A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F120C49E;
	Thu,  5 Dec 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lbPA0ahp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9820CCC3;
	Thu,  5 Dec 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399034; cv=none; b=HinXIUozNF0U4p4obVvNwR22MYDCm2SVfovOusMt234/EEOeuj+DujcZhoK9BP7v1q/WxjHS4OqSibWztGlPImq7t8JbIYgY0bc+OYEkeSObQS8FOx+dWpWSYH5bCOZCI+iLHRZ0GH+Cr5BCtxi+hNLneLRz59WixxlcNJ+SSLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399034; c=relaxed/simple;
	bh=QBhLboJy/EPEhPKkiL/r3Lo1W3Ty0UYTFagr+zEfnHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAH/kzX67gaNB/35HQHn+OSM5udf7WpkKMXEBxPDbPhjsL1+6MmVNM5E5zbdfsPQ3df/Nb1Y/eBMndmVnHfqTEFWvTYoX4AHQN+unC3hV7BcGT3YUh2efnmLdI5TBLje1cv33JSNtX1hZkT5vo+qTlFLUTpdTv1Sumq8H7RtIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lbPA0ahp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QBhLboJy/EPEhPKkiL/r3Lo1W3Ty0UYTFagr+zEfnHM=;
	t=1733399032; x=1734608632; b=lbPA0ahpw5uCMBJjp+WxL6KdmKukNJFN6RoAEGcRuxHxeda
	uOFmuPt8/7K/rNCibewdNIUagyITQdDzzx/97Jge/4+A3t0/mvd4XJiK7LlC8LQk0HwfwCpQpixz7
	9XJGQxjXg3DP4TId0UiiuPsZiqrjDXBOE2nSY5MBiq43Miby6IAAaKYvSVZ+/ZBDP8F58ptaGLMyo
	gt/H0VVdcVP7c0YYlWxIxWE3yfUYOcYczZya/JNOmsK9t2i1jfHG12nsWdQPoPr3tiZsvva8G8QV8
	LNKf4ivGP0cspofpO/6uYoDuvbFwRMpyokrdHAU0Upy/4xP0222pubJ8fFKKgnPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJAGr-0000000AsqP-09z1;
	Thu, 05 Dec 2024 12:43:49 +0100
Message-ID: <d0acd2178504d76770e9267ef6e7f5c04b50eab3.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: re-order unassigning channel in
 activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Dec 2024 12:43:48 +0100
In-Reply-To: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
References: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Therefore, re-order the logic so that stations are handled first and then
> channel is unassigned.
>=20

This causes memory leaks in my tests with iwlwifi.

johannes


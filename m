Return-Path: <linux-wireless+bounces-9604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC59180F2
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E5F1F22E11
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE3181D07;
	Wed, 26 Jun 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NgcXRYBo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9415FA71
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404840; cv=none; b=ObRqQt1uT4PkJXFKOv/SzY1U7q4JSw7hYwcb6FarPo4rAlbCcMYbkEWtcDodvxiU2ur98bL6L2xcjCNy+T2RJajT4IqEn8UBE4l0BHlvmrEdq4M1+MmPOLK4KH6HmMgZm5DhPYOQsFKTO6VRY18z6xXs2pisC/VsJZVomTOoBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404840; c=relaxed/simple;
	bh=iUxYBR9tZgYppmnABzyk5IIDOClzA7qjK/ozNIIAvDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oe+7WW5Jv6b0H117juT6qTuhfTvaIs+QSzfXd/uToSbSyNHI6SXYORAm2moRgSHJ1d071LHTjVYH5AYlOzMTneugihSOPKYQaBk4/5A4FzDIis0Y3NXcyUj7iMGEQRDC1v5tAplTQjBBVoWR7lhLu+UqLBMQMB0DH+ipYi67tDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NgcXRYBo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iUxYBR9tZgYppmnABzyk5IIDOClzA7qjK/ozNIIAvDI=;
	t=1719404839; x=1720614439; b=NgcXRYBoycRjbxkw4OrvUq0fr76z5J3rTC49nXz2hRHYKTN
	KGpBM1gln7a7mpjUnzsPqrBrIPRT88WjecIhl4kdtzMuO2fQpVTcXctqDvNPURSzI20nf31NBDZ/Z
	oZNbkfeUC/TeWipjzHGgMDf02u7B83tShVHX5SknRL2NNE3ga7DICHCiFrCODybLQvmOtSPAHXiXq
	f0bIdUj6FI2hGl6p8IrSR/f6L+IudkabhLtprG+rXot/zCjNUR5yl2oHlwIQvx20Bf6w57ah4dHT/
	3k45TT4/NVO0vkD6sL9FhBJBunggKed72h8cFc8GOonTXVPhA4HXmF3zH0LMgugA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRk3-00000003cQq-35g7;
	Wed, 26 Jun 2024 14:27:16 +0200
Message-ID: <2670401fe00f0da320c534a94eb4575b001b180a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 5/9] wifi: cfg80211: handle DFS on per link
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Jun 2024 14:27:14 +0200
In-Reply-To: <20240626045216.3754013-6-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-6-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Here, and also in patch 7, "handle DFS on per link" seems incomplete?
Remove "on "? Or "per-link basis", though I find that a bit stilted?

johannes



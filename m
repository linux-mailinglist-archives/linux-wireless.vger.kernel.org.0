Return-Path: <linux-wireless+bounces-16373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921F9F0C0A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379D51686E2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA81AF0B9;
	Fri, 13 Dec 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sczxFCQl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699711DACA9
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092169; cv=none; b=GxwHvu1H40t4RnHMn+n5Av4TBJwzyt97WCdOShr/DEYzzwbXmyE4ESZzui0knqYRr7MWc009VS+enXmYbtM/fJx5fNzJbJ+aBAKC5DGDG/E9D4R74THmQLQ8ehPCX3opoOWQTC9hmGL2MM2KsEPdAtJqUVf2mQ1QliOWSTGVTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092169; c=relaxed/simple;
	bh=R//ukypql+khoX4YCIORwikDeWONqhkiJt2y9J/uHsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcJyquh3BUY/xJszMOMmkcZF6WBPBifUjfA4UDKn5hI7/WQ/unOb5nJqzAi+jedGAqJclbwgNyjD8SrFiR+Ww7hrwqppnsdnNtkjhJO9tiFMRrTiF068vtHUQn0ji4Mgc15+GqPa7SIZtnFz7RWLEph0bNQ+iO70KSZMj9Hbz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sczxFCQl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=R//ukypql+khoX4YCIORwikDeWONqhkiJt2y9J/uHsc=;
	t=1734092166; x=1735301766; b=sczxFCQlVZR2D9xI6QFirBpDAr4X3qy9ccwpKDGna0hv+Cd
	RG216vpoc1poT0M9MnYwk9UbUSdd/btC8JpbxFv3CO8KHs9P95iP3ICovc+i1wPMOM1WqT3iSnKQU
	t+qpGwF489KUd3UMAcNk5WOYDR0TZe/tasdQrzhsJldfFmj0+Kb7qTQRFgKXMBKgG6S5vmp42BOK3
	IKuZMG4pDtRFg7JTRlG1tFDn36FbqE+w3VGEA1YG/ZMZbcT0De0mr6aYEqiLciGr4kk0Fynu1gxp6
	W8tQmNetOV0smgkJjKeOZfxViTf4eSvHzw/vF0PGuUXqwrVwpJBn00g8dVhirkng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tM4aQ-0000000FVsl-341C;
	Fri, 13 Dec 2024 13:16:02 +0100
Message-ID: <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: update Indoor AFC standard power type
 definition
From: Johannes Berg <johannes@sipsolutions.net>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 13 Dec 2024 13:16:02 +0100
In-Reply-To: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
References: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
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

On Fri, 2024-12-13 at 17:41 +0530, Veerendranath Jakkam wrote:
> Update 6 GHz regulatory info subfield mask and Indoor AFC standard power
> type definitions to align with spec changes introduced in the Draft
> P802.11Revme_D4.2, Figure 9-896 and Table E-13.
>=20

Huh. That seems like a change explicitly *designed* to break backward
compatibility? Should we accept the old value from older APs or so?
Otherwise we can't connect in some scenarios, I think?

Or at least should we say here in the commit message or so why backward
compatibility was broken, and that it was for other clients that didn't
behave well or something but our code was already fine?

Or am I completely confused about it?

johannes


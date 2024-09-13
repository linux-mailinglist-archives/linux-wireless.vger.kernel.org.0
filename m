Return-Path: <linux-wireless+bounces-12834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5042977AF3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE35B1C24C5B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9401D6C4C;
	Fri, 13 Sep 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LrU5LqWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28D1D67BA
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216163; cv=none; b=aVtdDJMbsa71c7tFYfyYbiyM1OuAaU4W05kcuAxGZ9/yZmrHBmA/2YfU4l7QE030SgRSBZh4ckzZ4sWoHnJ1/BCbY25Ms6DEGfqDCNm34gCw2lZlH76TlkPJdZ9vkx3RX3Lg0jk1nHQ2vagU3CFpeG6iOKIzUNM2YdIySHiUzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216163; c=relaxed/simple;
	bh=97/7aU7+HbVRk73G5FXiEuQXQh+Hdvc/F9YTouIh0r4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aERINcgCdtf5KRjHtr0aTCkrHAXBYflR62hMI8gryytT5w8t+IwoG44A7iCN+rjc6EkpmEt0JbCvkQ3yZdUcsM/JA0h616blIVIkK4G1m2wZIp2yUi2hw+fn8ISugd4n9vkGyMbL4YYTc0K+8MqaHfbaWm35+G4bNS3OrNnM2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LrU5LqWe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b+aKZZnccpC3XY+EZCYLN7mQ5GDj47m2bfwqWifH+lw=;
	t=1726216161; x=1727425761; b=LrU5LqWe9snHp14qWhZprruMI0yz1M7Xt0+p6QxS9mtqxik
	24VEkQ/i4M9ZDuwsAI1YJNbnd1mZFr3bSDs+igk+VEXUHBJRSmFG72OZL3G3t6TZsSOueSi9/hJSz
	Jq9IM7U7dNTsvNTkmrI2+VYiDdfDcDcuWnXMQcdaogO3IHIINSPPfkVHsaZWEUHswyyEtKc1rzS+K
	w/BWgcGBZxikKATSYHJP9yuzdL3ZCd6EDw/AuDNNZkqeC8vWvbIIPeOvs/sNrRRL51hVriTwuIyxp
	XSpPS4WsV07bRK2XI43IQyZKnDV7VPXqhHQBk7kZfZ6DozXdqdKRrUo9OYU5LkDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sp1g1-0000000Fnka-11yV;
	Fri, 13 Sep 2024 10:29:13 +0200
Message-ID: <a5f94700f09cc9eab7f01d63f699586de65a935d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211, cfg80211: miscellaneous spelling fixes
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date: Fri, 13 Sep 2024 10:29:11 +0200
In-Reply-To: <20240913075833.118491-1-dmantipov@yandex.ru>
References: <20240913075833.118491-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-09-13 at 10:58 +0300, Dmitry Antipov wrote:
>=20
>  	/*
>  	 * Follow the driver's regulatory domain, if present, unless a country
> -	 * IE has been processed or a user wants to help complaince further
> +	 * IE has been processed or a user wants to help complaints further
>=20

Yeah we all, users especially, complain a lot ;-)

But surely "compliance" was actually meant here.

johannes


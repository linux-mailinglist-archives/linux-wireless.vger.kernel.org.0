Return-Path: <linux-wireless+bounces-23353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE1AC1E1A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CEE3B2A90
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0D27FD7D;
	Fri, 23 May 2025 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pjG2LAG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B828135B;
	Fri, 23 May 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987180; cv=none; b=MfYBxUZVkRqNJVJc+jmi0NIHkvfFjGJKzaKHkdt9VnpZniYK4VmAy/8AA4bCjPYhDNeXQMdV51U4PQw3Mo1Zjmu24/S1WoDUnIVyzGqy06gdDAj5MOfDRr5Bczz0gmcaWW5RKfA3DHEi8W7K8jZHfE1SfvV3PvxvedtdPiunyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987180; c=relaxed/simple;
	bh=Q+6gyGuaEfvX1dxFKRrt/yKar6tHpO3QdgHv799wGOs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2pbBN8Znc/oefKAJxaKgaADZaDRlijb2EKUl6EV8oNSTcElkGc098LOGiuLK+yINzXjIJY4esdvW5uovK2swUVzGlU5BArwbOOw3rSUZnVwUdaTb3RWyVdeRZvik6eob4gJG3h1z1MeiDItD+MKdILbYIadnQvbW/Uursq0sEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pjG2LAG8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=12et8CCEtfUUjxDBHQEY1rs4kI0cJQPuZMMyHCY8V1Y=;
	t=1747987179; x=1749196779; b=pjG2LAG8UgjzU7s5A9X7sYqCzlJj2apb65F3WwqFMa2JMTM
	ybu8PlChozEZYGn6N8W9iNhKOJ//dPvnxRw06QchSAEUCsbtXNshu0yDcONi5T7MFGtanevL0aVRL
	GoakUVjplyF3X3uVqWRDjmM9EaYsyhOJDOSlXX+4zRUCA8oK6JNid5+i/wmrE0MHxRtM57iOzWIsB
	R6o+0SOj8I3Xe+EOA2npPsQ561LZw9Yd738fBoqyfG4HRTuhtGpIopLopwMwIBbBc7pC0vx6b3zFt
	MJgzdku9UaKdKNGc0TakRTZZGx8mmkOhbjSNCK16zfaMSbim1vFDTD6vvrlihHuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uINJW-000000011g7-3beq;
	Fri, 23 May 2025 09:59:35 +0200
Message-ID: <af7b544920184403a22f326c3c8f0d560bf1b4d0.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: cfg:  Limit cb_size to valid range
From: Johannes Berg <johannes@sipsolutions.net>
To: Pei Xiao <xiaopei01@kylinos.cn>, miriam.rachel.korenblit@intel.com, 
	emmanuel.grumbach@intel.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 23 May 2025 09:59:34 +0200
In-Reply-To: <5a603a35a2d05ac9bd44c87efc605d35051d5d12.1747980220.git.xiaopei01@kylinos.cn>
References: 
	<5a603a35a2d05ac9bd44c87efc605d35051d5d12.1747980220.git.xiaopei01@kylinos.cn>
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

On Fri, 2025-05-23 at 14:04 +0800, Pei Xiao wrote:
>=20
> =20
> -	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
> +	cb_size =3D RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans));
> +	if (unlikely(cb_size > 12)) {
> +		WARN_ON(1);
>=20

What's wrong with "if (WARN_ON(...))"?!?

Not that I think it even really needs to be there but I guess working
around a compiler warning could be worth it.

johannes


Return-Path: <linux-wireless+bounces-20411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B4A635F8
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Mar 2025 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15986170EFC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Mar 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4753AC17;
	Sun, 16 Mar 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wb1MF6ej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096754673;
	Sun, 16 Mar 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133664; cv=none; b=kt0xSWFLlh4N4H87wO3jyWlpjGmdD+D9L4qFd4QcPPrHzSBg8RSs2YWALdS13W4dlmf2xxbuuCbvfGaD1mAmw0yZghnZYwcCYi6EyDEI6i3oCe1t07RyVrvz2Opcm2c70pd97dBNRioIYcqs4h2YChF/Bt6siOGKhFELjbAACHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133664; c=relaxed/simple;
	bh=lanvKTNqZhbIUG6pcILYg1Ijf3w+itD0dMTSXFHK8o0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9ia65hBhNnUI2SbmJ1n7ozMyisz9pyQ93SEN0TuynYFLWTjlMnKek1JBpQenWkRlRwd9sYVdNQT0oCf+6O7yv6iGKoE46sMaEg8NqPUVZ3LNLrBaAZedhZh6dtUbKK3PTrjVMO6hMRaJUMo03rBxr9x24dFx+ITn/KxUg2DMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wb1MF6ej; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lanvKTNqZhbIUG6pcILYg1Ijf3w+itD0dMTSXFHK8o0=;
	t=1742133661; x=1743343261; b=wb1MF6ej6hNO4/AomMdNIagwg5pA9x3J29zEzF8D65JLZKy
	jG/BCUOoUWDhPDUC4SJGNCiq+Lwf0ahjuLDjTOh4cs9ZBZZJbD1XYeg0+Ko+UJ5NcrC5/gBjhpJHz
	FVnzphz/3buB/5T0/LObj9iEoM41E49BLn3Doy+RzkXgUxwL1BOVCGZXAuQrl91iC5K1rgL9QUIJr
	UeoP7pFrgxLdNsvhPokl2CfzhshLQE/P15j64wpAiUXQ4g59xqVcksGUfVONVWRpZu4Tqn+loFF9E
	0vtvAredMtNOFYDGuqkm1pqprOwFGmcVWRTWwLdj1Y9v9s+1BwZZ/0fUxcuiopwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ttoXq-0000000DAYk-1uFe;
	Sun, 16 Mar 2025 15:00:50 +0100
Message-ID: <2bf53580ead86edc83de8f97d1b7de576d3ac3b2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: minstrel_ht: Replace nested min() with single
   min3()
From: Johannes Berg <johannes@sipsolutions.net>
To: feng.wei8@zte.com.cn, linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Sun, 16 Mar 2025 15:00:49 +0100
In-Reply-To: <20250315111254625RMIKeUh51j1Xk9CWuu2LT@zte.com.cn>
References: <20250315111254625RMIKeUh51j1Xk9CWuu2LT@zte.com.cn>
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

Please do not send utter garbage patches. It wastes everyone's time.

If you don't know what you're doing, just stop. There's very very little
value in such patches anyway, so don't send them. First think if it
actually does something useful, and if in doubt, don't.

johannes


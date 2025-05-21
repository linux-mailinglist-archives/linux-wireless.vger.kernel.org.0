Return-Path: <linux-wireless+bounces-23203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E825ABECF8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBA53AD275
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA5201266;
	Wed, 21 May 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VyX76Bn/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746C7DA6D
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811968; cv=none; b=cHQTCBmk4oBGFiIebjIjkMIRJH4w/1cfMJrnFMQxAluBPUtFwzVR3vr5gWbH7A511tVr4KEmr6gKILOIlT+mOmgFsmbo9tvOIu6T8TluK5tKGPxLvq1zBJlXHclH82KeG7S/OspH6W/EfmY3rpJZOe23ivkP31Q+I7AOfWtwn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811968; c=relaxed/simple;
	bh=0C70zI1ebK0kas71SzbYEYeU1Nlh4qNEhqjLLKCh6CA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xvyj0ZngGyGywPdevTnQspB19L5y2OBjjg6M2YGdVEZ3OBr2b4LedhKshiLJCl/Y0K2vyBoQcB+Ip9PuijIM44tP5f2c5xo8i0Cqe42kv3/50EuKCOFwOxZ88pR6QMLLKQDcAvufvbIMkfWUPml3UK4G+/kpYbAf7jN6iIJFJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VyX76Bn/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/AX9b0jB7q6rskYsdAzwLMjNKe15u7XA7wXGzSsNQVQ=;
	t=1747811966; x=1749021566; b=VyX76Bn/hdqhvKyFfv15ZDPQlxjYgabH1KQXTJnC01y7l+J
	IoGFTsNmIrgCN4N7q4/1FalC4ISapTRSLwOMW/iVRLj4jGpxnx+fUp/XmR+jPmnewa3p7ND8yKMnr
	D9ptwgKGqQ/Jqeg/pQ4y2JzYLn1nafCndSiGD/QRwZBYm5tA6gFkpGKP3bZUBGzmB6Q4c22CjnfVv
	0XAEjZl0Ml1XvmxAjMI+pw3Qmud1RslvMfeYBk8a+XXR3OkchjxHff8d1L5n6QLxzPUruiHKhehbw
	/i4LEs/Of1XBiKUUDqNSZalgBA5mWxkO5BXpMpb8BW2j8SLk6PAhPBrEx7fiSpwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHdjW-0000000DwwI-1VDz;
	Wed, 21 May 2025 09:19:22 +0200
Message-ID: <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 09:19:21 +0200
In-Reply-To: <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
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

On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:

> +++ b/include/net/mac80211.h
> @@ -4569,7 +4569,8 @@ struct ieee80211_ops {
>  			    struct ieee80211_key_conf *key,
>  			    struct ieee80211_key_seq *seq);
>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id,
> +				 u32 value);

That should probably have documentation updates. And passing a negative
value to a u8 seems awkward? Maybe that should just be 'int'? For a
value that's likely passed in a register, u8 will probably require more
(machine) code anyway.

johannes


Return-Path: <linux-wireless+bounces-35877-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALAdGRbu+Gla3QIAu9opvQ
	(envelope-from <linux-wireless+bounces-35877-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:05:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47B4C2E0C
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 008703010257
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C243EF659;
	Mon,  4 May 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7661RZl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCE3EF65F
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921554; cv=none; b=QYbwNixVHCUk2AirM9B6WPtDkUnf2HxXYOaf5ZZy4akGe9ZIveCo+i1z3AE7o0TcOfzgwfKgHAZCSjQ5lc6UzrM7EYPaFXgeh3Lg2V3JDGGYKcZ2RWzZ+zo6pbA1VrvpFbJmniXJhyk6BvVOpiKyRclcc1xTAiQfY22ItZQleiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921554; c=relaxed/simple;
	bh=q5HtbRF94Pn54snggSn/E4S0jrZKW4+oCTJyu6Je3q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHymeCZjzAsNcNvVmRkn3JDM/p/5ik8AbLUuwdRWc/QRjn9mKiakYbz2i8Mawh6uHf4pxkY8ceIEPtDeE8KITXlvlSXBtvZsHxkR4PGFAVVURXYY2S/qRJPLzJV8bvtrM8HDt1QU4YYeH4cUgUjdBM4uND/D9B23VP/wOANeAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7661RZl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44da2de25f3so946960f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777921550; x=1778526350; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5HtbRF94Pn54snggSn/E4S0jrZKW4+oCTJyu6Je3q0=;
        b=Y7661RZleu9+nRxT3kWsGpa7Epz5CRe0j9zspE5ikPCmqM72tdZilic+Mx6E09NTyO
         ZHdEq2hZcdHC0m9U2ZcXzisN1zqMjHZjnCywUovUwphg1NVlRC4pGLZWluGmTvpvaKUu
         syX3OxIS+onvbi9Pu6+L1L7cqv4zWlLyT/eJR/Q4b5rY3ZNGHMZwj72puj0liLk3ITMN
         JkPye0/rhvpwLEl1+wn6BcmnFiDly74gIKM8vJqoNnm6IMkXuPyD+6iq33+uhte8P8Gi
         46jQzxNKdlW/9QlMzt6Y5wAPTvGTtj6bMqpWQ4zHkak/BxQPvZuz/+ntmvp2UHIBVN/4
         GPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921550; x=1778526350;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5HtbRF94Pn54snggSn/E4S0jrZKW4+oCTJyu6Je3q0=;
        b=fzaMel1fLGZxRUuXFB0jpLCsWa6S6xWKitAcz86/KZq1rV0pQ3DQ5ao3HWXZEga0IC
         3C/my6xS3tzRM4nT6h1e75N18Kn2UAbxZnXRQ+v43oOm6dSp5yDK7ATWoEcqT0JrQJrv
         5MtUfwt2bWe7/n84iKA0HjHBTunZjEZtCqBWqXOb0NOIGs7DwH9uvNcs3ad+Iog+3SSC
         +YDEt4tKay2NStuLQH3OeopFb/Pk+TMvvVwLoROdn+/WjSCEVBpt5Cc4WhxYDQhtvEKr
         gvZX47ssywWD2V21EF07gU31vADwX+S2H0WtS7Ib7DtZ3bOeHvo308khZ3WRhrOgMZ/j
         nCgA==
X-Forwarded-Encrypted: i=1; AFNElJ/4mK2GiDFjryum1TmP4ZP8IxmeHz/Uj86hyqdZgHDiXvUihts9BG8f1ADwK8d40VF8mXYfK8+lN/VVdZJ82w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEr2FNY54A9KzQKL4WVkB6sXuwpOPPcrXG5ekj9tB7rKLDTXK
	K9b8FBbm51yvkFwtoYg6ztfz8fzDjlGohiLZQs/rE1UY8TMU7r7HQ6g=
X-Gm-Gg: AeBDietmqiNnp6ek0qvQyy/MqJ85/DnboaaPrK2hDNwc89veeZR3cLIu4toxj9Z618a
	7ieFc8hjxkxtw4znOzrkVFhF0s0i36TwZj2FGLOSay1YLH185YirSGnn3ui2KBbDwbJFIyJMO0t
	25LoG/Py9AfkdjSgHTkugkTSReGvitkxqezbakvuwhRBZq9u7zYJoKvyfVcEuUMJqEbeq11OQM0
	GcNKmfP5qQKyAmdZMGgW6BIdFBxYRuca+2n9z8WCFUssuxm2MnLLB6dhTjUTo1KQNB0F/DOTiic
	4zvGzEUTT2Y3RX41EPeQZ4LssxtY7ujxu/qvCw4kl2dKg+RkVHfM0EoBRAWqz8kcmH7yTYXHzP9
	FNTo5ebY1dr9gn/TTPafKYDBp+PBQ53y0EWiQzr+o5KiDvR6n2qV7d1FRN/WPpAzoE9WggKXpMn
	Lu
X-Received: by 2002:a05:6000:310e:b0:43d:a37f:8d5e with SMTP id ffacd0b85a97d-44bb472271fmr18685488f8f.18.1777921549502;
        Mon, 04 May 2026 12:05:49 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4500d172c63sm85886f8f.8.2026.05.04.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:05:48 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
 tristan@talencesecurity.com
Subject: Re: [PATCH v3 2/2] wifi: libertas: fix OOB read from firmware
 bssdescriptsize in scan response
Date: Mon, 04 May 2026 19:05:48 -0000
Message-ID: <177792154836.3040070.7814391775444667231@gmail.com>
In-Reply-To: <afYuwVf23vKag2XA@stanley.mountain>
References: <20260421135027.357622-3-tristmd@gmail.com>
 <202605030019.lL8x0ZPx-lkp@intel.com> <afYuwVf23vKag2XA@stanley.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0E47B4C2E0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35877-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]

Hi Dan,

Good catch, thanks. I'll send a V4 with size_add() for both
the pkt_ptr and bssdescriptsize checks.

Thanks,
Tristan


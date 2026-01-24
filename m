Return-Path: <linux-wireless+bounces-31139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIx5GPc7dGma3gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jan 2026 04:26:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA397C4D8
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jan 2026 04:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 329B53002F78
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jan 2026 03:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80FA1D7E41;
	Sat, 24 Jan 2026 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pwno-io.20230601.gappssmtp.com header.i=@pwno-io.20230601.gappssmtp.com header.b="pgN5e0DV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CB1448E0
	for <linux-wireless@vger.kernel.org>; Sat, 24 Jan 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225200; cv=pass; b=j2S2o6eTsY+4QctzyonqMuHlgsy/AW79WCkqUCZLDgzMBLQPEynHz6XZxjPTn5YQVnSaYNiFgUy5ORjry66XFes1AjCtJuQ7Hta9dFpRGQRCiqkZt2rMz1iqx89BLEXVrUP5Vn5SNEla6E8xJDCz/eTA06uTAPlrL+XCo/ptFFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225200; c=relaxed/simple;
	bh=Zkh7kK+NQRaP4o12y9NBQhpGuICJgBOVB977wuucGeU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dAn+hM2ftGWk9US1jDZ4GeXVs2sfytIvuFVWEKJaoVMVSgffsyC4dZsxd4w0sGBo5ZYn0Kku+dP0TnNyOdHBgy2XFG6pOg0k2ohun5ZQc31Onq3o3Te1nEJb38LCFeb70XyNmUlFxMd7xy7XdsQzme7yeH00S4sKO3oal+vOIHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pwno.io; spf=pass smtp.mailfrom=pwno.io; dkim=pass (2048-bit key) header.d=pwno-io.20230601.gappssmtp.com header.i=@pwno-io.20230601.gappssmtp.com header.b=pgN5e0DV; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pwno.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwno.io
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b71557299dso4077909eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 19:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769225198; cv=none;
        d=google.com; s=arc-20240605;
        b=eXEV+H5e85fvfPy2VDvr0jleN4P3IVhV2GLPCm9dVAFLCkfL0UgbpDy0YZQEMmEzCC
         zFrp/putTYoyEoJWYf5wPO7qNj9mKvSfIX0QoQ9MRFCyKLzW/bk7kiIqaI9n9GFiDTkQ
         kw/ETnMZEC4kBYQL51avZxfS4E/SNYAv056J9B+qP+vs58EKTTrcs7/oqpgNg7mlyS6A
         t0/BjUJ9CLfaADkheV2abN6M0eGrE1whT9FXA004KIlUa/c0yG6LEM1FFAo9JUR1oe8u
         R5UycOEZFwczjIxE8fqSSIXucpSS0+KB/HagYzQnpazeOkr1RodHhLwuYhZKj3VjHxts
         keew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Zkh7kK+NQRaP4o12y9NBQhpGuICJgBOVB977wuucGeU=;
        fh=nbc55yupjusL3bboQ8QwxWZBFYkLcOpmKKSombhMNYk=;
        b=TafXazkwVaBuP82EqkqqUell2ROZhO9vIlusWHPBF0Fjr+RCYIjbhpAUN9aIL7Oipt
         nkKD36vsuzmk3speG14kLtvfHRarSQ650XaVJtp3uWwpAM2gDxILz3Anlk05Rm2U3MmI
         HlkttgqYnnObdWBhbUPnK1qO/y3zNldzclZDpQTi5y7N4+TtvUl1AuEvv6Tvdp4rtYq5
         fUisQNQVf2ew+N9o4QVHUg3ivaqhdSYqQy1fRQyCP0wHasmKGJLO2dU9grYgyDj4oiq7
         nqiIVuy2yCiJ2sa5KUiexWxGWzmrTGf+5JIOF1rd0RrIYQ/0Gq0kbbaqe/R+rRdbTBiN
         aPMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pwno-io.20230601.gappssmtp.com; s=20230601; t=1769225198; x=1769829998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zkh7kK+NQRaP4o12y9NBQhpGuICJgBOVB977wuucGeU=;
        b=pgN5e0DVRMIJwHLhL3M8sGyKi4BWnlcj7qt+MFBWRemzSfTKAL/VVE8iAIQW0qK0ug
         DTUGSZizvF6gRpkooaa6dPulPGchjMRxUjAA1c5zGNrEIX3Wt7X1u918qC1qsd/1/0Gq
         ln7o1IcGAiFTcvZgbut9C69HM1xvEEiKdIPoMlj807juBgXtGXCqDuHl+CI7FI5MLAmw
         7h0yOyXef4nfcFyLWE/zD8WIH5BH+jDw5OUGbZQWg9Qw4KKBBHLp3U8XOYkeJ737QTAV
         r+Ot9jyU1eg2/bNrqrk0nO/2mXoi9ces3DK5oFKy89+mGz8CjO9Dwb59vImCzdb48V88
         tk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225198; x=1769829998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zkh7kK+NQRaP4o12y9NBQhpGuICJgBOVB977wuucGeU=;
        b=DP42+vQKX2EiS54Ba/U5FvohVIfRuP0yUEQT6AnvPds/clCOhZlktQIBneiTGoD/oh
         ySmuYcDI/odKLSVE7tBPnYMD6km9ItwoFYZ20OzVDOhXW1DHvKQR4iYkZlKjv+GtbA5g
         /9xzV42Nj8jspXFePv/PGPBNmX1Hr1m6ZY3Vvh0yGJV+t736ZUsbo+QU9Ru7Qzd0UAF5
         Wss81/vY91dGi3Khk+zax/Hpp8J78IOnGJqDNmQY2saAcx4IGgSq0MLUupqzxlcWBHCY
         hczyp7g3YfkU85aI/sCYQaRw9JXp9UhV+f5t7UEgwvbBmG7GjRz8BWbaRDb1AGZBKfW9
         oHew==
X-Gm-Message-State: AOJu0YyDNliZMgE5kWcRU+R3WQlQE2sAIVeQeHjXXgc5YqjJuCUrBKjG
	E/yql8LY6zJ6TIzXYVUck8xabkxnCGFmlp1Kn0yNVLppdtvKysdUORRyFAgCf5AACv7AZzBMTCU
	TnLiTZLeVtUm4uoZeQfWRBQKjjMx1HKdCyV1L7b0jJXRZ/xN9rhSyT080
X-Gm-Gg: AZuq6aJhm6uN9jKJ0iWjFjYdvFLbw5y5/3Od20hWJC8tsk7zucKmt3zOOKGTU/kAjkO
	3yGflp+3+fAXwSZieK4XDg8VdlabJzb2szwHhu+CmZNyJlbydObOvV762RdqtjM673n7syfLU5L
	sfsPPLXca6Ng0RAGPHngE5NVb57QY+0bHF1rjeW5t7VceE1PmgxTJdxInrqO03AnlM5NcfQyEjC
	S1re/wgqqo+jZ+SoIVT88xHVhlj0XSEiqXtGxXx98/69fScNbKktqTAyDp22Xqfke6077tWyoIm
	jbrBx7U0Tv71WqdrWHkt3yPZ0HDiZSclXA42
X-Received: by 2002:a05:7300:a49a:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2b7399b0eeamr2382930eec.4.1769225198088; Fri, 23 Jan 2026
 19:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ruikai Peng <ruikai@pwno.io>
Date: Fri, 23 Jan 2026 22:26:26 -0500
X-Gm-Features: AZwV_QgMRXZuPxmJ-q3wWkeJtLcTj0FFu-XuVq4vwe3Jg9kChnmcJ4t4rmOUHPw
Message-ID: <CAFD3drMqc9YWvTCSHLyP89AOpBZsHdZ+pak6zVftYoZcUyF7gw@mail.gmail.com>
Subject: [BUG] mac80211: TTLM advertised T2L parsing reads 1 byte past element
 end with DEF_LINK_MAP
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pwno-io.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31139-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[pwno-io.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pwno.io];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruikai@pwno.io,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pwno.io:url,pwno-io.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AA397C4D8
X-Rspamd-Action: no action

Hi,

I believe there is a remotely-triggerable out-of-bounds read in
mac80211 TTLM parsing.

ieee80211_parse_adv_t2l() unconditionally reads the first byte of
ttlm->optional:
link_map_presence = *pos; ieee80211_tid_to_link_map_size_ok() permits
DEF_LINK_MAP with no optional bytes
(minimum element length == sizeof(struct ieee80211_ttlm_elem)). So a
minimal TTLM element with DEF_LINK_MAP passes validation but causes
the parser to read 1 byte past the element boundary.

Input
- Extension IE: EID=0xFF, LEN=0x02, EXT_ID=0x6D (TTLM)
- CONTROL=0x06 (DIR=BOTH + DEF_LINK_MAP)
- Byte sequence: ff 02 6d 06

Reachability
- Assoc response path: ieee80211_assoc_success() -> ieee80211_parse_adv_t2l()
- Beacon path: ieee80211_process_adv_ttlm() -> ieee80211_parse_adv_t2l()

This would result in a OOB read of 1 byte (element-level; may still be
inside the skb buffer). Value is unused when DEF_LINK_MAP is set, so
exploitability appears low.

Repro:
MLO association using hwsim + hostapd/wpa_supplicant; Advertise the
minimal TTLM IE in beacon + assocresp; I used GDB confirms
ttlm->optional == end-of-element, then parser reads *pos.
(Additional writeup: https://bugs.pwno.io/private/95a10f11e34e89d5)

I recommend defer reading *pos until after DEF_LINK_MAP check, or
require at least 1 optional byte in validation when DEF_LINK_MAP is
set.

I can provide a small patch if you'd like.
- Ruikai Peng


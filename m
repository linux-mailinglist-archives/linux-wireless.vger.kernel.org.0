Return-Path: <linux-wireless+bounces-33038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMEBLvtHsmlrLAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:58:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DCF26D3EE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8A36300ADBF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 04:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B039448E;
	Thu, 12 Mar 2026 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="JMGjBBsP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0471DDC28
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291510; cv=none; b=rQs1pwnQ0aONySLUiC8P5O7UjTSAsPZmvM0NBoi9fn/msgawXO43cM3Jl7+B8fi8uFz2V+81xHsxWk5Sls1SSCrPQQGpB9Pazopuef8U1I60VcvMrn2tJL0SZGP/8gjHNmKzWX9qcYVbi9/65rQTV8r1vRPi2p7SVj8VgoWKnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291510; c=relaxed/simple;
	bh=yX+GxdEvO1hi/Wow2Y4jh93cZII6gUXqCFCa078vthI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pg3W40bxeUDAWG5PJ9cEqFYYUJSFQJq8nryFk4lK94qHkd4PJYu/OfGZbLoG37S/nNzekqAuSyz6qSiMCGNjIx0wV2R+pKD7hCIj9ncW7YEfmPzsOAsHVCRxD9ySN5Y4TrVMnXv0YZhxz5TJcYcfYM6oACwVRuOKGZZ3lVqCdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=JMGjBBsP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82984c077b2so369233b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 21:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773291508; x=1773896308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyNRbHaLaEUBeW1M4dB+ZiFKtLVtXEisrHjMlTTw+lw=;
        b=JMGjBBsPRDrtLNzyc5i8aOtHE6yZgfz3m1lmreIjp45CYqVryDyxm1MedQbjJ7O4rS
         4ZzNNc3HTuefQ2ZGnMzhCJAUYCqjXEPpvCwVZ/H/NVAP1JYYQ6M7AJ6CxId/XWYxV2Pv
         f9JGf34ufbawaFfGDWrDUYKX2ugYlU8HIBHTGcrAwUNZ3fu6joOJWREWTu1cfs/nGAPH
         fkGiydt7ESOMAKUTGDYAczj5jjAwEO51DLLDE0LrclgpZ9SU1v6PT3CXR+KwgRRrGAAV
         x1rYqlfQ/kSM1DLyoeH4MRufrpJfA4crAVlEk28GTiy6VoXTWPrvIcFNHPPa5VcmP35w
         Mv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291508; x=1773896308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyNRbHaLaEUBeW1M4dB+ZiFKtLVtXEisrHjMlTTw+lw=;
        b=fl+deKEarKNeEpkZ/8jtI894KeTotAoBaFV54zKdIVYco3sOhLcFnJtsUlzEA7nj/B
         h9bDi5tQJ3CLD5RyqNn0m4qaywJ1ddxE/In+GmBT1bwLDFQadT9bIdWtSG6l08rZ5JuX
         G7fZ9TsrEJns8wJw4sM9PwNE79Cv+XIl5Yk2FKqZHhKwDoP0D91V4e0n06XkZ6N5EId8
         crLFZtqlECQYh6dHxSzICh9nfzyIKNicrlWBt7GDyZ24rSGS3L4D/JFUCD1f7MryrZmY
         /lRaMA/vCFzJZxZ9jRD+hsa/xG7TXYTMPjcscjRsClGyRO7fkUe9XbtIxczjJTbYqN9L
         3ByQ==
X-Gm-Message-State: AOJu0YxPwJdomeLz7MLxvUOfRqGI9zrvH3jqzOsIKRZFXpJ2D1qhzE9h
	/LGDHXTso42Eaa968km73dlTy3jVDfW6O3NCqlJlElDaeHqrp0OnpXfJK8nzsG/WNvA=
X-Gm-Gg: ATEYQzxUvDe1lJxDVE13DJ+sStMVFJPXljxuEWAVkc2eX++VpikQh72NvM6+h/z6LB9
	VwqzynBpWrX1BeJ7e0LJx1fZn+jo5bO3DEUTrPjDRKExkL+WQ6hd+AFiaom4k6VNZdCU1dq5Hw8
	+USCE5eJug+Ssa0FH0KWeq80sEGhh7N72lB7n3rAWbx1g9amR8VN5N8GXQu4iG7aveqpatXOsOh
	RZHAgex1z4aVoRXaKxe2zIqxJSzrlZxxaH/8yfx933pCQP3j0WpBc0HXOa2X/E/AjU1eCvoGb6v
	3Ngv3TUnhezGn3vZRr5GRbL5/ntCN8/Ekb9MfNGvTIf896Kw/fQHUmjmuxTcFVNiGJz78nbweJr
	Hcbsqx5pyODHW4DtGUKarHFCBfqRbrk9nfWk5p2T20d+tRCdZu9UkUCM+kch1Gd8PObuzYmfuEf
	DguFQYCjZ+3g86E+waeRwSRMrFUsJR5sVaAMxKwBZNfYioDN3glcTUMbxvRDfWlu+UTjmmlbByi
	LOqID0SMeW/1E2nCQ/X2mHnLooyQo8=
X-Received: by 2002:a05:6a00:92a3:b0:829:7e6d:cf19 with SMTP id d2e1a72fcca58-829f70aca8cmr5135415b3a.48.1773291508133;
        Wed, 11 Mar 2026 21:58:28 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm1382480b3a.46.2026.03.11.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:58:27 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v3 0/3] misc chandef cleanups
Date: Thu, 12 Mar 2026 15:58:01 +1100
Message-ID: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[morsemicro-com.20230601.gappssmtp.com:server fail,morsemicro.com:server fail,sin.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33038-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20230601.gappssmtp.com:dkim,morsemicro.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0DCF26D3EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was discussed in [1] that calling cfg80211_create_chandef() probably
doesn't make the most sense for non-HT based bands (that being S1G and
60GHz currently). Even though it's called fairly frequently, most of
those paths are unrelated or not supported yet. However creating
the default chandef is one. So creating a helper specifically for
creating the default chandef which is band-agnostic makes more
sense. Additionally, insert a WARN into cfg80211_chandef_create() to
catch any misuses by S1G and 60GHz bands.

hwsim tests were run just to double check nothing broke on hostap
tip 11620497a ("EPPKE: Do not start Authenticator state machine on
reassociation") and wireless-next 97492c019da4 ("wifi: mwifiex: drop
redundant device reference").

The 3rd patch adds some simple validation for when we have an S1G
chandef but a non-S1G width to catch any weird corner cases like one
discussed in [2].

[1] https://lore.kernel.org/linux-wireless/6832f8f0b516157452bd9c23b7c7af087d63d425.camel@sipsolutions.net/T/#mdd8f8115f3c8195638568cface3e20ab777f9f33
[2] https://lore.kernel.org/linux-wireless/20260311061800.517849-1-lachlan.hodges@morsemicro.com/

lachlan

Lachlan Hodges (3):
  wifi: mac80211: don't use cfg80211_chandef_create() for default
    chandef
  wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based
    bands
  wifi: cfg80211: check non-S1G width with S1G chandef

 net/mac80211/main.c | 18 +++++++++++++++---
 net/wireless/chan.c | 12 +++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.43.0



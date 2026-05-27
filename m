Return-Path: <linux-wireless+bounces-36963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGzPK29nFmqLmAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:39:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D385DEFA1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD32303850C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 03:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C2385529;
	Wed, 27 May 2026 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="ZmHqVfVU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C493806B8
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853127; cv=none; b=oESqXHTVLPNKMpQO433Oq+5Ld4Q6oyeKINYmZbxaHU4WPNiErbxIgGwIcPQ1ytLOUGZl1WV3WcCD3PPj4Qrcqrum4/+Lt/HlZgrr0koH9rs4k3HUcUFMxMJajaz0Cuwstl9euiulzj+QezlAHii2/vX3/X45GwhHxRwCBRBzz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853127; c=relaxed/simple;
	bh=M+SUV1ryZw3tTuOnQQiPd2QRHlP9X5yNPblEHZ2TtKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqSvEXveYxfcH+mKsNOrEo44JAvIxiJFIXXx69eyTz15AHSH90OqO5UOve4hgew8n8DTgzxzIt+uwOoO4G53HHnXD0/AWtlfXGvp8rXuMdfpfVChK4DAWnGhXkuNId5bMvnwIkLVYZLnzwUHtoudCXbAaLLwmWPG+73fqCc/SpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=ZmHqVfVU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b788a98557so72475715ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1779853124; x=1780457924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkJPHn7o5ifpAifkHHZcZ8JrQv4oRjgOYQu45cREUj8=;
        b=ZmHqVfVUK05XgVzWwUinurW5d/xES2Csc5ylV4/GvV+dJc/RTXRMRHVNNjZsX5Y5AC
         dDxYMkXeul00T5xjdYEtQDJ3fHA1YxuCFXCT7Fh5rYH8nsFfojhxAQ1buIhtABvc2FJU
         RU7PCYqS75s7GwlgyIgnRytoRSpa+GcpiPkiKQgXObh8gjzTPzuWePRYzcsglfAHlPR/
         gUP43L+9ghIB13Py9f9nL3w9sjtakpTH8bmsEIdfxzNFuVEsQzlNNkYsiJkcBjekUY/A
         BysY8iQ8k2vGDzHDSs52nbEtSl0xP+LDtdfZG7CNw8B56Qa8y2n4t1G/ALTq7u6P0nqX
         OZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853124; x=1780457924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkJPHn7o5ifpAifkHHZcZ8JrQv4oRjgOYQu45cREUj8=;
        b=o8ZhLYkVW1xM8m4cySegFEfLl1Xs7Im+Gvx9WzT1BuCO7W6nqIfdG/bwTO3BWkAJ0p
         ajHppCQdcYc/4QWtFZ5dBt3sMUt9rmQdkojbRl2Hn0stzXxh6thKPOID9z8xGhgjRWPV
         wsa97E7ZSn6S8oo0NciZcfIKu3fRaOjzQZ2fXWRm9+OILUyhWQNtiBF4FNUPcQfxkzIT
         JHGtjbQeVWQyKO9LvtyXgV8+1ouq0h+rGChQTaLHg2Vd2ztcHq3LneTWgLzgZMsIaxTF
         TWYYsDooj52V7zMfTZa4X/Teb0YPSuAMFFSfzUXrx9kpdiih+3aJPDLQJjhqAbN1DKQc
         RDjw==
X-Gm-Message-State: AOJu0Yx/4B0a0Um3jYL9rn+o+LHK88O5JvmMul675WcfhPIOo6CtL9zK
	aYx/vZ/i3nDJFLXbrK7BN51c4JglVbyQ9AmMrxhRn1YYkOTcMNsW9a6Moye2n/DmnATTueY2Vis
	4tm8S
X-Gm-Gg: Acq92OH1ro8VLbXBgcjJBnrHublKiT5K8ZKoxNiDXhR6VV1kXzOlrgz7t+fTNa6pKlJ
	8XOiyMmduxLSeVIrPJz4TcS3QDO0XiHqJioa6NprZxg/VsA/dDkCZp2cvk/rA2jrXabGbDpfSN5
	gizM1C3voL+UKfTRktLVZiqSAJGw8buII8f+EUUanRrkz/mL9ctphNoYD41UF1BA6YAc3ikRI7/
	FmS1mej/N3cm6jg3G6S0vVv0xHhAh7nPy5l1lL9lj3xPbh0KlzPB3xE2HPdVhCC994dGfkORKv9
	IJtrSVW2W4BG1Gfxg4YR2+0HTGCYL8sjCZOF27xC3Lk8E95M4wHkA9WDWPhBk8uQ+l7GAViq06B
	WGVE+cMoNhS6L8uaMHMenCteRn7H+uUevK7Przpg71BITVNajPvnSanyPSN/H8HOFRRNq8gAaWy
	Oy9nghtMn1mYCo1CpnRODIEZcsVqpWPw0z6fsqTCcjc8c7/5GCM8UhZPupt1pC38o3IENZd+WtD
	B7ascLBP9jCR4RaWya9RFOawWSIF+Q=
X-Received: by 2002:a17:903:1a07:b0:2bd:8822:d8cb with SMTP id d9443c01a7336-2beb063193emr237524425ad.23.1779853123733;
        Tue, 26 May 2026 20:38:43 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5924211sm127970475ad.84.2026.05.26.20.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:38:43 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 1/2] wifi: mac80211_hwsim: don't run RC update on new STA on S1G vif
Date: Wed, 27 May 2026 13:38:27 +1000
Message-ID: <20260527033828.183821-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527033828.183821-1-lachlan.hodges@morsemicro.com>
References: <20260527033828.183821-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36963-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 10D385DEFA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mac80211_hwsim_sta_rc_update() is unable to handle S1G widths so
when a new STA is added under a S1G vif the WARN is hit preventing
hwsim use for S1G. For now, skip calling rc_update() for S1G
interfaces. This is required such that the soon-to-be S1G hwsim tests
can successfully run.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

Ran hwsim tests just to confirm nothing broke on tip of hostapd
and everything looks good. Hopefully this is the last if (s1g/!s1g)
for a while.. I am to post the hostap patchset in a couple of days
so hopefully soon there will be s1g tests will will actually
execute the S1G paths.

---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 67a33e5e7d54..0241b38beddc 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2816,7 +2816,10 @@ static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 
 	hwsim_check_magic(vif);
 	hwsim_set_sta_magic(sta);
-	mac80211_hwsim_sta_rc_update(hw, vif, &sta->deflink, 0);
+
+	/* For now, don't run RC update on STAs on an S1G interface */
+	if (!vif->cfg.s1g)
+		mac80211_hwsim_sta_rc_update(hw, vif, &sta->deflink, 0);
 
 	if (sta->valid_links) {
 		WARN(hweight16(sta->valid_links) > 1,
-- 
2.43.0



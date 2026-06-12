Return-Path: <linux-wireless+bounces-37750-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LN3qI9EkLGq2MAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37750-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 17:25:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F367A82F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 17:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Hjznpygb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37750-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37750-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9619330065D9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C162F28FC;
	Fri, 12 Jun 2026 15:25:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619962EBDE9
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 15:25:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277901; cv=none; b=uoiUTN5G1n7Mf899a1rnVB6ztgd8qgw6g/tIUF1ehAeyYVVGfnZ1tbIifjLDWehg0CgGT8bXZ61xhzkSifIH7Vy2E21ScBQFkmnROuWWAjSqRKtDLw49TL5/rPheukMex4veAaQYw3fsoTZgLsVjRvmm2KS2IvN7qep6IUCC468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277901; c=relaxed/simple;
	bh=78U7QauUk0dnW2o0xhv1MebU5tpI7bWkDT6+gCoo0Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLhsYgyQfqnLCrcNSUqxbWvUFGLotbkonZAhtiDwUTGq0u2FfYX5FnyBHUJu/vK7NRD3y5ZzW5YF7imeiqmboIGWS9SO0JWoi84FK21vVC3VHja8rbuTPXOaI0LxdxS0QzZizvSQuY4Cfh3iuuGq2WTGU7y0G0/xTPvU6uv+F7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjznpygb; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so869879a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781277900; x=1781882700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl2dpQV7rPZXhzrcHJ01w/u7zK7v9/YyGk77q76ol7k=;
        b=HjznpygbjDjNobyzc5F2kVGKCluooSUbn3HmIkZ5pgtQFovXbv0eea1lUa1xkL79Wc
         aiSHgzwEoirjIg3Qme2mXoVoK1ON/fkrcfsxybgh0I/dJUtPcfG8u1HbMfie3pqPCB92
         D2LtrQ1uDW9duaNs1HVeEK9Tq/p4ykK7S0RrN96YsSKzBIYhBBxGQJBlsSfx+bZLJkV+
         YT9FZbFqFGlXNzUWfhcqWuzRrqquO7oH0i9QbBj4EGZ06JnA9yKTtbIenVd5UntKmUTI
         EJBCXioEVlJ3gSjDSF3/XlFBue7DXkuR4MoBN2a6X6ScdHRi70fl71uYHC3rHhkVfYqN
         BBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277900; x=1781882700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nl2dpQV7rPZXhzrcHJ01w/u7zK7v9/YyGk77q76ol7k=;
        b=BMPhMzGBnqsES48No+kGHBW9w3b11IpKrGS1gMPNLx6tMzPI2UnNItqJUIaUhykCnp
         davBkA/sZBO5GgudBZn+HZthykOQ2pVdwaG4SgQz5CspNzyKuSuyP4CG/4GMu1R+xTGi
         4zaKVcY37mjJ2aoJxgj68+rdAqz5gxidjNf04PAxg9iFSnJLCF6NLT1ofsugms57rBTf
         RF5BiyDKZCBmO+r6EuDNRz6+IJofRMRzAwlXuoYpweepWb+OYMdIzFZSIBC3wSK7tYTu
         ZEE50O7iWIUWMnmlUegQypuoBh24NOUh44zXLq8VvQmstrbhL+atwrJlEil2qyvvCtKZ
         hvYA==
X-Gm-Message-State: AOJu0YzioFOFZVXpZBZHXBaI4Blhl1qXFRAkkthR3RbVA6GijVJAALiA
	IdJ3jR00vDcahMWs2C00gEha1FaT5uKX4+pBEMm9keTxpaco7nvTYqCRuM6CopURSi0fsxjX
X-Gm-Gg: Acq92OGVZJrDaYqQarHgWvf/xsnTVDOSppNYR1knJoyiBSnFRVtE+LmvSw9D12Atum5
	kLe2PDOUtdfPgMnlzcrprfNeDZ00/CQsYwCdpuYKFrwmYYGW0/bTpuUkUomkPVITDkijS/TDF0I
	T6EJbsnnTcTa5msmSiDbb3gw7zitVSTJlXcrY0st7HfFV/da1lTuiJapxOgSrHoyieXubC1xJGP
	uAkya2yiEFkYlr4g5iSiZY67NHii8f8pV3GDgyYsf9km6UBTUdqxUyCVlAnHOG0QaWJsm9phbhT
	8BqNToy+s2y5qdFYg+Xr56i6ZOi0NQaJ9ah0qx58Ft6H2ANaJzsUOtRyZ03hlK1hr7PzlbGc2a3
	9Wvwu+vp78vMlvN+t6J0XJ7Ky27ziaUbK6m29rxMHs+3OK85qwVEoMDox1oUjQvfqX6aNSLsFzi
	1oHI9bs/4Z7aUNFeZiyQ9kOv1ziyeUPuCe9ORvOUoRs8y5fyDRUeqDgiO9I/rIE3V4sFIndcQ7X
	et0IR52nA==
X-Received: by 2002:a17:90b:3cd0:b0:36d:a510:f908 with SMTP id 98e67ed59e1d1-37a01846f18mr3999585a91.5.1781277899664;
        Fri, 12 Jun 2026 08:24:59 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([2408:8459:881:fe1a:4533:6957:44c1:cf77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8ec3sm2605424a91.3.2026.06.12.08.24.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 08:24:59 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: johannes@sipsolutions.net,
	lachlan.hodges@morsemicro.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: mac80211: avoid non-S1G AID fallback for S1G assoc
Date: Fri, 12 Jun 2026 23:24:41 +0800
Message-ID: <20260612152440.25955-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612133649.92630-2-enderaoelyther@gmail.com>
References: <20260612133649.92630-2-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37750-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 306F367A82F

When assoc_data->s1g is set and no AID Response element is present,
falling back to mgmt->u.assoc_resp.aid reads the non-S1G
association-response layout.

Keep the fallback for non-S1G only. If a successful S1G association
response omits the AID Response element, abandon the association
instead of proceeding with AID 0. Initialize aid to 0 for other S1G
responses so the later mask and logging flow keeps a defined value
without reading the non-S1G layout.

Fixes: 2a8a6b7c4cb0 ("wifi: mac80211: handle station association response with S1G")
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b98ddfa3003e1..ddd3479f0b403 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6659,7 +6659,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
-	u16 capab_info, status_code, aid;
+	u16 capab_info, status_code, aid = 0;
 	struct ieee80211_elems_parse_params parse_params = {
 		.bss = NULL,
 		.link_id = -1,
@@ -6737,8 +6737,10 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 
 	if (elems->aid_resp)
 		aid = le16_to_cpu(elems->aid_resp->aid);
-	else
+	else if (!assoc_data->s1g)
 		aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
+	else if (status_code == WLAN_STATUS_SUCCESS)
+		goto abandon_assoc;
 
 	/*
 	 * The 5 MSB of the AID field are reserved for a non-S1G STA. For
-- 
2.50.1 (Apple Git-155)


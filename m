Return-Path: <linux-wireless+bounces-34834-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJnoEJgQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34834-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:26:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3314089CC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36B573113D08
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EBD391500;
	Wed, 15 Apr 2026 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fan5027C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD75396B67
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291818; cv=none; b=HezPoIqL3gE855HKRURx/CHYOMtPoFGhbGDMETSlVKmqfxP8okLJBYNBI+k+KcrgzqwdBSDTw1Y83gJzTP2EP4zeJF3ueIanJOb9NYXJ3iS4IOCvzQZxH/np3tzV8tWvqyti6NqWSigUGGLZh4BSazJFnVgmNtKNZsHvTlfK0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291818; c=relaxed/simple;
	bh=MavtfL3xiOSiEDuui2n8xegyyd/QvogrGBdkqZOpWic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCZADz97+R9w8QysSi7oOBtMYJW34qwWgN8s4K003WZpBjhKqucYFFQhajP0C9ZiaIINOdbyJ1LqwXic+2qTDTuMVmcV/YsQKUlh3tOpDh+vLI6v10WrPHJsSE4Nd5uWDudmZ1LTi+CPXzev7aiGyazCbCLPxyNbvqHmqethCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fan5027C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so66785005e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291815; x=1776896615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFwd+xRU79WqFGCbQieg8NXuV9zuceNYi5AxTmvFP/Y=;
        b=Fan5027CshaIyBOjgjPJCnVncxZBskzqjwgUCeyvajmuh6izD4cvrSo2yXHUF79dGC
         Jr0gJeIJg8fNPoQYQryHYO9o9QvaxT9/6gonKycgno8HFPZqOgAP/d/5wikAPF9GpACn
         exYYEMbfK92LfbtwjbN24Ga7cSpVO9IAdOEn5+4yMLuMpCp/itChL4mu1JQDKL5FfejU
         9Ac1fBSbmwslwj4eM+newkAT8vH+NeQy40Dr9pe+k2WBKCL1ahZifWM/3P4RsAdefi0p
         z34gcedkz2gtgiBbB2hG+z7kiDLJoKA3txljbx+0jQZPd29kULBlEyQRyXQiv/LjAWuC
         66mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291815; x=1776896615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFwd+xRU79WqFGCbQieg8NXuV9zuceNYi5AxTmvFP/Y=;
        b=P0Yis3wWEdgC/lPTGtmxsamq//MVUZyA7uCCg1io3q5IpLyQrq+KOZhq6teVmXLrdC
         27Ui4gNgOjgrnWvYHMtShZGxcbT0hDhyiFr4qF30v8s/kkiYZkFCm8W1H7JmAx3Rc9AP
         mtmp5SWrLtHSPOtodqFNqhZ8UUFtc6LHbgu7sameb0K+9OwgwMH64VK+b3el2kibkV6k
         XPtiyg42xokHjJCNfvsuP8ylXqlKPtwRHAokBTAN+Utrg6HUPyekRQ8/HNkszk33BeWZ
         FrJMVDxKcq9Ier78b3OyAoZDmqiY+ifl0AeoczTevVi2zogIM8RyY8F4b3vVEfEDFqts
         AAyg==
X-Forwarded-Encrypted: i=1; AFNElJ8C/wdkPTt5B+fvOAuIRdzFKxmpd1pMD4M1Xq/X3NujK9EkBBW2zvCKYdBEdRgjT8i9nQHbja4rWKFY4zoMSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeja3fUmQQsirYJOT/OIBrFYH2Ey/FAOnqhv1i2j+y/weC1ERE
	RQ5fmEonx659u0LA16CUCG4K9JB5W6FGe8qwKkaAT02Lkm8LhawT8Gk=
X-Gm-Gg: AeBDieuJxP4e3fHzZyhqCePm8rdmmo4ArW41rzkpRtwjxToQX7v2xyzylxMDBiKJtLz
	OZSHyU01DjtUcd1KfwzsHvlCXfSF3mT59BBPWL44afIHh/FrqccowX6i56258yPkTJ258bEWUFy
	JaEkOnmYGkdLgdNa0O6RAhYRAZDMad+qJYd7SI9Zd+RADxAIMIZpHxAcX1gsEOBHwlKymnFQXNS
	9Ke7rK+yU3T7NquQQYBooIyfDH3Hjhagm9xU+ENiYKOzMv82+W28zSW0InxAKLzYauVqoXjjFrD
	QGdF4x9Z/i2Gn0/mmhIcwMvEhJ3/DMaeH+Yy04oCGG5TNqthJZfDyGiPRh9t5BuOuEVRH+0SDk2
	Fp5HU2FC0YFz4mTdCoAHOs1gE84YzJMmso4HI7VHqHuNjq3o9dVgoTazBDgfPQHUzYYkL5uSDVk
	OyuLo=
X-Received: by 2002:a05:600c:4e16:b0:488:966f:70a7 with SMTP id 5b1f17b1804b1-488d67bbc7emr340553555e9.2.1776291815250;
        Wed, 15 Apr 2026 15:23:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] wifi: mwifiex: fix OOB read from firmware intf_num in multichannel event
Date: Wed, 15 Apr 2026 22:23:26 +0000
Message-ID: <20260415222327.1539269-6-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34834-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC3314089CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled intf_num is used to iterate the flexible array
bss_type_numlist[] without checking it against the TLV data length. An
inflated value causes out-of-bounds reads past the TLV data.

Clamp intf_num to the available TLV data.

Fixes: 8d6b538a5eac ("mwifiex: handle multichannel event")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/mwifiex/sta_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -450,7 +450,15 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 		grp_info = (struct mwifiex_ie_types_mc_group_info *)tlv;

 		intf_num = grp_info->intf_num;
+		{
+			u16 fixed_len = sizeof(*grp_info) -
+					sizeof(grp_info->header);
+			if (tlv_len < fixed_len ||
+			    intf_num > tlv_len - fixed_len)
+				intf_num = 0;
+		}
+
 		for (i = 0; i < intf_num; i++) {
 			bss_type = grp_info->bss_type_numlist[i] >> 4;



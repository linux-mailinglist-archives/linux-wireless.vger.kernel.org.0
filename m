Return-Path: <linux-wireless+bounces-26866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FBEB3BB9C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 14:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C95856D6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5031A05D;
	Fri, 29 Aug 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pvr6Do8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0E1A3142
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471731; cv=none; b=CfgAWoxz7hp0qBgBj3oV9VUCRPsgEv/BeVdFMLH+zLFAfDNzo0XT9cSn2NMLihwA0pi9wDGanfI8REnA16YSN53YOhkqiGZqnAxX35C1RJm2KkJz0/1U+E4B6rU4vcewVNVPD9aAV4zmBJrqThmg5giYljMLuf9ulbDNSYrK7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471731; c=relaxed/simple;
	bh=BMZ/MNijEEIk/FpGTtfiEwpO4Kns+lZU+ojwgvMo0qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiH8HfhfMAIgFVT2wAl0s4Vf2JK60ER8GypiyyG5BSG+e3uGITXeY4wd/d6qpf0A7I/tNCz2e5UjZCR/UwxBkDazppRsH00knq7pHDzIir7tAXGr4lVO2vIu9H4Nzol+NcVYaGDiUHGtMrvUnZajAy54EbsRAIiBNWOzwp4jeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pvr6Do8M; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c79f0a5c5fso1606731f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471729; x=1757076529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ck+n5rGbWRlsQRXehQxg/mLWI6V1ptp52cr6SEHZ1hA=;
        b=Pvr6Do8MxThFjz3Msj3YrYmGCKwv87cKqrIAfKw2jyaHQGnZ4NwgOQ/fv64hdyt3Li
         1ktd6kMZKi3Ie7FAXpWMHk8nke79VkK/t3zgHVR10k2QMhBgIhjjde5F6PDmNpzE6rta
         7NSyrLZewkJQIlNYvW807Y1/WNbcvHCAkdCQCMhCFVlni/GLHKT8YX4GtXUFEFdtTYIK
         q1kEortTHe6wgsDahDgM13uDT6I+KORAYrPg4x0jLgegJz7R9D6/cIygR/vAbD8mkiqI
         dB83wonzOhA/gvhWcz7GCCivDJU9z755wWOQ+1wBv0HMglcZHHHMIRrSoVancdbsZshB
         GiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471729; x=1757076529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck+n5rGbWRlsQRXehQxg/mLWI6V1ptp52cr6SEHZ1hA=;
        b=codsEEJp4gfBXRzIWAS3wDjGO1EB9K4fhqp73ZNJiRYiHzofUlWcyyt6hSWEWdq7C/
         NsW029zOVqNTud1QDR0wArbUKP+ei97eRhqKbDZVY+m/qxpFD7LEP2B6BcoiCEch9c2T
         2MfqtQ5YMeOFqepllu0sy/nz7mzqqrPzKYy71WraWQOU8I49wA1WVKIKsnr2HB0YBjdN
         7el/WeJRsFEji82WEEz3EGQwAzyi5ZB0CmnuSWnuYngf+WwPicQ0rLRBquTo90ZCPV/K
         OPsFueyx16v1pD2Z9ZQgj+VyZdphlIYAObDc30rRWjXi7I7UwlpER7ucmq7Nvi0Ugk+1
         ApVg==
X-Forwarded-Encrypted: i=1; AJvYcCXMEdLgFSHVMCTpva2bHILhomlOkJuhVIz4dhmkmmzQTmFjqrYmkXakhyM7dGBoAZAMZHzVwJotacY4nTZoDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwPyaGOgWUksf0ieZ0Qgnyl++VPTzPguvxTyMqNm+Pb3sy5R1
	n3wElTC4eVyrhBa4vpcSjhECx/bp6rryKW83aGlO5D6tFKCb1ttB9Gs4zI5Qxh5ieCLPqN82WEq
	SvHqg
X-Gm-Gg: ASbGnctzKBnUISRd9usLFVvRW40JEgYNKu6U8Al/Dug7RBK0PY262FdGbnSANUFJmVE
	JV9K/nmkgpt5g9RUwhMDeEmp4hjqhqkqR5VA8SyY1NgG8Uom/rgBEBgzh38/lUq23Woa4DGyVpz
	twvuIw4WeEeT29cUE9ov4+1x5etoujoA2lfte84OGbuEa66RBxo9HkOlhfRehNZI5Q8g8C3X0Tl
	nqrEukFw8dSocXNBCk6Zt/7w0he9/x4tsKkBFPU993RCI9jJBAKwaUw6gy3s4GE0iJMsgV4YYhG
	gIX+h5klYVqZQuogWLrqA86nI5Jb8W/ziWIA+caZhJGta9nyNjauBnftuBVBh+r+GAvpEc2WnWt
	OqQ/PGAkqGQQW8Kamsfw5siCj4pzjezjf0PTpHA==
X-Google-Smtp-Source: AGHT+IHqAL/pnUSG2018CghKhwcQSgL0BqvunVzn+qXjZWNrgfogLc1879jtNukYRptPvZIatFaBWg==
X-Received: by 2002:a05:6000:24c1:b0:3c8:4d98:7402 with SMTP id ffacd0b85a97d-3c84d987994mr18396631f8f.39.1756471728612;
        Fri, 29 Aug 2025 05:48:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf8a64fce8sm3029385f8f.34.2025.08.29.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:48 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Bornand <dev.mbornand@systemb.ch>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] wifi: cfg80211: sme: capp SSID length in
 __cfg80211_connect_result()
Message-ID: <0aaaae4a3ed37c6252363c34ae4904b1604e8e32.1756456951.git.dan.carpenter@linaro.org>
References: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756456951.git.dan.carpenter@linaro.org>

If the ssid->datalen is more than IEEE80211_MAX_SSID_LEN (32) it would
lead to memory corruption so add some bounds checking.

Fixes: c38c70185101 ("wifi: cfg80211: Set SSID if it is not already set")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/wireless/sme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 826ec0a6355f..3a028ff287fb 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -900,13 +900,16 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!wdev->u.client.ssid_len) {
 		rcu_read_lock();
 		for_each_valid_link(cr, link) {
+			u32 ssid_len;
+
 			ssid = ieee80211_bss_get_elem(cr->links[link].bss,
 						      WLAN_EID_SSID);
 
 			if (!ssid || !ssid->datalen)
 				continue;
 
-			memcpy(wdev->u.client.ssid, ssid->data, ssid->datalen);
+			ssid_len = min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
+			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
 			wdev->u.client.ssid_len = ssid->datalen;
 			break;
 		}
-- 
2.47.2



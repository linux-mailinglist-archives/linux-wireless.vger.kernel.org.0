Return-Path: <linux-wireless+bounces-33795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPMDE0Qpw2n2ogQAu9opvQ
	(envelope-from <linux-wireless+bounces-33795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 01:16:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8631DEF5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 01:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F8A30432FD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30217BB21;
	Wed, 25 Mar 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cip7d31g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382E18DB2A
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397732; cv=none; b=k19SX7ubw9PIC+wHKIvh1oru79sojFmDN/TSifnJDXilCItvmJVSqcYKDTpzKGmVZBDORu5taXMBSjNFvg04oQX1wZdsMGDww9ILcxvQHsKjrEzsUt2KbfDRTkMtfj9z9GCjMgjgW4/7tzwLv6KH/D12Q+HJHgPFKQkI9YIxntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397732; c=relaxed/simple;
	bh=0P7oBDeyrtiUEeDcuz2XhUSLvG1+u+qDk3LZCKzquw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE6VgTptK80wAX/nOIAsiqYMQ4hON77jxcWgVdvyhnUa3Lp3PlTj+ziwz6JXHKwYKawkGihqkefOLknrFvaEdkFIkHXzO7+t7FJmaZGcc1Qjyq67bfhAq8ggMv8nXgTpThxyvtBT2qVsdpQLEMaQDzwYcUcH08ddw5mljlyrnfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cip7d31g; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso2824602a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 17:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774397730; x=1775002530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFu/4C9dcZr81R85Vo6ldm6Rbl3IdmjMsm6pyx/n7JI=;
        b=Cip7d31g/X47oecqaofhDWvVIQDy1CJXls40L1McW3R0uzOyCpcM9y/ZH6QrPtv+Ut
         rcQhXLL6DFO2cSAtx81nX9OXv+eiYted85+YAoQCUm8FycgM8/d7e6hhYNLCPwm2MvuM
         RYtfk8/2m6kBgZSflT3Fycs750NGQ0j1Tb92R3ZZw0PR1JvNHeWxfQfmmTFtg6YeyzDo
         /wFod/ZBe9RlJuI2v7pzWYVjeNWIoksfyC/F/b+LOtIJV9H/9ee7gow6qxf9HUU5P6M/
         +YG7osWpz+pIQaZrTuHjb8hIkKsFO/Jnkbc3WE/0EBNMyPD4dP8PJBxzrBMzgA09XRUM
         Wghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774397730; x=1775002530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFu/4C9dcZr81R85Vo6ldm6Rbl3IdmjMsm6pyx/n7JI=;
        b=F7yAYRemG3OT9MYmvexye0IMoJlwjGUdvuC6O5vBLcbjD1Lb60QioJgs9efKXtNvM3
         UIYUpZVT6yMsh/i8kdmB6YDo12VoqKjP/P18S7rBCnyAVW3qdroWBAucIJyrtIDigv25
         ucK5wu2v+Q2BOZ0+4ZtKVJ8MFAvNbLr4E97+2q95Q+m57bKSQ0EgT9ZGuo9IbeHrcyPS
         I2/W8vdNnRjI3w81wpBIUV1orrbmsfGWiI/DPhIRn1bschnbSGwZai/iHpFpcEt1R7nh
         4xwP0o/IaTN6YUyDu3SOdwGKZtTscmt9nl+7iCD2lXyrOJkUwplRYxLVr0rQDiV6QYsM
         T8/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGr5BWkhPQE/lW4aZqSTuMiL6J7DU+S3ai5BcXgSz/qE5NFwXEIO5r0JFoD/OgQNJH9Ekk/wcIQMfOua8LrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0u7e4+xyoB1j2bcwjULYZi27gOPEQ26nu6bmaggMf2klkUlH
	CgUbYRxZrHA/yvKgEa8rrztiRjyubAv5jzEEEXTWE9dhuFG3fYku25YCuPwuLGjG
X-Gm-Gg: ATEYQzxcaeom4U8ee8NBahJgbdNJ08YrS7s2fBFjKJZ1ynvNoej6uc4nEcgjN5+9zEX
	S6YSba5PEc/N8TqPBpS5q85dSwSXAb5LNak91uEn9vyzChnYAL8QaHc9j0DRL5JwDqwU/pqBjcH
	Wn9wvQUlVRyTcwZ82KM1VSylhaPlDQy1PyopFUxyL8EdMzPN/paU4MCu66BUdhzdWftG/F9ZS+/
	n01jJX9h++eZ//mFHmuiYrHBRPGYlgclixppQ7xb4saUayRaOnpaIPZU+q6j/qxV1qsx+oCAV04
	wcfSBcmo4S3/MLa7k/RYl0Z2jokiOQho/JqZzXSzmekYOYszJi0FtZ3fZbFW19KnqXpm7fltoXG
	/tmYiV8M3nNp7QacyO2gqsVd8TRDJbLL8TEElol4HFE285XSgAzz34mjHxQKaDx619p4JfbwkQ0
	w0YY/Rah5VX19SBDPEBJ9saYFFIeU1EIOSzOaflD7LVI+HxLuYkQRVLEBK386yGrm+F2cQ33bRN
	z7e
X-Received: by 2002:a17:90b:5783:b0:359:c7ef:97bc with SMTP id 98e67ed59e1d1-35c0dd8076fmr1097254a91.22.1774397730194;
        Tue, 24 Mar 2026 17:15:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:820:e910:f579:1a1f:54c3:bfb1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c744560683bsm11380577a12.30.2026.03.24.17.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 17:15:29 -0700 (PDT)
From: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
To: oscar.alfonso.diaz@gmail.com
Cc: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Wed, 25 Mar 2026 08:15:13 +0800
Message-ID: <20260325001513.1303-1-fjhhz1997@gmail.com>
X-Mailer: git-send-email 2.45.0.windows.1
In-Reply-To: <CA+bbHrW0C9+Pz5TOUgM_oodhfJnoO7P0YiEdp85D08h=hLPF5A@mail.gmail.com>
References: <CA+bbHrW0C9+Pz5TOUgM_oodhfJnoO7P0YiEdp85D08h=hLPF5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33795-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fjhhz1997@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6B8631DEF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oscar,

Thank you for testing the v1 patch and reporting the VM hang -- your
report was critical in identifying the root cause.

Lucid-Duck did extensive debugging and reproduction work on this.
The full discussion is here:
https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4120751621

Root cause of the crash:

The v1 patch falls back to list_first_entry_or_null(&local->chanctx_list)
when the monitor vif has no chanctx. In your Evil Twin + DoS scenario,
the AP and monitor interfaces created multiple channel contexts. The
fallback blindly grabbed whichever chanctx was first on the list --
which could be the AP's chanctx that the firmware wasn't expecting
monitor traffic on. Injecting frames on a chanctx where
mt7921_mcu_config_sniffer() was never called is the likely trigger
for the hard hang.

The v2 patch adds a list_is_singular() guard: injection only proceeds
when there is exactly one chanctx (unambiguous), and is refused when
multiple chanctxs exist. This covers the common single-channel AP +
monitor case while preventing the dangerous multi-chanctx path that
caused your crash.

Lucid-Duck tested v2 extensively on kernel 6.19.8 with the MT7921AU
(ALFA AWUS036AXML) -- single-channel AP + monitor + injection,
multi-chanctx via P2P-GO, heavy load injection floods (50k fps,
1.8M packets) -- all stable with zero crashes or kernel warnings.

The v2 diff against net/mac80211/tx.c:

 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-	if (chanctx_conf)
+	if (chanctx_conf) {
 		chandef = &chanctx_conf->def;
-	else if (local->emulate_chanctx)
+	} else if (local->emulate_chanctx) {
 		chandef = &local->hw.conf.chandef;
-	else
-		goto fail_rcu;
+	} else {
+		struct ieee80211_chanctx *ctx;
+
+		ctx = list_first_entry_or_null(&local->chanctx_list,
+					       struct ieee80211_chanctx,
+					       list);
+		if (ctx && list_is_singular(&local->chanctx_list))
+			chandef = &ctx->conf.def;
+		else
+			goto fail_rcu;
+	}

If you have time, could you re-test with this v2 patch in your
original Evil Twin + DoS setup? That would help confirm the fix
before I send v2 to the list.

Thanks again for your help!

Best regards,
傅继晗


Return-Path: <linux-wireless+bounces-35449-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCtYAwZq8GkITAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35449-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:04:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC647F8F9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49845305DA6C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450C3C553B;
	Tue, 28 Apr 2026 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkpMmTim"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC13C141F
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362294; cv=none; b=KQHIb3EJuZ12a2aMJRQD3AWVZLGacIbz3X5iUUxgXY3n/bTTAJhDL1LWTkB4Lmzu4f8PTL1qnbzkrJeekJkSR8VWS0DKuGv5NsD5dwpQfGWPkF9Q9Ks5mCmyBvzp496+ePnPPi66+/9xp10XlxvFvn3G9OrFqn5adNsoEWcBXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362294; c=relaxed/simple;
	bh=bvj5YW6DIY3n4aeyM428x7eV3s0S18cGh6G2bQluCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICrgihuBXeyvwQywQkJOq9p7pGwEggs/ftVD3k4GMEId0NFk1qkWdxIN2TIl1UolMDV8glB3mciBKreLLNqq6kSbGEfh6nFL5kfvaqXKe5Zd9Y2V+3rjF0r7YOR5H6MtOj1mnIUNWfQq8+ykh29F//aiDpKjZ+Iz3qF4wtOoqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkpMmTim; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so136717575e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777362292; x=1777967092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay0YrL7KdWQZJLtovQfJUXj+JpmdCsK/vViiNlHAeCI=;
        b=VkpMmTimbVSbwY+hl7R43CVTZETFXV57fBYMd2knDLjQ09zfgzwv4dLVCvJ0TumrJl
         Zvyjv1R6DZ+Q0WyU/+F4DQHuc8GpbhLXJaKOjAAePtgHEBnIR8+PsfxDzyFgzKl+BPxp
         TqEYddCRtP7XiHNcg+sMO6lP1SDx3XKqYXWv10M2jfEh7Cbj9PKNd6Q6yDHWDAEin/OZ
         th74Euhd30GrfPzj9iOihnzsejC7icujCjKgC2wV3qhh4cIs3fYZRHjpm/NeJSZ8MFYF
         8BnI0gjeXxyPpFp2NhDS+xKKGf2VTH+d1recXmWuf4MfIpq2WWY3k7W352Az8uvipYMi
         txdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777362292; x=1777967092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ay0YrL7KdWQZJLtovQfJUXj+JpmdCsK/vViiNlHAeCI=;
        b=UYZSidb2Ch+kDojor5u092E6Ju2b70Kp21HK30aWTKfBkToWJEi8A3rXsVeZT12aVN
         LdKmAHzuV/yh4PTaUDR0Fx9t1KrWqH0dvUI3s2yf00yvopL0yIGgICBAbDqxsy6YLLYP
         58DvV05f4AF8ZehxcLSs9cp54/Kx7apK5rL56R/HYzREtSW8eITA2ahlj5KNlLOLYjyE
         OOG8m1jR48F/jKNIG7Fjz2hgbhTVSm8aMRstb5ad5xwtk6AaUjB+V1jResDbwhcuV8f3
         WO0cigUgR7zledAovObZ/itlPj9ZraEzdzInxyO+UcGYhNnoZhS3prJ5S3dvTitB1ZvC
         lKDg==
X-Forwarded-Encrypted: i=1; AFNElJ/SbOk5T0qpZ1KpCr1mKDALphy7mI1O/+Z++kzSI3yJRRCjXWJ8HdXd/fWe74gxuOoJF8GAxa5gi1SgjCq59g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/OwFleRQifx5P6PoXhlh7YUXFJjbGbJ9e90O/U3bTyA9Ltz+
	eYRulnyMXZ5Re90bo+ss0DUwjiDrMP0ukTVS6yJ/T15ldeMihLB+oSvl
X-Gm-Gg: AeBDieurR9xod7V8lSU0ws7AVQkESlhX1CPHQ1tNYadZ6A/uYn1deLnYOnQ6zCC9iOW
	rQapMKufkp3/fBJdoo0yWnIifPda1P51DyN+gDF2DfI6nQ0Sf/b84RzCDs2E5rzua6bdXZ6ulGv
	2BYboDbWsE8uyaNlWfJvrC7JsO93f8UJgNu14m51XaifpPW/oNvDB/RJ/xm0Bsuj8SB80PLLmNP
	C/FElks+XB5SqZPr92jwcf6m4rlPQSiKJ2vD7j4HkHCix0V9Y/DOvHOTqMYx/Vau8ZeWRXPySFS
	KergfbvHEfSKfAVWxNNa/pw/e/KRGCUKKAD1m233HLrCeocfrnYA4ZA75qIrJyv5sm/7/OQMUQ/
	2DOSAsxjLoEpGme1o9dG672oV9sMZnYgBKAAm7YF/ZDPTx06cKVOO1CT9o7FSuZV+UiCeQU3CjB
	bVbN34z4kHgLVKMzl4DQc/a5nJgqoYNqldUNRc+Flwxy+D2Ou6VeGFu6+fLTOT
X-Received: by 2002:a05:600c:5494:b0:488:ffad:6728 with SMTP id 5b1f17b1804b1-48a77b05c77mr33023525e9.19.1777362291622;
        Tue, 28 Apr 2026 00:44:51 -0700 (PDT)
Received: from localhost ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fa89140sm4167809f8f.27.2026.04.28.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:44:51 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: K900 <me@0upti.me>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Valeriy Kosikhin <vkosikhin@gmail.com>,
	wireless-regdb@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: allow 320MHz channel width for Russia
Date: Tue, 28 Apr 2026 09:44:47 +0200
Message-ID: <20260428074500.ru-320-review-resend@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250708-russia-320-v1-1-53641e8dd417@0upti.me>
References: <20250708-russia-320-v1-1-53641e8dd417@0upti.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72AC647F8F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35449-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

ChenYu, thanks for the ping on this one.

Cross-checked against SCRF 22-65-05 (which added 5925-6425 MHz to the
2007 spectrum allocation, Appendix 2):

  Section 2 ("Devices with direct sequence spread spectrum and other
  modulation types") for 5925-6425 MHz specifies:
    LPI: max EIRP 200 mW, max PSD 10 mW/MHz, indoor only,
         with automatic power control
    VLP: max EIRP 25 mW, max PSD 1.3 mW/MHz, indoor only

  No channel-width restriction is specified for this category. The
  only width cap (less than 20 MHz) applies to the FHSS subsection,
  not to DSSS / 802.11-style modulation.

  SCRF 23-68-03 §3.1 later replaced "automatic power control" with
  "LBT mode" globally in that appendix, which the 802.11 CCA mechanism
  satisfies.

320 MHz operation at the 200 mW LPI cap gives 0.625 mW/MHz, well under
the 10 mW/MHz PSD ceiling, so the wider channel stays compliant on
both EIRP and PSD limits. Per regdb convention of encoding the
spectrum allocation ceiling and leaving per-standard equipment
certification to drivers, the bandwidth widening is sound.

Reviewed-by: Louis Kotze <loukot@gmail.com>

Note that the patch base predates the recent RU power update (commit
6873bfe in wens/wireless-regdb), which changed 5925-6425 from 100 mW
to 200 mW, so this needs a rebase on current HEAD before it can be
applied.

Regards,
Louis


Return-Path: <linux-wireless+bounces-34849-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULtGOksS4GllcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34849-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:33:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C218408B4D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A530F31D0F5D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BC396587;
	Wed, 15 Apr 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU4PxMzu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FD396560
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291862; cv=none; b=FHM/06k0EHxQqvCp4+9MQtCM59WlrbVI5qLTWHoyeJWCx9zRP5VrmvFT6qI5osgKCOltl9+gTFmaUACWzcSP77BR9JW0LmEJ7VkuwbpWkfTUo+7SahyINJC36HHXn+awgHBlRf9JdNm0fHbqdU7RyjovEaZrwh8fWsfYODGhj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291862; c=relaxed/simple;
	bh=2WTz9wO43K8OXao1BAmYECy9Cp3XkGDB4TIWT/nqByQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVNWmsPtO5xyCN2ren8tINa0SON/qUsVygi0rJPO8l0Ed+5Af2eVlFRlNRwyanwQ3prBHx1w6y9LtuKPvpxrRqOTFXcG6lYqcdyQdXwG4IZFxHnqkX2yyL2ufspWJFuDLQpXwtyykmPAHKj7cXSLBT2LOP6bpZAdauW9V9+WgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU4PxMzu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso112621485e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291859; x=1776896659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WTz9wO43K8OXao1BAmYECy9Cp3XkGDB4TIWT/nqByQ=;
        b=ZU4PxMzuMkdHc9sB0VT/mCmPucTL5z94NBTeGhtCs4lcL8G5e7nW/UFC6Hqb3MOXCf
         P4V7wlVXEj/f+/gGx9QbPL/zcOsMDuuBQ+cEgX6lMW4NHUNSAkhYeEdrdtgs0J7JB+Z+
         LjxTdpQ76kv4b7BrGVeuVraUlLZ1UBb9XT6JK1UQrh//jA9eYfR+MFz4dHle6k/+CCKp
         qOn4moRP2/4s31j1nrGTxnn+ImeD6ijGDuArVCw0vXJE9wR1ErX4VGqzmLX117uwj2Yr
         nsI5Z74V7/3WKr/IboK/1o0xK7L9GYuUfXgfal4SwiOUGn/UtZqJJHbHhTUeDcMcKV54
         S/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291859; x=1776896659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WTz9wO43K8OXao1BAmYECy9Cp3XkGDB4TIWT/nqByQ=;
        b=TXvEa6YF34FLH0PnTg8yXQvzdC2J0/zadpD9fT9d6VNIutt6ndwKEFiLv+rO/glESk
         orkqes2qMmUU3lqJXutL5yWSM1Rt9keBLsYLd8ijIIj/otT5fGGVuDJPd9XcnbznQ1Fz
         po/bPWJcQdLVLSbmBYPFVW6qX0/xpyOo/vrtuCyOTzFC6/zeV4G6Adn/MsQTt8Xr8cxj
         dCxX9mzGcRfq/a5KPzcRTzSDWFb4+uH61rzd2YBQHv6IhO1YvaPl7L5OWAkBmWP+F3r5
         H10H6t/0M06QKjE3AU4TrHsijd8oKqfZ2p9Xi6Wz83SEN+9vmxyB3Z9EI1y0ZMTeixb+
         PWxw==
X-Forwarded-Encrypted: i=1; AFNElJ+SN4kXGktlAezX7LjU9cTbNh5to1jDKIqtSV5dUzi3Y/OoatTd471PNGNEaqf4VVDYa9leSXxFkEpPyg5kYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mcOneoKzS4I+imowMiQFQf39LdJlbVwObLWwv4lj52oUNEmv
	MyOsyoQjMySoSsp5W3vCfXj6xGoceT+wK8vYm0qxQnNO7czhlB7lFM8=
X-Gm-Gg: AeBDieur7vIoWRYgYzTPc6iyGHT2OPXRBXOWkH+ilVbXt82vVlNWu8kQaOTwwc2/nZI
	lSun7+uwPkGJ3UthsReq45YOZt609JEO/nubjn2opGVIPtMOA1O+Y77U0TiH1R0QqejVv+Xq5Rt
	tWWFOeckgXWcHHQEYNG4sD0SNcHG54NlCtFjG9Jy/2WuM5r2LSBNO+HjPooeaCsg7FO40QEs8YZ
	9nzmGSYldAJzZRW5kvtq5rGEE4RXRleDxNe3suQvQSej8DiZyVG2X9A+Iz8f7TbSrgODhftnmz6
	I2ZxbW3tfojyT1epUXOqhqJfS3s72I8PEvbwysvz6ddZyfSWdRl9CY15qlyy76mGzwwIMyz76rP
	WP7u14YpuTZY8pAIXdF2JM2XrkWp+RvnH6Oh5s9Iq0JzcMyTIPaP135+/69lBls4K9q9DfPhF0r
	86RVBsbgxynFTBbQ==
X-Received: by 2002:a05:600d:1:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488d67c720emr295264085e9.3.1776291859134;
        Wed, 15 Apr 2026 15:24:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm1890655e9.3.2026.04.15.15.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:18 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/2] wifi: wilc1000: fix integer underflow and OOB read from firmware packets
Date: Wed, 15 Apr 2026 22:24:15 +0000
Message-ID: <20260415222418.1543832-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34849-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C218408B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Ajay, Claudiu,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Two issues in wilc1000 where firmware-controlled packet fields are used
without validation:

Proposed fixes in the following patches.

Thanks,
Tristan



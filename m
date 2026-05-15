Return-Path: <linux-wireless+bounces-36494-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCWPG1U7B2ottwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36494-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 17:27:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6B5521E2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49B4E305D9CF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C93CCFC6;
	Fri, 15 May 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY4y2UeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3A3CC31C
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858258; cv=none; b=ugr3EJ+mFr1gCnyfG4w4t36l2RrFCf4kCDgS5QO8fGbiqDbhzcX4MIjfMpEp1e0NHA+7zUU7u8/ARSK32ZttFPnMLkeHzvk22C8R+9D0Wy4dFI8z5eg6DidDr96NfgZk0VOgJac7RwxhVJ4VV3BlyWp2Bz7b+sz/CnJJmrpOaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858258; c=relaxed/simple;
	bh=u6jb9Fs1k5nZrvjQt4XNUqnejmYfiJ3UGsEMQ5UICJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m499IJyRm/paJV1kGCda0qOspzRR/+6ewEA2iw+P3aRHPNdOnczVhCY01EWUeQ4mi0qcDyQuo2B5bYzbTE7AejTGCzkwnT6pfcOxyCAQrRaX9SuFPXmpTHgPLQ/6iNCJhdWV7X/tVs3X4arfPXLXxXOelv7CJeA28WGgjPczuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY4y2UeF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9125d2a4d36so45807285a.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858254; x=1779463054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HI+46hroiLUB5E9BmVjlUPUfW8yVSnW31LUwOO9Kjc=;
        b=gY4y2UeF0xk+cCnO6b/FLsOWoDWlSBIteQ7sgmv/DtAUZXNcbyyknYrhJ4a13kFchV
         z1DAiAzsXyci0YJw2Qk57REBS1f4v+BnjJ1K1/lwjXTmKh3CdY5Rfu6a9qOdZokVsObr
         QwL49ph0iY19Y6s6hAzTRM2yqiJH5QbWZZA7kVw8qEAbt63j5d9Nhrsv4rfjWHELO2ps
         9Zc0GTxPvoEljw7MhBJa6vGvdoYS4kBQQUnZZBbjBPVxKdcIvrBUyP81dIrj2OFXMem9
         Bcdrgn619ukBZeJlAdzUrH0UesFoFst0LuDPIPbcxIlv9B+AzykCtRpAUWmS+HWgOpif
         iBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858254; x=1779463054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HI+46hroiLUB5E9BmVjlUPUfW8yVSnW31LUwOO9Kjc=;
        b=TBQkp0hbHBzg/T9r+HyU2iU8y1AWkMt0H7y74SYT/ZPYWWrZSwTYH6TJ+mUEeq+Ivu
         NoHMG44cRHQYsYD7ORhLBwlLoq2AbS9G6L+diQFHu+joR/la2b6kTPHg8b8jruvXIBZy
         kRjtWuVgYCSII/1y05EMkbL+I2FAYPPqD3uiDvKKOMf6UXo2pH5faJekr/A8NorPfzxG
         0/DCrQRjA3nAnNRb7O2F1kxwc5BkWeiSyW1z3wAuOwRCvxibUxYjoYZG9J7AbB1U5nOe
         f3M1tGWznxB2YRQikk/wuwZ3Gr86xX1IhnXEQZGeF2ONJYXLQpmP8bq1qMqRanRHIrOu
         yLIA==
X-Forwarded-Encrypted: i=1; AFNElJ9ePj0jHyKsNcNg/A+q38r7BHqjginr9IPx2aDDeWzfQNsUVSJoPlNgJETT8Oh7Qxu8vL8p4kYcywKBzjnd5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wnMtSuF4DejWNX9mZ/hbr4W2uy8TbxIGjBdH6deZGJKHIpsZ
	CiD+coJvfz8xhLCboPIreWkxZ239n+mjeUYHoxucaxLXzLWVEc9ICpH2
X-Gm-Gg: Acq92OFbPThqggiJ+nBbPyi1ySNGvi6J4gwW+Eutx1ASqoGZES+tq5ux39/vOifNYq3
	z0Wa1QboVFwHa5OY9GzOBWBmUBh+U9P1C5/SdttDkpJ+He9BFwIshM1U4SXwIo0WUo1E3QJ4SYp
	Igy6dUMWp4t6AT5ty0Aa/Teq8qR1MDx7YmkWtQBcxF5yayrcypRHWYtVC9AW3Ot0jnTaHBFQM1A
	6G4G2b/VStWV1R96BX+nAkl+UWfsEp72P24Aj9PWqxV1yL4TziK5OrYYygSuLN9/Ul9KBa//7aY
	tBKtGIgBWxF0WTga1LmpPIJhvQmTx9lDg68C4h55joql25xph+mLLmCdeWFYwlkOy31tnYCAZcQ
	OP0VQ2uPM8zmUONTll7cgnPR+Q3z7iygu1E+zGz5VFrx/uFnLtey7mgzOd8QcCk3/aTu2grAZot
	8pvzqlt73P4U//F+CbZcgsr3Edp7PoF/DUr70jc6eHu3fqG/Pcki+Sz3YNR6dKrrgH+mLcuQfpP
	IzB/UuxJA4a6BWT6wwW884nPBEy+6EBnW4nzTL4tuM=
X-Received: by 2002:a05:620a:2302:20b0:911:f0ff:3d21 with SMTP id af79cd13be357-911f10e8471mr474266085a.37.1778858253882;
        Fri, 15 May 2026 08:17:33 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm569877385a.9.2026.05.15.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:17:33 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ayala Beker <ayala.beker@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless 1/2] wifi: mac80211: consume only present negotiated TTLM maps
Date: Fri, 15 May 2026 11:17:18 -0400
Message-ID: <20260515151719.1317659-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515151719.1317659-1-michael.bommarito@gmail.com>
References: <20260515151719.1317659-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0BB6B5521E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36494-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ieee80211_tid_to_link_map_size_ok() validates negotiated TTLM elements
against the number of link-map entries indicated by link_map_presence.
ieee80211_parse_neg_ttlm() must consume the same layout.

The parser advanced its cursor for every TID, including TIDs whose
presence bit is clear and therefore have no map bytes in the element.
A sparse map can then make a later present TID read past the validated
element.

The bad bytes land in neg_ttlm->{up,down}link[tid] but are gated by
valid_links before being applied to driver state, so a peer cannot
turn the read into a policy change.  Under KUnit + KASAN with an
exact-sized element allocation the OOB read is reported as a
slab-out-of-bounds; whether the same trigger fires under the
production RX path depends on surrounding allocator state.

Advance the cursor only when the current TID has a map present.

Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 160ae65a5c645..c3a2844740a14 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8155,6 +8155,7 @@ ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 					 "No active links for TID %d", tid);
 				return -EINVAL;
 			}
+			pos += map_size;
 		} else {
 			map = 0;
 		}
@@ -8173,7 +8174,6 @@ ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 		default:
 			return -EINVAL;
 		}
-		pos += map_size;
 	}
 	return 0;
 }
-- 
2.53.0



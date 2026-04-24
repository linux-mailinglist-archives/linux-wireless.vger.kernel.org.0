Return-Path: <linux-wireless+bounces-35276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKVUA7eC62kONwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:48:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C24605C5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBCFE3006208
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8603E0232;
	Fri, 24 Apr 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOo/ewqj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507323E022D
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042097; cv=none; b=IYwwfUAaYPIcdH6aPt3Ro9BZBxtITzblAZ3q0e1wHAWhZ3i411v/Gp9p/V0zpcZoOYNMjQoN0kLydLSaxJPfxdtdwvu2tezAIzSx97tcmgm4lSw9nPFrJSekCxP6E621JzS8H0uTFigl0JKc0E9pWuBixUHGvncDy3KICFwid0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042097; c=relaxed/simple;
	bh=7BGxycw9TD6UvArXUMhq/Yy+efsyYMcvbzGqrZ+k6yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nhp+uLyWdTMtUJPv6txd+PC1fVPdkLSapRIHdY9uLeJjUNNlZ4ctziAL+htztrrYpcPTpQsgdV2+DToENswwwg7pCnfm8TQK5Ux1Nf6xEPypG/LfBNLzeXz/Es2f2i7upqhDx2kkggzIifdM/v11mw8oVJvLeBSrfDBCLZKwJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOo/ewqj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso79484645e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042095; x=1777646895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXZ4zjbaOSRY7Q/S0vThNdYI3+newzohnQo/7Wbdrz8=;
        b=pOo/ewqj54hSHg2c2wjniz9zm9ZxUKSov9QFMFpTNyDlYgn/9+8KklAfpPb923hYDR
         l82kPBpGntfZxWSQpxIOpoNRu6d2n3h3t71AeTExxD8xof8gI6TOaWtz47TkLZkIfQxR
         0HLvt2vj6HuA1L5lFn+NG1VDaBrpYTEmFbwq1exEBFdux/LXuEo7cKoc5Slg1n+ghz2+
         7KqtU4wjSnZawEGx2Vnc4kw2V1C4nFoeZcjM9emzZtjDnDcPKNLhXdP5RKKcq6NRCBfU
         gNmWKi+xPatvH9dLF2STLdlsZFQ5QleKpY/garXysq3mL6lk/8VkepfsDpW3dhWrBsTx
         asjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042095; x=1777646895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXZ4zjbaOSRY7Q/S0vThNdYI3+newzohnQo/7Wbdrz8=;
        b=Qo5HQaXCLh2Z4LuFh5f35/BKvzZDJAROx5ei7aPUiS/a6J5LgtbuAazoRnUJpAZGMf
         SXe4DPoljJ+HfHORg/YsSTEScZEc2fxMonuEcxeOMqKwsVuHf+BvytQhb3EqRbVdU41Z
         3ngZAfpm+tpYMA1sHXCHUGXNBd/sWInXKanaYw3BCjOeSpV1RXtIiedZKI5qivS/Q4/u
         3z6A0sRVGPaUMxhbxvZ6CHnzqsND+CbTB3ySkY7PBje1T1yiIhkWhtbNM4Op7V65JsOe
         6T9nwpXdJzxLKeeP74RmqRimyqFqWTpf7IGo6rj1wraGSYyXfHLWSF/UhfJlQwQZD9J0
         YNTw==
X-Gm-Message-State: AOJu0YxOL3NPslXoiA0VHo6EIVZn7E5UG1y8BUEOCJgxVsPttydH4/79
	yV2IIUTaZHkC+ItZpdnEhfTIwqUbMZaV9WQyY+tK3oJMkYdwGRGRKhKH
X-Gm-Gg: AeBDieteyb/5BIJweiAmhPlt+IDeRmmvpSjKX7d77kyNy1rjxio+mJoIQnlHluWkufa
	CsBk+Pgk3iPinFEm3w5PBGalHyzYqZT5fVEFx2ZUx3SVkq/siWLnd03F7lmEZZ4FQGbq++Ea7ES
	+TV/R6UDn6AtVaRXWCplz99Up8JRULSCgbHd7P9T0RGYM98z8ckqT4zCpRrKiDe6MxU1+vTMLSZ
	4jIdhcJvRx8JHsJjPeJnWNTzAd18I1IJWFBKa4scXYcksfy5ju6MdXKznJ07fQhT2EgCmfCpJ+S
	rBg+VHh9vjwMLKoYr6NwHDtAuD6qnb+cfg/n6YsJhsUxLGFC4aISMXSrJlpDmX4lKQW45TB4jtD
	0A85k93H/OT41e6d4zTKAw7FzxvTh5VdxZtVJtuVlMfZir3YEBMaes89Mq8gI12NJRFh9J40pS3
	qC9SUCGlCErMNjKCZpKf/R2H2lQ148Y33zZAOVl3q9aek9zRm1dx0nNVWTRsZVcL7OIx0=
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a07615b87mr258627745e9.8.1777042094451;
        Fri, 24 Apr 2026 07:48:14 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm157605825e9.26.2026.04.24.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:48:14 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath 0/2] fix leaks in some WMI error path
Date: Fri, 24 Apr 2026 16:48:11 +0200
Message-ID: <20260424144813.1708214-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED4C24605C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35276-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

So this is similar work to what has been posted here [0] for ath12k.

When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
explicitly checking the return value we fail to free the allocated skb.

This has been split into 2 patches per Jeff's guidance to hopefully
ease the backporting process.

[0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/

Nicolas Escande (2):
  wifi: ath11k: fix leak in error path of some WOW related WMI commands
  wifi: ath11k: fix error path leaks in some WMI calls

 drivers/net/wireless/ath/ath11k/wmi.c | 131 ++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 19 deletions(-)

-- 
2.53.0



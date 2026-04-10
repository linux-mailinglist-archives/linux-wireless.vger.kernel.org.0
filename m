Return-Path: <linux-wireless+bounces-34644-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AMRLOFs2WmmpggAu9opvQ
	(envelope-from <linux-wireless+bounces-34644-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 23:34:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F83DCF59
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 23:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D7F5304C4F3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C993A9D84;
	Fri, 10 Apr 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWkDX45e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AC1DDC33
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856776; cv=none; b=C5Q/KjjelEuclH+ic+oSbs8IyvQfFEu8O1u1sXdcAmF2M6476Y4JSo19dwLx/XDgaHsfemvVxnP+6822zpyYQ0TBujPyEAUFPAZOI0DPni762/hYUZY8x+xdNlek6mpZPL4X2u9I9uxyxcY6A23mFwHPPb6eHygPe2tA8ye37sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856776; c=relaxed/simple;
	bh=r/+L6UGQPd90//cjmPCPj7O1kgKQip8p9vsVYMbLdXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QulA7gjrN5wxctYcLJYxR1gWVugnG03sd7o7wC7j+Mhu8V5r0dg9eKcif3wHftGt1Ep+JQRSgMz1F0t8w0tT2C5iRuOqhUx0fcEoFW89Hc3bpn6ICIflMVqFAplLCs6JtjSoZpBQrN8jHGt19+kmoLm5p/+QCPg60rHOynotkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWkDX45e; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1505726f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775856773; x=1776461573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aK6HX6RaV/3EyZX7NQpf9GKlfsm2kDzIhqgy5c7sYI=;
        b=mWkDX45eml6esnf+FeME5spxTlKuqwQ1ngmAFPZg2ayNrujqkkN1GknIb4WN4CQGCm
         4lIOgbGupDlglkZM0gY+wRQrdTfdurzqPeCw0OiJ0vH+gRxY/ihE5AcJQIefHNnzn/rJ
         OaKJ8nxQBuVPKORxN3/ANKga9XtYyuudDL/unQpBqctQ9r7Ni8jpRJ6mRdaU46PuDjpH
         iporaIMi+5Dh8PiN8wBfsm0Cr+kvNFXY0GOKXKLGLv0NKKPMCToRB4wurSJ1rP3xEhLG
         T4Q9hMr1sgDGLXidbjpPDX5V1UitDAfgplZymDlH6D80c/j8g78Rsu/JHA8oh5MUbcLc
         2jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856773; x=1776461573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/aK6HX6RaV/3EyZX7NQpf9GKlfsm2kDzIhqgy5c7sYI=;
        b=Vlr6oTwoH2E4yOcgaux6+DcAVrAe744GQhjCOmiwDcQB/C+0aT+j12RFxs8pIbTxaB
         3u582X41RTqvhpl4tYvdNlSjh6clNAroT7tmLjZ4rjBYDuUeBCJ+Poin5kbs5VvD7UQg
         fvJhK2HbkbNXtsnLA4GSAQghkNr0fQ3UQWrHrLP4UK9O68T0HwlSM5B+370cCWUk5ku3
         dLCFMiJ9ITwe4zdNwpoM0V4dlyxd36X8wZhz6NdoqgsJ3G/FyGkHkXpDwHNSMCbijs37
         GeH/oKLeNvJWtDOguTmciXGQsgMljLx2fmgFFbmMkk+ALR/hPiEDh4XEabpK/vsD/3ZR
         32Zg==
X-Gm-Message-State: AOJu0YwbzBEjfY4j5ZIcRwmQRFpYbSn2oXEW99oPZRqfezp0cz3itVv2
	EJILPruwoiEVW01hboEdAMFOSRCMuCKx4oiKuoG0H0nyxDt2Mg4BjNd56ivs7J/SdQ==
X-Gm-Gg: AeBDieubcsW41VqOo/eh8XwHeU5DtK43L+U/Kx9Uk1DoXoRu/d3dr+fNVDZDHoeMOU7
	xyTFw8bAd4/mTEQclQmRWMqqgNkYWeZ972Tjzni17Tz4abRbznBgzFfovspKJ8Fb5gEL6uOCWUH
	Ikwon6ttMCPU9S3f89eoixZSglta/mOigE9yMPkyhPNji8cHoWP5+b2LB2mY/D9HrfUO+zw2mVH
	VDcfHmpCNEMMD7i1fXUVapRZonVyAvAcanEKIXfo1WfCPkuzLEwHTnpf3sIeejxmyA55+Y9AA/S
	XELr5vxx0urn3TxsWNnP2VpJ4Uxb7Srq9BwPcYtXaISQFo01/58nx1VjIMxZaw9lQcS6B6wnHbE
	mnwY4MKqGj8iIb1tgPA9Yt9O11dlqCxvdj7nZAeRtP9RGrIWsYEhXBo0OtR8YqCxCtTO2fCZDQm
	7MKUgwTPOrRybFRpjtZQWUzf/TmjPRdqdSBBjoxSHZvL7nxSEqWwd/GLMVHLPHIdzpI/+L9foaK
	UvaGggoOMQ5kyr8On+nHae31EpWdT9tnjycEBpeMNuUDbw4+QmGww==
X-Received: by 2002:a05:6000:1847:b0:43c:f52b:7ff6 with SMTP id ffacd0b85a97d-43d642c09d8mr6922929f8f.37.1775856773034;
        Fri, 10 Apr 2026 14:32:53 -0700 (PDT)
Received: from archtop.localdomain (92-242-249-17.broadband.mtnet.hr. [92.242.249.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec28asm10753094f8f.15.2026.04.10.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:32:52 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Dan Williams <dcbw@redhat.com>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Jakov Novak <jakovnovak30@gmail.com>,
	syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com
Subject: [PATCH 1/1] add wake_up call inside if_usb_disconnect
Date: Fri, 10 Apr 2026 23:32:41 +0200
Message-ID: <20260410213241.1177592-2-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410213241.1177592-1-jakovnovak30@gmail.com>
References: <20260410213241.1177592-1-jakovnovak30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,tuxdriver.com,redhat.com,lists.infradead.org,vger.kernel.org,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-34644-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 159F83DCF59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes: 954ee164f4f45
Reported-and-tested-by: syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c99d17aa44dbdba16ad2
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 8a6bf1365cfa..245c902a7e42 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -310,6 +310,7 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	struct lbs_private *priv = cardp->priv;
 
 	cardp->surprise_removed = 1;
+	wake_up(&cardp->fw_wq);
 
 	if (priv) {
 		lbs_stop_card(priv);
-- 
2.53.0



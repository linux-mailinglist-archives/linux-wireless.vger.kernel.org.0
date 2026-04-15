Return-Path: <linux-wireless+bounces-34800-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EGVK4KV32leWQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34800-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:41:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F669404EF5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8561230DBCF3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C623EAAF;
	Wed, 15 Apr 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMQcFnnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366C3B583D
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260233; cv=none; b=cNExk4lqkx5ciCWE8wLuKt2rCi6VVvDU5jMFtLRQcw9hxRnTV2fyMsacD8uXpBVpO+/I+jjw6eqjgFS2OFDfK2YWCDwEGhSKBG12UkWQeE4rYTQQbcJBWrRKT6UdXC0riyP2g73ep6YF0jT0zeHyPLhbaPlODAIBw2KgIs7KK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260233; c=relaxed/simple;
	bh=ta2G6HPvMX2EUOZiP3aeStQb4RpUJwXLhxgghgaZQow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUD6+fhHlz8zI3G1mP1pm54gfiUexMwiYhp0CwBlYOH2CGhXAu+cEo6VaZfqF5cnO7tzpgiU42Epj/fUz0W7+l6TYmP0z8whUZIm7Rdw723nTGtzG+SDtIc9PbQOj45ZnmRMHkB4D9mB6fe8jGZZjVwxQpNIomNkftlNxgQ/c0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMQcFnnv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so67207435e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776260230; x=1776865030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkSpTw5qSJfQU5L2GxzQhg4hcVT9aLbhMz1Ha6rNX4s=;
        b=FMQcFnnv2Beg7jZ5Y4GF+NcOJfPAqp0X1y1S01pFHVbCftwWbh1l0QtSdpQgW+7WbW
         eTwWecAibePE5GpmtHq7oboM1yfkSjOo3kZLI/KMQqySowXnBLIjjC9lUBB5m92PN6tw
         KWv93K+uP6evC/JFPMEKlteEMJWtq2rJqJsEmmyRPttHSw5SLwHTX8YmjztPiLe7QmKV
         OOyrQRkt3Ajh15NAgvf7HzJd7mGqygeF9GldCb36MBRzGaq6he54EItm8VxJBYWDJDKz
         TLkzV/N/CNemKe2FzexL31RO168UrPYmfZaGGW/uLxKkoDzv1C4PqohdnpU1off9hg5I
         cX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776260230; x=1776865030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkSpTw5qSJfQU5L2GxzQhg4hcVT9aLbhMz1Ha6rNX4s=;
        b=oYavyKRB7wOKdCzti/ot90JVC0aEFeWhbAuspr/yVdf+C7P9Isj2iL7YMsZcg240m0
         c1gBekFTwwV8SoPNgaLl6HCnkUwZHrTxC2YF0Lj0tsgDadMfqqlpfIg3uEPTm8jNKN9G
         V4V/TyprG4wFNB56iSpN/Zd3hPUIb1V44KXhXeGceO5v0Grv/KIlmm0PayxelPdOpk9e
         FUCOFwQJDA9x4gc/otLQPops3xZJMOtMuDJkBSwRdOYvRnUM2KvbYefXyVEZV0+MmvqW
         BCq+Mao4eyuJ+TwCDMHn4imQMmvSmBLTZkppEBahuJVE2AQCgjo5Svp9315GJaehYqQD
         Tt7w==
X-Gm-Message-State: AOJu0YxLwM/CN+0DWm3w9mNkQfQarBJ63UjD15e0haiJVgqGEBEcn3Rd
	Z2C1OyxGl9d4geWluj4vyrcEdfjdI3djbUnxOFEVMFp5UCRN9Eko1aZYF2aEDy4=
X-Gm-Gg: AeBDiev00XPfh8TmZXb2S1ZpcBAFDQVAkImdL+EbLmiMWXdYZLSSNFB/D1S33Ovx26b
	KJnQw/fnaQ8WtllkNTDmdz9/PONdNPt1z4gBfxiVBIx4StfZj66sfhbq/S8/k1mar1wlQQ+c2UV
	nyXvP7PNwcvPu6mXvR0Fp2Z1pABO/iUUyuUMoBnREuP0Rmf3mg+SyfZ2aczJytP5xhsz5YpG6xt
	E/qOny4G7qzOG6NLfX8+V3zKPPfhUUIz1QmO6L+ZBw63jCzzkH6GFn+ch8NByBusQkWZwE1mYeY
	Y+cq/2noSG8xNsPtoOjjKHWj1hGYHXLW/Jq7s3KCVo8oSKEcwyggdJXLKAp9MUqljFbvzHTsWzz
	Kvq1mafm99/soI7pPLkWNp8SLm+CgjSr2G/33jcMq6tGF20ZAX6WASPdzbyOJkB+fQG0ZU02BGT
	X7sPqI5Nb+lcoTKBl73jswdvx2XRdWbS9X/rk39NKBw8/9W6uo1w8bqnE3vO0re2Gdhw6F0F8Aq
	xP0HkqSNiPD3lMEH/wzv83vWBYMqj/mCCt6KMfCeFXlE+zdGURi5Q==
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id 5b1f17b1804b1-488d6836508mr210704565e9.15.1776260230110;
        Wed, 15 Apr 2026 06:37:10 -0700 (PDT)
Received: from archtop.localdomain (92-242-248-33.broadband.mtnet.hr. [92.242.248.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1d60ec2sm58105435e9.0.2026.04.15.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:37:09 -0700 (PDT)
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
Subject: [PATCH v2 1/1] wifi: libertas: add wake_up() call to properly notify fw_wq during disconnect
Date: Wed, 15 Apr 2026 15:36:28 +0200
Message-ID: <20260415133626.172702-4-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415133626.172702-2-jakovnovak30@gmail.com>
References: <20260415133626.172702-2-jakovnovak30@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,tuxdriver.com,redhat.com,lists.infradead.org,vger.kernel.org,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-34800-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 0F669404EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is necessary because the thread would be stuck if the
firmware is not fully loaded before the if_usb_disconnect function is
called. In that case if_usb_prog_firmware would be stuck in
wait_event_interruptible and lbs_remove_card would also be stuck waiting
for firmware loading to be done which was the original bug reported.

Fixes: 954ee164f4f4 ("[PATCH] libertas: reorganize and simplify init sequence")
Reported-and-tested-by: syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c99d17aa44dbdba16ad2
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 245c902a7e42..8a6bf1365cfa 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -310,7 +310,6 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	struct lbs_private *priv = cardp->priv;
 
 	cardp->surprise_removed = 1;
+	wake_up(&cardp->fw_wq);
 
 	if (priv) {
 		lbs_stop_card(priv);
-- 
2.53.0



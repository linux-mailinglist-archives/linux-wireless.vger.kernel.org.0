Return-Path: <linux-wireless+bounces-37956-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+pBAbukOGpYfAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37956-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 04:58:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0206AC3DF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 04:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=XBTvLEnm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37956-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37956-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D97A3013003
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 02:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981D33555F;
	Mon, 22 Jun 2026 02:57:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B45474F;
	Mon, 22 Jun 2026 02:57:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097079; cv=none; b=LZlhJZNArSeNj0o7D/5rh4x3P00kntMlmQ6p5eV+LlU7Cet6UCuGDQxSxo9Uub8oeh6+ZSu36PfmoDZZJvszK0tyquL5wHp69tkvwcL9C38BdE/k9M4ZB21ZxibpR1Yybbk8h2gYW6rsB7NtahaJj/cF8JRLnzMXJ5CVZpZIJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097079; c=relaxed/simple;
	bh=PRgM73AzyUGGTAzU9ACZPcoryYBmMOZ4Ebq/s37wFno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnnY4hDHqB5VcjqKA7snGloUQst6j0spTSDtbfIdeVXv6ToqpAROEwx9yuK/AMMibTai029i3ay3qqc20/aZJtlXjMDzf7ZSUa1ye3B7e3mNN9zL8ocsu+rbEWt9BwxCEaqmbQlc+p0BR5V4bRj/SwtqKFuJMgMOgLXjqU7AQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XBTvLEnm; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782097034;
	bh=/dZrKZyJQsh8CVq0V1vQx87a/QiFzODktdeo6xpWzw4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XBTvLEnmzBfaYFKSDBi66rkPNaIh2yqgAZjsnJk49fON2lU56gMLiCHNUcspGXHK1
	 5hrvWYTBVwsaZ/ydofeWDc9NeVrB5Cpvi4hHKsAqiLY2DgecQ+H/ghLRYoWQi7Y8zO
	 02eXX0yePFk3KOBS0B57TuHRlOGun5rHL7p7j8/I=
X-QQ-mid: esmtpgz13t1782097029tf773796c
X-QQ-Originating-IP: pQAhdQ2K8DBH86OGSYD/2Bl7UlibMqvqKXMwSU7VKEI=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 10:57:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3873773278757756852
EX-QQ-RecipientCnt: 5
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] wifi: ath11k: fix resource leak on error in ext IRQ setup
Date: Mon, 22 Jun 2026 10:56:59 +0800
Message-Id: <20260622025659.1235658-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OapyzHutjwH/z1OrIGPVJ617gkaKfgP7BZAlBmZl2KmQdumzbHbzDKS/
	VwpN9/92Z4YZTK8Cf9MVjEfYoItwOLU8K/GAyI/le47vS+3GuGIBOQJy6DZocBZr7YvO0z7
	jPqd3lMCiOdyG6G+YHrPPitOFKmF0995fwxW9L0Jn6Pm6wlhH1Fg1axcZlMtSIDuqO3Xnjv
	BCovHc96nY1gM0Z1aoKI5PD4mrIlKZSSbQaLe7e6xVuj4/Dzf5vnvaDzXK+FzuBlR2h1Juc
	beZh5r0KCkCYdJiFw6rc5qMcf9Lsm1a5xGZavj1xyZyU1Gts3dK7tUeCxeYOFyIZYATzD+t
	RQakM0lEqdk6ybBcNjHmPHrmTB+SnK9dyxv5iZZlTX8WcIm88oQjhpt3PDQzJsa0BkxvuJf
	QQwv1OABIPwA66EWFPwqOx1/ypO5Nvfk9sbuQ4ubWP8OAwcFMwqppCSD02GL2Ice6HqerQe
	3uYZVSpE5fwwKpG16fWx30QAGJo12F0pOoULUpa44VXdrgl0tIN5k6B5u1rDQip79dxCjWO
	ZX3nsDPdhb32qGhIg+eRUcp6dr2rrawO3OyOnyT9E8wZGbolUmdpSflXm/zeUnENq+JO2lg
	0AFv+SmkOIY6SCLe8MiSRFlc2HTSfyF3sTGMLWcWmw+l5vLviivNiljHwSLtNcITwTR0kUs
	2KhOkAeTVdGo9XP7UPXRB+wh1gp6sAS2/s48sGGzBkxmHlFJrK35NusSL8oMbmDX8zpo2HU
	uOLQ1FWEWIS3WWlDRPrmxcMrmYrRCL6xFnqCzGyUvjfF9s0fmFlLOYFzTyYjkKZroeMOTKF
	GNtCC0Ae2zTy3d+HYCTRLEHNI+IbtLS4Nuy6dkwpqeSxVuogrII7Try7XcTvkX247TWoS1j
	PygKulq9ZOD1sY+jsPUP6pVhzGx5jvxh3nyik7USNK9kZvnMvqbBdMaebdFSDHRd/JbnX5n
	X3D8dze/peG2M/nZlW19JtP+ZSBdOrjrstdRd1ygPVXmBJOwYZf2XAfpvUaAo8LvkyeSGR6
	CsZzC8KgeNwBu9kOcvEEjrheFqLmI=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37956-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:zhaojinming@uniontech.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C0206AC3DF

In ath11k_ahb_config_irq(), when a CE request_irq() fails, the function
returns the error immediately without freeing the CE IRQs that were
successfully registered in previous loop iterations. The probe error
path does not call ath11k_ahb_free_irq() either, so the previously
registered CE IRQ handlers remain attached to the interrupt lines and
are never released.

In ath11k_ahb_config_ext_irq(), when an external request_irq() fails,
the error is only logged and the loop continues. The function then
returns 0 indicating success, leaving the device in a partially
configured state where some external IRQs are not registered. This
causes enable_irq()/disable_irq()/free_irq() to be called on
unregistered IRQs during runtime and remove/shutdown, triggering
WARN_ON(!desc->action), and missing interrupt handlers lead to data
loss.

Additionally, if alloc_netdev_dummy() fails for a later IRQ group, the
function returns -ENOMEM without freeing the ext IRQs and napi_ndev
that were successfully set up for earlier groups.

Fix all three issues: propagate the error up to the caller and unwind
all successfully registered IRQs and allocated resources on failure.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f566d699d074..041c0fefe8c8 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -536,8 +536,10 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
 		irq_grp->grp_id = i;
 
 		irq_grp->napi_ndev = alloc_netdev_dummy(0);
-		if (!irq_grp->napi_ndev)
-			return -ENOMEM;
+		if (!irq_grp->napi_ndev) {
+			irq_grp->num_irq = 0;
+			goto err_request_irq;
+		}
 
 		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_ahb_ext_grp_napi_poll);
@@ -600,11 +602,25 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
 			if (ret) {
 				ath11k_err(ab, "failed request_irq for %d\n",
 					   irq);
+				irq_grp->num_irq = j;
+				goto err_request_irq;
 			}
 		}
 	}
 
 	return 0;
+
+err_request_irq:
+	for ( ; i >= 0; i--) {
+		irq_grp = &ab->ext_irq_grp[i];
+		for (j = irq_grp->num_irq - 1; j >= 0; j--)
+			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
+		if (irq_grp->napi_ndev) {
+			netif_napi_del(&irq_grp->napi);
+			free_netdev(irq_grp->napi_ndev);
+		}
+	}
+	return ret;
 }
 
 static int ath11k_ahb_config_irq(struct ath11k_base *ab)
@@ -629,8 +645,16 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 		ret = request_irq(irq, ath11k_ahb_ce_interrupt_handler,
 				  IRQF_TRIGGER_RISING, irq_name[irq_idx],
 				  ce_pipe);
-		if (ret)
+		if (ret) {
+			ath11k_err(ab, "failed request_irq for %d\n", irq);
+			for (i--; i >= 0; i--) {
+				if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+					continue;
+				free_irq(ab->irq_num[ATH11K_IRQ_CE0_OFFSET + i],
+					 &ab->ce.ce_pipe[i]);
+			}
 			return ret;
+		}
 
 		ab->irq_num[irq_idx] = irq;
 	}
-- 
2.20.1



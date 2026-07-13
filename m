Return-Path: <linux-wireless+bounces-38969-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S1ndBUXFVGr2SgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38969-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 13:00:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB6E74A13D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 13:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=bOMjQMsa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38969-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38969-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48C463013462
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF247310763;
	Mon, 13 Jul 2026 11:00:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3A3E2746;
	Mon, 13 Jul 2026 11:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940417; cv=none; b=muxPej1R1P2NJCDwpkdpYrChqLBT3hTksVYnLgwTz4mZbKtJ7kci3meNTviOY8mWR8KFMUPbtwNKRc39+OdJQNWaJAEQrqQm+0T4xa4kFlHVLv4YRkSuZvGkSX0zubEkyEP2wuTLQFDltNphpEt43TGHC7pzHEeZOem2Ba27iMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940417; c=relaxed/simple;
	bh=FTjgfiaDdmjk72hNg0JbiNdcw2bCIxzwj8jiQw5Qkwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiFj52NfqypE0ld5Tbc/Bkn/H94NXxuwHGYTaQxhsbXkQXtfBnuHKNNvDVqG8SFjNgzoodS7jtjGBhVa4BqhXs8zy08BPkA9FcSMyUaT8jtP+OHzZLtOggAyKL91ie6u+Sh3yAAgVEq7DG9ine5fnM3XRLtTJgLKTxVF0CDGxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bOMjQMsa; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783940370;
	bh=jJPsR86XrOODhJxDejRA16YQr5qtfou1j8CBqENWGb0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bOMjQMsam4CmRJ1BjuHl7qIBf3ZAjdejfF65vETYPl2C5hWso2AjBhrHOs4s8HWun
	 nt+9zPCU6RFT3MSHrvSKd/U219JxXgPQb+YSOFqyJvkbf4jY9eRbc7gsNTM+cSoH5v
	 kqg5AS66v/HhWSXfZAsPNdoqrauu+Sb/GDEoH3LE=
X-QQ-mid: esmtpsz18t1783940365tf1273139
X-QQ-Originating-IP: LtJy7DAdSToEKrbmk1WHryHLn8AfNnE6ep6w+qhHWFA=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 18:59:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14095854033121246129
EX-QQ-RecipientCnt: 6
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH v2] wifi: ath11k: fix resource leak on error in ext IRQ setup
Date: Mon, 13 Jul 2026 18:59:12 +0800
Message-Id: <20260713105912.20095-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e94de910-0a15-4b82-b006-03da98305e9b@oss.qualcomm.com>
References: <e94de910-0a15-4b82-b006-03da98305e9b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MD5XEDocxEOLMhpAoive5j/Lmhsnh8cPqK+KNC/K7PyUtN8XOzSePirI
	jKToBChwB8p/zVNFq8rgcA0ibN2tkLHkmYpKdrN+Vnaa8tNFXt/ZpB8WdIkwAzyY6j7Uuww
	cxmTnMvMlbvo+3IOzF9SbdlZkBGlA7bH7RJYrLFYbVRLXabsDLtxop4PTSWTk49bqPLdRgN
	QFWNSdRE59s4UE+NqoThrUhMAfyrWIj5obos8djqWbJzmWISa08ysFbK+ZjS+xIz8u2uRrx
	eDhQs4hF2A/wcbgVL7eEuqSU8zq9bCNFjssTtRDgA3cTUI7euFQAJF381zLly0HcT8Vdz+S
	eyTveRPKQ+HUs0gl/3ludqMHdp4JsBKacPQkhQCQ7p0mFWC7wMJz3RCr4df4UqtV6UvuIKY
	vNt3v+BufGtROnjr4rzJWc6iqriFq1kfI/ezBa4UlxXlOyOidEK/tO2G9G75XE1+tnEA5Qj
	LQPQlp03qduFsDzQ8ZH8/ElAJxdS5wvIjvf4jf3PlE+EYkmaQ3vh5aa79M+hOO3JL9pLqWf
	9Q6HmT8vC6JyjZ0sk/ZHFXAe83EgmRB48oEAu37ESt6fSIljf3dLvDny0oLLmmylELQ2GWk
	oH498NksJfltLWpJZy6+VHFiK+FI5I5crZMlG6OJKm5J272tqCOfLbsBjf/hLdnZoeqmyG5
	9DSaJSMkNORNam/DIxO5zNvLNyDkuvvzT94Rk5Vquv4jnNLKC4KXwwhWlS5xOHymHEXf8RJ
	YmTMeb00g1IlSzto+AZOAeof9gGCk1yvOHNGhFs5QptIr8A8kj5keRnt1Jt+rXfMtRYa/hV
	DFOtGncCCuLnYffTi5hKiFwPp5rFbZ2KadWAPMrheTdm0IMKNJzNUZguW/KiLNK8Vjjw/v7
	ADIerUu35QA2Dl1aTFtIO8+U8UOqVUkGq9wUH0nrnVTr1rTQUArxbOuVc1zVkkMdy3GDOh3
	+2jW7IDCXQFlBpjyjGhcPxxvtoh3Vpkn++GOmTfoUyZaBWon8supMMmMH5FvCiZhDsCGXS0
	VeOHvj0CY5bRL8S26uxP5Btq4bcTXj9AbFctJDzw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38969-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:zhaojinming@uniontech.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FB6E74A13D

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

Changes in v2:
- Move `irq_grp` declaration from for-loop body to function scope to fix
  compile error in err_request_irq error path.
- Set ret = -ENOMEM before goto err_request_irq on alloc_netdev_dummy()
  failure to avoid returning uninitialized value.
- When ath11k_ahb_config_ext_irq() fails, unwind the already-registered
  CE IRQs via a shared err_ce_irq cleanup path to avoid leaking them.

 drivers/net/wireless/ath/ath11k/ahb.c | 48 ++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f566d699d074..11bafbd94aff 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -524,20 +524,24 @@ static irqreturn_t ath11k_ahb_ext_interrupt_handler(int irq, void *arg)
 static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
 {
 	struct ath11k_hw_params *hw = &ab->hw_params;
+	struct ath11k_ext_irq_grp *irq_grp;
 	int i, j;
 	int irq;
 	int ret;
 
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+		irq_grp = &ab->ext_irq_grp[i];
 		u32 num_irq = 0;
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
 
 		irq_grp->napi_ndev = alloc_netdev_dummy(0);
-		if (!irq_grp->napi_ndev)
-			return -ENOMEM;
+		if (!irq_grp->napi_ndev) {
+			ret = -ENOMEM;
+			irq_grp->num_irq = 0;
+			goto err_request_irq;
+		}
 
 		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_ahb_ext_grp_napi_poll);
@@ -600,11 +604,25 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
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
@@ -629,15 +647,30 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 		ret = request_irq(irq, ath11k_ahb_ce_interrupt_handler,
 				  IRQF_TRIGGER_RISING, irq_name[irq_idx],
 				  ce_pipe);
-		if (ret)
-			return ret;
+		if (ret) {
+			ath11k_err(ab, "failed request_irq for %d\n", irq);
+			goto err_ce_irq;
+		}
 
 		ab->irq_num[irq_idx] = irq;
 	}
 
 	/* Configure external interrupts */
 	ret = ath11k_ahb_config_ext_irq(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to configure ext irq: %d\n", ret);
+		goto err_ce_irq;
+	}
+
+	return 0;
 
+err_ce_irq:
+	for (i--; i >= 0; i--) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		free_irq(ab->irq_num[ATH11K_IRQ_CE0_OFFSET + i],
+			 &ab->ce.ce_pipe[i]);
+	}
 	return ret;
 }
 
-- 
2.20.1


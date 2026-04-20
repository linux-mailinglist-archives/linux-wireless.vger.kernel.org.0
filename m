Return-Path: <linux-wireless+bounces-35085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDXnHj1c5mkwvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:02:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055834306F0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079D0388AD21
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706E2D5937;
	Mon, 20 Apr 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QAkHDprO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic310-24.consmr.mail.ne1.yahoo.com (sonic310-24.consmr.mail.ne1.yahoo.com [66.163.186.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A717BA6
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698035; cv=none; b=CZTI0pPTxq+5O8caCdrOsxUdSoV70gIaApxAdR4LCmTwqeudoaOIwhB/xBSTFaSCq1gfB0UfLKqaayIPEfnE6gsdUbAWE8qrccfMerObZ7Mm+L5f0LxqTwmRLHNaYJ27OoKF/SHIgRjOefQXUWi1kO6SHz20Uwu5BdXOTkMHBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698035; c=relaxed/simple;
	bh=9l1lILh6ZuJPo1YoiPQIaTiQok9ui4T1vFQ0girnWZE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=gI/7cIR8sTaJpV+7/sJ/aAot2XvKEdYAZINMHmYGH7JnQa9znU/BXnQgrRJ57+pt/GMosr2/sxhxgIRKd9OYdsOX9+yRvjEi4VpLITHXZz5HflWDMSoYaCQt7Yq+uu+vknyxy+Yt6FjUZowsXMhd6W2A2+h6oMFvUosY6+zJVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QAkHDprO; arc=none smtp.client-ip=66.163.186.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776698033; bh=zEO9F6KCtjAmsamjB337B9zKnk6+bwWW0kHh1LNdh9s=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=QAkHDprOuvUYurXSx56LcVJhgBmMM0afqo1YC08Yh1LKhL1YZkVuqfFh8ELq0NyEIHL4toT/9MOeb64Yy9SobWufr/5TWGO1UwAch52Nv+22lOgBAmgJkZqv6wABGXAmw5KMdfvwHlta3UoCdBmesqnDUacVZ/bVQEe+KY2WGTHxjmoBsPDejhk7fb2I2wEa82+k9SVye0Fhy1JvEA13dolBGXKUdq792GgMsuT50d5zeO7nRxJg8XCFmvN+VHEELAJo6X5c6r4CpeQrCFaZV1eoMr/v4cg5YsCJwWeQELdUO8P3PyoWqBOSdIm0y3JCgxIR2p8z49jURCN2j9j93w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776698033; bh=auUDPVAspxAEdnXO9qtSJOMYwKIU7WDWIdZley+G1v7=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=lLp9t8KQ5hi73Uop38Mk2NcZoeGkkmhnLfho6goUv/mUvCp4lYHioo+VzPHxgFUS1IzWg6CfBbSx8R9zo1WD0kj2Us/8vl/SnbFns/Lt4WB2o7vaomUBJ5guQk70kuHncD+jme1tCTvi/yzOCHnsJj9EgJ2bOay6gVJLUem8bPBzKC7wqV4NUOg95EAM9jO/feJ8iATHsgbktGx4AUtq1MB3S4szX+tuPXg98UiMrzyr4idrVWQlmi0678dgnBhx1A3fyOvsEfnd+yto2t7XVF7gFwD7NoDxD0YJD6D25L2QcULZzD7M6TCI1ghmMmEw0aikgVGUrzdRetw5mMo8Ew==
X-YMail-OSG: Xhcatu8VM1mcFGKZct0oI5EDpww48pqVFffbjfZbLbmBm._HFzGXhxgCbavIQRm
 Z.Q6MsGKLl.wztlLcslg_rB9mTy4L8X4Mco7YX6wUsS4loXoLeymgc8HWa_LlzEo26u9VRvmB.Ug
 s5Yea2UyBdndORZ6vimyKSk3e64o5i42OqZuzDje7YNoVcOkX5Dc4F0u0GbIYjeCdXl2J1NRZSMY
 XBHt6.cMTNVOJF3V928U8htYlPiYITRgkxZzh5pkSLGY4IWeP8l6Mwyqk3QgMeBrh2O04pbOA7pJ
 jgrWe4_RcTKjsfPmEZytkdo2eGNUiosYriXTQzJ5fI8zqoQDoIFbEJAzFfJZgtxmVSPnCVNoSHbc
 6ZWJQzs7JGKOixkTSOSJbrE5HH9CULRDjRgUQMwYhVFt5HB1fg7k5lnFzmpE8jWKz5yHI25KEkpl
 Z2MYhdxWs9LAAavi14rmTGL9YG9ptsyUhQVpmKwLxs_pr1..KIPj8_7bF3uInS5lgEl0_xW_b0UZ
 FaeenAtvVhgzElt3EscxdN5QDv0gKXOXmX2rt9KLCOcQ0GpSXmXgrtEBVLEgERyOuiE6sDNrbOnB
 udD6sru6S7_RuEWBLC0Vcd2E69hxuE98VMyg78MhcU67bI1BVdf_ndfsHxBm2XRUzGWSOrFTPo1d
 .EgncP5WsZsM5HRpz9F53Crim_wujZTfqhlrsu2ahgS_2RZKYT2.typCJtdxKOGUtTQHyAHKuy_n
 Xls0Bxtd9GPscw6DNMR6a551q0xcWgjDC9ctGdCGOWtfUlCIM6wzq_APYSJKuC9KWt6fU1bgRHex
 EOSU.sTtrVGABtAbA1QhAFmAelSyhdtFJzJGJj8JX6FR7A_CtxqOywe3RoGk4aJCMPfnjOlkkhaF
 zcmgOvYpd4Kk_A_h9OWyBoWPLeLbRxeiEKA6bgzywUzROmBwQs_ck4rV603StyJGlTJEoD9iyy67
 .dvnrlGweSzg8xQ.SdmLfE_DT_OKNpR1lal8XDNujv9ccgdRDqTXXmZ5V0riE7tKdWYgvYSt730n
 bHdsEVFuaxGluq3H81247qoh0.fm51g39vhEGk3tn8mkRZXlQAiRNtTO4kdcxi.35JPVbxcCPn1T
 u_3_voE3zI6QTziZbcj9XAachpZC9WoOuBWkXXgawzjKOmsL3E8CI1.lq24gbCIQ4khiX2svRroG
 k7CdmN27Z_9yF5jtwdKumiUx_M4.tGeXNoMtw2FRTITnLXiNlKFsMxkLr2ARapfmRbV3vLxOAKYp
 SN_WHI1UGQT6zWYidQCi1ofB7PEKbIS48F8x6DCuJg9RijP1uFtsob29YSub9YcBXcl5YVnxhxry
 YN8nZ34sPmztKIw.EJGT6XwUNC5ZV3jBFsrmEfzNrmTNB43xJZiR2JwABysW1QrBux3rUEUSxtk7
 dET_VI3583zJNUe8YbAZoJfq.QbiVy8HwMxyrlRTkUdavuUg1Aj_y.fZMpBW2LEbE3lxnIO9Uww1
 nL5WFbEPQBoKqIzLgYjMaRAIj94wjaRE_cSMxbZpoTdj7.jLO_EgMxQfpt9kmVOO_G_JeqVUV60g
 OeuTzLY7SzlfXDoB2D2d_4KlNwwHPMXe3KfncUoa93fL9zCPcAyVnpknHq_sLUo30pyorTHdK7NH
 wt7qX.ZhbYk6WIUiGFrk5Wj6FyJo0P8NVJVTwJ17iWvv2Yt1CvVjUtJyypWxQHVyR1mQvqHxTClN
 tV_pBAbGS6SQCsE1NEp1eu9dgBQgjEfXZ5OnKXFDGEuhYy3mHWT8f7bAumLea0pi9ccLOVr9c8by
 6W7lzHKSk6Jyg3bCI5n03tDPZoqPbST82I7jZ1unt79dpbnc7jjo32UAyzVA45J4t3oUP4lsbohZ
 wL7aSj5JshtJhtUyWbEGiwbroEtvjavbdiInRCOOnG9M0q395wxGXVJsYXeUe3ipt5QRW1ifzYl3
 9c5cdN2nonXo1kTzBAZ1kxOxJCWMh053sMj_joYqKGWfcFTB08ZlF7K3XOgxnhtIsoyZSN_5bzd9
 QEvx2_o7C0Gb9zQZgpWE07WBNgl1NQJr2Fcobyeavs9_p_lXCE6e8l4VG1AJtlDrF6h5HuIiJdYW
 dTST5Y87_UiPRUSRSIgTUIDUdW9YaP4aZPpHstUtjnWYNFuAMlci.OFWwYN1DKC1vVkY2qXEAbdG
 lc2YIGt66..q7j5ynRpBxbL7Ipzdf_LamPcQa1ONIbdIGHZrVZSLZOF4yXOqpFurNN_o5fvbwQiM
 JZzoHnOSLt237xzOLLVgv6KRgOskH5xNQRn6UyotvUKK7bn.mIbdyo7F_Gwag4awPAZJh6muLFgk
 HVpeg
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: ffe72429-e90b-48e7-8cef-291e078bc123
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 20 Apr 2026 15:13:53 +0000
Received: by hermes--production-ir2-bbcfb4457-g4h2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6c5d01a27a275055da359b650fa91b96;
          Mon, 20 Apr 2026 14:42:33 +0000 (UTC)
Message-ID: <321f7c0e-2ae7-4633-beac-51bcfac4f4bb@yahoo.com>
Date: Mon, 20 Apr 2026 16:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linux-wireless@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH] wifi: mt76: use hrtimer_setup() in mt76x02u beacon init
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <321f7c0e-2ae7-4633-beac-51bcfac4f4bb.ref@yahoo.com>
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	TAGGED_FROM(0.00)[bounces-35085-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 055834306F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the two-step hrtimer initialization pattern with a single
consolidated call to hrtimer_setup().
The legacy approach of calling hrtimer_init() followed by manual
assignment to timer.function is deprecated. The new hrtimer_setup()
helper atomically initializes the timer and assigns the callback
function in one operation, eliminating the race-prone intermediate
state where the timer is initialized but lacks a handler.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 mt76x02_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mt76x02_usb_core.c b/mt76x02_usb_core.c
index c94c2f661..3a28a8cc1 100644
--- a/mt76x02_usb_core.c
+++ b/mt76x02_usb_core.c
@@ -264,8 +264,8 @@ void mt76x02u_init_beacon_config(struct mt76x02_dev *dev)
 	};
 	dev->beacon_ops = &beacon_ops;
 
-	hrtimer_init(&dev->pre_tbtt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dev->pre_tbtt_timer.function = mt76x02u_pre_tbtt_interrupt;
+	hrtimer_setup(&dev->pre_tbtt_timer, mt76x02u_pre_tbtt_interrupt, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	INIT_WORK(&dev->pre_tbtt_work, mt76x02u_pre_tbtt_work);
 
 	mt76x02_init_beacon_config(dev);
-- 
2.53.0


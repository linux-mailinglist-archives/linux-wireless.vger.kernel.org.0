Return-Path: <linux-wireless+bounces-39077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zHYEMFJRVmpA3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:10:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A551E756426
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=meta.ua header.s=mail header.b=jvFaNA08;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39077-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39077-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=meta.ua (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7D1A300373F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF143FD1F;
	Tue, 14 Jul 2026 15:08:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxs2.meta.ua (mxs2.meta.ua [194.0.131.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910F2A1BF
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 15:08:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041723; cv=none; b=ZBIvc5u1C8SoyQDYzp7KEG9wdaCTrB0LY32icpWTMuuIvY60JPp5DW58/mfAvUE90Ml/oVCcO0k0gWVr16h7edE+unoTegWGcCnYxofXzqQHDJs43ou/5QDdTqZZKbl23k5lJIgr6FSwjELwT/xcoTd0X3nzloPtD2nU7dNuDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041723; c=relaxed/simple;
	bh=QJ00Zl34Gjy8qLnfkB7lRiNsYkfNC2svwlbWyU1q+j8=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type; b=gcvTl4bC7dA42bvj+6jFbs3FbWRStOTzOHAsJw+4nMsuh+2blp09mXXleZyOjshUXs2PADJuHDVctvoqMOjeMg/yEzujdh6ER/uX2kab+d4MeKs9sQnEwPp0pElgavQSutr8VD94fzBfsHRVkaFwKEq9ptsjtEOid7sG8XoX3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=meta.ua; spf=pass smtp.mailfrom=meta.ua; dkim=pass (2048-bit key) header.d=meta.ua header.i=@meta.ua header.b=jvFaNA08; arc=none smtp.client-ip=194.0.131.3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=meta.ua;
	s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:Cc:To:
	From:Subject:Date:Message-ID:Sender:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QJ00Zl34Gjy8qLnfkB7lRiNsYkfNC2svwlbWyU1q+j8=; b=jvFaNA08m6CGGvmAB1oE3VPAFB
	SqoYuqT/SZCECyp8fz82aTu2Xwj7MQsfLnFoYiRVDl/ePWs8ga8dInTGASjVioLgR4Dhk4QKwq48W
	fz/lwxdxlk80SrRBAdEKX12TAyDnEewegdoT5vnp69qbtTAN28W0ImrAq5LDP6xCNBq1jIHnf3z3d
	A7smEDLW1uWYFMJb9SE1ViOlDnvs1+rPp4vJk5CXy/LhwcqTLhbvFghDXwYm4oHIXqSPObjR0FpHb
	1JATnUsRFn6c9mhULmD9A4gyQu52EVBMv/5eEaU+sFEZ+LZ3x052no0bPDiCjRCoT3lKsnarCM1YI
	vyDpNViw==;
Received: from 185.179.215.97
        (MetaMail authenticated user nurofen55@meta.ua)
        by mail.meta.ua with HTTP;
        Tue, 14 Jul 2026 18:08:39 +0300 (EEST)
Message-ID: <44184.185.179.215.97.1784041719.metamail@mail.meta.ua>
Date: Tue, 14 Jul 2026 18:08:39 +0300 (EEST)
Subject: 
From: nurofen55@meta.ua
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org
Reply-To: nurofen55@meta.ua
User-Agent: MetaMail/1.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
Importance: Normal
X-Browser: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like
 Gecko) Chrome/150.0.0.0 Safari/537.36
MetaPassport-Id: 11250186
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	EMPTY_SUBJECT(1.00)[];
	R_DKIM_REJECT(1.00)[meta.ua:s=mail];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[meta.ua : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39077-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.meta.ua:mid];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[meta.ua];
	FORGED_SENDER(0.00)[nurofen55@meta.ua,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[meta.ua];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nurofen55@meta.ua];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nurofen55@meta.ua,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.ua:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A551E756426

Hi Ping-Ke,
Thank you for the quick and insightful analysis!
Here are the results from your suggestions:
1. Firmware Check:

You were absolutely right. I ran `dmesg | grep -i rtw89` on the 7.1.x kernel, and it confirmed that it is indeed loading the new v2 firmware:

rtw89_8852be 0000:02:00.0: loaded firmware rtw89/rtw8852b_fw-2.bin

Firmware version 0.29.29.18 (9e3d777f)
2. Power Save Test:

I identified my interface as wlp2s0 and completely disabled power saving:

sudo iw dev wlp2s0 set power_save off

Unfortunately, this did not improve the 2.4GHz stability; the intermittent packet loss and high latency spikes still persist under the same conditions.
3. Testing Nearby the AP:

Moving the laptop closer to the router (stronger signal) slightly mitigates the frequency of the drops, but the latency spikes still occur randomly on 2.4GHz, whereas 5GHz remains flawlessly stable.
Since I am on openSUSE Tumbleweed (a rolling release distribution) and use it for my daily hospital workflow, compiling a custom kernel to manually apply patch 63ccdfac8677 is quite problematic for me at the moment.
Given that commit 63ccdfac8677 fixes the exact AMPDU drop logic bug introduced in 7.0, it sounds like the perfect candidate to resolve this. Could you please queue this fix for inclusion into the upstream 7.1.x stable kernel tree? Once it is merged there, the openSUSE maintainers will pull it automatically, and I will gladly test the updated repository kernel to confirm the fix!
Best regards,

Svyatoslav



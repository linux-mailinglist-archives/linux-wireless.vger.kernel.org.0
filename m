Return-Path: <linux-wireless+bounces-38837-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pp1tLV5XUGosxAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38837-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 04:22:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13A736A30
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 04:22:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38837-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38837-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC113028F2C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC6282F14;
	Fri, 10 Jul 2026 02:22:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ECD7E792;
	Fri, 10 Jul 2026 02:22:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650135; cv=none; b=Gd/yu3VKxcDvA4QALQi6lsOS113FlCFmVap+rK2f4LxCp2e3SE+VAtVsEigqcSigepnKip91W4SxiELzoS4Pa4Np6NHivOZnD1/MTVWw3xMMk54p+xBN+LfNOC0rvAnme1nDhujzydprWu1jXwgbAV/EktW1c+yCzzX3JF6nFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650135; c=relaxed/simple;
	bh=vDmmFMtTx0g6s6h5HhJRmiH/58fftU5/U/sMtTERGOo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DrD8LEv5RSfMVX2BPziiS7Fy51ajE8xXm5JPCdgLM8EaBwzbrSdhNO+A7dNB/NNtCAFR592uQy5JPwrNN68dKN7TpPlTPefbv9DQAJHfXppJMuXM+5YsJmlDUmLxTfFBHU0pAFDvT4wEVS3QaRUj92Mqq78f2yzIPaMTutkmCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Received: from zju.edu.cn (unknown [10.97.40.56])
	by mtasvr (Coremail) with SMTP id _____wDX9RRKV1BqSewuAA--.35S3;
	Fri, 10 Jul 2026 10:22:03 +0800 (CST)
Received: from smtpclient.apple (unknown [10.97.40.56])
	by mail-app3 (Coremail) with SMTP id zS_KCgBXb3FJV1BqVVoGAw--.13159S2;
	Fri, 10 Jul 2026 10:22:02 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <20260710002451.500112-1-eddiephillips@google.com>
Date: Fri, 10 Jul 2026 10:21:51 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 Arend van Spriel <aspriel@gmail.com>,
 Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
 Wright Feng <wright.feng@infineon.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <47D1D7A8-65F4-4EBE-ABD8-5CDBA5A5CDAC@zju.edu.cn>
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
 <20260710002451.500112-1-eddiephillips@google.com>
To: Eddie Phillips <eddiephillips@google.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zS_KCgBXb3FJV1BqVVoGAw--.13159S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?gXApPgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WM8Dms9pSd1duk7P2JRh5+sy7aOgo1D8mBVqMLc1ZNCvnaO
	PAtn46iPjtACMN8bHkqp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uFyfZrWxuF1DGFyfGryUArc_yoW8GrWUpr
	W3JrW5tF4qqa45KF4DZF12qa40gryS9FWDJr18Gry5tr98Jr12grW2yFyjgFWUurs5Aaya
	vr43uw45Zan09agCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ructUUUUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[zju.edu.cn,gmail.com,kernel.org,broadcom.com,infineon.com,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38837-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:aspriel@gmail.com,m:kvalo@kernel.org,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:chi-hsien.lin@infineon.com,m:wright.feng@infineon.com,m:chung-hsien.hsu@infineon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211-dev-list.pdl@broadcom.com,m:SHA-cyfmac-dev-list@infineon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:eddiephillips@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[12321260@zju.edu.cn,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[12321260@zju.edu.cn,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zju.edu.cn:mid,zju.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E13A736A30

On Thu, Jul 09, 2026 at 05:23:37PM -0700, Eddie Phillips wrote:
> Is this safe in a softIRQ context?
> mutex_lock() sleeps until it can get the lock.

Thanks for taking a look. I agree this is not the right interface shape.

The current call sites I traced reach brcmf_fw_crashed() from the PCIe
threaded IRQ path or from SDIO workqueue context, but brcmf_fw_crashed()
is a core helper and the reset scheduling path should not grow a hidden
sleepable-context requirement. I will respin this part so the arming gate
does not use a mutex.

> How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> path is already running, it can invoke the worker thread. Is there
> potential that both try to reset?

Yes, that is a real issue with this version. The lock only serializes
scheduling against the cancel point. If the reset work has already started,
cancel_work_sync() waits for it, but the worker may already be executing the
bus reset teardown path; remove can then continue and run its own teardown
afterwards.

So the patch needs a stronger state/ownership model than just
schedule-vs-cancel serialization. I will rework it so reset and remove cannot
both own the same teardown sequence, and will send a v2 after auditing the
PCIe/SDIO/USB paths again.

Thanks,
Fan



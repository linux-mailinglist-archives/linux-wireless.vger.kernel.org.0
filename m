Return-Path: <linux-wireless+bounces-38692-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id niWyAKDGS2pIaAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38692-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:15:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A271272F
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:15:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=ltcHrTS6;
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38692-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38692-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBCF33185F15
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA812298CA3;
	Mon,  6 Jul 2026 14:25:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442F37A849;
	Mon,  6 Jul 2026 14:25:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347907; cv=none; b=IRgI9nSszNlsO7oD6Kxm+JTEmYYL/yOWoDUYhokAs8945Pyw8fIWC8VatqYGLfuIwG2qTQAvWW35IXb6TcE+7hJXaIo4tcIzdOqP9N00xE1E2JZUFgQ0lG78PeZApL/Z6dOfAELK5luSUtecvDcPJPzDyMJLcxRqwGiA3X+caxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347907; c=relaxed/simple;
	bh=C2Saa5XpV03/C4HkVOGMRTqdRTVQbwGa+2F/73MPLWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Et4oyt4NIu5q6XgTjzCUR1TjWztP2RnSo7IalmT07vMZfUk2Ss6zKtF1JroLtnqynq0mtP8OXyKXKvwIX1Qs0Y1RJtunucuLfzJx9ZZVAJ2/zglQpIYiUbt1mj+2dg6XKYjrzfv4CCwxrBGsTebnTuosaSlXNjhSfDkKy+WplzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ltcHrTS6; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4516bc2c4;
	Mon, 6 Jul 2026 22:24:54 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: johannes@sipsolutions.net
Cc: dawei.feng@seu.edu.cn,
	jeff.johnson@oss.qualcomm.com,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in ieee80211_register_hw()
Date: Mon,  6 Jul 2026 22:24:54 +0800
Message-Id: <20260706142454.143798-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <986fff6416ba2acd8d7a4e5fb2f6a89eb40e10d1.camel@sipsolutions.net>
References: <986fff6416ba2acd8d7a4e5fb2f6a89eb40e10d1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f37d1571303a2kunm313b7b15960e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh5OVh1OHh9OSR5KQ0lDGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ltcHrTS6LrY53O1dpuK+Fteeim+QCEHdmqPgnpnRt4IPML1KRoELNidIVgnQGNWdeU+uoR3ik9yJoIQdS4/b+VMkvTLplMx40KHji3+1leYzZFS1b2lBRD9fAobg/IOH9LUC+pdlWYf7v+ct7eJRdB32syJzJu91niikwTZ9Icg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=C2Saa5XpV03/C4HkVOGMRTqdRTVQbwGa+2F/73MPLWo=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38692-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:dawei.feng@seu.edu.cn,m:jeff.johnson@oss.qualcomm.com,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:from_mime,seu.edu.cn:dkim,seu.edu.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB3A271272F

On Mon, 06 Jul 2026 13:47:22 +0200, Johannes Berg wrote:
> Reported-by? Reviewed-by?
>
>> To better align with the kernel submission guidelines, I will add a
>> "Co-developed-by:" tag in the v2 patch for Zilin to properly reflect his
>> contributions. Would this be acceptable?
>
> If he did development, I guess?
>
> Anyway you didn't do that for v2, so please resend after you figure out
> what you want :-)

Hi, Johannes,

Thank you for pointing out my omission. I will use Reviewed-by tags for
Zilin in v3 patch.

Best regards,
Dawei


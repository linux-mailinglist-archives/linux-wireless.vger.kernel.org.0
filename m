Return-Path: <linux-wireless+bounces-31355-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIG9NmxhfGl0MAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31355-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:44:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C189B8043
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D33530157F6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E234EF01;
	Fri, 30 Jan 2026 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OHwbRpFS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457732BEC20;
	Fri, 30 Jan 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759081; cv=none; b=AYe0wv2/MgGrCNfLMSppEMB8UdaXiZod2CLf2/n/ZMi4miEwUwnQKHMWBnZF2vJzc021Bl4vYpY4HmVqqMlqx0E3zfTX7cNZJc+otoBwG5RLTK5sYUlsrVVoBioT80On+ipyVmQtEkdK/WvzBVmj2CiYDqusCwYPwsmj+oly+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759081; c=relaxed/simple;
	bh=rxb0/bbhEcmFlnuJ+AoBrePH0FrZoLOnFKeVCQHY6Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4Gr4xkM93bo2JndRPNIiKf4rQvrIlHchneLWTKpSJsRhT6FchzXgPpJIDb2drn6LgxKphNlI2rd4AnEiHSNwlKLvZqxZBh+AF5NWYVyijgoNYXUum3GTg+ANpeJvO07sr3djSpoknPw+Gw4uEEx6lmqQRQHlw7la8HO7akEVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OHwbRpFS; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3288ed044;
	Fri, 30 Jan 2026 15:44:27 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	baochen.qiang@oss.qualcomm.com,
	jianhao.xu@seu.edu.cn,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH v2] wifi: ath11k: fix memory leaks in beacon template setup
Date: Fri, 30 Jan 2026 07:44:26 +0000
Message-Id: <20260130074426.63517-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <97b132e8-d3b2-4e52-aa74-c8aeb0f5d516@oss.qualcomm.com>
References: <97b132e8-d3b2-4e52-aa74-c8aeb0f5d516@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0ddc4b9c03a1kunmed20031614a423
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkNOVkwdSksfGR4dTBpJTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OHwbRpFSsU6IIhOQFDMjnyPOpaOL+QC8uBYyUAoG/1jESujr4ryGiteLrOMD0YfpfvUoHwZoP6RabS0rvUyqsw3tTqkwVHqGNhORNjUGpHYue8hi2n1KAvD5kfFMiatJUnEMoOxGi5RuipZXUpx4AEwKTNkWgFJtRJS8aS96KxU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=dxrW9ETbBNzSeSrVWsa/TL7QUsND7/iXmMFvytA+xzs=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31355-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: 6C189B8043
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:36:43AM -0800, Jeff Johnson wrote:
> I prefer strict logical consistency so I prefer either adding the goto or
> removing the beacons->cnt check.
> 
> Or a completely different approach would be to use cleanup.h functionality and
> annotate beacons with __free(ieee80211_beacon_free_ema_list) so that no
> explicit calls to that function are required. If you try this approach then
> beacons must be defined at the point of allocation:
> 
> 	struct ieee80211_ema_beacons *beacons __free(ieee80211_beacon_free_ema_list) =
> 		ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
> 						       tx_arvif->vif, 0);
> 
> Note that I have not tried this approach with allocations other than from the
> kmalloc() family with __free(kfree), but in theory this should work.
> 
> /jeff

Thanks! I'll add the goto path for the beacons->cnt check in v3.

Best regards,
Zilin


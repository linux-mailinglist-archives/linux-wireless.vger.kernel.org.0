Return-Path: <linux-wireless+bounces-31041-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BZNEl6acGlyYgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31041-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 10:20:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F454425
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 10:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E5806B9A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6A45BD68;
	Wed, 21 Jan 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WrQtDeue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE034FF4D;
	Wed, 21 Jan 2026 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986318; cv=none; b=Y9ddCaaahip8rxY1IAC8c1cq74HH9p81g0XSOvHDbN/EAhLyipZM5M5mJ5sx6fwCFiXkV3q45b/sWiyZKVLQDOZ+LgQEYtJHzE5teA5AudhEc/F7oGFFiThmM0JOFGcsieXFwnl4HaYMR0FmzdoLLxvx12HJHZrhTHoftTh8wSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986318; c=relaxed/simple;
	bh=JrQStGuhFE1f4PyY0ua1RpkpcoifR08lcf5T9FjEMfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dW/eKQm0113t4vfIu5I7Dr48Xm40HNpDq1Htvut/DUS6ZpthUbyRTuIYZ/RI06zl5LFUQOC1sbkTjWHp5zauqiMv6f/PCeS7H0kadofL5g7oIBhzvEHr/HZi61ezAIQmDonFxVR6Jwr4tFWLUtGG6h85bItPY/ua6QdVm1r/olU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WrQtDeue; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 316f069a2;
	Wed, 21 Jan 2026 17:05:08 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: chunkeey@gmail.com
Cc: jianhao.xu@seu.edu.cn,
	johannes.berg@intel.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_rdevanat@quicinc.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH v2] wifi: p54: Fix memory leak in p54_beacon_update()
Date: Wed, 21 Jan 2026 09:05:07 +0000
Message-Id: <20260121090507.3442567-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <71ec168e-423b-4269-88b9-56e08c1d8110@gmail.com>
References: <71ec168e-423b-4269-88b9-56e08c1d8110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bdfccedaa03a1kunm071d8f9c2d9cca
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxgYVk5MSk9OShhMTkJMH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WrQtDeueUbIPi0KunaNUCG85dQ1lhL1gShat3SyOnVfm7ZDawqfrheY90V4/htV1dCTG1pcH1VCEv+gfXakWD3ZHlUI3loj5HdOAGOEyMQVK/fQSZeSFt78/gG56O8cj4c2xZnLg8PEaPLhQFK5Z76xbT0guX78V3CWViFL+paY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=/6UBV3Ra2Gm9+edzGVspvw6IhXIfdKzMOQySl8nFMs0=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31041-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: AA3F454425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:25:15PM +0100, Christian Lamparter wrote:
> Ok, from what I remember, this return basically is/was and likely will be a dead-code path.
> So adding something there is only there to "look" good for the static analysis tools.
> But many commits like these have been merged before. As long as it is mentioned that
> static analysis was the reason for this. Yeah sure why not.
> 
> 
> Reason being why this is dead-code is that in order for the path to trigger, mac80211's
> ieee80211_beacon_get must have prepared an invalid beacon (with an invalid TIM Element)
> to start with... And looking at ieee80211_beacon_add_tim_pvb, it still looks to me like
> the IE length can't be less than 3 ever. But, I've been wrong before, if you do see please
> correct me. (If not, you don't neet to really bother with the Fixes-Tag)
> 
> 
> Cheers,
> Christian

Hi Christian,

Thanks for the detailed review.

I agree with your analysis. I checked the code and confirmed that mac80211 
guarantees a minimum TIM length of 4 bytes for non-S1G devices.

I appreciate you accepting this patch to silence the static analysis warning.

Best regards,
Zilin Guan


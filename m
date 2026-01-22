Return-Path: <linux-wireless+bounces-31057-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNeyAuTicWk+MgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31057-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:42:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B292C63557
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88E0F5A860B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BE73E8C40;
	Thu, 22 Jan 2026 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OJ4UT1+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A63D5242;
	Thu, 22 Jan 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070873; cv=none; b=Eo5luiE4ZeRVUsqaSxSUbX2nxno84b5hxkAnmLYDZDn5wXKMJMF0U0o4mdlsIEX6TK8SL/kODbvxVmeoAffYztsFRc3IWGTC2/g8w5SmR623Mgz37xyNd1feUiV5bgZ1wx6ULoEpsXrkWf9rxJzr9wP+RoWP04xkfOGrpj78J1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070873; c=relaxed/simple;
	bh=ZVn70PkiJ7LBhX4YjI1RIlM+nRymQ31/MJyAe5068RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrphSROybzTmFX/U6zbVY1vXAcb1sYbF15yLQ6fB1u1t/x44vSNQO19Xksnoa8lrshSQeZNvQguwa5nziTylr1+Ag8JGFziueTqgVbrSsyE8RO8n73m9uq1TnGJr8/WK0G37OEkrIhcAjr2JBDyLAxN9OM2A7MZGOEpYM/Sakd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OJ4UT1+0; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 319367856;
	Thu, 22 Jan 2026 16:34:24 +0800 (GMT+08:00)
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
Date: Thu, 22 Jan 2026 08:34:23 +0000
Message-Id: <20260122083423.408425-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <819fc850-98b4-4a0c-af4d-da2cf41cfcbd@gmail.com>
References: <819fc850-98b4-4a0c-af4d-da2cf41cfcbd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be4d7260a03a1kunm9b80778232bed
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkNCVh8ZSx5PQhlDQkJPTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=OJ4UT1+0g5C1g81HTpMSnOt4aakQ7AIxBBIZEwdIKXI+s3f1uENU5MNxPRhKRv/RB+KF9dh2SSJxHWR+7ATiPOVWbvooAlr8ABot0ZdvIlVa48537KYWiZ2/vg0fnVRUUMnm5LSE4z8PxS9Go6cZXBr64wIGF7Z746a/BS5R+q0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=IBG2TU7meYxUEZOx+iu4zCjh2R8j2RLNT6XiIfcQhLA=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31057-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:mid,seu.edu.cn:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B292C63557
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:14:50AM +0100, Christian Lamparter wrote:
> Hi Zilin,
> 
> On 1/21/26 10:05 AM, Zilin Guan wrote:
> > On Tue, Jan 20, 2026 at 09:25:15PM +0100, Christian Lamparter wrote:
> >> Ok, from what I remember, this return basically is/was and likely will be a dead-code path.
> >> So adding something there is only there to "look" good for the static analysis tools.
> >> But many commits like these have been merged before. As long as it is mentioned that
> >> static analysis was the reason for this. Yeah sure why not.
> >>
> >>
> >> Reason being why this is dead-code is that in order for the path to trigger, mac80211's
> >> ieee80211_beacon_get must have prepared an invalid beacon (with an invalid TIM Element)
> >> to start with... And looking at ieee80211_beacon_add_tim_pvb, it still looks to me like
> >> the IE length can't be less than 3 ever. But, I've been wrong before, if you do see please
> >> correct me. (If not, you don't neet to really bother with the Fixes-Tag)
> > 
> > I agree with your analysis. I checked the code and confirmed that mac80211
> > guarantees a minimum TIM length of 4 bytes for non-S1G devices.
> > 
> > I appreciate you accepting this patch to silence the static analysis warning.
> 
> Phew, and so far no buildbot replied with comments.
> 
> I have one last request: Can you please add a sentence about that analysis into the commit log as well?
> Our future selves could maybe appreciate that one day, if this comes up again. Because then we won't have
> to remember all or search/look for it again, if it's already neatly written down directly there.
> 
> Thank you,
> Christian

Hi Christian,

Sure, I will add a note about the analysis to the commit message as 
requested and send a v3 patch shortly.

Thanks,
Zilin


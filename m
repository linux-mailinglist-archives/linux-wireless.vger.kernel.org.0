Return-Path: <linux-wireless+bounces-34539-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMVgLgJf12kCNAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34539-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 10:10:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A193C789A
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 10:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD2830474ED
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFE38BF72;
	Thu,  9 Apr 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gVTPOnrF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6437AA77
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721939; cv=none; b=YWDJBvYeBGws//M2+aMlSkiCY96qQYehHc+19VCQFgfqCQ69ljcWIsoNVRxXLwKk9mT7MATDPzXZhBInqYXwNsiAwKqVJwbcU/FzPjPCjeoMs48Wg3pO4W8KkgQRHcoc0/VTALefC4K5c7aYh5IInGwUO2JW9dF4ZDyCEvmZfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721939; c=relaxed/simple;
	bh=RBVUIKRN3zU8l7PTjpjmmShJDgfhxwNhFqjzM3tw/Z8=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=IIYRHxamJAv0eWaq+eojCRm7PaKD49B1HFZdB+aAisyEOKSwX4VhvHwAHnfnZDYzopwPOvu7UwkAjOZjrUOf9tIwZy6d0NExjJ4ffSMeIucb46bBXaw5TUeLCrDrwk1N37+ncd3QBmIHIi3oZtgwMPzYXEzfJB20Jv4gYJ4dB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gVTPOnrF; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id ABA28240029
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 10:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775721934; bh=IfmKGl1b4fkOFzJku3o8qbny+9fSAOmo5O4Ct0sJ1Lw=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=gVTPOnrF2WzinI6yQxjtiImEeE4cW+e61oLmqP7R3P1hqtyR7czAPAJPIivKbnWZ3
	 566bYDkIaBDuxZzz+RipmKeHBdgxpgb2nUqZTK5pntxfhNXZiF0hihHRLp53XZEhIm
	 vHyZiX4OJNFVKD0drSIl9LZDE4h6x44YMhgu6NYbTr+frhShP/AshfaMvbV9qwHDxQ
	 Dy3V0SJyP+efIo6YtQO9XlYELuTdV2t42ZElhmnyt68UcE6whnfUXorrhbPI5SFrq/
	 MSsHNdBmsLtYjIu48UjTL8CZNFwN4o1h2Aapvs7N6FnD1g9vqHGbrs3CQpBrEwHhz3
	 9qKHIBbeFpb9g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4frstk1whTz9rxG
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 10:05:34 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Apr 2026 08:05:34 +0000
From: Steffen May <steffen.may@posteo.de>
To: linux-wireless@vger.kernel.org
Subject: nl80211: missing minimum TX power attribute causes misleading
 userspace behavior
Message-ID: <9ec6fd0b1c7392fce8c913a46c1b197e@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[posteo.de:s=2017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[posteo.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34539-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.may@posteo.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,posteo.de:dkim,posteo.de:mid,mac80211.sh:url]
X-Rspamd-Queue-Id: 14A193C789A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This issue was discovered during the analysis of two documented OpenWrt 
bugs. Bug 1 is a type comparison error in LuCI wireless.js that causes 0 
dBm to be displayed incorrectly. Bug 2 is in ucode mac80211.sh where the 
value 0 is treated as falsy, causing the router to transmit at maximum 
power instead. Both bugs are proven and reported.

During verification of Bug 2 on five devices with three different 
chipsets, it became apparent that the hardware floor is device-dependent 
and completely unknown to the stack. This is not a bug but a missing 
feature.

Because the floor is unknown, iwinfo generates selection lists 
containing values that have no real effect on the actual output power. 
Userspace accepts configurations such as 0 dBm even though the hardware 
cannot apply them. The system reports success while the hardware remains 
at its minimum supported level. This creates false assumptions.

Measurements

The deviation between the requested transmit power and the actual 
hardware floor is not constant but depends on the hardware:

Device                Chipset            Requested     Actual floor   
Difference
Buffalo WZR-600DHP    Atheros AR7161     1 dBm         3 dBm          +2 
dB
TP-Link Archer C7     Qualcomm QCA9558   1 dBm         5 dBm          +4 
dB
OpenWrt One           MTK Filogic        1 dBm         1 dBm           0 
dB
Cudy WR3000           MTK Filogic        1 dBm         1 dBm           0 
dB
GL.iNet GL-MT6000     MTK Filogic        1 dBm         1 dBm           0 
dB

Concrete example: Buffalo WZR-600DHP with Atheros AR7161

Because the system does not know the actual floor, the list generated by 
iwinfo contains values with no real effect:

0 dBm (1 mW)  reported, hardware remains at floor
1 dBm (1 mW)  reported, no actual reduction
2 dBm (1 mW)  reported, no actual reduction
3 dBm (1 mW)  actual hardware floor
4 dBm (2 mW)  first real power step above the floor

Proposed solution

Introduction of a new nl80211 attribute NL80211_ATTR_WIPHY_TX_POWER_MIN. 
nl80211 already exposes the maximum transmit power. Minimum and maximum 
are both fixed hardware properties -- it is inconsistent that only one 
of the two values is available.

No patch is provided. This mail is intended to describe the problem and 
to encourage interest in an implementation.


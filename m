Return-Path: <linux-wireless+bounces-34568-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gQwLOAqf2GnegAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34568-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:56:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C53D2FCA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B08AD300737B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FA33263E;
	Fri, 10 Apr 2026 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="UWeqc/1o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116626F47C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804168; cv=none; b=adsh8y0jP8FTmPJioR0TMmx216CfBhgs0Gjor1MP72hiizzaBX5okWg4i3w9bTT5at+BnjFb66cSskrWIKKQRewWn0fdzD9gRTQ4wnQ8jrAAUE41/fHx1QYz3NkhafQogw+Mc4P60hYXPzxobs7/4lc0kq+KZZwhpwLBcEN7FSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804168; c=relaxed/simple;
	bh=hdqhqava8DhRt7DzgzGpYGCqe6UmG+GP5K7HF83hygg=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=TB1iuVTLkOOwiNEKhSpC1TYS17lQbQCO/Qu/7sa7wT2wmkgeMCMp+bpJ/k3TYQILzD/PVd/guPtRKxVasrclWuU/m4dBq2fN4Iw6q46xPY46FbatPAnLuRTXdqOrAdN6Xv/3uuERLOeswyIw4R3q1dJqXbuj/PlzCIDuguP5D+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=UWeqc/1o; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E1F76240101
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 08:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775804157; bh=6M2mmyeOT+HMUVVKoE2d/0e/hLtkSl5dxtv7CPF4n8k=;
	h=Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:
	 Message-Id:Date:Cc:To:From;
	b=UWeqc/1ocbHXNRZH2NuYX4xMrEbI6uuZwbATVCiKiqfAtHiTBSWzloVhX2Y4I6Tr6
	 83eWdn6j87UCBC8IwgrXUc/+rdA3urxRWq2h7Obls4Wg0j0qpPjCYZW1D3W0gb27Vb
	 x0g9TM7esGvn1hmW6B+bvi6AsFaXxaf7l5++DINMs2gAb5z/6hMfjlcYgCnjnHXauV
	 LpXVrEuij2rw2CKlJzKq0ut/1onIRW9+8kYbHbjph+p07u/NB2vWh5XMnyx5bYwxGm
	 QqNbHGTXSSsO4OKa8HHlcfW8eTApJ3ChrOyiP1xVcEeLV4LLDLQbH0mFhwrwC9MTG/
	 bEhen+G0VD3/A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fsSHx2msfz6tsf;
	Fri, 10 Apr 2026 08:55:57 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: May <steffen.may@posteo.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: nl80211: missing minimum TX power attribute causes misleading userspace behavior
Message-Id: <D227BC4E-EE8A-4138-8046-87E931112EA1@posteo.de>
Date: Fri, 10 Apr 2026 06:55:57 +0000
Cc: linux-wireless@vger.kernel.org
To: Ben Greear <greearb@candelatech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[posteo.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.de:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-34568-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[posteo.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.may@posteo.de,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,posteo.de:dkim,posteo.de:mid,candelatech.com:email,candelatech.com:url,mac80211.sh:url]
X-Rspamd-Queue-Id: 3E4C53D2FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=EF=BB=BF
=EF=BB=BFConfirmed on two devices:

TP-Link Archer C7 v2 (QCA9558): txpower=3D1, iwinfo reports 5 dBm
Buffalo WZR-600DHP (AR7161): txpower=3D1, iwinfo reports 3 dBm

Reporting is accurate -- iwinfo reflects the actual hardware floor, not the r=
equested value.

To clarify: this was never intended as a bug report but a feature request. T=
he hardware floor is device-dependent and cannot be queried by userspace. It=
 would be useful if this minimum were made available, so that LuCI can offer=
 only values the hardware can actually deliver.

Steffen


Am 09.04.2026 um 17:27 schrieb Ben Greear <greearb@candelatech.com>:

=EF=BB=BFOn 4/9/26 01:05, Steffen May wrote:
> This issue was discovered during the analysis of two documented OpenWrt bu=
gs. Bug 1 is a type comparison error in LuCI wireless.js that causes 0 dBm t=
o be displayed incorrectly. Bug 2 is in ucode mac80211.sh where the value 0 i=
s treated as falsy, causing the router to transmit at maximum power instead.=
 Both bugs are proven and reported.
> During verification of Bug 2 on five devices with three different chipsets=
, it became apparent that the hardware floor is device-dependent and complet=
ely unknown to the stack. This is not a bug but a missing feature.
> Because the floor is unknown, iwinfo generates selection lists containing v=
alues that have no real effect on the actual output power. Userspace accepts=
 configurations such as 0 dBm even though the hardware cannot apply them. Th=
e system reports success while the hardware remains at its minimum supported=
 level. This creates false assumptions.
> Measurements
> The deviation between the requested transmit power and the actual hardware=
 floor is not constant but depends on the hardware:
> Device                Chipset            Requested     Actual floor Differ=
ence
> Buffalo WZR-600DHP    Atheros AR7161     1 dBm         3 dBm          +2 d=
B
> TP-Link Archer C7     Qualcomm QCA9558   1 dBm         5 dBm          +4 d=
B
> OpenWrt One           MTK Filogic        1 dBm         1 dBm           0 d=
B
> Cudy WR3000           MTK Filogic        1 dBm         1 dBm           0 d=
B
> GL.iNet GL-MT6000     MTK Filogic        1 dBm         1 dBm           0 d=
B

If you set that tplink to 1dbm, and then read the reported power, does it pr=
operly show 5dbm?

If so, that seems good enough?

If not, then we should fix the reporting, but having a floor reported doesn'=
t seem helpful
to me.  There are lots of things that can affect actual txpower.  User-space=
 can at best
offer its suggestion of preferred txpower.  Kernel/driver/firmware/hardware t=
hen makes final
decision.

Thanks,
Ben

--
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com





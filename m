Return-Path: <linux-wireless+bounces-28666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C38C3B095
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 13:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4596D50136D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43B3328E1;
	Thu,  6 Nov 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gu5aWBrM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0A331A5F
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433588; cv=none; b=X5c5NeEBR/x5t8//QdvuO2rIUM5M/dIFmh78qSbplTAyRtE9JblUkpDCzaNsWWD+huv6hME9RAKKTOhZETjKEVuRDFv8QUEmciFADDO8UL3bzUStd3fo7SKnY1tOotaH2Z2xEJhHMbpY5Oyn1HUeg++PStzzK47AoGmpkBFXw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433588; c=relaxed/simple;
	bh=SB8+JLmxMvZ1taiZmigv9b0OWRL2mwFbMhEcLnOTyhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECLNTH2x3h2YwGSSs/apSbWZvz6TB5j8TgnRIs1lpyDcApBdkF+thjAu6xu8acGliC2EwJ3KLK3tqomOFE4rk1/C/3Mgj8eWx0wm1n5u+ASJwseP+kbm6deqn9gFzjjQ05yEBLpbMe8SZ2Ms7KT00kmiAOql0Xj+354YmZqovzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gu5aWBrM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SB8+JLmxMvZ1taiZmigv9b0OWRL2mwFbMhEcLnOTyhU=;
	t=1762433586; x=1763643186; b=gu5aWBrMTZ8So9auL/Syki9rqx7yQ5dJLZnQ+2V8pRjlKJa
	OQxwfDzoaDY4gC9LKagy5H/B4fLyucfcVLD4Yn3DMhLtNldESSxT90J+h4CCFsbcb6drM3DETfQcQ
	HgrUfE3cWn+lxqxC7qSDDO51aOzAOq5lsjVh/scDcd+C8DUGz7y+aHGxLNLiRJjdSaxT22bbEONyn
	BRZZb2cAH8Ab6/dV3NuPKmQnuOF5DhKkomuDWBfjMfYX/nYNlHAOthj+7xc9FKUdZ5oV0sDODkyMs
	woNdYAH4OJn5aq3E27Bbj9rvEjXJjsqODG424wNpgC7rpZ1wmDmv8D1uLaMvlFHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vGzTx-00000000Bbc-1oWV;
	Thu, 06 Nov 2025 13:52:53 +0100
Message-ID: <996194019be7dcca0ee0fd16d7d3274d0f2d4a92.camel@sipsolutions.net>
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Aditya Sathish <quic_asathish@quicinc.com>, Johannes Berg
	 <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	hostap@lists.infradead.org
Date: Thu, 06 Nov 2025 13:52:52 +0100
In-Reply-To: <793f6c8d-d092-49c8-b34f-8e6db7761750@quicinc.com> (sfid-20251104_223218_742396_D7F355C0)
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
		 <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
		 <30403bb70a2a017c90b1d4a5a1a07514bb670822.camel@sipsolutions.net>
		 <fb0a1ddb-af24-47f9-9d75-0a8f2e346d81@quicinc.com>
		 <b6a9de98b9b09c73003b89331ba235c3a959c3fd.camel@sipsolutions.net>
		 <793f6c8d-d092-49c8-b34f-8e6db7761750@quicinc.com>
		 (sfid-20251104_223218_742396_D7F355C0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Aditya,

On Tue, 2025-11-04 at 13:30 -0800, Aditya Sathish wrote:
> On 10/30/2025 01:47, Benjamin Berg wrote:
> > Do we have a clear picture of what the performance issues might be?
> >=20
> > To me, it seems a bit that talking about threading might be a red
> > heering. It could be that the primary issue is the prioritization of
> > events when there is a burst of activity.
> >=20
> > We should not need threading as long as each individual event can be
> > processed quickly and hostapd is able to keep up overall. In that case,
> > we have an event ordering issue which can likely be solved by using
> > multiple nl80211 sockets and giving them different priorities in the
> > mainloop. By doing that, you can effectively pull all time-critical
> > events to the front of the queue and ensure they are processed with
> > only a short delay.
> >=20
> > Now, that doesn't invalidate your point at all. If we do have tasks
> > that take a long time (crypto?, external requests?), then it can make
> > sense to push just the slow part into a separate thread and pick up
> > processing in the main thread once it has finished.
> To preface our concerns: the longer the context transfer takes, the
> less time the serving AP has available to drain its remaining packets
> before hitting the SN limit. This can result in a larger gap in
> client-perceived latency during roaming depending on when the target
> AP is ready to start DL transmission. Efficient handling of the
> context transfer (during the ST Execution phase) is therefore key to
> minimize client-perceived latency.

Right, so the time it takes to drain the queues and the likelihood of
hitting the SN limit is not purely a function of how long the whole ST
Execution process takes.

I am probably missing some important bits, but I imagine that an early
bridge update is quite important. The earlier the bridge stops
forwarding packets to Serving AP MLD, the fewer packets need to be
flushed relaxing the SN limit issue and minimizing the time needed to
drain the queues.

As far as I can tell, one could immediately ask the bridge to stop
forwarding packets to the Serving AP MLD when the ST Execution Request
frame is received. Similarly, forwarding to the Target AP MLD can begin
as soon as it is known that the ST Execution will succeed. After all,
the Target AP MLD already knows about the station and can buffer frames
for it. Such buffering can happen before the HW is fully configured and
even before the Context has been transferred.

Now, the Target AP MLD does need to be fully configured before the ST
Execution Response can be sent out. But maybe we can effectively start
the the DL draining period early and relax the timings that way?

> You've accurately captured the core performance concerns we intended
> to highlight:
> 1. _Prioritization of Management Frames:_
> =C2=A0=C2=A0 Certain management frames - such as SMD - should be able to =
"skip
> =C2=A0=C2=A0 the line" since a roam request typically will indicate degra=
ded
> =C2=A0=C2=A0 client link quality and prioritizing immediate transition ov=
er
> =C2=A0=C2=A0 processing existing management traffic is likely in the clie=
nt's
> =C2=A0=C2=A0 best interest - especially after preparation has already com=
pleted.
> 2. _Additional Threads for Long-Polled Operations:_
> =C2=A0=C2=A0 Without multi-threading, long-polled netlink messages or sys=
tem
> =C2=A0=C2=A0 calls can block even the prioritized kernel events. As you n=
oted,
> =C2=A0=C2=A0 offloading slow operations that are busy waiting to worker t=
hreads
> =C2=A0=C2=A0 can allow the main thread to handle time-critical events.
>=20
> That said, even with multi-threading in hostapd, we still face
> overhead from RTNL locks and netlink socket overhead =E2=80=94 not only f=
rom
> hostapd of the serving MLD but also from other hostapd processes tied
> to other MLDs on the AP. This is why we initially proposed moving the
> ST Execution sequence to mac80211. Doing so could reduce round-trip
> latency from ST Execution Request to Response, especially under high
> system load and concurrent work across multiple hostapd interfaces.

Yeah, there may be some things for which a lock might need to be held
in the kernel. That said, with the above in mind, I am wondering what
the critical parts there are and how long the round-trip time is
permitted to be in the end.

Benjamin


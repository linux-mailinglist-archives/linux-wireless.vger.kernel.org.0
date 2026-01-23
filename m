Return-Path: <linux-wireless+bounces-31114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPkTHPJqc2mivQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 13:34:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E4475E21
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 13:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F41E301828A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91628136C;
	Fri, 23 Jan 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DivuSVAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FA26B741
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171691; cv=none; b=WhAQJhQvHjg346kAGH6Wyn7lD4NmW4g4NhwPiaQaI8HflT/TTz8ZicmWGmmV7ftIDdhz9hz5dSrHcSD8E9mebU0P2ADLBKG27FTesTvjXKeuWuhXnR6ORlXfRv70mBx4qfkdEUrg2k7PjsrfMSmB9AZocR4fxGImWkoYLPRTEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171691; c=relaxed/simple;
	bh=Ap7W1OsQ4xr5bXiTDUi+0zYdKUdtaQ3QVhwPB87IfqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2musRqA+iEXH3qmozibG1jxsmeI3b7NjmJ1Os6YNMR+qE6bpwEyGT57Y4bNpVFRmJs8Em2W6xs0OCqEhwFsPBWfXZlyPNryahXFu47jTP0r5mrhDROzyYv9CJJB3bNRP+Zr3PknUCfEutLFXVVwgqqR/RFF82BeWmSbMKfmHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DivuSVAH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZOqjqLtDvG99yYqI/I7zi9/9o268DymXDCi6dweV0lI=;
	t=1769171689; x=1770381289; b=DivuSVAHgMP6dxSnTMy0VF85/EHF+0ToS/vLBWEKC+6VuGC
	fGza1KB1r3/HE5gHHai+z2QsIFjPoB5Qp77axdMzCZXEDWqDwPWnCUc2T9SxAtoxeXbJBdtgXyCNW
	WFDQnC5Ge1M7voE/nD1FiJzao/jP50f8YH1Oj5mBhCcbhRbgrZuFhhfRV911+woDxyyaiQntD9lgq
	QeHyzCVO/MYfpjGmaI2pwhEw35y+LXsfT2gzGJg1t4CmL4ozYrkrWDz1qMoQvAoe4UZEQxOQbk12b
	Rimx0MZ5mTokm8GTQYF+jaMkZ4TO9bGPUxp8ihWgiieRc48aIkpNoMPepWCkbQpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vjGN6-00000001heb-3CwF;
	Fri, 23 Jan 2026 13:34:40 +0100
Message-ID: <6fbfb8b4f4a4a745b81cc8f81e01429ca90aa547.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce computation
 for management frames with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Rohan Dutta <quic_drohan@quicinc.com>
Date: Fri, 23 Jan 2026 13:34:40 +0100
In-Reply-To: <215985b3-e951-415e-b091-3306fa08036c@oss.qualcomm.com> (sfid-20260123_123940_345604_B7F23BEC)
References: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
	 <5ff51b07b69284ca9b477dfcbe08890167c7ed14.camel@sipsolutions.net>
	 <0847363a-055a-4d6f-a9ac-b62f275e02ec@oss.qualcomm.com>
	 <d0798e0f62405687c57eff59767ac77b25c1f330.camel@sipsolutions.net>
	 <215985b3-e951-415e-b091-3306fa08036c@oss.qualcomm.com>
	 (sfid-20260123_123940_345604_B7F23BEC)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31114-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6E4475E21
X-Rspamd-Action: no action

Hi Sai,

So I'll preface this saying (maybe again) I'm mostly thinking out loud,
because adding 150+ lines of complex address munging code that reaches
into a lot of different data structures for what's effectively a hwsim-
only special case doesn't seem like a good trade-off right now... If we
can avoid this in mac80211 and push something into hwsim, it seems like
a win even if it were more complex there.

> > Obviously we still want to have hwsim, but if this really is only for
> > that then I feel we can still fairly easily implement TX encryption
> > "offload"? After all, in RX we make decryption optional for every singl=
e
> > frame - so if the device/driver didn't decrypt/validate the frame then
> > mac80211 will. We also pass the key to the driver for each individual
> > packet (struct ieee80211_tx_info::control::key). So doing the encryptio=
n
> > in hwsim would be really simple if we export a function akin to
> > ieee80211_tx_h_encrypt() that works on a single skb (which has the key
> > pointer), sets up a single-frame struct ieee80211_tx_data and returns
> > the skb from that [2].
> >=20
> "Implement TX encryption offload" - As I understand, your guidance is
> towards implementing the Tx encryption in the mac80211_hwsim driver
> Can you please kindly clarify if the understanding is correct?

Not sure I'd say "guidance", but yes, that's what I was thinking of.
Note that this is fairly limited, I'll elaborate below.

> In order to let mac80211_hwsim driver do the Tx encryption:
> (1)Add support for key install to hwsim driver, i.e,=20
> mac80211_hwsim_ops::add_key, so mac80211 knows that the driver is going=
=20
> to do the encryption.

Yes. Note that due to the mac80211 SW crypto design, it doesn't really
need to do _anything_, because:
 - on TX, mac80211 gives the key in the tx_info of every skb
 - on RX, mac80211 will happily do SW decryption if RX_FLAG_DECRYPTED
   isn't set on the skb

> (2)A function similar to ieee80211_tx_h_encrypt() in the hwsim driver
> that can do the actual encryption.=C2=A0

Actually, the function I posted in my other mail was going to live in
mac80211, but exported to be (only) called by hwsim. That way we can
reuse all the existing mac80211 code without making it more complex.
(We could even put it under a hwsim ifdef or hwsim-only export
namespace, but not sure that has much value.)

> Since mgmt frames need to use link=20
> addresses for crypto computations, possibly I could call=20
> ieee80211_encrypt_tx_skb() [2] after address translation to link=20
> addresses in mac80211_hwsim_tx() and since data frames need to use the=
=20
> MLD addresses, ieee80211_encrypt_tx_skb() can be called before the=20
> address translation to link addresses.

Right.

Given the function I posted wasn't even 30 lines, and the key install
function in hwsim can be basically "return 0", the RX part likely won't
be _that_ much either, I'd tend to think that overall it could end up
with even fewer lines of code than this solution, never mind the fact
that it won't have to reach into all the vif/link/sta/link_sta data
structures.

Now I haven't actually written it, so I don't know for sure it'll be
that simple, but at this point I'm fairly confident it should be? Do you
see any holes in this?

johannes


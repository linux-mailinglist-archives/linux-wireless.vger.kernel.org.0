Return-Path: <linux-wireless+bounces-34895-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEwyMf/s4Gk4ngAAu9opvQ
	(envelope-from <linux-wireless+bounces-34895-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 16:06:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 263FD40F5B3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 16:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 894133009B1A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB64A37F01D;
	Thu, 16 Apr 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eskapa.be header.i=@eskapa.be header.b="FuU0M92D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA20388E66
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348195; cv=none; b=Y71CmXP4KcEHLe6uiq3F6h/GisVlAryJ4oTXBY+//9e4MlKAKNZ4+Ys6/B/YeROkj0edIQ9Ev3l7AZab5Q25+AHhvLPnvOMO0vhOnvNWY+sDiX/xaOwm/ubaJJiBomcDK3R57tCTQtvXAHbrVDApF7ME99Ur7qr+3nw0AGbUU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348195; c=relaxed/simple;
	bh=ztADxfovP+qcLUeywN8+haMNesxbRtHBTW4AH+8dOf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIed6/kfg+gnWZ0YWuzWD/ybgJmof1dvNegX7PlqGBw0e4Dqv0PSGSu+SodYcdIw5gJIDp3VandopThuF+NUylf0msjFyT7OZw7/ULgScxDtOIm8lB8XM/1a7yiDJF1O6mapUfEDv9FkESWrc8D4Y6JfHSXSsRAcNiWgO5xNw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eskapa.be; spf=pass smtp.mailfrom=eskapa.be; dkim=pass (2048-bit key) header.d=eskapa.be header.i=@eskapa.be header.b=FuU0M92D; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eskapa.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eskapa.be
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fxKTx6FpJzCfx;
	Thu, 16 Apr 2026 16:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eskapa.be;
	s=20230820; t=1776348181;
	bh=RfrQg/it18ckHj/EYlJ2LT25J9rl/GLhaCc0Qa7HdfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FuU0M92DQ2oDwW6rBo+t055Eq+WSZxfkHq22nLYXKTi3OKTsyGwAt9UpJ0yautqbX
	 EhS+7s+E5bNTzD1FczOutO/1vHHx6Xtqw34BAHa9XJHPQNOtUP0ciwDK+H9Lxqi6Yc
	 x2tOXUUnHooegjn5qx5k3n6zvovXcAysbx7JVwWxYdIyFBJd6aM/7YoYfbXUqY59mB
	 pcZvB1Pc9P4teKibE0/yKIb4wypjQ0AfFP41+bSfXKsxfwrmuqZF/tDE3L1Dr7nC82
	 KPh4e/Js10phv/SdpTt1XXfovdCe6Tjo1EvkFaNTym5LsWmuFxexMq5ClG+OHCFl0R
	 OA61nKUlux5hA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fxKTx2lXmz86X;
	Thu, 16 Apr 2026 16:03:01 +0200 (CEST)
Message-ID: <5b3d8cb4-13a4-45ca-8ddc-0692ace0488b@eskapa.be>
Date: Thu, 16 Apr 2026 16:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: Benson Bear <benson.bear@gmail.com>
Cc: linux-wireless@vger.kernel.org
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
 <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
 <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be>
 <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
From: Pablo MARTIN-GOMEZ <pablomg@eskapa.be>
Content-Language: en-US
In-Reply-To: <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[eskapa.be,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[eskapa.be:s=20230820];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34895-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[eskapa.be:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablomg@eskapa.be,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 263FD40F5B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/04/2026 14:34, Benson Bear wrote:
> On Thu, Apr 16, 2026 at 7:47 AM Pablo MARTIN-GOMEZ
> <pablomg@eskapa.be> wrote:
> 
> 
[...]
> 
> Thanks again.  Sadly it looks like linux (the wpa_supplicant) is in
> the wrong here, just reasoning about it.   I assume the AP always
> offers the option.   It doesn't get a rejection before it even makes
> an offer.   So that means when it offered it when PMF was not
> disabled in the client, the client must have accepted the offer.
> Because we know in the other case, when PMF *is* disabled, that it
> works fine, which must mean the AP received correctly a rejection of
> the offer.  So had the client sent a rejection in the first case,
> like it did in the second, there is no reason the AP would not have
> accepted that rejection.  So the client must have sent an
> acceptance.
You have dig slightly into 802.11 standard to understand the PMF
negotiation. Here is a quick summary:
1. the AP advertise MFP Capable/MFP Required support in its Beacon and
Probe Response frames (RSN element)
2. the STA advertise MFP Capable/MFP Required support to the AP in its
Association request (RSN element)
3. the AP will accept the assoc (regarding PMF) unless the STA or the AP
advertise MFP Required and the other one does not advertise MFP Capable;
if both are MFPC, the PMF is "pre negotiated"
4. in the M2 of the 4-way handshake, the STA resend its RSN element (it
must match the one in the assoc frame)
5. in the M3 of the 4-way handshake, the AP sends the IGTK used to
encrypt the (robust) management frames
6. in the M4 of the 4-way handshake, the STA acks the keys as a whole

The AP has the final say in the negotiation of PMF. If there is a IGTK
in the M3, PMF has been negotiated, if not it is not (the STA must send
the M4 even if it was expecting a IGTK and didn't received it). In the
M4, the STA cannot say "hey, the IGTK is missing?!" or "I cannot used
the IGTK you sent me [as long as the MIC is validated]" or "your M4 has
weird content I cannot parse beside the PTK". The bug you are
encountering is most probably either the AP thinking it has put the IGTK
inside M3 but, in fact, has not or the STA not being able to
extract/parse the IGTK [while the PTK and MIC are both valid].

> 
> Not iron clad, because maybe the AP is just plain crazy.
> 
> But it seems that this craziness would be hard to accomplish, since
> there is nothing to distinguish the two cases from its point of view
> if the client correctly rejects in both of them.
> 
> Unless you can say that, contrary to my initial assumption, the
> client makes the rejection even before the offer is made.
> 
> I was hoping I could go back to Rogers and tell them their AP is
> buggy on this point, but it looks like perhaps not.
> 
> Unless you see some other flaw in the reasoning.  If you don't, I
> will take the issue over to the wpa_supplicant people, if you think
> that is a good idea.
> 
> It does seem weird, though, that the client here would send an
> acceptance and then not carry through with it!
> 
> (Since my own problem is solved I might lose interest, and not be
> able to carry out the over the air examination, something like this
> I have never done... but still we should get it resolved somehow)
> 



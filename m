Return-Path: <linux-wireless+bounces-35038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF13Gfz15Wl+pgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:46:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8D429016
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B988301A2A6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CEB33507C;
	Mon, 20 Apr 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eskapa.be header.i=@eskapa.be header.b="pF/PSzNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B54391E7F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678316; cv=none; b=fRP5iHCgm4u9rQVdmRqofiAWYgOX+SPOaeqjf2l6sD9jkFABG2Dii3yIK9bywn3+5E5nWX7HN6s0R38gzddz1MiUQL3gcDoN/m3/SVBvrc8hjy69FcrW4JEDUf1foxwZ+YSnlSnZWEs1Oe0a/BUUMHZDLHuS4fjiPVAiWB68ePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678316; c=relaxed/simple;
	bh=fjZ8e8By0WCkGroXwLC5ZFCGZ96s/w0JM9iujZ2P61g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h5euri1QWJqOME2hRjW154gb1qx8fMC1ZDXkk+bzEM6dJUrVJdscI5+2+Dd6ix6mhyqsAWrzaCL93u6grjAkLH4XG2xYdyd8yFWfYoTB1BzfMGpOFUAvMLTNGHu/H8sWUYShtBN2qENlosoSC+Q+d5rkPQLqIoWnVdoCUrNv3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eskapa.be; spf=pass smtp.mailfrom=eskapa.be; dkim=pass (2048-bit key) header.d=eskapa.be header.i=@eskapa.be header.b=pF/PSzNY; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eskapa.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eskapa.be
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fzgM112r4zRc6;
	Mon, 20 Apr 2026 11:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eskapa.be;
	s=20230820; t=1776677709;
	bh=AGnDbPPdwWFv1Vykkzc5QVFnGBl3/qXI3vRxGRG+mTE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pF/PSzNYLjcSTWzZnAkh0U+yBdmAtne38yHJbsc/mdhQoPQ2TOLvMECXlb32RuUaX
	 i2uKQb+c4M3wioj0f3+s4LCMfrwcBa2xyqo1ga6hi8QHz57uVQmFj4lY7eX+5MK1pC
	 +QJaQ3uEHypKyq9VDBDq0v2tYR13X9u+mzszqzFx/51NzeEbHpVxMPMx/uAlGDUJ2Z
	 ivrEw8r+ISa5SzbukymMbTVmIzxfo2xuzi3WFmSRy6ATOTCYQ+byOQa1uuZ6Q8lfO0
	 K0kJdPFTLEfAWGRPiKbbYUlTc26xBzES0dkoRJKdF7aR66QwQH+U17Cnyv99l1Oy3t
	 DsDYvPdG52Xrw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fzgM052s6zKjW;
	Mon, 20 Apr 2026 11:35:08 +0200 (CEST)
Message-ID: <9ea2591b-c284-454b-b3b3-5ca824c0a3b9@eskapa.be>
Date: Mon, 20 Apr 2026 11:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: Benson Bear <benson.bear@gmail.com>, linux-wireless@vger.kernel.org
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
 <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
 <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be>
 <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
 <5b3d8cb4-13a4-45ca-8ddc-0692ace0488b@eskapa.be>
 <CACM6vn5FpHycsv6=bUwP2yBmV_an69zTgsJKJPVdewz4cnv5sA@mail.gmail.com>
 <CACM6vn6ySMs0HUFt3ddFc42FTakJ_dnWsBOfiiN+6ORZn9cm7Q@mail.gmail.com>
From: Pablo MARTIN-GOMEZ <pablomg@eskapa.be>
Content-Language: en-US
In-Reply-To: <CACM6vn6ySMs0HUFt3ddFc42FTakJ_dnWsBOfiiN+6ORZn9cm7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[eskapa.be,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[eskapa.be:s=20230820];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35038-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
X-Rspamd-Queue-Id: C2A8D429016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18/04/2026 14:04, Benson Bear wrote:
> Okay, I have little idea what I am doing, but I believe I have managed
> to set one of my machines'  NIC to monitor mode (the Intel NIC) and
> used it to monitor the attempt of the other machine (RT) to
> connect to the AP when the machine is configured to PMF
> being optional.
> 
> I have never used wireshark before but I messed around and
> managed to filter out all the noise and leave only those frames
> that are to or from the MAC of the NIC.   Then I took just
> the initial part (including a small file transfer).   Took quite
> a while to get this much figured out!
The pcap is missing a lot of important frames [a probe request or a
beacon from the AP would be nice], probably a combination of bad monitor
and over filtering, but we can figure some stuff out.
> 
> I have not tried to examine it much yet, but I imagine
> any of you might be able to immediately figure something
> out..
Surprisingly, the STAs are not doing what I though there would be
doing... None of them are encrypting the action frames. Your non-AP STA
sends ADDBA requests to the AP, does not receive any ADDBA response and
eventually (~2sec) sends a DELBA with reason 0x25. The AP sends an ADDBA
request to the STA, it receives a successful ADDBA response (and ACK it)
but somehow does not process it because resends one for the same TID. So
effectively, you don't have a BA session so you have pre-11n performance
(plus both STA "spam" the channel with useless action frames).
> 
> One thing I do notice, is that there are only two EAPOL
> frames, the ones from the AP.   I assume that this could
> be a problem with the monitor capture and not something
> else because it seems the frames must be there.   I
> imagine this can be inferred from the frame contents but
> I havent looked into that yet.   Have to look up in
> more detail the meaning of the fields.
> 
> Another thing I noticed.   I tried configuring the STA to
> require PMF, and guess what?   It does not connect
> AT ALL.   Another clue.
The AP might in fact not advertised MFPC but a part of its stack might
still process the MFPC setting of the STA and end up on the state you see.
> 
> Again, I will try to look into this myself, but I pass this
> on now in case any of you can produce with great ease
> an analysis or need to request different data.
> 
> I will get frame captures for the PMF disabled mode,
> and the PMF required mode, and I will try again to
> get one with all the EAPOL frames in there.  I believe
> I saw some before I did the capture to the .pcap
> file.



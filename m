Return-Path: <linux-wireless+bounces-38759-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pbc+ICwDTWrxtQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38759-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 15:46:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1366971C178
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 15:46:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L6RLv5oa;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38759-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38759-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C367303C648
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3A41DECC;
	Tue,  7 Jul 2026 13:41:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9B3F23C5;
	Tue,  7 Jul 2026 13:41:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431698; cv=none; b=VxEXUuxXPT8bwTIl+Ab1r8i/b83ZUqeB4G3hs79PhT5206029Zku23hcJFAvSgz66XcjOaWbkZ5edBwlBdKoqMwbGqFkRxAEPjfEqTCMwGhgPruqzCJyCR2qnA2/5Cnx7/jZAlfyWV6F1GVdkZiGTn6GzkJ9YLo5ahtBM2HKY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431698; c=relaxed/simple;
	bh=Q8bZHt7yJ+qnecwmMvVMWaD1rJjvWnisLULY4A4dVgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBovhx/ZotK9uLegLGk/0sT/HdVNE56/1cFNpvCb4jZHfSoHYpHrB12wuORfyelS+rg37/rdypN0biPy8nQ/IY+83ypDURpxvRfuxeZAkRnyIWlwmI3W8rjj5/K+is0Ib8XenejJ2vE7oQY85lxyCoKFDuGTAB1N/qiW1qfAj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6RLv5oa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE74E1F000E9;
	Tue,  7 Jul 2026 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431696;
	bh=bBAfp/1WTjfXkIXmaMektccP3AUgen/qc3sIQcub5vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L6RLv5oae/GlbVM6EYEtzsV9gqOUqvIJWoGIE98a2DdQvknAOzsyPGZddYbOUK52i
	 rBVz61LGnWjQWhah+Wtqx91WphWRQvAPOQkW/M9APuFZuZRhnv8vLK4WMWYowF1eKs
	 g0sTD7nNUpPn5jBUh36uh5+UmrYcJvtoNroBp7g8IsY1Z7tUaoGExPcX4yKNiF5RfS
	 Oxn2i/vEarvAHnn0Nme6i+cqPKmFcHVJADCmNUztm7Cdiq2T8nmj+NK04cLRSGEZdo
	 6E7IZdnuPRvfVQovGpzi2WuwPwpSSlh3HxkqdwICYdefbhMQ1oofZNUGNcc2mwyaZL
	 w6as4tFkpYf+Q==
Message-ID: <25951ecd-53e1-439e-92a2-8de3ff471d8a@kernel.org>
Date: Tue, 7 Jul 2026 15:41:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] usb: fix UAF when probe runs concurrent to dyn ID
 removal
To: Gary Guo <gary@garyguo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Johan Hovold <johan@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chas Williams <3chas3@gmail.com>, Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-wireless@vger.kernel.org, linux-media@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <20260707-usb_dyn_id_uaf-v2-0-632dcf3adfba@garyguo.net>
 <20260707-usb_dyn_id_uaf-v2-7-632dcf3adfba@garyguo.net>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260707-usb_dyn_id_uaf-v2-7-632dcf3adfba@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38759-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:mchehab@kernel.org,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:3chas3@gmail.com,m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,toke.dk,nucleusys.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,rowland.harvard.edu,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,lists.one-eyed-alien.net];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1366971C178

On 7/7/26 2:26 PM, Gary Guo wrote:
> Dynamic IDs are only guaranteed to be valid when usb_dynids_lock is held,
> as remove_id_store can free the node. Thus, make a copy in
> usb_probe_interface. Clarify the documentation that the id parameter is
> only valid during the probe.
> 
> USB serial has the same pattern, but it does not need fixing as the IDs
> cannot be removed via sysfs.
> 
> Fixes: 0c7a2b72746a ("USB: add remove_id sysfs attr for usb drivers")
> Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>


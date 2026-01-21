Return-Path: <linux-wireless+bounces-31040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FgzEmhTcGlvXQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 05:17:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41E50EBC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 05:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9544D4EF3BC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F092C32F751;
	Wed, 21 Jan 2026 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="gmk/WyQC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5022D193F
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969044; cv=none; b=YRtpNgNDSSLzMpssVOr0SX5k9TpvXI3P9fLGyVI3e+LJ3sZDjF2IRoUTtUEgSl/80PqxzgYhPgKEMedBRGKI95wk6ts0InNyFsjpsKd55Qp11u2bdeS3Z+mzc/AbzqS5hEL7iXLNiJDsGamRQ9xJ8bHuZKkRXsWDQ8PimvhKl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969044; c=relaxed/simple;
	bh=ifJM+HDRnWuJodoXoiyZ/dhPb5YHnV+/zFCuyOP4vaw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=a241IC77axkx6ljGPPzg6Ju5DlEOyLdHy/F14P37ZNcPz+AE0L97GWSIUU+UaB89AsC5vcClGicTxDFYtuEoBmBriC1OUhA/twXdi9ya+9jkAPLoj9rKBgUKNRsrjjdAUdK/+ySF07mSbHYLxUm5qkvXMEoAs47I7iWJHxW0nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=gmk/WyQC; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1AA9644006C;
	Wed, 21 Jan 2026 04:17:04 +0000 (UTC)
Received: from [172.31.0.20] (216-160-65-116.tukw.qwest.net [216.160.65.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 25C3913C2B0;
	Tue, 20 Jan 2026 20:16:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 25C3913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1768969021;
	bh=ifJM+HDRnWuJodoXoiyZ/dhPb5YHnV+/zFCuyOP4vaw=;
	h=Date:From:Subject:To:Cc:From;
	b=gmk/WyQCy/H0xJUTsEREX3l33wShwaXUQBpoTIEbDNJBg2jV97n5hzPkzK0HRzC2q
	 L13lV+fjEMcIJhSGGwey79eVGiVF2mEIRARr7qTJZfNSnLQmS0eb7NdkTWwLbJPha8
	 8nWdlnmXF8WGwdzqq39ZIUbWMQknoigKnAEbna7I=
Message-ID: <3872e1bb-20ab-45b5-87af-5df5bb1507c6@candelatech.com>
Date: Tue, 20 Jan 2026 20:16:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Alex Gavin <alex.gavin@candelatech.com>
Subject: mt7996 AP Stops Beaconing after Channel Switch with 6.17+
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, deren.wu@mediatek.com
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 hostap@lists.infradead.org, greearb@candelatech.com, chad@monroe.io
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1768969025-FhbHFzs72nFv
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1768969025;FhbHFzs72nFv;<alex.gavin@candelatech.com>;74082705b292d2cf81c347affc1d2557
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[candelatech.com,none];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TAGGED_FROM(0.00)[bounces-31040-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.gavin@candelatech.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CC41E50EBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi there. When performing an AP channel switch using a mt7996 radio, 
6.17+ kernels and latest hostapd (both vanilla), the AP stops beaconing 
shortly after switching channels. The issue occurs regardless of band 
and notably does not occur when using other radios like the mt7915 with 
the same kernel and hostapd.

The following command is used to trigger the channel switch from the 
hostapd CLI. Running the 'update_beacon' command after restores the AP 
back to beaconing state on the new channel. Config file used available 
here [1].

chan_switch 3 5745 sec_channel_offset=1 center_freq1=5775 bandwidth=80 he

Interestingly, the CSA count matches the number of beacons sent on the 
new channel before stopping. In each of these beacons on the new 
channel, the destination MAC is sent with the first octet modified, 
which looks a lot like the CSA count decrementing.

For example with CSA count set to three (edited for readability) using a 
5 GHz AP initially configured to 5180 MHz switching to 5745 MHz a packet 
capture shows the following:

$ tshark -r capture.pcapng
xx:_:xx -> Broadcast         5180MHz ...  Beacon frame <- non-CSA
xx:_:xx -> Broadcast         5180MHz ...  Beacon frame <- CSA 3
xx:_:xx -> Broadcast         5180MHz ...  Beacon frame <- CSA 2
xx:_:xx -> Broadcast         5180MHz ...  Beacon frame <- CSA 1
xx:_:xx -> 03:ff:ff:ff:ff:ff 5745MHz ...  Beacon frame <- new channel
xx:_:xx -> 02:ff:ff:ff:ff:ff 5745MHz ...  Beacon frame
xx:_:xx -> 01:ff:ff:ff:ff:ff 5745MHz ...  Beacon frame
(nothing)

This has made for interesting 'spelunking' through the channel switching 
and beacon configuration infrastructure. However, I'm not confident I 
can come up with a fix in any sort of reasonable timeframe. I'd be happy 
to test any proposed fix and/or share any further information needed 
(e.g. 'trace-cmd' output).

[1] 
https://codeberg.org/a-gavin/hostap-confs/src/branch/main/wpa2/hostapd_5GHz-wpa2.conf


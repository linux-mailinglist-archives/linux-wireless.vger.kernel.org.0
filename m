Return-Path: <linux-wireless+bounces-34550-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J7vD+fG12n6SwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34550-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 17:33:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 639B13CCBF1
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F81C3064F0E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C53DEFFF;
	Thu,  9 Apr 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="D7PwVn6+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770563BD62A
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748438; cv=none; b=IhpHgjlpUeNzO8JKQ78KgTu+KwuMDzPHnNbXnQ7CzBjTbyKKb520GVAs/dg0ojrVvV/EdUB0N4haD3PbPUaXGwMvM0R3rRGWH5S92qEeeQjW00HHkHtuumEwoMGx/iK/z21vsfr/tLU03woNBq/ocu++jTyOz/Z6jnITy8KOzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748438; c=relaxed/simple;
	bh=bENqwAGIWd+5rU4iDjnQ7Wgk7w2A3yQwftCXQFWN2Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m1lOvaWhIaflIgQjH6P7amqmtTlWlN2fCgGS8ShcBQikYtpMWeGtxpeH2EvgPnJB0hKrplARVs202hST3WrSfbRnu5XRAM0oAONQ7ho6HJCpg6VObqmOqa+yPPZxZQxlry5N8rrxd6i7+NP02sHSHTbXKaxqD2mlt5o8l4rnT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=D7PwVn6+; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EBDBB10008B;
	Thu,  9 Apr 2026 15:27:08 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 853A713C2B0;
	Thu,  9 Apr 2026 08:27:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 853A713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1775748426;
	bh=bENqwAGIWd+5rU4iDjnQ7Wgk7w2A3yQwftCXQFWN2Jo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D7PwVn6+2eKMlrYohrtH7VOQBTdu5iylJdH35O+BQeDdl0rrZ8OrNnPBOR01OF3Qz
	 ee4WQt6eeTPvd8FhBNNvuuvjHta8ZPDpUmeNc2JR116QJEcZpsGYwLZ8AIKybqJ+XA
	 4I3LVEYoGSDGeHiTT1BbE7Z5HDmHdM6kBDpkcohA=
Message-ID: <1e00d8c4-9d97-da1e-5cbd-cf336900363b@candelatech.com>
Date: Thu, 9 Apr 2026 08:27:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: nl80211: missing minimum TX power attribute causes misleading
 userspace behavior
To: Steffen May <steffen.may@posteo.de>, linux-wireless@vger.kernel.org
References: <9ec6fd0b1c7392fce8c913a46c1b197e@posteo.de>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <9ec6fd0b1c7392fce8c913a46c1b197e@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1775748429-SmZojdT5SLkP
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1775748429;SmZojdT5SLkP;<greearb@candelatech.com>;0e0cb912402f57d70bfea4d5fa2fe9ab
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34550-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mac80211.sh:url]
X-Rspamd-Queue-Id: 639B13CCBF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 01:05, Steffen May wrote:
> 
> This issue was discovered during the analysis of two documented OpenWrt bugs. Bug 1 is a type comparison error in LuCI wireless.js that causes 0 dBm to be 
> displayed incorrectly. Bug 2 is in ucode mac80211.sh where the value 0 is treated as falsy, causing the router to transmit at maximum power instead. Both bugs 
> are proven and reported.
> 
> During verification of Bug 2 on five devices with three different chipsets, it became apparent that the hardware floor is device-dependent and completely 
> unknown to the stack. This is not a bug but a missing feature.
> 
> Because the floor is unknown, iwinfo generates selection lists containing values that have no real effect on the actual output power. Userspace accepts 
> configurations such as 0 dBm even though the hardware cannot apply them. The system reports success while the hardware remains at its minimum supported level. 
> This creates false assumptions.
> 
> Measurements
> 
> The deviation between the requested transmit power and the actual hardware floor is not constant but depends on the hardware:
> 
> Device                Chipset            Requested     Actual floor Difference
> Buffalo WZR-600DHP    Atheros AR7161     1 dBm         3 dBm          +2 dB
> TP-Link Archer C7     Qualcomm QCA9558   1 dBm         5 dBm          +4 dB
> OpenWrt One           MTK Filogic        1 dBm         1 dBm           0 dB
> Cudy WR3000           MTK Filogic        1 dBm         1 dBm           0 dB
> GL.iNet GL-MT6000     MTK Filogic        1 dBm         1 dBm           0 dB

If you set that tplink to 1dbm, and then read the reported power, does it properly show 5dbm?

If so, that seems good enough?

If not, then we should fix the reporting, but having a floor reported doesn't seem helpful
to me.  There are lots of things that can affect actual txpower.  User-space can at best
offer its suggestion of preferred txpower.  Kernel/driver/firmware/hardware then makes final
decision.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




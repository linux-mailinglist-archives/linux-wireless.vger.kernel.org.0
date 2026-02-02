Return-Path: <linux-wireless+bounces-31457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH6cOJeXgGnL/gIAu9opvQ
	(envelope-from <linux-wireless+bounces-31457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 13:24:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E7CC515
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5604F300AB37
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A335EDB3;
	Mon,  2 Feb 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bkhonJRa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448F23EA8B
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034981; cv=none; b=YJ5kzx4tZpG1S4bpzrtK2KFv9Uktx37ZqAHHuQcxaRm4EIuVaPtztDv1uCJKSd7ELtGTaMQwR556TX5Qwt3QZPHUkBCIBeqMzO3BzjpGX7dZRXgdHj23hVYQmtLBBc/FYlv3Qpp+LjbaUIHxOC5FmsCZUKKvMCYtPc8fb9TZMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034981; c=relaxed/simple;
	bh=kr3F2RfHX6VcL1EGsdIOS1N16hQfqpw1ypaotNNOZJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuOTEBBMxKPnSH/CrUnJ5D7MlXhxtBUl9x/15jswM3ijnc5aQVLtrOMhy1bQpk5/XJHOALdjDL8miadTYb9/tLaa7ijo463XekJJLu3ZTr4ht/BDAXs922M/WVGBDEleNPAV6NWTEVjQKDo8io2Hos+sMtsKYEqp2T1fCcbul7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bkhonJRa; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B3wyZj1OEUAcRzzomRP9ekZ+iETH+yBhgOZbuNPiIPI=; b=bkhonJRaaY3cxLofbvJ8LZxjlT
	U2b11gMH3gdVvEuWEX4AoPW2s0uiqE+Xn27uIqmgFevgBOVShnP+jZjLpI2Ma7l1GHDrrQJKcC1Uc
	JBlj4CF4ghM8YI3vRdlUgrGUXet1DPPwZDhcsoBV/pFHBEPiZcNVopY7SnHLAlFgWxpM=;
Received: from p54a43c03.dip0.t-ipconnect.de ([84.164.60.3] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vmsxC-000Mcj-0J;
	Mon, 02 Feb 2026 13:22:54 +0100
Message-ID: <0df57be5-a8ed-4dc4-856a-a45fe4f4466d@nbd.name>
Date: Mon, 2 Feb 2026 13:22:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: mt76: mt7996: fix queue pause after scan due to
 wrong channel switch reason
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>
References: <20260202075311.365673-1-shayne.chen@mediatek.com>
 <20260202075311.365673-5-shayne.chen@mediatek.com>
 <fe5bb9ed-7dab-4cd5-b2ab-e5252713095c@nbd.name>
 <41b9111e696c0b0a9a3ad4d8728cf9819aa64708.camel@mediatek.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <41b9111e696c0b0a9a3ad4d8728cf9819aa64708.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nbd.name:-];
	TAGGED_FROM(0.00)[bounces-31457-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email]
X-Rspamd-Queue-Id: 540E7CC515
X-Rspamd-Action: no action

On 02.02.26 12:52, Shayne Chen wrote:
> On Mon, 2026-02-02 at 10:01 +0100, Felix Fietkau wrote:
>> On 02.02.26 08:53, Shayne Chen wrote:
>> > From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>> > 
>> > Previously, we use the IEEE80211_CONF_IDLE flag to avoid setting
>> > the
>> > parking channel with the CH_SWITCH_NORMAL reason, which could
>> > trigger TX
>> > emission before bootup CAC.
>> > 
>> > However, we found that this flag can be set after triggering
>> > scanning on a
>> > connected station interface, and the reason
>> > CH_SWITCH_SCAN_BYPASS_DPD will
>> > be used when switching back to the operating channel, which makes
>> > the
>> > firmware failed to resume paused AC queues.
>> > 
>> > Seems that we should avoid relying on this flag after switching to
>> > single
>> > multi-radio architecture. Instead, replace it with
>> > MT76_STATE_RUNNING.
>> 
>> I don't see how the conditions are comparable at all. I also don't
>> see 
>> how this function can be called with MT76_STATE_RUNNING unset.
>> 
> The condition is used to prevent mt7996_mcu_set_chan_info() (in
> mt7996_run()) from triggering TX emission.

Makes sense.

>> Maybe a better replacement would be to check for a chanctx on the
>> phy?
>> 
> Will do some tests on this and send v2.

Thanks.

- Felix


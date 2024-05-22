Return-Path: <linux-wireless+bounces-7960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2989E8CC395
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EF1B20B86
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E124C1C683;
	Wed, 22 May 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="noWSaB/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71D18645
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389726; cv=none; b=sIM/FMNR53KJZPBVdBBk7ZZu1APqM4athwXYaQSsCGul5h7TqqXb78kdgGvBws+y/dxJUnE/gTEKKFaKlfbvFBMODidIeoTHNzJL0OiHdSpwlesd3j+RTh03BxkDCYka24UNxtaNGbHenamyUJ8JBMinuNJfJvfIRFmjzXFtNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389726; c=relaxed/simple;
	bh=Qzt6XHpb5ReAf52w5o2e8pFsV+m/C/aM4EH0eIDFo90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lktm9dflPBTOyHwa9KtUGPy+4+YOi6gMTm/ArqnyQeG4Zukb4HPpZxyQ6X1N58E0ipmxZhjGuFd1tIc+J+xxTCKLDN+BntMVDGhEeFmS/qoR/uikBwCf4/T1Cil63C/pLEpkeT42vdARIwxp9iE4kJ4aLyymFIRPkWz+bg+JNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=noWSaB/d; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QlQYNTVOtmn9v/JjoZiyonEKrkd+v5yLR6uwFRs9G7s=; b=noWSaB/dcT2uT3SCz5Za3/aQQO
	ypc4dgHsQufzLC1TiSBlt2XluZLSRSMnurnvi1Uwjq4vhNf6zzlHZXo+1UUMHT4EElZOplbseP0JA
	qHescuVYQg2v3vz7J6GV29XBgEgRMbTmcohKTBcEw0UGpSZkmLgTZ3nmdeVtWlVdKFiA=;
Received: from p4ff13644.dip0.t-ipconnect.de ([79.241.54.68] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s9nN7-003abS-1F;
	Wed, 22 May 2024 16:55:17 +0200
Message-ID: <0dcc9afc-98ed-4f58-a368-79a5242a5bec@nbd.name>
Date: Wed, 22 May 2024 16:55:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] wifi: Add multi physical hardware iface combination
 support
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 ath12k@lists.infradead.org, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
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
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.03.24 08:29, Karthikeyan Periyasamy wrote:
> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
> expectation, some drivers may need to group multiple discrete hardware each
> acting as a link in MLO under single wiphy. So it required to have some
> sort of mapping while describing interface combination capabilities for
> each of the underlying physical hardware. This patch set tries to add an
> infrastructure to advertise underlying hw specific capabilities like
> channel and interface combinations.
> 
> Some of the todos
> 
>   - More than one concurrent monitor mode support each operating on
>     different channels under one ieee80211_hw
>   - Mechanism for each underlying radio specific configurations like
>     txpower, channel, etc.
> 
> RFC series Link: https://lore.kernel.org/linux-wireless/20220920100518.19705-1-quic_vthiagar@quicinc.com/

FYI, I made a replacement for the wiphy radio hardware reporting parts 
of this series with a different design:
https://patchwork.kernel.org/project/linux-wireless/list/?series=855042

The key differences are:
- Only band bitmask and optionally frequency ranges are provided, so no 
per-radio channel list
This is easier to track and vastly reduces the amount of data sent to 
user space in the wiphy dump

- No integration with ifcomb. I don't really see the need for that one 
at this point. It can easily be added later if it's actually needed.

- Validation happens in mac80211 instead of cfg80211, because that 
removes a lot of complexity
The radio id is tracked per chanctx and only one chanctx per radio is 
allowed.
I think if we ever get a non-mac80211 driver that needs multi-radio 
support, it should just do its own validation, since that's likely going 
to be less complex than having cfg80211 do it in the first place.

- Felix


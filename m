Return-Path: <linux-wireless+bounces-31960-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TAaRNq88lWlpNgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31960-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 05:14:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021FF152F07
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 05:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D92B2301106F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93A2EBDC0;
	Wed, 18 Feb 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="V3AluvI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496BA2E229F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388077; cv=none; b=g07/tB9Wc5WZ7no/XFV338MyDHaKzPW/MCZBLeeJbAm6/yX8lKffojyoqDq9qmwDVPtd/gvgUFrdxwCIJmYpbW1IjS6zJFXsII0IDRfSnPbI61sRniYycVCRO+cVUA5PL/DNZ1c3OP9X38OuUSeGj2IYJHn22C04kIC/5BXdCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388077; c=relaxed/simple;
	bh=Tno7IPwKM8hWxohGnsXJYcMHB0SxSK2TolQMeWsseGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=saiiOinZfOqQht9AIy99W2KwmsT70lsqJwju9iIfoLKl+HHF9G3UzwRwKmjUtYl3fPYkO/PKwHrfN8d9vTTd1sZXXxuvR6o1OQmVymqIKsmW2NvGfHRABSvTo3DB55qZ6NKyfKCSXa+/YZ7q0S16HbtXRi6dc8wWhO/hcFtm9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=V3AluvI+; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04618B90A4;
	Tue, 17 Feb 2026 23:14:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1771388067; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nnmmFg2p9ndQMUp443AkrQMcvSBoRVPETFCCB2R3R5M=;
	b=V3AluvI+yE6k8Wi+GVD2VD/boIwsN9HuMVfwCauQBBHnlpiwALbmPlNCkaQ+/MhD3XfNMi
	o5XFAC6v5JYTkpGsGMV1RTgWHHJ/ihyxMZXyY/74W/vzSIOJBMF0uVSYNwjRCY5aVOiJ7g
	UIjcaxGfIunySEGuP3eSwwYBzTjDP8Y=
Message-ID: <9c4a65a5-aef1-4b6a-95b4-91b4910a6bfc@kaechele.ca>
Date: Tue, 17 Feb 2026 23:14:22 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: James Prestwood <prestwoj@gmail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Richard Acayan <mailingradian@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
 <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
 <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
 <1c6a4aaa-b450-4843-8c44-930a8c3f6d66@gmail.com>
Content-Language: en-US
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <1c6a4aaa-b450-4843-8c44-930a8c3f6d66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kaechele.ca,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kaechele.ca:s=201907];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31960-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix@kaechele.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kaechele.ca:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 021FF152F07
X-Rspamd-Action: no action

Hi,

On 2026-02-13 09:00, James Prestwood wrote:
> Hi Jeff/Baochen,
> 
> On 2/12/26 9:56 AM, Jeff Johnson wrote:
>> On 2/11/2026 6:11 PM, James Prestwood wrote:
>>> On 2/9/26 6:12 PM, Richard Acayan wrote:
>>>> When sending DELETE_KEY, the driver times out waiting for a response
>>>> that doesn't come. Only wait for a response when sending SET_KEY.
>>> We've run into the exact same thing on the QCA6174 and have been
>>> carrying an identical patch to this for at least a year.
>>>
>>> https://lore.kernel.org/linux-wireless/b2838a23-ea30-4dee-b513- 
>>> f5471d486af2@gmail.com/
>> Baochen,
>> Were we ever able to reproduce this?
>> Do we normally always get a response to DELETE_KEY but in some 
>> instances it
>> comes very late (or not at all)?
>> If we remove the wait, is there any concern that a late arriving 
>> DELETE_KEY
>> response might be processed as a response to a subsequent SET_KEY 
>> command?
> 
> For some added color, we only see this oddly with some vendors of APs, 
> primarily "classic" Cisco Aeronet equipment (not Meraki).

I use Ubiquiti nanoHD APs in my home network and have this issue with 
those. The device I am focusing on with this (Lenovo ThinkSmart View) 
originally came with Android and uses qcacld-2.0 there. I do see similar 
disconnects on group rekeying on Android as well and have reports from 
other users that WiFi does not consistently stay connected and on 
Android in some cases may even fail to reconnect at all.
With ath10k on near mainline Linux I have yet to see a full loss of 
connectivity.
To me this suggests that it's possibly a firmware issue.
I do have ath10k debug traces I can share, if this is helpful.

dmesg output:

qcom-msm8953 kernel: ath10k_sdio mmc1:0001:1: qca9379 hw1.0 sdio target 
0x05040000 chip_id 0x00000000 sub 0000:0000
qcom-msm8953 kernel: ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1 
tracing 1 dfs 0 testmode 0
qcom-msm8953 kernel: ath10k_sdio mmc1:0001:1: firmware ver 
WLAN.NPL.1.6-00163-QCANPLSWPZ-1 api 6 features wowlan,ignore-otp,mfp 
crc32 ac81ca26

Regards,
Felix


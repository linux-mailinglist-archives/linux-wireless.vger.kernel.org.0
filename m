Return-Path: <linux-wireless+bounces-34189-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHmGE4mPymlC+AUAu9opvQ
	(envelope-from <linux-wireless+bounces-34189-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 16:58:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E913535D4D6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DFAE3096B46
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC25325726;
	Mon, 30 Mar 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="VAjNg/lg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AC327C00
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882173; cv=none; b=JBRbHBzCUpBnRB0x8RhXiT+3fdMVB++JqPzGVYS5nhOCZK7NugX65CevAiUQCc65WxLVx7NvdvhRN5zxlzLaksUVRyQmvadnyirta0W1I7m9xiRipy8aiVxEWZzSjJ2TlgcnqgHm5HW2AT0YagO9jhKtCul8eKSwgBLQLtfYa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882173; c=relaxed/simple;
	bh=AZhPhJRLCGtPQjoHd129UL1eYJACE7UgWWZXH++mpUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=msxDlzHEDBERUM13ZNl5R3sYRyDZZ8ZDRfa+b+HILEh+Aink8yw7DV71J3o2LGyJjGJRJKQBTrSTkZ17wzoFCLhnl1umCIwImxk0n0fA5NClTnXOGEvs3mVBbPUBZWO+EpNed3CyMQdgfK5gY8aN/4lNmBYoY6wPQ4MV/4YmYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=VAjNg/lg; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9681B5095C0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:42:00 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2FBF6800B0;
	Mon, 30 Mar 2026 14:41:53 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D812313C2B0;
	Mon, 30 Mar 2026 07:41:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D812313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1774881710;
	bh=AZhPhJRLCGtPQjoHd129UL1eYJACE7UgWWZXH++mpUg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VAjNg/lgudp/8JPzBCRTVeRRJZciweC7mjzyv4vOLAgR4u2rvO2FhMLNjw6BEdWvt
	 0n/6Tw4XChe+rCTDG3GmSmg0MsErMsGueeAHJ7qw2K4xXZqupCrfM+36J8kbz8kDYH
	 hDZfPu0HqihpNoHvt+VKGs/KPm0DgKghhztxomMQ=
Message-ID: <1250870e-1631-4a8f-baac-d113828fc0fc@candelatech.com>
Date: Mon, 30 Mar 2026 07:41:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi-mld: Fix fw id leak in OOM case
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <02f66cee-4892-24a3-9a07-1e722fe8888f@candelatech.com>
 <DM3PPF63A6024A927179DD5C6D8BEB45B11A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <495b7e8d-454c-4c0f-8976-c31fcee0783d@candelatech.com>
 <DM3PPF63A6024A91F45CEFDD04F62A8BC91A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <DM3PPF63A6024A91F45CEFDD04F62A8BC91A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1774881714-Uy0C3YIi-lJH
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1774881714;Uy0C3YIi-lJH;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34189-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E913535D4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 23:55, Korenblit, Miriam Rachel wrote:

>> Are you fine with having IWL_ERR in the patch like I have above?
> No need for any message.
> And you should have a proper commit message

I already posted a real patch as part the of the big series, please pick it
out of there.

[PATCH wireless-next v2 11/28] wifi: iwlwifi: mld: Fix stale reference in fw_id_to_link_sta

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



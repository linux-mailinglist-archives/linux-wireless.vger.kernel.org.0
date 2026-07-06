Return-Path: <linux-wireless+bounces-38706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8pKOAy/9S2rEeAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:08:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E6714CF2
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:08:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="SJd/NXAJ";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38706-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38706-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 331F23017275
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA68387341;
	Mon,  6 Jul 2026 19:06:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7338331C
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 19:06:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364780; cv=none; b=Cyhb8WkbAscQCxPpkF2kE1GjPEeNOPjyqMWRRdDrc83ga4kez5hcLB6cH704cdzyt+zThCLt/ekNkG3tNDdEv0XQCvJnRHLqgGSZjH4HVqhZYlPs7MDSQIBigylWTk3dXp+bJSuO/c2Ay3GC4ob+w9TJ0K7UWkt+QPrFTjoHVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364780; c=relaxed/simple;
	bh=KvPjYSetF/yUEo5b4twvRTste5FXr5R4057h569+x1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwYvj9TDRRgRzNwNVBpDroZgptdntZCF6OVtdf9sYC25IuYrCDixjOZAVPO39lhLtZndn8YGDf/sCGAfKE5wuiKo6alRPlE0/O+G0IgEyZFhOgp48i5urYlq5c300JsHLI4Y4zjxvmys4DI4SOLB10yiiF9ET3fiJVP2tSwlnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJd/NXAJ; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-51c01089e8aso27008361cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 12:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364778; x=1783969578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ic1Z9t9IaQ7A2sjcuIlUdtXhSR+9iAL555xfaUA/Ru0=;
        b=aAaWu3JuFHEqc5fvNwuu2Lx/JX51KCGZt0XqTzN+Ica3o4vDXUQ9XgKfPd+A0CZuOk
         GUfZOH1ZWakW75niBCA55ENdI/t/+SuthuIh0LeynfpyMvFWjMAS+Bt6iWjKifUZF09a
         rPJQF0rK9pg2F1PhF3cGuyNP4RcdsA3xt16QxHFhGv6C1ldG2Cxkqj+rYkFi43hfS9wv
         hgtrrh40R+yBN/xWimF2jxvGVA1lIHqETpeiDldo2gp3k+r6ssd1JSVTfRc7sO/e8wuP
         txIy/lOX7rKSwEVXSSeyJtQeg1/t6OySXEyv2um2AO4PnEXJ4Ue/o65F2aM6J6VC7cG1
         Syng==
X-Forwarded-Encrypted: i=1; AHgh+RooMKvIEjmzer09soXvuE3M3F7F82qWPAhkKq7rH87tVdWTam7Xv92lohaJk8FJrmKYvb2n9bBtqUBHJ9sggQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rJ1LZ2DVtC/QKAetcLkLXoSPYw0aUWaJDksUhndazgZkwV8X
	42aWbEKN7RVVREIUXN1aG1hX08C2U8QdklT4YL8EesxJqMUeJugCx5gAlwPYu/cNG838MFpVazb
	fHj6vtVMR7CNzDE5uSi06wgGUPKlu0fLjznNr1jbcjk6UBrwt+USQuyK+HJ8VdzLEDOLXp/lB6Y
	LSJY6ylFjJuqmPJ2uGHc5BSEhXvjiuL5PhbVJ9Q5hAwAPtj2EsYydiYb8cftGlukN9RT74QOYzD
	4kqkiGPH9zv1YmKEvwfM5TEiDCG
X-Gm-Gg: AfdE7cknLbgHPs8FEyomaUI2bFeIojxB4mFRCmM1VvCZKwRphQKZhHWmrpUkX2u6Dg5
	wsDzZG/8ftD8DXfWYHgmFozY5mFxxUOSdlwV1KRhpafLobP3PwYi/tY8KD0ewrkBbUf2B5iu3+o
	+m3Ymtt5U+5Wmi1dOehCgxbXrAKUsLRpp9/s3zj6ZizuPQKeqEQb9C+fbklNtbnOxHyjul7whTf
	PSCXK6gSv92wMjdhqRDRPNqxCYitGuL0aEKNGTSd8wCZKCuphDRClEVLYB13SpwQleDqVPHLwE2
	7HxVkTCFxIPJhzM+UF7rYCPPsgATlwN0mghh17iBaVoxCIYsByLV+AWCf6vt84xcS4a/TXNvLXE
	P4kSgD/oJHmrpevl/KUwAaErK/jpInL6cxE9hQAM1GGIDJG5HaVcJvkvi5JsIR24ZubebsyIKZ/
	AzVJs/pHjCQoZ2Cdy+URqVaIS9bhPItvL6p18CfP8O0HdipATl+g==
X-Received: by 2002:ac8:7d88:0:b0:516:df59:32cf with SMTP id d75a77b69052e-51c7479f5b5mr23559291cf.7.1783364778328;
        Mon, 06 Jul 2026 12:06:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8f470b7c3f3sm12506906d6.19.2026.07.06.12.06.17
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:06:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5740so394670985a.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783364777; x=1783969577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ic1Z9t9IaQ7A2sjcuIlUdtXhSR+9iAL555xfaUA/Ru0=;
        b=SJd/NXAJQyWCkIpOY8pniZlFffEYwzHmfin8Usp0mN/dQIwmhV7wF6ScyZKTdaRqlv
         C0Bu/rx1FMmz0Qyw2OE+ZPfAngP67uptUfuZPAZVkhanQjWsZepYGdl3UTHOls2nF7Zb
         xppKglO81COn6ggBgoawCY4hWgIYSYYv0mfkw=
X-Forwarded-Encrypted: i=1; AHgh+Ro2axFeDrTmwgw01Zc3cQd+VYgKQYF3+Y48lZGK25fPR1MY1a7E9qYkUvQEex566RUqme7lW4S9RJuB5I+kJQ==@vger.kernel.org
X-Received: by 2002:a05:620a:2908:b0:92e:6430:3c73 with SMTP id af79cd13be357-92ebb566320mr270472685a.21.1783364777300;
        Mon, 06 Jul 2026 12:06:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2908:b0:92e:6430:3c73 with SMTP id af79cd13be357-92ebb566320mr270466385a.21.1783364776661;
        Mon, 06 Jul 2026 12:06:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm964890985a.4.2026.07.06.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:06:16 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Daniel Kim <dekim@broadcom.com>,
	Franky Lin <frankyl@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH wireless] wifi: brcmfmac: initialize SDIO data work before cleanup
Date: Mon,  6 Jul 2026 21:06:10 +0200
Message-ID: <20260706190612.708609-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619064401.1048976-1-runyu.xiao@seu.edu.cn>
References: <20260619064401.1048976-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:kvalo@kernel.org,m:pieterpg@broadcom.com,m:meuleman@broadcom.com,m:dekim@broadcom.com,m:frankyl@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:arend.vanspriel@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38706-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A00E6714CF2

On Fri, 19 Jun 2026 14:44:01 +0800, Runyu Xiao wrote:
> brcmf_sdio_probe() stores the newly allocated bus in sdiodev->bus before
> allocating the ordered workqueue. If that allocation fails, the function
> jumps to fail and calls brcmf_sdio_remove().
>
> brcmf_sdio_remove() unconditionally cancels bus->datawork. Initialize the
> work item before the first failure path that can reach brcmf_sdio_remove(),
> so the cleanup path always observes a valid work object.

[...]

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend


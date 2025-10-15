Return-Path: <linux-wireless+bounces-27979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3BBDE415
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 13:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71E284F6CAA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE631A811;
	Wed, 15 Oct 2025 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uEBU5WAA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983C30BBA8;
	Wed, 15 Oct 2025 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527506; cv=none; b=IS29OgKedI2kjRSfEs49Hjo5iDHJLIFS7ZsHtzmIp68crgXiJ/lAP04vmk+04pQa9V1RSUpHjZV7R4JXfoOzhBhQZd4WTvafnx/5hhQQAlQJ3pgFwGeqDt6PJB/60jbTGYllSdyzKPigBs8gcRtPj+XNeMJziw+zI0LVThAiFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527506; c=relaxed/simple;
	bh=1pW+ZrFHs0Eb8nNNM3+g+Cc7KOejr3ELdi5PxJaOL0I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dzb+HceZ3FBAImmX0B055Cq6wc4hoQzGqkfGrTJbAV5DOdgfgW2mHI5QRlpRpgheNGnPL/eRJosfkNo1NuRQ43jnFIPYesnT6OOZCOPBokEiI1WqbD/2jTVFS0HRYpfOpXT8pOxiFilem9J1a4JkqfsNodjVGctuPPUsCH/2j3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uEBU5WAA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760527500; x=1761132300; i=markus.elfring@web.de;
	bh=1pW+ZrFHs0Eb8nNNM3+g+Cc7KOejr3ELdi5PxJaOL0I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uEBU5WAAWJHmiCNru5+kKYhAe3CgtWrakGVlNtwJr7Z7X6pzfrMJABVpjNYDYbhp
	 h9Qr8cvM8J/dAwWqOfX6hUL3rHIaFIfbMaCXRPyHpWq8SRs2TjxEGTsOZhAkfjlwE
	 UOqJIJSShDfwhSRBN/Ct6/IOIG+ROBQRWL9Nwr72v80APj3OPz7IQXfIA02Ic252H
	 DNtVA0ssmqhio1WYzgyEMXiPVPkKZj66ujjEbOeK2/FrvdRWzplU7htJuABzr0ZYv
	 7WpTn0TuFWKNAKySV683nvy3RsYkNL9bO7mqRgocFK19sKa1Lc3um18pJexXE5Bo0
	 3Nd/D2DNwrbkXVHe7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.181]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28SL-1v6Wmb2Wdd-00H77B; Wed, 15
 Oct 2025 13:25:00 +0200
Message-ID: <a5a7515e-a35c-46dd-8522-0daa41e23b1d@web.de>
Date: Wed, 15 Oct 2025 13:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Qiang <liqiang01@kylinos.cn>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251015071607.96415-1-liqiang01@kylinos.cn>
Subject: Re: [PATCH] wifi: brcmfmac: Add null pointer check to
 brcmf_acpi_probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251015071607.96415-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3QtQ3W0lmrjyYRZubuG8PdYJ/gDYjw7ubQq2vvuA8g3MzzC3kmr
 vKtFq3aveuzv3Fc+zJHsGxamAkIoHKv7S7oM64kt3WyPZHBS63xjH0Agj38Q55FHvlhcatn
 cnGgT4FHkGMJvaVANlS/PMMU1snADVKirR8ckWckwT9NSMRWCBEu4xPCTIQTK7X59ApVNJ1
 Ol0+6ldMPBpRWSn7sgFgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YeFG10qA4ZM=;uyjCFabf4jJkD5nDDQHP8OfChds
 +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

> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.

Will another imperative wording approach become more helpful for an improv=
ed
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94


Can a summary phrase like =E2=80=9CPrevent null pointer dereference in brc=
mf_acpi_probe()=E2=80=9D
be nicer?

Regards,
Markus


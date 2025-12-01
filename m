Return-Path: <linux-wireless+bounces-29440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC3C9727F
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 12:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C626F34252F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331282F616B;
	Mon,  1 Dec 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QWtWhAgi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD227280B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590348; cv=none; b=cMPvszwdyAnXVMQ6zTm6ZhomrR50H/1oa7LsPTAzBQ+FUmmFx3vyo39odDIstmuSNYgbkP31WwV6NUFkiVIQeUE3PL7BE+YL8iSK2r6lPMZm0u/BL4bKnHlzXONGX2VFxDWdrTU1kQSpIJ5WrH8IDNI3DuB6GJ/F5zwN3VlhCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590348; c=relaxed/simple;
	bh=5B03tDGPsT2KVEYfua3Vg13bbYoRPzGZpC0PQE4PdNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqyYMeS6cMrgpTmYR5ZwFSbXDkmjvGH7QtdSJq7fjW/Y1PQC4HEgF14pSfpAcdEtBcscVm2K760CiPQNhfX4xLQQtXfLiALLCTnW58HVo5cei3y+vJnk+jOHUBROWJDZmF4jdXWwv2HOtRfeZiiKDtrwCIb33wqcTLZZrIgASFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QWtWhAgi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5B03tDGPsT2KVEYfua3Vg13bbYoRPzGZpC0PQE4PdNY=;
	t=1764590346; x=1765799946; b=QWtWhAgiqKKRZRvxJnk+Ke8iTJm4AziaNHLuuzl6kC44Q1m
	/XrkZXLoEJorJAta/2/Q4s9naM6LS3yiLFHFSDBcc3jJ0ik+9Li7KDL2wH5pNA/tx7zcuJf/nPdP3
	u0PJulCu3gX3U3xkz0HYglTb9RuHUBRqqLyCIeRN1FUS0zQauz1AjaD6BZ7FVINSfuEoR2EYZCZRA
	MXKqB3FnG3ruET2H45iJNMm2R4nmUxu4NPmioRSI5JqGhx2HfTfIqlG4Jwl+StROxq+2B7poiabOD
	cGD+7gRoT+1OHYdEd4Md4VuoGkChxsmixtWED3cJUM0KPZXwnPoq+T6oEw+4B9yQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vQ2YX-0000000DEdf-0wvN;
	Mon, 01 Dec 2025 12:59:01 +0100
Message-ID: <02483c18eabf8758cae729e3bff7bb59f6b0f75b.camel@sipsolutions.net>
Subject: Re: NPCA/DSO configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ping-Ke Shih
	 <pkshih@realtek.com>, Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 01 Dec 2025 12:59:00 +0100
In-Reply-To: <f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
References: 
	<f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-08-27 at 18:40 +0200, Johannes Berg wrote:
>=20
> Anyone have any other thoughts?

Thinking also about the configuration/tracking on the AP side - can
anyone comment on how this is likely going to work?

And that's maybe even a more general question, there's NPCA, DPS, etc.
all using the same action frame, with changes to all of these possible
at the same time.

But if e.g. FW handles it, then how does hostapd build the correct
beacon/probe response, particularly NPCA requires finding and
advertising the common ground configuration for all stations, possibly
even accepting the activation on any given station only after that has
been updated (and proliferate through the BSS?)

johannes


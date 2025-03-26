Return-Path: <linux-wireless+bounces-20864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC71A726DF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5907A2C8F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E51263F28;
	Wed, 26 Mar 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="nSyy96jW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541E5028C;
	Wed, 26 Mar 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030504; cv=none; b=jNrkaD1kv8obJ98zjSYDalcxv2iOYbw43YCybEE+dYVAzBXHfbsJlbs3qNtSVNJCpbu6Dhf8ys7/G16JOPsWPqv+6ca91of5bJCXPb8mFIctx04hrkgXrpYrglVm1XtG/uXetmlC+0dgQTYMA1SnGHvW43jXUhB5pxd7dRJ0WqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030504; c=relaxed/simple;
	bh=X4S/7dZElRQ2b6/lLtsy6EQGCbSHCEn9feN9sZrfxEo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m0xnGdKk4nDla0fkFl1rnUVNLN65IZbeVhiV5y62PMSAdNWj0LLSndfhmMFQXk/ePGPFqgpBQCHbNKOH0okXbgcmQCpNKsHo+aUpDb+qiKKwv8U1elW9jz7sYLVBpj3HrhPJZTOwyFJfQfwRvVF+KAhGy3G5DRDh2kyEvCHn0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=nSyy96jW; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [127.0.0.1] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 0DCA01669CD;
	Thu, 27 Mar 2025 00:08:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1743030493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4S/7dZElRQ2b6/lLtsy6EQGCbSHCEn9feN9sZrfxEo=;
	b=nSyy96jWQX1INa/o7HHsVcLizeqeBbkFXicTR06X/YXc++3wLrYzgJYA/q1VamnffnYvv3
	cEGhlmjglTnPYPRtRWbyU5KHbA7Pijuy698eACoyzZ59kYSvB4mFo4vzVBHg7bwy+am8Mi
	H66y/uBKKcSTbSs1XZ8Vi9wFIDLmTas=
Date: Wed, 26 Mar 2025 23:08:13 +0000
From: David Heidelberg <david@ixit.cz>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>,
 =?ISO-8859-1?Q?J=E9r=F4me_Pouiller?= <jerome.pouiller@silabs.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
 Mailing List <devicetree-spec@vger.kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
In-Reply-To: <bfb7433131cb9aeebc75666f86a67a6c71521229.camel@sipsolutions.net>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz> <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net> <CAL_JsqLv9THitHzj8nj7ppCp-aKn010-Oz=s+AUNKOCoDmBnbQ@mail.gmail.com> <bfb7433131cb9aeebc75666f86a67a6c71521229.camel@sipsolutions.net>
Message-ID: <4B465FA3-E6B5-4EB1-A712-0C8874402FCE@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I can do that, but I suppose it's 6=2E16 material at this point=2E

Hi Johannes=2E=20

I assume you meant 6=2E15?=20
This patchset should mainly clarify where these properties can be used and=
 address incorrect warnings regarding device-tree verification=2E=20

David

> johannes


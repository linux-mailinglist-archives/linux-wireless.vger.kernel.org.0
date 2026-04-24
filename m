Return-Path: <linux-wireless+bounces-35282-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKSXJWuY62m7OgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35282-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 18:20:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0246141E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8385930058E0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ACF3DBD48;
	Fri, 24 Apr 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="qr4ABPVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ihkj5RWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE603C3452;
	Fri, 24 Apr 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047655; cv=none; b=dPE2xbx4oJ3Xd5p6iFsqIpqTemusKe/+5mLjtYBQqYep6RzamcZu24RkqEInv+yDpfaYsOv1mKywD7aXbNh8nrGaADA/WFdh8PEvvlDHOzLhm7vr9wM5VoEP1InWQTK48r6SFGQBPTJN05btwOQWFL1czgLx2KjoH68uF7ndZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047655; c=relaxed/simple;
	bh=1IqN3myNGyn5/4h0I7QYnz3X9j3NjD0M7B3fzq6u5iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2FLI+a21D5aaxWKj6QJcyy0bNt3J9H5lqulvqb+8ZQEyOPBQTc9Ov6ZhHftFdJBZr1Ut3m1alEjcawtiQKP5rJZOHgiU5HUDdEaJw6yG2fksm9sZkrqFn192qA4yPfzY8s9PFn5uaEfRa95400nveD5MRV/uUTz5daPwrVyMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com; spf=pass smtp.mailfrom=animalcreek.com; dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b=qr4ABPVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ihkj5RWx; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animalcreek.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 27C891D0018A;
	Fri, 24 Apr 2026 12:20:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 24 Apr 2026 12:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1777047651; x=1777134051; bh=LVq2Kle+d/Y+s8+bCyU5/Eq5sWVprcwc
	qu5fxzL/SA0=; b=qr4ABPVY2RkcECGGD8eFZH1q1LrnWqK0e3l7XmXxnQ94VQqu
	6voxw1I0W/qLeQZtCyP93cRJYLEDWsjYjc/Ba2zIRKMO8/nfWtDj/GgenhBg6oCs
	ToPMyHSUTmboXy2QMBhcZrJibFTWLwU82qz40EGwdV8KKdB2TLLlRT/t8xpA7DzN
	KxNszKKEadpDpUk5UpcCpVi3LUAuzGhINSQIvZSF0X6igeBSkEAfZEoaXzwFdpOn
	Z+8StpEltJMqbpdxl9fIjdb59iC6RZ1/QIbW3S67CAon/ZgAZ0Z9CXiKmTDhISgm
	sDxxJMcfQ5o/nTKBOIwN3IJPtVCO9ksL2OaUsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777047651; x=
	1777134051; bh=LVq2Kle+d/Y+s8+bCyU5/Eq5sWVprcwcqu5fxzL/SA0=; b=I
	hkj5RWxKSeKr45/vvp+bOY3+Ld1/rDtDDNLIZ7Dye417ajQz/s6tXevPY7DQuV+N
	nzfymizGIHJ9K2UD8LPSUkcYOPNL4tXUsDUyRHcytueWSqH04NBmbL/SmUmTIAep
	VlFou40B4cFFNdYUVm7U/r4YztTdj5TuCgXd8PzRK1r465nQyzkIrJijM/ZQXYea
	R+c/tgdNnB8vlFu9xN90ESWj31SGQHKv0zaBE8oOCDDsVCkweObHKwiWhS8VPFHe
	u/p0iQJ5soitAXOEoYrDsZdzdUwCbMaOskBuysSGlmAIoStnARQ/JvXt5p9zrKiA
	AWvxiGx7yuvc2hpaGxu/A==
X-ME-Sender: <xms:Y5jraRupid-aT-GnFYzOuSMPWZZLb56laterazZhVwt6kiKjlee7UA>
    <xme:Y5jraZg92Li_Ht_O4Mtzjiwr76mTAi_P6suseaBswEnb67N6rUVTO0HUInQJPmITv
    BaI97v3Q0wF2cNEAN4WGz2XTH82uS0aCuMhK6Wvc_UxK6wgJufOOYk>
X-ME-Received: <xmr:Y5jraa-HFSdFwzMREf8oExpIm0-TA_aNeJZbCrBIxKJ24JGQ9fgxhlkUYM2GHgF_OCvTytztkbJrq858JDOk5FfPCAGT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhohgjtgfgsehtjeertddtvdejnecuhfhrohhmpeforghrkhcu
    ifhrvggvrhcuoehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomheqnecuggftrf
    grthhtvghrnhephfduteehueffkeelfeefkeefjeeuffdtuedvffeftdettdfhleduvddu
    tdefheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhdrghgvuhhrthhssehprh
    houghrihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhrtghpthhtohepshgrmhgv
    oheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvg
    hlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhijhhnrdguvgdr
    ghhouhifsehprhhoughrihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhrtghpth
    htohepmhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhm
X-ME-Proxy: <xmx:Y5jraUsdT0jL6MLd8sfKFnEw10lHU0gR1Gdqqhu1INX2tyKmBnrYzw>
    <xmx:Y5jraWppYxFxR-1mNc64JXvsREAIckp3NOKi_Ag7HGiwlBySvo1VPQ>
    <xmx:Y5jraQocebJFWW-TzE3WT4Q28mvQgXDcUDTrGxdudTZ2tWvrpDE5Aw>
    <xmx:Y5jradY8vdRgphujM9TRUV3I7N3XfFf5IQxYZY0p9xFb9JAngBePqA>
    <xmx:Y5jraSAqwnYdx8tvNd-cQ0rVkAaSgT78_nXthbO-ytNkGWEDfvjvA9Aa>
Feedback-ID: i9cc843c7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 12:20:50 -0400 (EDT)
Message-ID: <19fae358-acc4-4b9e-8dec-b83af066a97d@animalcreek.com>
Date: Fri, 24 Apr 2026 09:20:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFC: trf7970a: Ignore antenna noise when checking for RF
 field
To: Paul Geurts <paul.geurts@prodrive-technologies.com>,
 sameo@linux.intel.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: martijn.de.gouw@prodrive-technologies.com
References: <20260422100930.581237-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: Mark Greer <mgreer@animalcreek.com>
Organization: Animal Creek Technologies, Inc.
In-Reply-To: <20260422100930.581237-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 15A0246141E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[animalcreek.com:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35282-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[animalcreek.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[animalcreek.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgreer@animalcreek.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]


On 4/22/26 3:09 AM, Paul Geurts wrote:
> The main channel Received Signal Strength Indicator (RSSI) measurement
> is used to determine whether an RF field is present or not. RSSI != 0
> is interpreted as an RF Field is present. This does not take RF noise
> and measurement inaccuracy into account, and results in false positives
> in the field.
> 
> Define a noise level and make sure the RF field is only interpreted as
> present when the RSSI is above the noise level.
> 
> Fixes: 851ee3cbf850 ("NFC: trf7970a: Don't turn on RF if there is already an RF field")
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>   drivers/nfc/trf7970a.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index d17c701c7888..08c27bb438b5 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -317,6 +317,7 @@
>   #define TRF7970A_RSSI_OSC_STATUS_RSSI_MASK	(BIT(2) | BIT(1) | BIT(0))
>   #define TRF7970A_RSSI_OSC_STATUS_RSSI_X_MASK	(BIT(5) | BIT(4) | BIT(3))
>   #define TRF7970A_RSSI_OSC_STATUS_RSSI_OSC_OK	BIT(6)
> +#define TRF7970A_RSSI_OSC_STATUS_RSSI_NOISE_LEVEL	1
>   
>   #define TRF7970A_SPECIAL_FCN_REG1_COL_7_6		BIT(0)
>   #define TRF7970A_SPECIAL_FCN_REG1_14_ANTICOLL		BIT(1)
> @@ -1300,7 +1301,7 @@ static int trf7970a_is_rf_field(struct trf7970a *trf, bool *is_rf_field)
>   	if (ret)
>   		return ret;
>   
> -	if (rssi & TRF7970A_RSSI_OSC_STATUS_RSSI_MASK)
> +	if ((rssi & TRF7970A_RSSI_OSC_STATUS_RSSI_MASK) > TRF7970A_RSSI_OSC_STATUS_RSSI_NOISE_LEVEL)
>   		*is_rf_field = true;
>   	else
>   		*is_rf_field = false;

Given that false positives are happening in the field and assuming that 
a value of 1 is enough to filter out those false positives, this seems 
like a reasonable solution.

Reviewed-by: Mark Greer <mgreer@animalcreek.com>


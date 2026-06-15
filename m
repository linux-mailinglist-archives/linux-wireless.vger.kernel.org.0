Return-Path: <linux-wireless+bounces-37820-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1px2L24AMGpVLgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37820-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 15:38:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAC686CC4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 15:38:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BY2O9icd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37820-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37820-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A9C3078667
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86D3F1AA8;
	Mon, 15 Jun 2026 13:36:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B763EDAA3
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 13:36:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530616; cv=none; b=up6jlR3NyVqF2vbuzirNlJF/t+41Qx6c7aRCW4tc0uxhsqkzLpJ7fU/oep5ZxU20c3MsPoeBt3bqn1EspP1ntKsS2SQrKeqQZTFCCBj36kZiEVBnpRf+/K/+taV8rwCScC5M0YQaHEH0EkamVY4ee1mU5wdbD0O0jbbc/Ebtuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530616; c=relaxed/simple;
	bh=X4W99tGe8AunxStwgyiEQ8nkueEHmuGZtFFwNXRnrIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq5s8Q74hvzBkrKo+4RFZ2u21CBv7PEccc2MecTXOhYJevI40jbD/82vPkrVCTZsaOMYmPClx6WPEseSeq5Luw4ccwpDssRo2pivljJqMI/+DwztUjeTCiZ1UupPfCt0qds3J06jPdjjQF/7B0TTEYRYWH8hJahTudM7ksV7yeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY2O9icd; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so37413465e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781530613; x=1782135413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bJPr7AwovREaKXgEuzZAVb8kOr5xcjm3uq69zeHw4Ao=;
        b=BY2O9icd+CYW+ktDT30G/mGbHOgFSFCQlk2ho1atz7D5gAb47Oi0nB2FfOebTI83OV
         kR1c5QGR0xx4YS7vwTC6Qtne126TJdFUp7P1yy6k5Wh48FcJAhPQvcMLCWg71PXBrDWS
         n7aYdOoxrJht5OUyds2KpEu8ui/vUNm6LVuC8frukXZjoxfEvpFVGj5YAMZBPoT8gxVS
         xY2j2HKeMjY6fktg/kNDcHTzHClKs2vj+vuhlibOyycY7WgPsPbgzsUPbHHlh4hhAM21
         4AzmbtFYw1M3oUWsyPCRmtW6eNufvuV4hrxh1D1UAin2UE+WJwtqw5tAuRrrhFUlWeRG
         jVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781530613; x=1782135413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJPr7AwovREaKXgEuzZAVb8kOr5xcjm3uq69zeHw4Ao=;
        b=s7j99CPHMuyk4LDxXdQJWsij/oi3Aa322Eu2w5NbwTQKZLLvCt/wqdnolznZ073Dkc
         VE7F/VwNuaBA8ruxRm/cVvCU1nA5SToJlO708Nm0C+mNVMqRgYe/fuk53JejmxBo2Bgx
         p0eY9AplgOfLRnheMNW3E6iRkgbfkjb48it0MhqLqqhkoVIOziK+RiRjg5Ikkbrl+6rG
         KERLOM6AvmXEaQlUTbKLnVC55DIpjFV+2Y0v+xfDYnEieNdO/iBoogBArfDdNEHr69us
         buentVzlwJI4XGYFRDGgIyn39/Ddkw600VTE8eNANL4cbXlo68Eo9lTu6MEKIborCJfs
         WM9A==
X-Forwarded-Encrypted: i=1; AFNElJ/FDqoD1E8mNZEG/b/upQbYWwnIHP3TxbatN7IqfUf8eA8zwRjl3FICBia2ne55ISJg1smTJ8WFfP7IMNqm/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsXSClmbthsveJ8LSAAoEG2/UmZhwoDySUBW2yw70ngN0yff2
	NvgTljFbip5Zg+6EbyvX24nI9K6wqwUAjhLbLRRq4EUHjUFLpH3LEdns
X-Gm-Gg: Acq92OHw1cfuwQf8gq34yHNaWhDXqP2OzVF3oJ500mlOA2eVzDlxoj3HtMAaKRwaINx
	DwSq3+uLl75E/9+t8WCkonE4qosZuKamPzxkbU+2KHzFh1PvOkjwV9G1Uc0IZrVx1BMctZiRc4Z
	NYW6T3JFep46l+DGnUM1DdU7J3RtN7DiXpQeTXIZmFJsLx0l+rheuyQfidL9xPUezqflDoqDavF
	CI789R4mn0Z052sDmnTjJk6JCMDY1KwzeoHcB+WWT6FXS2YNIQTakodcQBItGXcyROAcAiyTDxY
	5wRwFNXw+UGvaxgenRCajvBS41jRh04lMN6HrI1iCvvZ59Xhie1ws6x6D5rh8ikTvR/DJktGT9o
	l94yizSdijQsUzHHEvpqIhFDL+zbC8nR31yoboaIO9plkc3x5tvDJurh1GSfmievyZ9SFFl9ev8
	SO4l9wYQq46QCYUtorxFB6UejQucAmFTHunAo9LnApRvn+FqBTYLILM7QLRFclL0tE/4JP3+FB1
	RD90DTRoYtWVlburukcLusb8wY=
X-Received: by 2002:a05:600c:4512:b0:490:4663:691b with SMTP id 5b1f17b1804b1-490ec4992aamr201275805e9.7.1781530613100;
        Mon, 15 Jun 2026 06:36:53 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea961f18sm270433745e9.2.2026.06.15.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 06:36:52 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:36:50 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Andrew LaMarche <andrewjlamarche@gmail.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: ath12k: support calibration-variant from
 device tree
Message-ID: <23fr45actdrqt6rp6fozcaugyk3egs5zm7imschl7gyuuj6cme@3pvdhqv7xvkq>
References: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
 <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
 <dc8c9c9c-dc85-40dd-9313-845a808a35f4@oss.qualcomm.com>
 <3B9D1FBE-37D0-4902-8C0C-8AB57C1310A5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B9D1FBE-37D0-4902-8C0C-8AB57C1310A5@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrewjlamarche@gmail.com,m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37820-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:email,3pvdhqv7xvkq:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25AAC686CC4

On Wed, May 27, 2026 at 05:01:51PM -0400, Andrew LaMarche wrote:
> Ack on the deprecation of qcom,ath12k-calibration-variant in favor of the
> generic qcom,calibration-variant. 
> 
> However, drivers/net/wireless/ath/ath12k/core.c still misses the logic to 
> actually load in the BDF, which this patch also accomplishes. I don’t see that
> in the Qualcomm-authored series you linked. Perhaps a v2 to address this?
> 
> Andrew
> 
> > On May 27, 2026, at 3:52 PM, Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:
> > 
> > On 5/27/2026 9:12 AM, Andrew LaMarche wrote:
> >> Hi,
> >> 
> >> A kind ping here. I’m not sure why this functionality is missing in the first place, but it is needed for loading caldata from the device tree.
> > 
> > Your patch duplicates functionality in the Qualcomm authored series:
> > https://msgid.link/20250228184214.337119-1-quic_rajkbhag@quicinc.com
> > 
> > And note the upstream device bindings for ath10k and ath11k only support the
> > generic binding qcom,calibration-variant.
> > 
> > There are no longer any generation-specific bindings, see:
> > https://msgid.link/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org
> > 
> > /jeff
> 

Hi Jeff,
Hi Andrew,

We also need this functionality, and as Andrew noted, the patch series
from Qualcomm does not actually address this.

I believe some confusion arose because the patch series mentions the
"qcom,calibration-variant" DT property, but it does nothing to implement
this in the driver. In that series it only exists within a schema file:
Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml

Our need for this property was previously discussed here, and for now I
don't see a way forward without it:
https://lore.kernel.org/all/77vowy4ax4cl6dlc45i2q3fjmwn3q676wqghq267tmbix7773b@27h5t66mflur/

Thanks a lot for your work here.

Best regards,
Ernest


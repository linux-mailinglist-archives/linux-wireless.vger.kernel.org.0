Return-Path: <linux-wireless+bounces-34693-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMqGEMC43Gn2VgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34693-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 11:34:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CED713E9E3F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456CF3019532
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADE3AE6FA;
	Mon, 13 Apr 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osbBTfx2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E037F8B0
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072740; cv=none; b=ON1dmp72G+xjYR8htvPIK5z6kvBbpfsqg9HbaynnTIqUVroU4wyW5Jy3dqoTuHM8gRA4JI4D/YWzZUTEioRmM2vaPHNppedrShApN8kcom5xqn4jWu+jRf7r/06paIbRf5y4PTLW0B84PetX+TZekpPLv+Zzd998j/l2A8y7hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072740; c=relaxed/simple;
	bh=r5ox1dFrYoySIHS4XOEUtJOp25+xZgVyE1/HrKTClvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnQM+gpIl+lZvPK68lswyYNs/JGZ4SVcF1XOf1hxS6UeExulkxp1APfaUVfpkMsZaSZnKA6VdWItk9AKm+thV7Q0/Z96mY0Z8oXjwZAOqr2hRiVyC214PQxeGg8VQkyM9L09BWwiGlcaAKINSy620dMh9cd3kwpPpacCSUiXysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osbBTfx2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so58931015e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776072737; x=1776677537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AtkvQUwJwxJbSQun1xp3UJ1EVjDwjdDQxfbDiJ20NYU=;
        b=osbBTfx2EuPaopnJhnQ6tZhL+KgZ+jKpAmh6Jnb3rnmlrZfZDqc3ue6S/YIG92WoJv
         yw8RrIUL0fcZETO9WrBngZE10BnkO8us4nXreihw7QmfB9npgaY+8WoCOnwV2gTPH1yI
         l/guAHJhfjoKwtFrYY5dY98/IjIirgVbKlpbl2E9a1WnLMFcvjf4+EbzXacxld0t7Qes
         V5ywmUBsY4KYUbfswg4R+KDD0Q4KpoUQtWbZk9b734pwwd4W0AfFDMHTjgb8ejyigrTf
         19P0ZcOFiE2WQUEpj+ROosJw4nIesy+VCOu0AEjEiDr59TVVh8lzuCZAby0ix4bNaEhA
         4RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072737; x=1776677537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtkvQUwJwxJbSQun1xp3UJ1EVjDwjdDQxfbDiJ20NYU=;
        b=iJoR+uy5AW8NJOanVyuU2t9XpGAVuKgJydQLkE8uIRg/RbYCpW9fPOMXGzf7qtUeMJ
         Z3pdrX0W4SVwD4vVhB46jXkql7FJUmeZv07GIAqucAfyhe993bf+UWHyuAFBPOaTz5aj
         KGixtkh31XwDY9KdGPiJWx45jG6tA6ejydTswze76Jk84zTnKDbzt9DYRwgA5dzCK94e
         nFCgdvPM/FOQdJo1+OB1xqX1vLund0Uk1nMuu7RXnGOwfqOv7DDCOttNtKRTOXKTB038
         5LR/tug9QCEZk+2t0mbG97WYSA1WC3SdiEGlgg4QTHZNGZWY1GPdiFT5HaI0zjDR/GKq
         y49g==
X-Forwarded-Encrypted: i=1; AFNElJ98Okx8gy7OSDLxrO5q0pjabjd7PCog/N176D3tAkJIVzBPyKS/QMUbpFKqAi9/FDMaCfm1tGNAzCjmJZOH3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd45uN76R91V1Tl54Gbj/4bEU0FQq/LO236lq+eHo/PrPug+E7
	cHRqUkusnSIvvrX2NhEL1U2ryF4GBqEjKdNzFg3X807EgHBYlAEE7Tea
X-Gm-Gg: AeBDiet2RQG/EVEivi5IEMZj3Rnsvj2y12xI7PAqBcIK0yIgzTTMn0NWx7tDf52GC4D
	9QJw9dNcUhfBoqTAScYf0/lK2AKzCG0+4WSRkp0vVFtXvC8j4ekTs962cqYAKT86VRCMGXIA6jP
	H/Q/SlK29RX/zC2+X1MuW4wnh/iXxx7OO1T2qlxjZlGcEJi/gy6vlkLzSBZT1LwiPAcXVg50FJX
	WfeIU5SjRfPX80QC+KiarwGUN9KjJ78s2YXN+6BR2jsNE2LBB9y0q5CgHuWn/QATN9EDacadzC/
	WqxjYtmxEEJUpfkFAQfXJUR40WNrv5Mr3aWcuOowyUT0PPIvgLBFgZj7wDQ2zGkrGVee43aD3P/
	5KAjbyRwbQfie679NMwAled3clHuQ52fMGnywcx43FYXxbWaJg86p6plW05r+7d7QoOpKEwaxVj
	ENW2bdGQAsmEMzuo+CkRqg8rpGyVeLKZtdgZwHAu/Y9nWLVwznnfNeYK+4L3Jxcy8x/v2XS58A5
	pXkniWFJ+fXHJ+rsfNFai9jNOk=
X-Received: by 2002:a05:600c:1391:b0:486:fe23:1707 with SMTP id 5b1f17b1804b1-488d687116amr185252315e9.20.1776072737113;
        Mon, 13 Apr 2026 02:32:17 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm374255055e9.3.2026.04.13.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:32:16 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:32:15 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, ath10k@lists.infradead.org, 
	ath11k@lists.infradead.org, devicetree@vger.kernel.org, ath12k@lists.infradead.org, 
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
Message-ID: <77vowy4ax4cl6dlc45i2q3fjmwn3q676wqghq267tmbix7773b@27h5t66mflur>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <2fd84ab2-2e3e-4d05-add5-17930a35fedf@oss.qualcomm.com>
 <jnggqxqv3rjzhyevovnnxzplfhl3t6auhhvmoz7wxmsf6awgdx@dusdgxwsxvts>
 <b8277024-f9d4-4f17-946f-c2c390669067@oss.qualcomm.com>
 <exfmj52dqu3uctwsb2gopcjg7744vq5avlkahtmgfw4opw4mfl@t2svrln72u53>
 <f853d9b2-47f8-47b5-a02d-6aa8f12a4283@oss.qualcomm.com>
 <trr5j57vwk2dhoibdgdxnlkftnmfcmjkwmicsiltmhybxanjaf@tzaeeqcyz56l>
 <fasihmiu2szj6m2r3qef5slvzlvdjo2ajhrd6xyqsa5cajrbzq@a5dyulg2dnac>
 <ff11954f-345f-4865-a86e-759aa167768d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff11954f-345f-4865-a86e-759aa167768d@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34693-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CED713E9E3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 02:06:00PM +0800, Baochen Qiang wrote:
> 
> 
> On 11/25/2025 5:57 PM, Ernest Van Hoecke wrote:
> > On Tue, Nov 18, 2025 at 12:23:20PM +0530, Manivannan Sadhasivam wrote:
> >>
> >> ath12k doesn't seem to require a calibration variant. But even if the user
> >> replaces ath11k chipset with ath10k one, the calibration variant should be the
> >> same as it is platform specific except for WSI.
> >>
> >> - Mani
> >>
> >> -- 
> >> மணிவண்ணன் சதாசிவம்
> >>
> > 
> > Hi all,
> > 
> > Jumping in on this thread to ask about how we should handle variants.
> > 
> > We are using the WCN7850 device with the ath12k driver and received three
> > board files for this from Silex, signed by Qualcomm. All three support the
> > same board (SX-PCEBE), where one is the board file to be used for the
> > US/EU/JP and the other two are one for higher emissions in the UK/CA and
> > one for lower emissions in the UK/CA.
> > 
> > Since these are needed for regulatory differences but support the same
> > board, we were wondering about your views on how to handle that in
> > mainline. I see that there is no support for the board file selection in
> > the device tree for ath12k, and that there is some discussion on how to
> > handle variants in general. We are using a device tree-based setup and no
> > ACPI.
> 
> does your machine has different 'model' property for different BDFs ?
> does the existing ath11k 'calibration' property based mechanism satisfy your requirement?
> 

We have a SoM with always the same WiFi SoC on board. These SoMs are
then mated with a carrier board, in our case often a development board,
and together they form a whole machine for which we have a specific
device tree with a specific model and compatible name.

Customers that create their own carrier board would have their own
device tree with their own model string. These carrier board device
trees include the base SoM dtsi.

When these devices are sold in multiple markets, the model string is
thus not specific to it. For example, the same model string can be sold
in Japan and in Canada, with different regulatory requirements and thus
a different board file that needs to be used.

In short: no, the machine does not have a different model property for
different BDFs.

Similarly, the WCN7850 would also not have a different PCI ID in
different regions since the hardware sold is the same.

The existing ath11k calibration property did provide a way to specify in
the DT which BDF should be used, so in that way it can provide a
solution yes. Of course, with the drawback that the PCI device has to be
specified in the DT.

This would allow customers to ship their device with a different DT
based on the the target market and its regulatory requirements. Another
mechanism that allows them to specify which variant to use in SW/HW
in- or outside the device tree would also work.

Thanks for looking at this and kind regards,
Ernest


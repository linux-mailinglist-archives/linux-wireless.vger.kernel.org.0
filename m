Return-Path: <linux-wireless+bounces-16240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5E9EC7B8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA6D16AA4B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604801E9B21;
	Wed, 11 Dec 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfAYVRpC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239F1E9B0A;
	Wed, 11 Dec 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907159; cv=none; b=aluTkrXSWBKmTaVhukCtXPWMUfr/lEN0/1sJw2gZmODkuGO6ETCF+tiINvK3xnmb26JetaVVtUYzaKv2+cn7EcrmgKHFHu7HMsGa9NUvEwqFrXqU2fFpRWZHHFaFp/R9gvrrpa2ZPTqG3eLMTf5OubGJIgEA3PWvP0E0e2RKTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907159; c=relaxed/simple;
	bh=EWCFqp/kWK73aZA9KQp5JhGFxDPQj2mhNnR6ifLue9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWNVnlpozFDvo7ccC8JoTkkk6kWdpBaLUNXmIvBm2D/Tk6zkzL3xowbd1xR/5G6RJicggRKz4YSDf8bvUfSLpzUNmt8G4cMx+O1W7vnB4mFw0FyT3oYCaK/WRLgd7vG3sUKO9t0E/QZ7oWPnGM07ADRXUAC94FPuBsNaVZ9VnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfAYVRpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C6FC4CED2;
	Wed, 11 Dec 2024 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733907158;
	bh=EWCFqp/kWK73aZA9KQp5JhGFxDPQj2mhNnR6ifLue9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfAYVRpCrBwT9D74sGx1D/qJMrWZDdCjn1so3fnLz3eyWmXD4fcwn4j2jj3NPXQwX
	 fpgRRHR1jgFgWfd55OHnSYAs4KeCEfmr3VmkuZOuQkD3wUpW9SKlFBkCa//rXj+Hbe
	 NhWO8I6xKI08PkKx6fDxLqmALX8fVyOfidAcgxBtuYoIkxvXj1Lmg0wdCgRXvcGqzW
	 KBnZBgddL7dJkmSgfZPJPQ/HBb/TUSmJ1SY57Nk7W3mkeshpgNrMWiqK829Zt/FZDe
	 RS2cx7OkVPXNHzaCkUd4wN9wRxJ8CxNEQXZkaxVRFHCB8gmYrhBq9DkmIlBMX4fJpq
	 fOg8gDfInPTrw==
Date: Wed, 11 Dec 2024 09:52:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 07/13] wifi: ath12k: add support for fixed QMI
 firmware memory
Message-ID: <7qypvfjb34nyvcqmdw37zjpcxga5drvddwimlc3cuhejtyzjnz@4agqjdalxl7x>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <20241210074159.2637933-8-quic_rajkbhag@quicinc.com>
 <2d86b600-a7b1-4f7f-87ba-c167ec8c0405@kernel.org>
 <ab745c8c-421d-42de-aec7-54c2064cee58@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab745c8c-421d-42de-aec7-54c2064cee58@quicinc.com>

On Tue, Dec 10, 2024 at 10:30:54PM +0530, Raj Kumar Bhagat wrote:
> On 12/10/2024 8:13 PM, Krzysztof Kozlowski wrote:
> > On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
> >> +		case CALDB_MEM_REGION_TYPE:
> >> +			/* Cold boot calibration is not enabled in Ath12k. Hence,
> >> +			 * assign paddr = 0.
> >> +			 * Once cold boot calibration is enabled add support to
> >> +			 * assign reserved memory from DT.
> >> +			 */
> >> +			ab->qmi.target_mem[idx].paddr = 0;
> >> +			ab->qmi.target_mem[idx].v.ioaddr = NULL;
> >> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
> >> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
> >> +			idx++;
> >> +			break;
> >> +		case M3_DUMP_REGION_TYPE:
> >> +			dev_node = of_find_node_by_name(NULL, "m3_dump");
> > 
> > NAK
> > 
> > That's neither correct name nor documented in the bindings. You created
> > now undocumented ABI. Even with incorrect name. :/
> > 
> 
> Most of the Device Tree related concern in this series are from the
> undocumented ABIs and wrong naming (use of '_' instead of '-'):
> "m3_dump" and "mlo_global_mem_0".
> 
> To address the undocumented ABIs, "memory-region" and "memory-region-names"
> should be used to reference all the reserved memory required. This should
> include "m3_dump" and "mlo_global_mem_0" memory region.

You already use them, so this code here and explanation is confusing.

> 
> If the above approach valid to address undocumented ABIs?

Dunno. Change all node names, run dtbs_check. Do you see errors? Now run
your driver. Does it work correctly? If yes, then ABI seems documented.
If not, ABI is not documented.

Best regards,
Krzysztof



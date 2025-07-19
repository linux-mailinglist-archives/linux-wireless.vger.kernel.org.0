Return-Path: <linux-wireless+bounces-25675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02249B0ADB5
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 05:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCC4E81C4
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB01DE8B3;
	Sat, 19 Jul 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6ZIsGkr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD2EEA8;
	Sat, 19 Jul 2025 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752895489; cv=none; b=DLlmqEVGZ6jN0FuO4pL3CGnVwh1pMTuKaKkf7oPd8EddYNt6Q/XAyBVp9ymIahuauQblqZ4RsXOumgZxXZMxee0KQceI3ZDpLEww2qQQXjxucmcU9pmfbcvI1rCI4Lx2KNUgUS6HpfG/c1Q6capIK8Y6IG7S184KDWklNC+qheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752895489; c=relaxed/simple;
	bh=XEASl2DavDoT9hNzoWLmpWGP6OxRxWr3zHYeH6vOsgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID0RmFa/tOLXuJPj9xkgZGeyMLR8tV+2F7XPX/gbnb7haed/Z+7RMwePSygfoeguRspwvWldmRuFBaRSpv9TkvehlNjY0QiWLcMNqhium0fxg/tZoA+43Ob86qv8Khql8BqftjgIZ4ZDIzxSnVjEWhjVbbNEmEci2HGfFTZ7ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6ZIsGkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C80C4CEEB;
	Sat, 19 Jul 2025 03:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752895488;
	bh=XEASl2DavDoT9hNzoWLmpWGP6OxRxWr3zHYeH6vOsgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6ZIsGkrXKkcYkOZjst0jboOvYy8GYi1dDxIImUnOqZSAPd3tOKvpKieaGRhjhk1Y
	 1saGJ/cmKKBPfxeUvMwrKrRCaFvFJcIgg8Mfia6TZpmloYfbez6xQwfdg+dxQAXJs5
	 WoiOw8cbJUPAL1qbgTucPlp6VWGNetFEQ97ZVHGn7lLWETNkicnr+8+CiltnDq0CeO
	 /sTRDFmIo1HJOps9HLo83uB+7Z2IRlIAFsXy8pKOqjikoJSqsGHE2opNBuoGHiX8sl
	 jW+uFsTHNBLNTdKRLTkNVojJdoHTO8Tb2zIPFhAIuOZBTixAfT/D9N6Eq4E9QLQZwO
	 gNLgeuUNsrM9A==
Date: Sat, 19 Jul 2025 08:54:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Youssef Samir <quic_yabdulra@quicinc.com>, 
	Matthew Leung <quic_mattleun@quicinc.com>, Carl Vanderlip <quic_carlv@quicinc.com>, 
	Yan Zhen <yanzhen@vivo.com>, Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kunwu Chan <chentao@kylinos.cn>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Troy Hanson <quic_thanson@quicinc.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, sebastian.reichel@collabora.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	Sumit Garg <sumit.garg@kernel.org>, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org
Subject: Re: [PATCH v6] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
Message-ID: <yywgwnk3aky2qqyxnyiisqxdi5a545tijtigm3al3yyzxrjnst@ged5v7i24nsc>
References: <20250516184952.878726-1-usama.anjum@collabora.com>
 <175014516328.16478.17449149106590025798.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175014516328.16478.17449149106590025798.b4-ty@kernel.org>

On Tue, Jun 17, 2025 at 12:58:51PM GMT, Manivannan Sadhasivam wrote:
> 
> On Fri, 16 May 2025 23:49:31 +0500, Muhammad Usama Anjum wrote:
> > Fix dma_direct_alloc() failure at resume time during bhie_table
> > allocation because of memory pressure. There is a report where at
> > resume time, the memory from the dma doesn't get allocated and MHI
> > fails to re-initialize.
> > 
> > To fix it, don't free the memory at power down during suspend /
> > hibernation. Instead, use the same allocated memory again after every
> > resume / hibernation. This patch has been tested with resume and
> > hibernation both.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] bus: mhi: host: don't free bhie tables during suspend/hibernation
>       commit: df75d6d7ce922645e674f5d591c7333f11027cdc
> 

Dropped this patch from mhi-next as Greg is opposed to drivers keeping memory
during suspend [1].

Please resubmit once the consensus is reached.

- Mani

[1] https://lore.kernel.org/mhi/2025071722-panther-legwarmer-d2be@gregkh/

-- 
மணிவண்ணன் சதாசிவம்


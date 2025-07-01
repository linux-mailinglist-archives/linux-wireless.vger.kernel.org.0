Return-Path: <linux-wireless+bounces-24715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9BAEF4FF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1382D1C0174D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1F2701B1;
	Tue,  1 Jul 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aWFtFdlP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752826FDAC;
	Tue,  1 Jul 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365538; cv=none; b=Csv4/nn1/omtGkBu7vctBpiT3lfPLYgiNZTDLJWldvfCCHdnreru4lryTXmzHdPdWmUp9Sa4gkpSjyINJNh9FjJMUj436sYGjpDv7d6VO+iIxgpgOUloekawrnDKUk1D65c7azN51/qcE7irZVAuZmpCD1G6O4CK0BUmbR5+OzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365538; c=relaxed/simple;
	bh=1sgmZSc0RqiZBnc+0Tf8VpLK7tigaJ0hMiDLE8raUok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+0QaN7I2N9/n/sLYyT+HS8DMtsBbDCKEmsErdDR1qV0pvyXVOEmyaZm2WVy8jhJ8BM4WY+q/V+rpArJWA2/asSxh5tH/14MB6wavJj6ahHGECBQNo8DzmfTekRI1aWIymBoiRqLnJhvPHBSL8zuT6d1/jFXzqd2GxytBMAFJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aWFtFdlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D14C4CEEB;
	Tue,  1 Jul 2025 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751365537;
	bh=1sgmZSc0RqiZBnc+0Tf8VpLK7tigaJ0hMiDLE8raUok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWFtFdlP7LxJXSmkxWjJdgi3ZxiYDS3tcdzS+NdbAXMfm7qvQ3fXE5ThJShDLJuTQ
	 NUtFoF5lXF1oe93UCUwVtp4+oI4E/k4oGz6xvAYgARQ4b0TClNcGG2OIMsf8NI7sbt
	 ewAf1w4ndj1WqKo9kvXITIGmsgzC5a9qYTmLZYpU=
Date: Tue, 1 Jul 2025 12:25:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	Sujeev Dias <sdias@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	John Crispin <john@phrozen.org>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
Message-ID: <2025070128-chihuahua-slimness-da88@gregkh>
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630074330.253867-3-usama.anjum@collabora.com>

On Mon, Jun 30, 2025 at 12:43:29PM +0500, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

No cc: stable?


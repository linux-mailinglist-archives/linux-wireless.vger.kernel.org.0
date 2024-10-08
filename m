Return-Path: <linux-wireless+bounces-13688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE3D993F5D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7664C1F21E76
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6818DF77;
	Tue,  8 Oct 2024 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMfNWCjG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52F152532;
	Tue,  8 Oct 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369755; cv=none; b=KXsl7ejCEyXLfQb2NDa26gLsMDiga/w535RAFsCgwoBebcgBjMUyGL6QARlUIIGs6GF4iV5bvfBRoavTCpNB1fjnvsqlRhMsxyzXuZSvvT2BusqVWRCIOWPhwNMy8SXvDcNn/0C94/0/hoLbFMJlkinfXSSKwUeVrwhrn+SXU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369755; c=relaxed/simple;
	bh=nKqUXhLCu2H22kchjl8YaKDGoNtj3tZt0TXQEHPoe0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYpCJFWk4o0qXZB5lUTlsQ7r8900t/WNoXytm5Nee4uN4Ddh6tENitU9MF+6CDv5mj3DOahEbVqONXO2rri7ZIUaP1UnKA3DCXyPvzwNeuD7RC7xxYqhWDTRFoKs8975SW1TEdmeEnYtG0A6LBaLgwikNO08S1amNdvM0ecYzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMfNWCjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE79C4CEC7;
	Tue,  8 Oct 2024 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728369755;
	bh=nKqUXhLCu2H22kchjl8YaKDGoNtj3tZt0TXQEHPoe0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMfNWCjGhugOGqnDSJ3LsnPU1joNofDhPJ2NpkJ9yRHIaTeOykJ53BDRVDGXMNKHm
	 EC5EMuDlFfbB7Ne9kKCMNBBAGjQqUzk+3RxspSZi2kD5sE9pfMH+HWy2T7WTvlQeJU
	 VaOZqE+Cl+gBJbNp/ohPBIyN7Jc4rXKwARN9afiM=
Date: Tue, 8 Oct 2024 08:42:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 4/6] staging: rtl8192e: delete the driver
Message-ID: <2024100825-badly-smartness-cf1b@gregkh>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
 <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>

On Mon, Oct 07, 2024 at 08:26:54PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This driver is using lib80211 and any driver that plans to ever
> leave staging should never have done that, so remove the driver
> to enable cleaning up lib80211 into libipw inside the old Intel
> drivers.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Return-Path: <linux-wireless+bounces-20381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92ACA61109
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 13:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759EA463614
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A21FECC5;
	Fri, 14 Mar 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiKCos/4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC41FECBA;
	Fri, 14 Mar 2025 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955110; cv=none; b=u8+lMU7JRPHFeuvnC3QRNB36JX9uWCqvGzefpTYbB6RwihuEDMRusGB5qO3B+uKF1yPbiEFbU6Yvwer2n65ZgE8fXdTNrdbPClTkf8VDI0Pwk8+gAB3gpYV44kOr+acxdA/jpM7kufKjAMAK3U1jy/A37GI7cgcqmjPPYa536GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955110; c=relaxed/simple;
	bh=4yUZqv+zFjEOVzZ9rsSZ/h7wicQke9kUl8I46PLezqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMQjqqzEClYMdW1AAvUW0YfyKk4H+omnLYvOK2/Ak375SuzSe223MVm2XX8xAgJ6LQvy9T3n0pRIQtv1xyxWZYjWkQVpS+imE0ISDvYPrtDtJSEVhOlFsTRdNpJfMbs40OsP1DPqtgGXLFzC28UK6hJRh+RIEsTe2dmgB+gckVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiKCos/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB9C4CEE3;
	Fri, 14 Mar 2025 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741955109;
	bh=4yUZqv+zFjEOVzZ9rsSZ/h7wicQke9kUl8I46PLezqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiKCos/4tHDXUiRfeyR0qM2hBEHcVz3wg9uXgKSHfp//H2HWbc+BqkxwLXZ4kJnrS
	 qOoIo8FfYcsIznW7aUHXFask3aihjh9AyiYGi9BCnA77R4Zh33CXNUDuP/w/4oQrnn
	 bcGSlNDCsyuPklMFszYH7L0d0ymgWn+Va4v2MGMI=
Date: Fri, 14 Mar 2025 13:25:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com,
	Sean.Wang@mediatek.com, Leon.Yen@mediatek.com,
	Michael.Lo@mediatek.com, allan.wang@mediatek.com,
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com,
	Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7925: fix the incomplete revert of
 [tx,rx]_ba for MLO
Message-ID: <2025031447-attribute-sequel-f77b@gregkh>
References: <20250314090655.2856153-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314090655.2856153-1-mingyen.hsieh@mediatek.com>

On Fri, Mar 14, 2025 at 05:06:54PM +0800, Mingyen Hsieh wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> 
> Since the `Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"`
> was not completely clean, submit this patch to fully clean it up.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73915469c55a ("Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"")
> Change-Id: I2d851e6b79905baae35f691578bf50d56ad0adbf

Please always run scripts/checkpatch.pl before submitting changes :(

thanks,

greg k-h


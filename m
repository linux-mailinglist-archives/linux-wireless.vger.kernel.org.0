Return-Path: <linux-wireless+bounces-11989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA995F27C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284BBB21CAD
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157F17BEC1;
	Mon, 26 Aug 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ay/V7/Ai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EF1E519;
	Mon, 26 Aug 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677937; cv=none; b=SHLaPL+4CE9Kq2UksWKmJXeR2Dhxc7Uzu72eArQbN3+1XsHYo3+S3xHMWCtOVmUF/cgUFEjuzk3W914MB+7mqaY3Y79oKFUoepxQRx/Xztm5fj2xsypAbZ3oBoCFXk4hyVWmtaUIDbMFkxSz1IHkcYikH14tjUMvZMCjSUNbnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677937; c=relaxed/simple;
	bh=2Hwc0rlUSM7yZPSibAcCUtm/BA1aKxtEQmG6ERlsGHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD+bhJ7vB4xHye/Q0bU8BmMR7fTDiPOSoiMlXysG0yNQFQHyTkm4JEELl4C8mqTUGPMQCaO+aeOWpWfjPTqkaR9ClNeRXQGLSylmS6oTTxEo3PVrqiLA4hjwBkRHpgllozu2s3Z7mhT3ohmwnhjvfuPXnkJowU3bm4l9Io+VLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ay/V7/Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080D6C5E8A6;
	Mon, 26 Aug 2024 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724677937;
	bh=2Hwc0rlUSM7yZPSibAcCUtm/BA1aKxtEQmG6ERlsGHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ay/V7/AinftTTAO6O36jLK1UzgGW3+ab6Tn87cJIZj6yLUdx/awwevwjbhOA9w0c8
	 gZHHUZ6zkdosLGLsWJRnVTL7e/SuwkxXP5STG5MvCIUX3SXgObnD8TLE9+KcX5O4fF
	 3viLZyhpAEo5H0atnKGpVUPShK/xTgLqm5eYU5Os=
Date: Mon, 26 Aug 2024 15:12:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V4 1/2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in
 with usb_control_msg_recv
Message-ID: <2024082651-boring-friend-cee3@gregkh>
References: <2024082631-upward-zips-f7b8@gregkh>
 <tencent_A037749680365C4BCC750776D566183C4509@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A037749680365C4BCC750776D566183C4509@qq.com>

On Mon, Aug 26, 2024 at 08:29:56PM +0800, Edward Adam Davis wrote:
> ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> the length of the data read from the device is not equal to the len, and
> such missing judgments will result in subsequent code using incorrect data.
> 
> usb_control_msg_recv() handles the abnormal length of the returned data,
> so using it directly can fix this warning.
> 
> Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V4: Adjust indentation style
> 

Please list all of the version changes here.

Also, I got 2 copies of this, did something go wrong on your side?

thanks,

greg k-h


Return-Path: <linux-wireless+bounces-30036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ACCCD42A8
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Dec 2025 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D425430084DC
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Dec 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A79290DBB;
	Sun, 21 Dec 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pR9gJsQl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352B17B505;
	Sun, 21 Dec 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333261; cv=none; b=vC/NlzFTzW4OEAOMIiGFhv54PNKjwKryzCVkUK/iG4myvjbgI8ygomZnKwahXT2cqZF+9FlV5vDWAPVTtYeNw4aFwOCzxIM65IYU0nnJdFgO7pEh4l3THOji3LunOP+8B6Ht1ti2lvYBVHEB053/2MsCUcUxMJhSP3MELOmZBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333261; c=relaxed/simple;
	bh=pXl5ZmB5iGjVLs8NED9dnc20D6hQeMIdKC/+8EvY7fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtnEjapWuHfSja/nLe+PnmcUDdVzZSDv7+0BFS8tVvAQEo+HgMuRCmc6KZVVt6p+p5iMGWFoPpiJj5i7MLlSW8HUSdek7C5coMydgUazBHfeS6CSeGcEY+WimJtFERzFgFkhnZui3q3BeHeV1xZ1b71FA0nUBy2uVA8bpjDYvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pR9gJsQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A88BC4CEFB;
	Sun, 21 Dec 2025 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766333260;
	bh=pXl5ZmB5iGjVLs8NED9dnc20D6hQeMIdKC/+8EvY7fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pR9gJsQld5R2tq3B5bfeGaT+EXKbOSEKvUoGAZ+qMgqPaBTkmqgiFkb7j8RBezV8r
	 6v3M6ksrPLPofyVi/djGfK7PD+L21mlLT1kHTXf5iUQ9twZjerWWwY9i6jINpUQkxH
	 g36jk+i+uHTH95jcutTy6af+fgOG/aixVVEoZdyg=
Date: Sun, 21 Dec 2025 17:07:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cjz <guagua210311@qq.com>
Cc: linux-staging@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rtl8723bs: v3 - Remove global continual_io_error, use
 local count
Message-ID: <2025122109-dreamy-obtuse-0bee@gregkh>
References: <tencent_453BB45207600CD663A5957789EB5CEC1608@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_453BB45207600CD663A5957789EB5CEC1608@qq.com>

On Fri, Dec 19, 2025 at 05:39:47PM +0800, cjz wrote:
> From: changjunzheng <guagua210311@qq.com>
> 
> 1. Remove global 'continual_io_error' variable from struct dvobj_priv (eliminate cross-function dependency)
> 2. Replace global count logic with local 'error_count' in sd_read32/sd_write32
> 3. Delete redundant rtw_inc_and_chk/rtw_reset_continual_io_error functions
> 4. Add independent bool rtw_check_continual_io_error() (single responsibility)
> 5. Comply with kernel coding style (whitespace, indentation, variable declaration)

When you list different things, that's a huge hint that you need to have
multiple patches as a series.

> Signed-off-by: changjunzheng <guagua210311@qq.com>

Is this how you sign documents?  Sorry, I have to ask.

> ---

What changed from previous versions should be below here, as the
documentation requests to have happen.



>  drivers/staging/rtl8723bs/core/rtw_io.c         | 17 ++---------------
>  drivers/staging/rtl8723bs/include/drv_types.h   |  1 -
>  drivers/staging/rtl8723bs/include/rtw_io.h      |  3 +--
>  .../staging/rtl8723bs/os_dep/sdio_ops_linux.c   | 16 +++++++++-------
>  4 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
> index 0f52710e6d3a..33023ae45196 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_io.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_io.c
> @@ -131,20 +131,7 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapt
>  
>  	return _SUCCESS;
>  }
> -
> -/*
> - * Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
> - * @return true:
> - * @return false:
> - */
> -int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
> -{
> -	dvobj->continual_io_error++;
> -	return (dvobj->continual_io_error > MAX_CONTINUAL_IO_ERR);
> -}
> -
> -/* Set the continual_io_error of this @param dvobjprive to 0 */
> -void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
> +bool rtw_check_continual_io_error(int error_count)
>  {
> -	dvobj->continual_io_error = 0;
> +    return (error_count > MAX_CONTINUAL_IO_ERR) ? true : false;
>  }
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index bd7bb5828d56..de4bec961671 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -279,7 +279,6 @@ struct dvobj_priv {
>  	u8 Queue2Pipe[HW_QUEUE_ENTRY];/* for out pipe mapping */
>  
>  	u8 irq_alloc;
> -	int continual_io_error;
>  
>  	atomic_t disable_func;
>  
> diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
> index adf1de4d7924..8ae8849f5fd9 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_io.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_io.h
> @@ -48,8 +48,6 @@ struct	intf_hdl {
>  #define SD_IO_TRY_CNT (8)
>  #define MAX_CONTINUAL_IO_ERR SD_IO_TRY_CNT
>  
> -int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj);
> -void rtw_reset_continual_io_error(struct dvobj_priv *dvobj);
>  
>  struct io_priv {
>  
> @@ -70,5 +68,6 @@ extern int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
>  extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>  
>  int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapter *padapter, struct _io_ops *pops));
> +bool rtw_check_continual_io_error(int error_count);
>  
>  #endif	/* _RTL8711_IO_H_ */
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
> index 5dc00e9117ae..571a2c6fc37a 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
> @@ -207,7 +207,7 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
>  
>  	if (err && *err) {
>  		int i;
> -
> +		int error_count = 0;
>  		*err = 0;
>  		for (i = 0; i < SD_IO_TRY_CNT; i++) {
>  			if (claim_needed)
> @@ -217,13 +217,13 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
>  				sdio_release_host(func);
>  
>  			if (*err == 0) {
> -				rtw_reset_continual_io_error(psdiodev);
> +				error_count=0;
>  				break;
>  			} else {
>  				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
>  					padapter->bSurpriseRemoved = true;
> -
> -				if (rtw_inc_and_chk_continual_io_error(psdiodev) == true) {
> +				error_count++; 

This adds a coding style error, please always run your patches through
checkpatch before sending them out.

thanks,

greg k-h


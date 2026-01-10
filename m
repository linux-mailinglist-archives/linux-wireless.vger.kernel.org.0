Return-Path: <linux-wireless+bounces-30629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E82D0D387
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 09:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E81D3016CD6
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0E155389;
	Sat, 10 Jan 2026 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3RHWZ/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD19500947;
	Sat, 10 Jan 2026 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768035099; cv=none; b=BDXdNi+g9q8eIYs8/4j5NrswaZBUoLXFXaGB2N1n1VIUNYWpECC/KHqU4iZ35Sevh+kieOcTiU6OEohlXUOe5BZTu7Y5IyoX8ei+2eYDWjdGhFpj0ZaCmVpHS/uGzXs3H4OaTrwRIS+P0Ms+VAftckVaZmgpxe0OYjMSnFjVPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768035099; c=relaxed/simple;
	bh=zopuVitSl6EefdMB9cq5nKFrwOJZoaiSXmrwGEjLwWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjkRvklq2LIxQ60KvbG0aUmheRtOlb06HxujzysSuv3Co75/5yOWIOiMowBTI9YoHVO0lIb5e4KPj5l/o1RtKjWwKYycIg/o7ViLEfbKxx9ML/1aAS9PvvTZzSGU8pLfxxxvpe7FZTNZ2MO9su1sraouYENpIN9j6Yy76EBTG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E3RHWZ/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A323C4CEF1;
	Sat, 10 Jan 2026 08:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768035098;
	bh=zopuVitSl6EefdMB9cq5nKFrwOJZoaiSXmrwGEjLwWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3RHWZ/aJMZeO9Qaz3TZmGnom7FaV4dX/hOEvDQRw7My8PSQk5N9iC0NRU8oeRHao
	 bM5LrsQkGVg8NbPK/EQTa8imRgorQfve5pQhBVD5+sAk0PvYBIdDFaxcNDPkRiu5md
	 ldWzDSk9hGlrKNy9Ddz7fcSOa+NPINBxDTBLsdXo=
Date: Sat, 10 Jan 2026 09:51:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cjz <guagua210311@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and replace
 global io error var
Message-ID: <2026011016-manila-stable-91a9@gregkh>
References: <tencent_1726B023EBD3D2ED3BBDF506F6E01D282907@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1726B023EBD3D2ED3BBDF506F6E01D282907@qq.com>

On Sat, Jan 10, 2026 at 03:47:39PM +0800, cjz wrote:
> This patch series optimizes the IO error counting logic of the rtl8723bs wireless
> driver by removing redundant atomic_t operations (unnecessary for non-concurrent scenarios) and replacing the global continual_io_error variable with local error counting. The series is split into logical patches (per Greg KH's review comment)
> to ensure each patch fulfills a single, clear purpose, which greatly improves
> reviewability and future maintainability.
> 
> Patch Breakdown:
> 1. 0001: Add independent rtw_check_continual_io_error function (single responsibility, includes old function cleanup)
> 2. 0002: Use local error_count in sd_read32/sd_write32 (eliminate global dependency, remove atomic ops)
> 3. 0003: Remove redundant global continual_io_error variable (clean up struct)
> 
> Changelog from v3 to v4:
> - Split the monolithic v3 patch into logical, single-purpose patches
> - Fixed all coding style errors (trailing spaces, missing assignment spaces, indentation, blank line alignment)
> - Added detailed, purpose-driven commit messages for each patch
> - Added version changelog as required by kernel documentation
> - Added this cover letter to explain the entire patch series
> - Optimized the new check function to remove redundant ternary expression (more concise kernel style)
> 
> Thank you for your time and review!
> 
> Signed-off-by: changjunzheng <guagua210311@qq.com>
> ---
> 

I only see this email, not the 1-3 patches anywhere :(

